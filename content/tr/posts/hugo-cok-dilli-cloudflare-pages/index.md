---
title: "Cloudflare Pages üzerinde çok dilli bir Hugo blogu kurmak"
date: 2026-04-22T18:00:00+03:00
draft: false
summary: "İki dilli (EN + TR) bir Hugo + Blowfish blogunu tek kuruş harcamadan Cloudflare Pages'e nasıl yayınladım — ve bir saatimi yiyen tek i18n tuzağı."
tags: ["hugo", "i18n", "cloudflare", "static-site", "blowfish"]
categories: ["web"]
showReadingTime: true
showTableOfContents: true
showWordCount: true
---

Bu blogu az önce yayına aldım. Her şey — iki dilli içerik, dark mode, RSS, sitemap, deploy pipeline'ı — ücretsiz tier'lar ve tek bir statik site üreticisi üzerinde çalışıyor. Toplam fatura: sıfır. İşte nasıl bir araya geldiği — ve ömrümden bir saat yiyen o tek i18n tuzağı.

## Stack

Süslü bir şey yok:

- **[Hugo Extended](https://gohugo.io/)** — statik site üreticisi. Hızlı, tek binary, olgun.
- **[Blowfish](https://blowfish.page/)** — Hugo teması. Minimalist, varsayılan dark, yerel i18n.
- **[Cloudflare Pages](https://pages.cloudflare.com/)** — hosting. Ücretsiz tier ihtiyaç duyduğum her şeyi karşılıyor.
- **[GitHub](https://github.com/)** — tek doğru kaynak; ayrıca build doğrulaması için Actions.

Hepsi bu. CMS yok. Backend yok. Veritabanı yok. Sadece bir git repo'sunda Markdown ve bir statik build pipeline.

## Proje yapısı

Klasör yapısı standart Hugo iskeleti — bir önemli ekleme dışında: dil başına `contentDir`.

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

Blowfish teması git submodule olarak ekleniyor:

```bash
git submodule add -b main https://github.com/nunocoracao/blowfish.git themes/blowfish
```

`config/_default/` altındaki her config dosyası yalnızca değiştirdiğin alanları override eder — gerisi temadan miras alınır. Bu sayede proje dosyaların küçük kalır ve tema güncellemelerini temiz şekilde çekebilirsin.

## i18n tuzağı

İşte bana bir saate mâl olan şey.

İçeriği `content/en/...` ve `content/tr/...` olarak yapılandırdım, `defaultContentLanguage = "en"` ayarladım, `defaultContentLanguageInSubdir = false` olarak bıraktım ve İngilizce'nin URL kökünde olmasını bekledim.

Hugo siteyi mutlu mesut build etti. İngilizce ana sayfa `/` adresindeydi. Buraya kadar iyi.

Ama her İngilizce bölüm — `/posts/`, `/projects/`, `/about/` — 404 dönüyordu. Asıl içerik `/en/posts/`, `/en/projects/` vs. altındaydı. Türkçe ise `/tr/...` altında sorunsuz çalışıyordu.

Çözüm dil başına tek bir satır:

```toml
# config/_default/languages.en.toml
contentDir = "content/en"

# config/_default/languages.tr.toml
contentDir = "content/tr"
```

İçeriğin `content/{dil}/` klasörlerinde olduğu durumda Hugo ilişkiyi otomatik çıkarmıyor — iki yorumu da deniyor ve aralarında bir yerde tuhaf bir şekilde takılıp kalıyor. `contentDir`'i açıkça ayarlamak Hugo'ya şunu söyler: "bu klasör bu dilin içerik köküdür." Ondan sonra İngilizce `/`'da, Türkçe `/tr/`'de yaşıyor ve her şey çalışıyor.

> **Ders**: kararsız kaldığında, açık ol. Hugo'nun varsayılanları, ikisi çakışana kadar harika.

## Ücretsiz tier deploy

Cloudflare Pages GitHub'a bağlanır, bir branch'i izler ve her push'ta yeniden build eder. Kurulum:

1. Repo'yu GitHub'a push et.
2. Cloudflare panelinden yeni bir Pages projesi oluştur, repo'yu seç.
3. Build komutunu ayarla: `hugo --gc --minify`.
4. Build output dizinini ayarla: `public`.
5. `HUGO_VERSION` ortam değişkenini local'inde kullandığın versiyona ayarla.

Tüm deploy hikayesi bu. Cloudflare sana ücretsiz `*.pages.dev` veriyor — global CDN, otomatik HTTPS ve her branch için preview deploy dahil.

Analytics için **Cloudflare Web Analytics** ücretsiz, cookie kullanmıyor ve banner gerektirmiyor. Yorumlar için **giscus** GitHub Discussions kullanıyor ve tüm public repo'lar için ücretsiz. Site viral olmadığı sürece bunların hiçbiri para tutmuyor.

## Baştan yapsam farklı yapardım

Sıfırdan başlasam değiştireceğim birkaç şey:

- **Temayı en sona bırak.** Blowfish'e karar vermeden önce dört temayı değerlendirdim; kendi minimal layout'larımla başlayıp temayı sonra eklemiş olsaydım her geçiş daha ucuz olurdu.
- **`_headers`'ı erken yaz.** Cloudflare Pages build çıktısındaki `_headers` dosyasını okur ve oradaki HTTP header'ları uygular. Güvenlik header'larını eklemek (`Content-Security-Policy`, `Referrer-Policy`, `Permissions-Policy`) beş dakikalık iş ve securityheaders.com'da A skoru getiriyor.
- **Actions'ı ilk gün kur.** Her PR'da `hugo` + `lychee` (kırık link kontrolü) çalıştıran bir GitHub Actions workflow'u, ölü linkleri yayına çıkmadan yakalıyor — 30 saniyelik CI süresine değer.

## Sırada ne var

Site ayağa kalktığına göre, hedef haftada bir yazı — somut, teknik ve gerçekten bitirebilecek kadar kısa.

Bu blogun kaynak kodu [GitHub](https://github.com/muratoransoy/blog)'da. Bozuk bir şey görürsen issue aç.
