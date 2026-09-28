# AGENTS.md — web/

Astro frontend for the portfolio site. Follow the project docs in [`README.md`](./README.md) and keep the app buildable without the backend running.

## Development

From inside the dev container:

```bash
npm install
npm run dev -- --host 0.0.0.0
npm run build
```

## Critical rules

- `npm run build` must succeed when the `api` service is not running.
- Data that is already represented in `src/data/*.ts` should be reused rather than re-encoded in component markup.
- Do not call `fetch()` in a component's frontmatter block; fetch client-side after page load, as shown by `src/components/StatusBanner.astro`.

## Conventions

- Keep route-level content in `src/pages/` and reusable UI in `src/components/`.
- Use existing tokens from `src/styles/tokens.css` before adding new colors or typography values.
- Prefer the established Astro patterns already used in the project rather than introducing new frameworks or content systems.

## Useful references

- [Astro component docs](https://docs.astro.build/en/basics/astro-components/)
- [Astro routing docs](https://docs.astro.build/en/guides/routing/)
- [Astro styling docs](https://docs.astro.build/en/guides/styling/)
