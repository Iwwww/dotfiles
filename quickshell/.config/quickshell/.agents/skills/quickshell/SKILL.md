---
name: quickshell
description: >
  Помощь в создании и ревью конфигураций Quickshell — toolkit для
  десктопных оболочек на QtQuick/QML (бары, виджеты, локскрины).
  Использовать когда задача касается quickshell конфигурации или
  написания QML кода для quickshell.
---

## Router

| Интент | Когда | Модуль |
|--------|-------|--------|
| `create-config` | Создание shell.qml с нуля: базовая структура, окна, Variants для мониторов, Scope/Singleton, импорты | `modules/create-config.md` |
| `add-widget` | Добавление UI-компонентов: ClockWidget, Workspaces, SystemTray, PopupWindow, кликабельные элементы | `modules/add-widget.md` |
| `add-service` | Интеграция системных сервисов: Pipewire, Mpris, UPower, Network, Bluetooth, Notifications | `modules/add-service.md` |
| `debug` | Диагностика ошибок: binding loops, zero-size items, ReferenceError, процессы не обновляются | `modules/debug.md` |
| `general` | Всё остальное | — |

## Базовые правила

- Entrypoint: `~/.config/quickshell/<name>/shell.qml` (или `-p file.qml`)
- Всегда `import Quickshell`; для баров обычно `PanelWindow`, для обычных окон `FloatingWindow`, для меню `PopupWindow`
- Multi-monitor: `Variants { model: Quickshell.screens }` с `required property var modelData` и `screen: modelData`
- Разделяемые сервисы выносить в `Singleton` или `Scope` вне окна
- `//@ pragma` в shell.qml для глобальных настроек (IconTheme, UseQApplication, AppId)
- Не использовать `childrenRect` для размеров контейнера — ведёт к binding loop
- Предпочитать `MarginWrapperManager` над ручными привязками
- `Process` и связанные коллекторы держать в `Scope`/`Singleton`, если результат нужен между reload'ами

## Если не уверен / Документация

- [Guide](https://quickshell.org/docs/v0.3.0/guide)
- [Types](https://quickshell.org/docs/v0.3.0/types)
- [PanelWindow](https://quickshell.org/docs/v0.3.0/types/Quickshell/PanelWindow)
- [PopupWindow](https://quickshell.org/docs/v0.3.0/types/Quickshell/PopupWindow)
- [Variants](https://quickshell.org/docs/v0.3.0/types/Quickshell/Variants)
- [Scope](https://quickshell.org/docs/v0.3.0/types/Quickshell/Scope)
- [Singleton](https://quickshell.org/docs/v0.3.0/types/Quickshell/Singleton)
- [SystemClock](https://quickshell.org/docs/v0.3.0/types/Quickshell/SystemClock)
- [Process](https://quickshell.org/docs/v0.3.0/types/Quickshell.Io/Process)
- [MarginWrapperManager](https://quickshell.org/docs/v0.3.0/types/Quickshell.Widgets/MarginWrapperManager)
- [Notifications](https://quickshell.org/docs/v0.3.0/types/Quickshell.Services.Notifications)
- [Mpris](https://quickshell.org/docs/v0.3.0/types/Quickshell.Services.Mpris/Mpris)
- [SystemTray](https://quickshell.org/docs/v0.3.0/types/Quickshell.Services.SystemTray/SystemTray)
- [UPower](https://quickshell.org/docs/v0.3.0/types/Quickshell.Services.UPower/UPower)
