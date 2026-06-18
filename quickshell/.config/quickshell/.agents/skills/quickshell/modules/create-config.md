# Create Config

Создание новой quickshell конфигурации с нуля.

## Базовая структура

```
~/.config/quickshell/my-shell/
└── shell.qml
```

Запуск: `qs` (авто) или `qs -c my-shell`.

## Если нужен ориентир

- [Guide](https://quickshell.org/docs/v0.3.0/guide)
- [Types](https://quickshell.org/docs/v0.3.0/types)
- [Scope](https://quickshell.org/docs/v0.3.0/types/Quickshell/Scope)
- [PanelWindow](https://quickshell.org/docs/v0.3.0/types/Quickshell/PanelWindow)
- [Variants](https://quickshell.org/docs/v0.3.0/types/Quickshell/Variants)

## shell.qml каркас

```qml
import Quickshell
import QtQuick

Scope {
  id: root

  Variants {
    model: Quickshell.screens
    PanelWindow {
      required property var modelData
      screen: modelData
      anchors { top: true; left: true; right: true }
      implicitHeight: 36
      color: "#1e1e2e"
    }
  }
}
```

## Варианты корневого типа

- `Scope` — невидимый контейнер, рекомендован
- `Singleton` — для shared-сервисов (с `pragma Singleton`)

## Import порядок

```qml
import Quickshell           // всегда
import QtQuick              // всегда (базовые UI)
import Quickshell.Io        // Process, FileView
import QtQuick.Layouts       // RowLayout, ColumnLayout
import Quickshell.Widgets   // WrapperItem, IconImage
```

## pragma (опционально, в начало shell.qml)

```qml
//@ pragma IconTheme Papirus
//@ pragma NativeTextRendering
//@ pragma AppId my-shell
```

## Desktop entry (для запуска через DM)

```ini
[Desktop Entry]
Name=My Quickshell
Exec=qs -c my-shell
Type=Application
Icon=my-shell
```
