---
title: "muratoransoy.dev (bu blog)"
date: 2026-04-22
draft: false
summary: "Şu an okuduğun site. Hugo + Blowfish, Cloudflare Pages'te yayında, iki dilde yazılıyor."
tags: ["hugo", "go", "cloudflare", "açık-kaynak"]
categories: ["web"]
externalUrl: "https://github.com/muratoransoy/blog"
showReadingTime: false
showAuthor: false
---

Şu an okuduğun sitenin kendisi.

## Neden geliştirdim

Öğrendiklerim için küçük, hızlı ve tamamen sahip olduğum bir ev istiyordum — CMS yok, reklam yok, kilitlenme yok. Bir CDN'den servis edilen statik dosyalar, versiyon kontrolünde Markdown, kontrolümde içerik.

## Stack

- **Hugo Extended** statik site üretimi için.
- **Blowfish** başlangıç teması — slate renk şeması ve birkaç CSS rötuşuyla.
- **Cloudflare Pages** hosting için (ücretsiz tier, global CDN).
- **GitHub Actions** build doğrulama ve kırık-link kontrolü için.
- **giscus** yorumlar için (arka planda GitHub Discussions).

## Ne öğrendim

- Hugo'nun i18n modeli ve dil başına `contentDir` ile URL'lerin nasıl temiz tutulduğu.
- Cloudflare Pages build pipeline'ı ve `_headers` / `_redirects` dosyalarının değeri.
- Haftalık yazmanın bir sprint değil, bir disiplin olduğu.

Kaynak kod [GitHub](https://github.com/muratoransoy/blog)'da.
