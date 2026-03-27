---
description: Add or refine a liquid-glass visual treatment for a target component or section with CSS fallback and performance-safe defaults.
agent: build
---

Apply a liquid-glass effect to `$1`.

Use these constraints:
- fallback-first
- preserve text readability
- subtle distortion
- subtle chromatic aberration on edges/highlights only
- mobile-safe defaults
- reduced-motion support
- no framework-specific code

Please:
1. inspect the target component/section
2. identify which files to modify
3. implement CSS fallback first
4. add optional effect config and enhancement hooks under `src/effects/`
5. avoid overengineering
6. end with tuning knobs I can adjust
