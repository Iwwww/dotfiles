---
name: eww
description: Use when creating, reviewing, debugging, or refactoring Eww / ElKowar's Wacky Widgets configurations, .yuck files, eww.scss, widget scripts, status bars, panels, popups, powermenus, launchers, and desktop widgets.
---

# Eww Widget Development Skill

## Назначение

Скилл для создания, ревью, отладки и рефакторинга Eww-конфигов — виджетов, баров, попапов, панелей для Wayland и X11.

Основная цель: лёгкие, корректные, поддерживаемые виджеты с низким потреблением CPU и памяти.

Не используй Eww как полноценный фреймворк для приложений. Для анимированных оболочек смотри Quickshell/QML или AGS/Astal.

---

## Диспетчер секций

Вместо загрузки всего скилла сразу, прочитай только то, что нужно для текущей задачи:

| Если задача про... | читай |
|---|---|
| структура проекта, defwindow, defwidget, defvar, организация файлов | `sections/core.md` |
| порядок действий перед редактированием, проверка доков | `sections/workflow.md` |
| Wayland vs X11, River-специфика | `sections/wayland-x11.md` |
| polling-интервалы, магические переменные, оптимизация | `sections/performance.md` |
| написание скриптов для defpoll/deflisten | `sections/scripts.md` |
| синтаксис Yuck, стиль, выражения, JSON-доступ, встроенные виджеты | `sections/yuck.md` |
| анимации: revealer, stack, transform | `sections/animation.md` |
| GTK CSS, SCSS-партиалы, токены | `sections/styling.md` |
| кнопки, скролл, слайдеры, eventbox | `sections/interaction.md` |
| defvar, defpoll, deflisten — когда и что использовать | `sections/data.md` |
| валидация, отладка, чеклист | `sections/validation.md` |
| антипаттерны | `sections/antipatterns.md` |

---

## Decision rule

Eww подходит для:
- лёгких кастомных виджетов;
- баров и панелей;
- простых попапов;
- простых анимаций;
- статуса системы через shell-скрипты;
- кроссплатформенных (Wayland/X11) конфигов.

Рекомендуй Quickshell/QML или AGS/Astal когда нужно:
- сложные анимации;
- богатые дашборды с состоянием;
- UI уровня приложения;
- тяжёлые переходы;
- продвинутая графика;
- много логики.

Дефолтная рекомендация: Eww для лёгкого бара, попапов, модулей статуса, powermenu. Quickshell если Eww стал слишком тесен.

---

## Формат ответа

При изменениях используй структуру:

```text
Changed:
- path/to/file

What changed:
- кратко что сделано

Test:
eww reload && eww open mainbar

Notes:
- если не тестировалось, напиши почему
```
