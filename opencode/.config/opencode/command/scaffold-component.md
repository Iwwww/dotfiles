---
description: Scaffold a semantic liquid-glass UI primitive with states, tokens, fallback styling, and optional enhancement hooks.
agent: build
---

Scaffold a new UI primitive named `$1`.

Requirements:
- semantic HTML first
- framework-free
- TypeScript only if behavior is needed
- CSS variables only, no hardcoded theme values
- required states: default, hover, active, focus-visible, disabled
- reduced-motion safe
- mobile-friendly
- optional effect hook support, but component must work without WebGL

Please:
1. choose the correct files under `src/ui/` and `src/styles/`
2. implement minimal but production-leaning markup/API
3. add accessibility notes in comments only when needed
4. keep bundle impact minimal
5. summarize usage at the end
