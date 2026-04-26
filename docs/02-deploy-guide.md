# Deploy & Integration Guide

> What needs to be done by hand (Sprint 5 manual steps).
> Everything in code/configs is already in place — these are the actions
> that require external accounts (GitHub, Cloudflare, giscus).

---

## 1. Push the repo to GitHub

```bash
# (Already initialized locally; main branch.)
gh repo create muratoransoy/blog --public --source=. --remote=origin
git push -u origin main
```

If `gh` is not available:

1. Create the repo manually at https://github.com/new
   - Owner: `muratoransoy`
   - Name: `blog`
   - Visibility: **Public** (required for GitHub Actions free tier and giscus)
   - Do NOT initialize with README/license (we already have them)
2. Then locally:
   ```bash
   git remote add origin https://github.com/muratoransoy/blog.git
   git push -u origin main
   ```

After push, the two workflows in `.github/workflows/` start running automatically.

---

## 2. Connect Cloudflare Pages

1. https://dash.cloudflare.com/ → **Workers & Pages** → **Create** → **Pages** → **Connect to Git**.
2. Authorize GitHub and pick `muratoransoy/blog`.
3. Build settings:
   - **Framework preset**: Hugo
   - **Build command**: `hugo --gc --minify`
   - **Build output directory**: `public`
   - **Root directory**: leave empty
4. Environment variables:
   - `HUGO_VERSION` = `0.160.1`
5. Deploy.

After ~1 minute the site is live at `https://blog-XXXX.pages.dev`. Every push to `main` redeploys; every PR gets a preview URL.

---

## 3. Enable comments (giscus)

Comments are wired up in `layouts/partials/comments.html` but need real IDs.

1. On the GitHub repo: **Settings → General → Features → Discussions** → enable.
2. Install the giscus app: https://github.com/apps/giscus → grant access to `muratoransoy/blog`.
3. Visit https://giscus.app/ and fill out the form:
   - Repository: `muratoransoy/blog`
   - Page ↔ Discussions Mapping: **pathname**
   - Discussion Category: create one called **Comments** (Announcement type recommended)
4. Copy the values giscus generates and replace these placeholders in `layouts/partials/comments.html`:
   - `data-repo-id="TODO_REPO_ID"`
   - `data-category-id="TODO_CATEGORY_ID"`
5. Commit & push. Comments will render at the bottom of every post.

---

## 4. Enable Cloudflare Web Analytics

The script is already in `layouts/partials/extend-head.html` and only fires in production (not on `hugo server`).

1. https://dash.cloudflare.com/ → **Web Analytics** → **Add a site**.
2. Choose **Automatic setup** if the site is on a Cloudflare-served domain (after Sprint 6),
   or **Manual setup** to use the JS beacon now (works on `*.pages.dev` too).
3. Copy the `token` value from the snippet Cloudflare generates.
4. Replace `TODO_CF_BEACON_TOKEN` in `layouts/partials/extend-head.html`.
5. Commit & push. Page views show up in the dashboard within minutes.

---

## 5. Custom domain (Sprint 6 — separate task)

Deferred until a domain is purchased. Steps will be:

1. Buy domain (Cloudflare Registrar — at-cost pricing).
2. Cloudflare Pages project → **Custom domains** → add the apex.
3. DNS records auto-created if domain is on Cloudflare.
4. Update `baseURL` in `config/_default/hugo.toml`.
5. Uncomment the `www → apex` redirect in `static/_redirects`.

---

## CI/CD overview

Two workflows live in `.github/workflows/`:

| Workflow | Trigger | What it does |
|---|---|---|
| `build.yml` | every push & PR | Hugo build with theme submodule, uploads `public/` artifact |
| `links.yml` | every push & PR + weekly cron | Builds, then runs `lychee` against the output to catch broken links |

Cloudflare Pages does its own build separately (it's the source of truth for deploys); the GitHub workflows are pre-flight checks.

---

## Common errors

### `Could not detect a directory containing static files`

Full error (from CF Pages build log):

```text
Executing user deploy command: npx wrangler deploy
✘ [ERROR] Could not detect a directory containing static files
   (e.g. html, css and js) for the project
```

**Cause.** The Cloudflare project was created in **Workers** mode (the new unified Workers + Pages experience), so the deploy runs `npx wrangler deploy` instead of the classic Hugo build. No Hugo build happens, so `public/` doesn't exist.

**Fix (recommended — already in this repo).** A `wrangler.toml` and `scripts/cf-build.sh` are checked in. Wrangler reads the toml, runs the build script (which installs Hugo if it's missing), and serves `public/` as static assets. **No dashboard configuration is required** — just push to main and the deploy picks it up.

If `HUGO_VERSION` is set as an env var in the project's build settings, Cloudflare's auto-install kicks in and the script's fallback download is skipped (faster). To set it: project → **Settings → Variables and Secrets → Add** → `HUGO_VERSION` = `0.160.1`.

**Alternative fix (classic Pages project).** If you'd rather use the classic Pages build pipeline, in the dashboard → project → **Settings → Builds & deployments → Build configurations**, set:

| Field | Value |
|---|---|
| Framework preset | **Hugo** |
| Build command | `hugo --gc --minify` |
| Build output directory | `public` |
| Root directory | `/` (leave empty) |
| Environment variable | `HUGO_VERSION` = `0.160.1` |

Save, then **Deployments** → **Retry deployment** on the failed build.

### Theme files missing in build (404 on CSS/JS)

**Cause.** Cloudflare Pages didn't fetch the `themes/blowfish` git submodule.

**Fix.** Pages fetches submodules by default since 2023 — but if the build still misses them, set the env var `GIT_SUBMODULE_STRATEGY=recursive` in the build configuration.

### `hreflang` not appearing on a new bilingual post

**Cause.** Both language versions need the same `translationKey` in frontmatter, otherwise Hugo can't pair them and `.AllTranslations` stays empty.

**Fix.** Add the same `translationKey: "post-<slug>"` line to both EN and TR frontmatter, then rebuild.
