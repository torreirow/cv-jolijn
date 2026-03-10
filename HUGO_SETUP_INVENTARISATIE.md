# Hugo Website Setup Inventarisatie

**Datum**: 10 maart 2026
**Onderwerp**: CV Website Jolijn van der Toorren

## 1. Overzicht

Deze website is een persoonlijk CV/portfolio gebouwd met Hugo en het HugoBlox Academic CV template. De site presenteert professionele informatie, werkervaring, opleiding en vaardigheden van Jolijn van der Toorren.

- **Website URL**: https://jolijn.toorren.net/
- **Website Titel**: Resume H.J. van der Toorren
- **Template**: HugoBlox Academic CV (gratis versie)
- **Deployment Target**: GitHub Pages

## 2. Hugo Configuratie

### Versie Informatie
- **Hugo Versie**: 0.154.5
- **Go Versie**: 1.21.5
- **Node Versie**: 22
- **Template ID**: academic-cv
- **Go Module**: github.com/HugoBlox/kit/templates/academic-cv

### Taal Instellingen
- **Default Taal**: Engels (en)
- **Content Taal in Subdirectory**: Nee
- **CJK Taal Support**: Nee
- **Emoji Support**: Ja

### Build Configuratie
- **Write Stats**: Ja
- **Git Info**: Uitgeschakeld
- **Summary Length**: 30 woorden
- **Pagination**: 10 items per pagina
- **Robots.txt**: Uitgeschakeld
- **Timeout**: 600.000ms (10 minuten)

## 3. HugoBlox Configuratie

### Identiteit
- **Site Naam**: Jolijn van der Toorren
- **Type**: Person (schema.org)
- **Beschrijving**: Curriculum Vitae - Jolijn van der Toorren
- **Organisatie**: Geen

### Thema & Design
- **Theme Mode**: Dark
- **Theme Pack**: Matcha
- **Typografie Font**: Serif (Roboto Slab)
- **Font Size**: Medium (md)
- **Border Radius**: Medium (md)
- **Spacing**: Comfortable
- **Avatar Shape**: Square

### Header Configuratie
- **Style**: Navbar
- **Sticky**: Ja
- **Alignment**: Center
- **Search**: Uitgeschakeld
- **Theme Toggle**: Uitgeschakeld
- **Theme Picker**: Uitgeschakeld
- **Language Switcher**: Uitgeschakeld
- **CTA Button**: Uitgeschakeld

### Footer
- **Style**: Minimal
- **Language Switcher**: Uitgeschakeld

### Copyright
- **Type**: Creative Commons
- **Allow Derivatives**: Ja
- **Share Alike**: Nee
- **Allow Commercial**: Nee
- **Notice**: "© {year} {name}. This work is licensed under {license}"

### Content Features
- **Math Rendering**: Uitgeschakeld
- **Table of Contents**: Ingeschakeld
- **Reading Time**: Ingeschakeld
- **Citations Style**: APA

### Functionaliteiten
- **Search**: Uitgeschakeld
- **Comments**: Uitgeschakeld
- **Analytics**: Niet geconfigureerd
- **Repository Links**: Uitgeschakeld

### Privacy & Security
- **Privacy Mode**: Ingeschakeld
- **Anonymize Analytics**: Ja
- **Frame Options**: Allow
- **Debug Mode**: Uitgeschakeld

### SEO & AI
- **AI/LLM Crawling**: Niet toegestaan (disallowed: /)
- **Note**: "AI/LLM crawling is not permitted on this site."

## 4. Hugo Modules

De website gebruikt de volgende Hugo modules:

```yaml
imports:
  - github.com/HugoBlox/kit/modules/integrations/netlify
  - github.com/HugoBlox/kit/modules/blox
  - github.com/HugoBlox/kit/modules/slides
```

### Module Mounts
- **Community Blox**: hugo-blox/blox/community → layouts/_partials/blox/community/
- **All-Access Blox**: hugo-blox/blox/all-access → layouts/_partials/blox/
- **Blox CSS**: hugo-blox/blox → assets/dist/community/blox/

## 5. Menu Structuur

Huidige navigatie menu items:

1. **Bio** (/) - Weight: 10
2. **Experience** (/experience/) - Weight: 20

Uitgeschakeld (commentaar):
- Papers
- Talks
- News
- Projects
- Courses

## 6. Directory Structuur

```
cv-jolijn/
├── assets/
│   └── media/
│       ├── authors/
│       └── icons/
├── config/
│   └── _default/
│       ├── hugo.yaml
│       ├── params.yaml
│       ├── menus.yaml
│       ├── module.yaml
│       └── languages.yaml
├── content/
│   ├── _index.md           # Homepage
│   ├── experience.md       # Ervaring pagina
│   ├── authors/            # Author profielen
│   ├── blog/               # Blog posts
│   ├── courses/            # Cursus materiaal
│   ├── events/             # Events/talks
│   ├── projects/           # Project portfolio
│   ├── publications/       # Publicaties
│   └── slides/             # Presentaties
├── data/
│   └── authors/
│       └── me.yaml         # Persoonlijke gegevens
├── layouts/
│   └── _partials/
│       ├── blox/
│       └── hooks/
├── static/
│   ├── js/
│   ├── uploads/
│   │   └── resume-jolijn_van_der_toorren.pdf
│   └── robots.txt
├── public/                 # Build output
├── resources/              # Hugo resources cache
├── _vendor/                # Vendored modules
├── hugo.yaml              # Hoofd config
├── hugoblox.yaml          # HugoBlox config
├── go.mod                 # Go module definitie
├── package.json           # NPM dependencies
├── pnpm-lock.yaml         # PNPM lockfile
└── netlify.toml           # Netlify deployment config
```

## 7. Content Structuur

### Homepage (_index.md)

De homepage gebruikt een "landing" type pagina met de volgende secties:

1. **Resume Biography Block** (resume-biography-3)
   - Username: me
   - CV Download Button: /uploads/resume-jolijn_van_der_toorren.pdf
   - Gradient Mesh Background: Ingeschakeld
   - Avatar Size: Medium (200px)
   - Avatar Shape: Circle
   - Name Size: Medium

2. **Markdown Block** (demo: true)
   - Titel: "📚 My Research"
   - Demo content over research

3. **Collection Blocks** (demo: true)
   - Featured Publications
   - Recent Publications
   - Recent & Upcoming Talks
   - Recent News

4. **CTA Card** (demo: true)
   - HugoBlox promotional content

**Let op**: Veel secties zijn gemarkeerd als "demo: true" en kunnen verwijderd worden.

## 8. Author Systeem (data/authors/me.yaml)

### Persoonlijke Informatie
- **Slug**: me
- **Display Name**: Jolijn van der Toorren
- **Voornaam**: Jolijn
- **Achternaam**: van der Toorren
- **Rol**: Student
- **Status Icon**: 🎓

### Bio
Jolijn van der Toorren is een student International Public Policy and Leadership aan The Hague University of Applied Sciences, met een sterke interesse in maatschappelijke vraagstukken, publieke dienstverlening en effectieve communicatie.

### Links
- E-mail: jolijn@toorren.net
- LinkedIn: https://www.linkedin.com/in/jolijn-van-der-toorren-59a0b3301/

### Interesses
- Debate and structured argumentation
- Writing and analytical reflection
- Classical music appreciation and playing
- Swimming

### Opleidingen (3)
1. **International Public Policy and Leadership**
   - Instelling: The Hague University of Applied Sciences
   - Start: 2024-09-01
   - Status: Lopend

2. **Foundation Year (Basisjaar)**
   - Instelling: Evangelische Hogeschool Amersfoort
   - Periode: 2023-09-01 tot 2024-07-31

3. **High School Diploma (HAVO)**
   - Instelling: Christelijk College Groevenbeek
   - Periode: 2018-08-01 tot 2023-07-31
   - Eindcijfer: 8

### Werkervaring (8 posities)
1. Public Engagement Officer - Museon-Omniversum (2025-03 - present)
2. Housekeeper - Zorggroep Noordwest-Veluwe (2024-05 - 2024-08)
3. Customer Service Assistant - GAMMA Nederland (2023-12 - 2024-07)
4. Housekeeper - Zorggroep Noordwest-Veluwe (2023-06 - 2023-09)
5. Sales Assistant - Shoeby (2021-06 - 2023-01)
6. Hospitality Intern - Zorggroep Noord-West Veluwe (2021 - 2022)
7. Field Management Volunteer - Stichting Opwekking (2024-06 - 2024-06)
8. Promotional Staff Member - Evangelische Hogeschool (2023-01 - 2024-12)
9. Swimming Coach - Z&PC Triton (2024-01 - 2025-12)

### Vaardigheden (3 categorieën)

**Communication & Public Engagement**
- Public Communication: Level 4
- Customer Service: Level 4
- Interpersonal Communication: Level 4
- Written Communication: Level 4

**Policy & Analytical Skills**
- Policy Analysis: Level 2
- Analytical Thinking: Level 3
- Research Skills: Level 4
- Critical Thinking: Level 4

**Professional & Organizational Skills**
- Teamwork: Level 4
- Time Management: Level 3
- Responsibility & Reliability: Level 4
- Adaptability: Level 3

### Talen
- Nederlands: Level 5 (Native)
- Engels: Level 4.95 (Proficiency)
- Portugees: Level 2.4 (Intermediate)

### Awards
**Let op**: Bevat nog demo data (Best Paper Award - NeurIPS 2022) die verwijderd moet worden.

## 9. Build Systeem

### Dependencies (package.json)
```json
{
  "dependencies": {
    "@tailwindcss/cli": "^4.1.12",
    "@tailwindcss/typography": "^0.5.10",
    "pagefind": "^1.4.0",
    "preact": "^10.27.2",
    "tailwindcss": "^4.1.12"
  }
}
```

### Build Scripts
- **dev**: `hugo server --disableFastRender`
- **build**: `hugo --minify && pnpm run pagefind`
- **pagefind**: `pagefind --site public`

### Package Manager
- **PNPM**: 10.14.0

## 10. Deployment (Netlify)

### Build Command
```bash
pnpm install --verbose --no-frozen-lockfile
hugo --gc --minify -b $URL --logLevel debug --printI18nWarnings --printPathWarnings
pnpm run pagefind
```

### Publish Directory
- **public/**

### Environment Variables
- HUGO_VERSION: 0.154.5
- GO_VERSION: 1.21.5
- NODE_VERSION: 22
- HUGO_ENABLEGITINFO: true
- HUGO_LOG_I18N_WARNINGS: true
- FORCE_COLOR: 1

### Plugins
- netlify-plugin-hugo-cache-resources

### Deployment Contexten
1. **Production**: HUGO_ENV=production
2. **Deploy Preview**: Build met --buildFuture flag
3. **Branch Deploy**: Standaard build

## 11. Taxonomieën

Geconfigureerde taxonomieën:
- **author**: authors
- **tag**: tags
- **publication_type**: publication_types

## 12. Output Formaten

### Home Page
- HTML
- RSS
- headers
- redirects
- backlinks

### Section Pages
- HTML
- RSS

## 13. Imaging Configuratie

- **Resample Filter**: Lanczos
- **Quality**: 90
- **Anchor**: Smart
- **Hint**: Picture

## 14. Opgemerkte Issues & Aandachtspunten

### Demo Content
De volgende items bevatten nog demo/placeholder content en moeten aangepast of verwijderd worden:
1. **_index.md**: Meerdere blokken met `demo: true`
2. **me.yaml**: Award sectie bevat demo data (NeurIPS 2022)
3. **Content directories**: blog/, courses/, events/, projects/, publications/, slides/ bevatten waarschijnlijk demo content

### Git Status
Huidige wijzigingen (uncommitted):
- M content/_index.md
- M data/authors/me.yaml
- ?? static/uploads/resume-jolijn_van_der_toorren.pdf

### Aanbevelingen
1. Verwijder alle demo content uit _index.md
2. Verwijder demo award uit me.yaml
3. Controleer en verwijder ongebruikte content directories
4. Commit recente wijzigingen
5. Overweeg uitschakelen van ongebruikte features (search, comments, analytics)
6. Voeg LinkedIn handle toe aan social configuration indien gewenst

## 15. Technische Stack Samenvatting

**Static Site Generator**: Hugo 0.154.5
**Framework**: HugoBlox Kit (Academic CV template)
**Styling**: Tailwind CSS v4
**Frontend Framework**: Preact
**Search**: Pagefind
**Package Manager**: PNPM 10.14.0
**Hosting**: Netlify (configured) / GitHub Pages (intended)
**Version Control**: Git
**Content Format**: Markdown, YAML
**Programming Language**: Go 1.21.5

## 16. URLs & Links

- **Production URL**: https://jolijn.toorren.net/
- **CV Download**: /uploads/resume-jolijn_van_der_toorren.pdf
- **HugoBlox Docs**: https://docs.hugoblox.com/
- **Template Repository**: https://github.com/HugoBlox/hugo-theme-academic-cv
