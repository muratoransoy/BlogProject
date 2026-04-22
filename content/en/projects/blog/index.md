---
title: "muratoransoy.dev (this blog)"
date: 2026-04-22
draft: false
summary: "The site you're reading. Hugo + Blowfish, deployed to Cloudflare Pages, written in two languages."
tags: ["hugo", "go", "cloudflare", "open-source"]
categories: ["web"]
externalUrl: "https://github.com/muratoransoy/blog"
showReadingTime: false
showAuthor: false
---

The very site you're reading.

## Why I built it

I wanted a small, fast, fully-owned home for the things I learn — without a CMS, without ads, without lock-in. Static files served from a CDN, Markdown in version control, content I control.

## Stack

- **Hugo Extended** for the static site generation.
- **Blowfish** as a starting theme, with a slate color scheme and a few CSS tweaks.
- **Cloudflare Pages** for hosting (free tier, global CDN).
- **GitHub Actions** for build verification and broken-link checking.
- **giscus** for comments (GitHub Discussions under the hood).

## What I learned

- Hugo's i18n model and how `contentDir` per language keeps URLs clean.
- Cloudflare Pages' build pipeline and the value of `_headers` / `_redirects`.
- That writing weekly is a discipline, not a sprint.

The source is on [GitHub](https://github.com/muratoransoy/blog).
