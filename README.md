# BlogProject

Murat Oransoy's personal developer blog + portfolio.

## Stack

- **SSG** — Hugo Extended (v0.160.1)
- **Theme** — [Blowfish](https://blowfish.page/) (git submodule)
- **Languages** — English (default) + Türkçe (i18n with explicit `contentDir` per language)
- **Host** — Cloudflare Pages (free tier)
- **Repo** — GitHub
- **CI** — GitHub Actions (Hugo build verify + lychee link check)
- **Comments** — giscus (GitHub Discussions)
- **Analytics** — Cloudflare Web Analytics (cookie-less)

## Status

| Sprint | Scope | Status |
| --- | --- | --- |
| 0 | Planning, R&D | ✅ done |
| 1 | Hugo skeleton + Blowfish + i18n | ✅ done |
| 2 | Slate color, dark mode, avatar/favicon, custom CSS | ✅ done |
| 3 | About, Projects, Uses, Now content (EN+TR) | ✅ done |
| 4 | Archetypes + first technical post (EN+TR) | ✅ done |
| 5 | giscus, CF Analytics, security headers, CI workflows | ✅ code in place — manual deploy steps in `docs/02-deploy-guide.md` |
| 6 | Domain + launch | 🔜 awaiting domain purchase |

## Local development

```bash
# Clone with the theme submodule
git clone --recurse-submodules https://github.com/muratoransoy/blog.git

# Run dev server
hugo server

# Production build
hugo --gc --minify
```

## New content

```bash
hugo new content posts/<slug>/index.md
hugo new content projects/<slug>/index.md
```

Both archetypes set `draft: true` by default — flip to `false` when ready.

## Documentation

- [docs/00-research.md](docs/00-research.md) — stack decisions, theme comparison
- [docs/01-sprint-plan.md](docs/01-sprint-plan.md) — 6-sprint backlog (this is the plan that was followed)
- [docs/02-deploy-guide.md](docs/02-deploy-guide.md) — manual GitHub / Cloudflare / giscus setup
- [docs/03-domain-and-launch.md](docs/03-domain-and-launch.md) — domain shortlist + pre-launch QA checklist

## License

- Code: MIT (see `LICENSE` once added)
- Content (`content/`): CC BY 4.0
