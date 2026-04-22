# Faz 0 — Ar-Ge & Mimari Kararlar

> Hazırlandığı tarih: 2026-04-22
> Karar verici: Murat Oransoy

## 1. Hedef
Murat'ın **kişisel developer blog + portfolio** sitesi. Hugo (Go) ile statik site, GitHub'da kaynak, Cloudflare Pages'te ücretsiz host, ileride özel domain.

**Bütçe ilkesi**: Tüm bileşenler **open-source veya ücretsiz tier** olmalı. Ücretli servis kullanımı yalnızca son çare.

---

## 2. Teknoloji Yığını (Stack)

| Katman | Seçim | Maliyet | Neden |
|---|---|---|---|
| Static Site Generator | **Hugo Extended (latest)** | Ücretsiz | Hızlı build, mükemmel i18n, SCSS desteği |
| Tema | **Blowfish** (öneri) veya PaperMod | Ücretsiz, MIT | Bkz. §3 |
| Versiyon kontrolü | GitHub | Ücretsiz | İstek doğrultusunda |
| CI/CD | GitHub Actions | Ücretsiz (public repo) | Lint, broken-link check, build verify |
| Hosting | Cloudflare Pages | Ücretsiz | 500 build/ay, sınırsız bandwidth, global CDN |
| Yorum | giscus (GitHub Discussions) | Ücretsiz | Dev-friendly, spam yok, GH login |
| Analytics | Cloudflare Web Analytics | Ücretsiz | Cookie-less, GDPR uyumlu |
| Görsel CDN | `static/` → ileride R2 (10GB free) | Ücretsiz | Cloudflare Images $5/ay olduğu için elendi |
| Domain | _Henüz alınmadı_ | ~$10-15/yıl | En son adım (Faz 5) |
| Syntax highlighting | Hugo Chroma (built-in) | Ücretsiz | Ek bağımlılık yok |

---

## 3. Tema Karşılaştırması

İhtiyaçlar: minimalist, i18n (EN+TR), dark mode, blog + portfolio + projects + uses + now sayfaları, giscus desteği.

| Tema | Artıları | Eksileri | Skor |
|---|---|---|---|
| **Blowfish** ⭐ | Native portfolio/projects layout, mükemmel i18n, dark mode default, giscus built-in, tech-stack showcase, aktif geliştirme, Tailwind-based modern UI | Biraz daha "kalabalık" — minimalist için config kısma gerek | **Önerilen** |
| **PaperMod** | Çok popüler, ultra hafif, basit, hızlı, i18n iyi, dark mode | Portfolio için ekstra layout yazmak gerek, "uses/now" gibi sayfalar manuel | Alternatif |
| **Anubis** | Aşırı minimalist (terminal hissi) | Portfolio yok, az özellik | Eleme |
| **hugo-profile** | Portfolio-first | Blog ikincil, daha az esnek | Eleme |

**Karar (önerim)**: **Blowfish**. Sebep: tüm istenen sayfalar (portfolio, tech stack, projects, about) hazır gelir; minimalist görünüm config ile elde edilir; çift dil ilk sınıf vatandaş; giscus + analytics tek satırla aktif olur.

> Onayını bekliyorum — istersen PaperMod ile gidelim, ama o zaman portfolio/uses/now sayfaları için custom layout yazmamız gerekir (~+2 task).

---

## 4. Mimari Kararlar

### 4.1 Klasör yapısı
```
BlogProject/
├── .github/workflows/        # CI: build verify, link check
├── archetypes/               # Yeni içerik şablonları (post, project)
├── assets/                   # SCSS, JS (Hugo pipeline)
├── content/
│   ├── en/                   # İngilizce içerik (varsayılan)
│   │   ├── _index.md
│   │   ├── about/
│   │   ├── posts/
│   │   ├── projects/
│   │   ├── uses/
│   │   └── now/
│   └── tr/                   # Türkçe içerik
│       └── (aynı yapı)
├── data/                     # Tech stack, social links (YAML)
├── i18n/                     # UI çeviri stringleri
├── layouts/                  # Tema override'ları
├── static/                   # Görseller, CV.pdf, favicon
├── themes/blowfish/          # Submodule
├── docs/                     # Bu planlama dokümanları
├── hugo.toml                 # Ana config
└── README.md
```

### 4.2 i18n stratejisi
- **Default dil**: `en` (URL: `site.com/posts/...`)
- **İkincil dil**: `tr` (URL: `site.com/tr/posts/...`)
- Her post'un her iki dilde olması **zorunlu değil** — bir dilde yazıp diğerini sonra ekleyebilirsin.

### 4.3 İçerik tipleri
- `posts/` — Blog yazıları (haftalık 1)
- `projects/` — Portfolio projeleri (manuel + opsiyonel GitHub API ile auto-fetch)
- `uses/` — Kullandığın araçlar (tek sayfa)
- `now/` — Şu an ne yapıyorsun (tek sayfa, nownownow.com formatı)
- `about/` — Hakkımda + tech stack

### 4.4 Frontmatter standardı (posts)
```yaml
---
title: "..."
date: 2026-04-22
draft: false
tags: ["go", "hugo"]
categories: ["devops"]
summary: "..."
cover:
  image: "cover.webp"
  alt: "..."
showReadingTime: true
---
```

### 4.5 GitHub repo stratejisi
- Repo adı: `blog` veya `muratoransoy.dev` (domain alındığında)
- **Public** (Cloudflare Pages free + GH Actions free için)
- `main` branch → otomatik prod deploy
- `dev` branch → preview deploy (Cloudflare Pages preview URL)
- Hugo tema → **git submodule** (güncellemeleri kolayca çekmek için)

### 4.6 CI/CD akışı
```
push (main) → GitHub Actions:
  1. Hugo build (link check, --gc --minify)
  2. lychee ile broken link check
  3. ✅ → Cloudflare Pages otomatik webhook ile deploy
```

---

## 5. Açık Sorular / Kararlar
1. **Tema**: Blowfish onayı bekleniyor (önerim). 
2. **GitHub repo adı**: domain seçilene kadar `blog` mu, yoksa `muratoransoy.github.io` mu?
3. **Lisans**: İçerik (CC BY 4.0?) ve kod (MIT?) lisansları onayı.
4. **Görsel formatı**: WebP standardı kabul mü? (Hugo image processing ile otomatik dönüşüm)
5. **Cover image**: Her post için zorunlu mu, opsiyonel mi?

Bu sorular cevaplandığında Faz 1'e (sprint planı) geçebiliriz; ben şimdilik backlog'u en olası kararlarla hazırladım — `01-sprint-plan.md`.
