# Sprint Planı — Blog & Portfolio

> Toplam tahmini süre: **5-6 sprint** (her sprint ~1 hafta, esnek)
> Yöntem: Faz faz ilerleme, her sprint sonunda çalışan bir artifact.

---

## 🏁 Sprint 1 — İskelet & Tema Kurulumu

**Hedef**: Localhost'ta çalışan, çift dilli, Blowfish temalı temel Hugo sitesi.

| # | Task | Tahmini | Kabul kriteri |
|---|---|---|---|
| 1.1 | Hugo Extended kurulumu (Windows, latest) | 15dk | `hugo version` extended yazıyor |
| 1.2 | `hugo new site` ile proje init | 10dk | Klasör yapısı oluştu |
| 1.3 | Git init + `.gitignore` (Hugo template) | 10dk | İlk commit atıldı |
| 1.4 | Blowfish temasını submodule olarak ekle | 20dk | `themes/blowfish/` mevcut |
| 1.5 | Temel `hugo.toml` config (site adı, baseURL placeholder, dil, tema) | 30dk | `hugo server` hatasız çalışıyor |
| 1.6 | i18n setup (en default + tr) | 30dk | `/` ve `/tr/` URL'leri çalışıyor |
| 1.7 | Menü yapısı (Home, Posts, Projects, About, Uses, Now) | 30dk | Tüm menüler render oluyor |
| 1.8 | "Hello World" örnek post (en + tr) | 15dk | İki dilde post listede görünüyor |

**Çıktı**: `localhost:1313` üzerinde gezilebilir, çift dilli iskelet site.

---

## 🎨 Sprint 2 — Görünüm & Ana Sayfa Polish

**Hedef**: Minimalist, kişisel, "developer kimliği" yansıtan görünüm.

| # | Task | Tahmini | Kabul kriteri |
|---|---|---|---|
| 2.1 | Renk paleti & tipografi seçimi (Blowfish color scheme) | 30dk | Minimalist, dark mode default |
| 2.2 | Ana sayfa: hero + kısa bio + son postlar + featured projects | 1.5sa | Tek sayfada profil + öne çıkanlar |
| 2.3 | Avatar/profil görseli + social links (`data/social.yaml`) | 30dk | GitHub, LinkedIn, X, email ikonları |
| 2.4 | Favicon, OG image, site logosu | 45dk | Tarayıcı sekmesi + paylaşımda görünüyor |
| 2.5 | Dark/light mode toggle aktif & kontrol | 15dk | Toggle çalışıyor, tercih hatırlanıyor |
| 2.6 | Custom CSS override'ları (gerekirse `assets/css/custom.css`) | 1sa | Spacing, typography ince ayar |
| 2.7 | 404, search, taxonomy sayfaları kontrol | 30dk | Tüm yan sayfalar düzgün |

**Çıktı**: Görünüş olarak "yayına hazır" hisseden ana sayfa.

---

## 📝 Sprint 3 — İçerik Sayfaları (About, Projects, Uses, Now, CV)

**Hedef**: Tüm statik bölümlerin içeriklerle dolu olması.

| # | Task | Tahmini | Kabul kriteri |
|---|---|---|---|
| 3.1 | **About** sayfası (en+tr) — kim, ne yapıyor, deneyim, eğitim | 1sa | İki dilde tam içerik |
| 3.2 | **Tech stack** bölümü (`data/tech-stack.yaml` + layout) | 1sa | İkonlu kategorize liste (lang, framework, tool) |
| 3.3 | **Projects** sayfası — 3-5 proje kartı, açıklama, tech, link | 1.5sa | Her proje için ayrı `.md`, listede kartlar |
| 3.4 | _(Opsiyonel)_ GitHub repo otomatik fetch (Hugo `getJSON` + GH API) | 2sa | Build sırasında pinned repo'lar çekiliyor |
| 3.5 | **Uses** sayfası — donanım, yazılım, editör, terminal vs. | 45dk | Tek sayfa, kategorize liste |
| 3.6 | **Now** sayfası — şu an üzerinde çalıştıkların | 30dk | Tek sayfa, tarih damgalı |
| 3.7 | CV PDF'i `static/cv.pdf` + About'tan link | 15dk | İndirilebilir |
| 3.8 | İletişim sayfası (form yerine: email, social, calendly opsiyonel) | 30dk | Form yok, direkt linkler |

**Çıktı**: Site tüm bölümleriyle tamamlanmış, sadece blog post sayısı az.

---

## ✍️ Sprint 4 — Blog Pipeline & İlk Yazılar

**Hedef**: Blog yazma deneyimi smooth, ilk 2-3 yazı yayında.

| # | Task | Tahmini | Kabul kriteri |
|---|---|---|---|
| 4.1 | `archetypes/posts.md` — frontmatter şablonu | 30dk | `hugo new posts/x.md` doğru template'i veriyor |
| 4.2 | Cover image pipeline (Hugo image processing, WebP dönüşüm) | 1sa | JPG koy → WebP servis ediliyor |
| 4.3 | Tag/kategori sayfaları, okuma süresi, TOC | 30dk | Her postta TOC + reading time |
| 4.4 | Code block: copy butonu, dil etiketi, line numbers | 30dk | Chroma config tamam |
| 4.5 | İlk gerçek blog yazısı (en+tr) | 2sa | Yayında |
| 4.6 | RSS feed kontrolü (`/index.xml`) | 15dk | Feed validator pass |
| 4.7 | Sitemap + robots.txt kontrolü | 15dk | `/sitemap.xml` mevcut |
| 4.8 | SEO meta tags (Open Graph, Twitter Card) per-post | 30dk | sharepreview.com'da düzgün |

**Çıktı**: Blog yazma akışı hazır, RSS abone olunabilir.

---

## 💬 Sprint 5 — Yorum, Analytics, CI/CD, Deploy

**Hedef**: Site internette canlı, yorum + analytics çalışıyor, CI yeşil.

| # | Task | Tahmini | Kabul kriteri |
|---|---|---|---|
| 5.1 | giscus kurulumu (GH Discussions enable + config) | 30dk | Postların altında yorum kutusu |
| 5.2 | Cloudflare Web Analytics script entegrasyonu | 15dk | CF dashboard'da pageview görünüyor |
| 5.3 | GitHub repo oluştur + push (`muratoransoy/blog`) | 15dk | Repo public, README var |
| 5.4 | GitHub Actions: Hugo build verify workflow | 45dk | Her PR'da build kontrol |
| 5.5 | GitHub Actions: lychee broken-link check | 30dk | Kırık link → CI fail |
| 5.6 | Cloudflare Pages bağla (GH integration) | 30dk | `*.pages.dev` URL'i canlı |
| 5.7 | Branch deploy: `main` → prod, `dev` → preview | 15dk | Preview URL üretiliyor |
| 5.8 | `_headers`, `_redirects` dosyaları (security headers, www→apex) | 30dk | securityheaders.com A skoru |

**Çıktı**: `https://muratoransoy-blog.pages.dev` (veya benzeri) yayında.

---

## 🌐 Sprint 6 — Domain, SEO, Performans Polish

**Hedef**: Profesyonel domain + Lighthouse 95+ skoru.

| # | Task | Tahmini | Kabul kriteri |
|---|---|---|---|
| 6.1 | Domain ismi brainstorm (aşağıda öneriler) | — | Karar verildi |
| 6.2 | Domain satın alma (Cloudflare Registrar — at-cost, ucuz) | 15dk | Domain elde |
| 6.3 | Cloudflare DNS + Pages custom domain | 30dk | HTTPS aktif, www→apex redirect |
| 6.4 | `baseURL` güncelle, OG image URL'leri kontrol | 15dk | Mutlak URL'ler doğru |
| 6.5 | Lighthouse audit + iyileştirmeler | 1sa | Performance/SEO/A11y 95+ |
| 6.6 | Google Search Console + Bing kayıt + sitemap submit | 30dk | İndexlenme başladı |
| 6.7 | Schema.org JSON-LD (Person, BlogPosting) | 45dk | Rich Results Test pass |
| 6.8 | Final QA checklist (tüm linkler, formlar, mobil) | 1sa | ✅ |

**Çıktı**: `https://your-domain.dev` üzerinde profesyonel, hızlı, SEO-uyumlu site.

### 🎯 Domain ismi önerileri (beyin fırtınası — Faz 6'da karar)
- `muratoransoy.dev` — klasik, profesyonel ✅
- `muratoransoy.com` — global, daha pahalı
- `oransoy.dev` — kısa, şık
- `murat.codes` — modern, dev odaklı
- `muratbuilds.dev` — eylem odaklı
- _Senin önerilerin?_

---

## 📊 Backlog (Sprint sonrası, opsiyonel)

- [ ] Mailing list (Buttondown free tier — istersen Sprint 7)
- [ ] Series/multi-part post desteği
- [ ] Webmentions
- [ ] Algolia veya Pagefind ile arama
- [ ] Türkçe-İngilizce post arası link badge'i
- [ ] OG image otomatik üretimi (Cloudflare Workers)
- [ ] Hit counter / popular posts
- [ ] i18n için tema string çevirileri (TR)

---

## 🚦 İlerleme stratejisi
1. **Her sprint sonunda commit + push** — geri dönülebilirlik için
2. **Her sprint için ayrı branch**: `sprint/01-skeleton`, `sprint/02-design`...
3. **Sprint sonu mini-retro**: ne çalıştı, ne çalışmadı (`docs/retro/sprintN.md`)
4. **Acele yok** — kalite > hız (kullanıcı isteği)

---

## ▶️ Sıradaki adım
Senden onay/cevap beklediğim 5 nokta:
1. **Tema**: Blowfish ✅ mı, yoksa PaperMod mu?
2. **Repo adı**: domain seçilene kadar `blog` mu?
3. **Lisans**: kod MIT, içerik CC BY 4.0 — uygun mu?
4. **Cover image**: postlarda zorunlu mu, opsiyonel mi?
5. **Sprint 1'e başlayalım mı?** (Hugo kurulumundan başlıyoruz)
