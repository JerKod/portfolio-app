# Web — Astro frontend

Static site built with Astro, styled with Tailwind CSS.

## Development

From inside the dev container:

```bash
npm run dev -- --host 0.0.0.0
```

Visit http://localhost:4321.

## Build

```bash
npm run build
```

Output goes to `dist/`, served in production by nginx (see `Dockerfile`).
The build must succeed **without the `api` service running** — status and
metrics widgets fetch data client-side after the page loads, not during
build. See `src/components/StatusBanner.astro` for the pattern.

## Structure

- `src/pages/` — one file = one route
- `src/components/` — reusable UI pieces
- `src/layouts/` — shared page shells
- `src/data/` — content (experiences, certifications, tech catalog)
- `src/styles/tokens.css` — design tokens (colors, fonts) and Tailwind theme
