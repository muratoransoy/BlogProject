---
title: "Setting up a multilingual Hugo blog on Cloudflare Pages"
date: 2026-04-22T18:00:00+03:00
draft: false
summary: "How I shipped a bilingual (EN + TR) Hugo + Blowfish blog to Cloudflare Pages without spending a cent — and the one i18n gotcha that ate an hour."
tags: ["hugo", "i18n", "cloudflare", "static-site", "blowfish"]
categories: ["web"]
showReadingTime: true
showTableOfContents: true
showWordCount: true
---

I just shipped this blog. The whole thing — bilingual content, dark mode, RSS, sitemap, deploy pipeline — runs on free tiers and a single static site generator. Total bill: nothing. This is how it came together, and the one i18n gotcha that ate an hour of my life.

## The stack

Nothing fancy:

- **[Hugo Extended](https://gohugo.io/)** — the static site generator. Fast, single binary, mature.
- **[Blowfish](https://blowfish.page/)** — Hugo theme. Minimalist, dark by default, native i18n.
- **[Cloudflare Pages](https://pages.cloudflare.com/)** — hosting. Free tier covers everything I need.
- **[GitHub](https://github.com/)** — source of truth, plus Actions for build verification.

That's it. No CMS. No backend. No database. Just Markdown in a git repo and a static build pipeline.

## Project layout

The directory structure is the standard Hugo skeleton, with one important addition: per-language `contentDir`.

```text
.
├── archetypes/
├── assets/
├── config/_default/
│   ├── hugo.toml
│   ├── languages.en.toml
│   ├── languages.tr.toml
│   ├── menus.en.toml
│   ├── menus.tr.toml
│   └── params.toml
├── content/
│   ├── en/
│   │   └── posts/
│   └── tr/
│       └── posts/
├── static/
└── themes/blowfish/   # git submodule
```

The Blowfish theme is added as a git submodule:

```bash
git submodule add -b main https://github.com/nunocoracao/blowfish.git themes/blowfish
```

Every config file in `config/_default/` overrides only the keys you change — the rest is inherited from the theme. That keeps your project files small and lets you pull theme upgrades cleanly.

## The i18n gotcha

Here's the thing that cost me an hour.

I structured my content as `content/en/...` and `content/tr/...`, set `defaultContentLanguage = "en"`, left `defaultContentLanguageInSubdir = false`, and expected English to live at the URL root.

Hugo built the site happily. The English homepage was at `/`. So far so good.

But every English section — `/posts/`, `/projects/`, `/about/` — returned a 404. The actual content was at `/en/posts/`, `/en/projects/`, etc. Turkish, meanwhile, was perfectly happy at `/tr/...`.

The fix is one line per language:

```toml
# config/_default/languages.en.toml
contentDir = "content/en"

# config/_default/languages.tr.toml
contentDir = "content/tr"
```

When you have content under `content/{lang}/` directories, Hugo doesn't infer the relationship automatically — it tries both interpretations and lands somewhere awkward in between. Setting `contentDir` explicitly tells Hugo: "this directory IS the content root for this language." After that, English lives at `/`, Turkish at `/tr/`, and everything works.

> **Lesson**: when in doubt, be explicit. Hugo's defaults are great until two of them conflict.

## Free-tier deployment

Cloudflare Pages connects to GitHub, watches a branch, and rebuilds on every push. The setup is:

1. Push the repo to GitHub.
2. In the Cloudflare dashboard, create a new Pages project, pick the repo.
3. Set the build command: `hugo --gc --minify`.
4. Set the build output directory: `public`.
5. Set the environment variable `HUGO_VERSION` to whatever version your local install uses.

That's the entire deploy story. Cloudflare gives you `*.pages.dev` for free, with a global CDN, automatic HTTPS, and preview deploys for every branch.

For analytics, **Cloudflare Web Analytics** is free, cookie-less, and does not require a banner. For comments, **giscus** uses GitHub Discussions and is free for any public repo. None of this costs anything as long as the site doesn't go viral.

## What I'd do differently

A few things I'd change if I started over:

- **Pick the theme last.** I evaluated four themes before settling on Blowfish, and each migration would have been cheaper if I'd started with my own minimal layouts and added the theme later.
- **Write `_headers` early.** Cloudflare Pages reads a `_headers` file in the build output and applies HTTP headers from it. Adding security headers (`Content-Security-Policy`, `Referrer-Policy`, `Permissions-Policy`) is a five-minute job and gets you an A on securityheaders.com.
- **Set up Actions on day one.** A GitHub Actions workflow that runs `hugo` + `lychee` (broken link check) on every PR catches dead links before they go live, which is worth the 30 seconds of CI time.

## What's next

Now that the site is up, the goal is one post a week — concrete, technical, and short enough to actually finish.

The source for this blog is on [GitHub](https://github.com/muratoransoy/blog). If you spot something broken, open an issue.
