# AGENTS.md — web/

Astro frontend, styled with Tailwind CSS. See `README.md` for setup.

## Development

`astro dev` starts automatically in background mode when an AI coding
agent is detected (Astro 7+). Manage it with:

```bash
astro dev --background   # start explicitly
astro dev stop
astro dev status
astro dev logs -f
```

## Critical constraint

`npm run build` must succeed with the `api` service **not running** — it
runs in CI/Docker, where `api` isn't available yet. Never call `fetch()`
inside a component's frontmatter (the `---` block); anything that depends
on the API is fetched client-side, in a `<script>` tag, after the page
loads. See `src/components/StatusBanner.astro` for the established pattern.

## Conventions

- Content data (experiences, certifications, tech catalog) lives in
  `src/data/*.ts` — never hardcode content directly in `.astro` files
- Design tokens (colors, fonts) live in `src/styles/tokens.css`, consumed
  via Tailwind's `@theme` block — check there before introducing new colors

## Documentation

Full docs: https://docs.astro.build. Relevant to this project:

- [Astro components](https://docs.astro.build/en/basics/astro-components/)
- [Routing](https://docs.astro.build/en/guides/routing/)
- [Styling / Tailwind](https://docs.astro.build/en/guides/styling/)

(This project doesn't use content collections, i18n, or non-Astro
framework components — those guides don't apply here.)
