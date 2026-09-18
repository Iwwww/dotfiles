# Debug

Диагностика типичных проблем Quickshell конфигураций.

## Binding loop (виджет нулевого размера)

**Симптом**: консоль ловит binding loop, элемент не виден.

**Причина**: `implicitWidth: childrenRect.width` — создаёт циклическую зависимость.

**Фикс**: установить `implicitWidth/implicitHeight` на основе `child.implicitWidth` или использовать `MarginWrapperManager`.

```qml
// ПЛОХО — binding loop
Item {
  implicitWidth: childrenRect.width
  Rectangle { anchors.fill: parent; implicitWidth: 50; implicitHeight: 50 }
}

// ХОРОШО
Item {
  implicitWidth: 50
  implicitHeight: 50
  Rectangle { anchors.fill: parent }
}

// ЛУЧШЕ — MarginWrapperManager
Item {
  MarginWrapperManager {}
  Rectangle { implicitWidth: 50; implicitHeight: 50 }
}
```

## Zero-size item warning

**Симптом**: `WARN scene: zero-sized item` в консоли.

**Причина**: элемент без `width/height` и без `implicitWidth/implicitHeight`.

**Фикс**: задать `implicitWidth/Height` или `width/height`.

## ReferenceError: X is not defined

**Симптом**: процесс не обновляет текст.

**Причина**: `id` создаётся внутри `Component`/`delegate`, а ссылка на него снаружи. Внутри делегата `id` не виден снаружи (делегат клонируется).

**Фикс**: поднять состояние в `Scope` через свойство.

```qml
Scope {
  id: root
  property string time
  Variants {
    model: Quickshell.screens
    PanelWindow {
      Text { text: root.time }  // ссылка через root, не через id
    }
  }
  Process {
    stdout: StdioCollector {
      onStreamFinished: root.time = this.text
    }
  }
}
```

## Process не перезапускается

**Симптом**: команда выполнилась один раз, повторно не идёт.

**Фикс**: установить `running: true` при новом запуске.

```qml
Timer {
  interval: 1000; repeat: true; running: true
  onTriggered: myProcess.running = true  // не running = false
}
```

## LSP ошибки на PanelWindow

Qmlls имеет известные caveats с Quickshell-типами и `PanelWindow`. Если подсказки ломаются, сначала проверь setup из официального install/docs, а не добавляй `// @ts-ignore` без нужды.

## Ручная очистка

```bash
rm -rf ~/.cache/quickshell/by-shell/<shell-id>/
```

## Если нужен контекст

- [Installation & Setup](https://quickshell.org/docs/v0.3.0/guide/install-setup)
- [QML Language](https://quickshell.org/docs/v0.3.0/guide/qml-language)
- [Types](https://quickshell.org/docs/v0.3.0/types)
- [PanelWindow](https://quickshell.org/docs/v0.3.0/types/Quickshell/PanelWindow)
- [Scope](https://quickshell.org/docs/v0.3.0/types/Quickshell/Scope)
- [Process](https://quickshell.org/docs/v0.3.0/types/Quickshell.Io/Process)
