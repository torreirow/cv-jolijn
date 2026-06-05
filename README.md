# CV Jolijn van der Toorren

Persoonlijke CV-website van Jolijn van der Toorren, gebouwd met [Hugo](https://gohugo.io/) en het [HugoBlox Academic CV](https://hugoblox.com/templates/academic-cv/) template.

**Live**: [jolijn.toorren.net](https://jolijn.toorren.net/)

---

## Ontwikkelen

### Met Nix (aanbevolen)

De repository bevat een `flake.nix` die een complete ontwikkelomgeving opzet met alle benodigde tools:

| Tool | Doel |
| :--- | :--- |
| `hugo` | Static site generator |
| `nodejs_20` + `pnpm` | Frontend build (Tailwind CSS, Pagefind) |
| `go` | Hugo modules (HugoBlox dependencies) |
| `git` | Versie beheer en Hugo module downloads |
| `hugoblox` | HugoBlox CLI (via `npx hugoblox@latest`) |

```bash
# Activeer de dev shell (start automatisch zsh)
nix develop
```

Na activering zijn alle tools beschikbaar en toont de shell de actieve Hugo versie.

### Zonder Nix

Installeer handmatig: Hugo 0.154.5+, Go 1.21.5+, Node 22+, pnpm.

---

## Lokale ontwikkelserver

```bash
cd cv-jolijn
pnpm install
pnpm run dev
```

De site is dan beschikbaar op [http://localhost:1313](http://localhost:1313).

---

## Content bewerken

### Via Quiqr (aanbevolen)

De map `cv-jolijn/quiqr/` bevat een configuratie voor [Quiqr](https://quiqr.org/), een desktop CMS voor Hugo. Open het project in Quiqr voor een grafische editor.

Beschikbare secties in Quiqr:

- **CV Profiel** — alle CV-data: naam, biografie, werkervaring, opleiding, vaardigheden, talen (`data/authors/me.yaml`)
- **Opleiding** — detailpagina's per opleiding (`content/education/`)
- **Projecten** — projectportfolio (`content/projects/`)
- **Blog** — nieuwsberichten en artikelen (`content/blog/`)

### Handmatig

De belangrijkste bestanden:

| Bestand | Inhoud |
| :--- | :--- |
| `data/authors/me.yaml` | Alle CV-data (naam, ervaring, vaardigheden, talen) |
| `content/_index.md` | Homepage blokken |
| `content/experience.md` | Ervaring-pagina blokken |
| `content/education/*.md` | Opleidingspagina's |
| `config/_default/params.yaml` | Thema, kleuren en site-instellingen |

---

## Publiceren

De site wordt automatisch gepubliceerd via het `release.sh` script:

```bash
./release.sh
```

Dit bouwt de site, maakt een release-tag aan en pusht naar GitHub Pages.

---

## Projectstructuur

```
jolijn-cv/
├── cv-jolijn/           # Hugo site
│   ├── config/_default/ # Hugo configuratie (hugo.yaml, params.yaml, menus.yaml)
│   ├── content/         # Markdown content
│   ├── data/authors/    # CV-data (me.yaml)
│   ├── assets/          # CSS en media
│   ├── static/uploads/  # CV PDF
│   └── quiqr/           # Quiqr CMS configuratie
├── flake.nix            # Nix dev shell
└── papers/              # Academische literatuur en leesfiches
```
