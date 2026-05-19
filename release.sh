#!/usr/bin/env bash
set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
REMOTE_HOST="malandro"
REMOTE_PATH="/var/www/cv-jolijn"
BUILD_DIR="public"
BACKUP_DIR="backups"
TEMP_UPLOAD_DIR="/tmp/cv-jolijn_upload"

# Helper functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if rbw is unlocked
check_rbw_unlocked() {
    log_info "Checking rbw (Bitwarden CLI) unlock status..."

    if ! command -v rbw &> /dev/null; then
        log_error "rbw command not found. Please install rbw first."
        exit 1
    fi

    if ! rbw unlocked &> /dev/null; then
        log_error "rbw is locked. SSH keys cannot be loaded."
        log_error "Please unlock rbw first with: rbw unlock"
        exit 1
    fi

    log_success "rbw is unlocked"
}

# Check git status
check_git_status() {
    log_info "Checking git status..."

    if ! git diff-index --quiet HEAD --; then
        log_warning "You have uncommitted changes:"
        git status --short
        read -p "Continue anyway? (y/N) " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            log_error "Deployment cancelled"
            exit 1
        fi
    else
        log_success "Working directory is clean"
    fi

    # Show current branch and commit
    CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
    CURRENT_COMMIT=$(git rev-parse --short HEAD)
    log_info "Current branch: ${CURRENT_BRANCH}"
    log_info "Current commit: ${CURRENT_COMMIT}"
}

# Clean previous build
clean_build() {
    log_info "Cleaning previous build..."
    if [ -d "$BUILD_DIR" ]; then
        rm -rf "$BUILD_DIR"
        log_success "Build directory cleaned"
    fi

    log_info "Cleaning image processing cache..."
    if [ -d "resources/_gen" ]; then
        rm -rf "resources/_gen"
        log_success "Image cache cleaned"
    fi
}

# Build Hugo site
build_hugo() {
    log_info "Building Hugo site..."

    if ! command -v hugo &> /dev/null; then
        log_error "hugo command not found. Please install hugo first."
        exit 1
    fi

    # Check minimum required Hugo version (0.148.2 extended)
    HUGO_VERSION=$(hugo version | grep -oP '\d+\.\d+\.\d+' | head -1)
    HUGO_MIN="0.148.2"
    if ! printf '%s\n%s\n' "$HUGO_MIN" "$HUGO_VERSION" | sort -V -C; then
        log_error "Hugo $HUGO_VERSION is too old. Minimum required: $HUGO_MIN"
        exit 1
    fi
    if ! hugo version | grep -q "+extended"; then
        log_error "Hugo extended edition required, but found: $(hugo version)"
        exit 1
    fi
    log_success "Hugo $HUGO_VERSION extended - version OK"

    if ! hugo --minify --cleanDestinationDir; then
        log_error "Hugo build failed"
        exit 1
    fi

    log_success "Hugo build completed successfully"
}

# Verify build
verify_build() {
    log_info "Verifying build..."

    if [ ! -d "$BUILD_DIR" ]; then
        log_error "Build directory not found"
        exit 1
    fi

    if [ ! -f "$BUILD_DIR/index.html" ]; then
        log_error "index.html not found in build directory"
        exit 1
    fi

    # Count files
    FILE_COUNT=$(find "$BUILD_DIR" -type f | wc -l)
    BUILD_SIZE=$(du -sh "$BUILD_DIR" | cut -f1)

    log_success "Build verification passed"
    log_info "Files: $FILE_COUNT"
    log_info "Size: $BUILD_SIZE"
}

# Create backup on remote
create_remote_backup() {
    log_info "Creating backup on remote server..."

    TIMESTAMP=$(date +%Y%m%d_%H%M%S)
    BACKUP_NAME="backup_${TIMESTAMP}"

    ssh "$REMOTE_HOST" "sudo mkdir -p $(dirname $REMOTE_PATH)/$BACKUP_DIR && \
        sudo cp -r $REMOTE_PATH $(dirname $REMOTE_PATH)/$BACKUP_DIR/$BACKUP_NAME && \
        sudo bash -c 'cd $(dirname $REMOTE_PATH)/$BACKUP_DIR && ls -t | tail -n +6 | xargs -I {} rm -rf {}'" || {
        log_warning "Backup creation failed (continuing anyway)"
        return 1
    }

    log_success "Backup created: $BACKUP_NAME (keeping last 5 backups)"
}

# Deploy to remote
deploy() {
    log_info "Deploying to ${REMOTE_HOST}:${REMOTE_PATH}..."

    # Test SSH connection first
    if ! ssh -q "$REMOTE_HOST" exit; then
        log_error "Cannot connect to $REMOTE_HOST"
        log_error "Please check your SSH configuration and rbw unlock status"
        exit 1
    fi

    # Create temp upload directory on remote
    log_info "Preparing temporary upload directory..."
    ssh "$REMOTE_HOST" "rm -rf $TEMP_UPLOAD_DIR && mkdir -p $TEMP_UPLOAD_DIR" || {
        log_error "Failed to prepare temp directory"
        exit 1
    }

    # Sync files to temp directory
    log_info "Uploading files to temporary directory..."
    if ! rsync -rlDvz --delete \
         "$BUILD_DIR/" "$REMOTE_HOST:$TEMP_UPLOAD_DIR/"; then
        log_error "File upload failed"
        exit 1
    fi

    # Move files to final destination with sudo
    log_info "Moving files to ${REMOTE_PATH} (requires sudo)..."
    ssh "$REMOTE_HOST" "sudo mkdir -p $REMOTE_PATH && sudo rsync -a --delete $TEMP_UPLOAD_DIR/ $REMOTE_PATH/" || {
        log_error "Failed to move files to final destination"
        exit 1
    }

    # Clean up temp directory
    ssh "$REMOTE_HOST" "rm -rf $TEMP_UPLOAD_DIR" || log_warning "Failed to clean up temp directory"

    log_success "Deployment completed successfully"
}

# Set correct permissions for nginx
set_permissions() {
    log_info "Setting permissions for nginx..."

    ssh "$REMOTE_HOST" "sudo chown -R nginx:nginx $REMOTE_PATH && \
        sudo find $REMOTE_PATH -type d -exec chmod 755 {} \; && \
        sudo find $REMOTE_PATH -type f -exec chmod 644 {} \;" || {
        log_error "Failed to set permissions"
        exit 1
    }

    log_success "Permissions set correctly (nginx:nginx, dirs:755, files:644)"
}

# Verify deployment
verify_deployment() {
    log_info "Verifying deployment..."

    # Check if index.html exists on remote
    if ! ssh "$REMOTE_HOST" "sudo [ -f $REMOTE_PATH/index.html ]"; then
        log_error "Deployment verification failed: index.html not found on remote"
        exit 1
    fi

    log_success "Deployment verified"
}

# Main deployment workflow
main() {
    echo -e "${BLUE}╔═══════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║  Hugo Release Script - cv-jolijn          ║${NC}"
    echo -e "${BLUE}╚═══════════════════════════════════════════╝${NC}"
    echo

    # Pre-deployment checks
    check_rbw_unlocked
    check_git_status

    # Confirm deployment
    echo
    log_warning "Ready to deploy to production"
    read -p "Continue with deployment? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        log_error "Deployment cancelled"
        exit 1
    fi

    # Build and deploy
    echo
    clean_build
    build_hugo
    verify_build

    echo
    create_remote_backup || true
    deploy
    set_permissions
    verify_deployment

    # Tag release and push to GitHub
    RELEASE_TAG="release-$(date +%Y%m%d%H%M)"
    git tag "$RELEASE_TAG"
    git push upstream main --tags
    log_success "Tagged and pushed release: $RELEASE_TAG"

    # Summary
    echo
    echo -e "${GREEN}╔════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║      Deployment Successful! 🚀         ║${NC}"
    echo -e "${GREEN}╚════════════════════════════════════════╝${NC}"
    echo
    log_info "Branch: $(git rev-parse --abbrev-ref HEAD)"
    log_info "Commit: $(git rev-parse --short HEAD) - $(git log -1 --pretty=%B | head -n1)"
    log_info "Time: $(date '+%Y-%m-%d %H:%M:%S')"
    echo
}

# Run main function
main "$@"
