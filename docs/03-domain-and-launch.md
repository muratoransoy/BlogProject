# Domain & Launch — Sprint 6

> Status as of 2026-04-22: site is feature-complete, builds clean (EN 46 / TR 44 pages), comments + analytics + CI in place, only domain + manual deploy actions remain.

---

## 1. Domain shortlist

Goal: short, memorable, professional, dev-flavored, available, cheap.

| Candidate | Pros | Cons | Approx. cost / yr (CF Registrar) |
|---|---|---|---|
| **muratoransoy.dev** ⭐ | Personal, recognizable, `.dev` is dev-coded, HTTPS-forced (HSTS preload) | Slightly long | ~$12 |
| muratoransoy.com | Most universally trusted, easy to spell over the phone | Common; SEO crowded | ~$10 |
| oransoy.dev | Shorter, distinctive | Drops first name; lower personal recognition | ~$12 |
| murat.codes | Modern, dev-coded | `.codes` is non-standard, may seem trendy in 2 years | ~$30 |
| muratbuilds.dev | Action-oriented, brandable | Longer, more cute than professional | ~$12 |

**Recommendation**: **`muratoransoy.dev`**.
- It maps directly to identity (the GitHub handle, the email).
- `.dev` enforces HTTPS at the TLD level (HSTS preload), zero work to get the green padlock.
- Cloudflare Registrar sells it at cost (~$12/yr), no markup, no upsell, no whois shenanigans.

If `.dev` is unavailable for any reason, fall back to `muratoransoy.com`.

---

## 2. Purchase + connect (manual steps)

### a) Buy the domain

1. Cloudflare dashboard → **Domain Registration** → **Register Domains**.
2. Search `muratoransoy.dev` → add to cart → checkout.
3. Auto-renew: **on**. WHOIS privacy: **on** (free with CF).

### b) Point Cloudflare Pages at the new domain

1. **Workers & Pages** → the `blog` project → **Custom domains** → **Set up a custom domain**.
2. Add `muratoransoy.dev` (apex). Cloudflare creates the `CNAME`/`A` records automatically because the domain is on the same account.
3. Wait for the green checkmark (~30 seconds).
4. Add `www.muratoransoy.dev` as a second custom domain — Cloudflare wires the redirect.

### c) Code changes after the domain is live

| File | Change |
|---|---|
| `config/_default/hugo.toml` | `baseURL = "https://muratoransoy.dev/"` |
| `static/_redirects` | Uncomment the `www → apex` 301 line |
| `layouts/partials/extend-head.html` | Replace `TODO_CF_BEACON_TOKEN` |
| `layouts/partials/comments.html` | Replace `TODO_REPO_ID` and `TODO_CATEGORY_ID` |

Then `git push` — Cloudflare Pages rebuilds automatically.

---

## 3. SEO submission

After the domain resolves and serves 200s:

1. **Google Search Console** — https://search.google.com/search-console
   - Add property: `muratoransoy.dev`
   - Verify via DNS TXT (Cloudflare DNS panel, one click).
   - Submit `https://muratoransoy.dev/sitemap.xml`.
2. **Bing Webmaster Tools** — https://www.bing.com/webmasters
   - Import from Google Search Console (one-click).

Expect first index in 1–3 days for the homepage; a week or two for full coverage.

---

## 4. Pre-launch QA checklist

Run through every item before announcing the site.

### Build & content
- [ ] `hugo --gc --minify` exits 0 with no warnings.
- [ ] EN homepage, TR homepage, all menu items return 200.
- [ ] Both languages have at least one published post.
- [ ] EN and TR translations of the same post show hreflang links to each other.
- [ ] All internal links work (`lychee` clean in CI).
- [ ] No `TODO_` placeholders left in shipped HTML.

### SEO & metadata
- [ ] `<title>`, `<meta description>`, `og:*`, `twitter:*` present on every page.
- [ ] JSON-LD `Article` valid on each post (Google Rich Results Test).
- [ ] `JSON-LD` `BreadcrumbList` valid.
- [ ] `sitemap.xml` lists both `/en/sitemap.xml` and `/tr/sitemap.xml`.
- [ ] `robots.txt` allows everything and points to the right sitemap URL.
- [ ] `<link rel="canonical">` correct on every page.

### Hosting & headers
- [ ] HTTPS works on apex and `www`; `www` 301s to apex.
- [ ] HSTS header present.
- [ ] CSP header present (and giscus + Cloudflare Insights load with no console errors).
- [ ] `securityheaders.com` scan: A or A+.
- [ ] CDN-cached static assets serve `Cache-Control: public, max-age=31536000, immutable`.

### Performance
- [ ] Lighthouse (mobile, prod URL): Performance ≥ 95, Accessibility ≥ 95, Best Practices ≥ 95, SEO = 100.
- [ ] Largest Contentful Paint ≤ 1.5 s on Fast 3G.
- [ ] No layout shift on home or post pages.

### Functional
- [ ] Light/dark mode toggle works and persists.
- [ ] Search works (header search bar).
- [ ] giscus comments render under a post; can post a comment.
- [ ] Cloudflare Web Analytics records a hit within 5 minutes.
- [ ] RSS feed validates at https://validator.w3.org/feed/.

### Mobile
- [ ] Hero, menu, post body all readable on a 360px viewport.
- [ ] Tap targets ≥ 48px.
- [ ] No horizontal scroll.

---

## 5. Announce (after QA passes)

Soft launch first, hard launch later:

1. **Soft (week 1)**: share with 3–5 trusted friends, collect feedback.
2. **Fix anything they trip on.**
3. **Hard (week 2)**: post to LinkedIn / X / personal channels with a screenshot and the URL.

The first technical post (`hugo-multilingual-cloudflare-pages`) is the natural anchor — link to that, not just the homepage.

---

## 6. Done definition

The site is "shipped" when:

- The custom domain serves the site.
- All TODO placeholders are replaced.
- The QA checklist above is fully checked.
- One real reader has commented or emailed about a post.
