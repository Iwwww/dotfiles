---
name: skill-author
description: >
  Skill for creating, reviewing, and evolving opencode skills. Covers skill
  architecture, router design, module structure, token efficiency, and
  migration from AGENTS.md. Use when creating, reviewing, or evolving
  opencode skills, or migrating AGENTS.md into a skill.
---

# Skill Author

Создание, ревью и эволюция opencode skills.

## Trigger

Когда задача касается создания/изменения/ревью opencode skill файлов.

## Router

| Интент | Когда | Модуль(и) |
|--------|-------|-----------|
| `create` | Создание нового скилла с нуля | `modules/create.md` |
| `review` | Ревью существующего скилла | `modules/review.md` |
| `evolve` | Новый роут/модуль в существующий скилл | `modules/evolve.md` + `modules/create.md` |

## Базовые правила (всегда)

- Frontmatter (name + description) обязателен
- Description — чёткий, для авто-триггера
- Один скилл = одна зона ответственности
- Всегда добавлять fallback-интент (`general` → ничего) для запросов не подходящих под другие интенты
- Если запрос подходит под несколько интентов — загрузить пересечение модулей (минимум)
- Token efficiency: каждый текст должен быть настолько коротким, насколько возможно, но не короче
- Если в задаче есть анализ — сначала исследуй целевую конфигурацию, потом предлагай архитектуру
