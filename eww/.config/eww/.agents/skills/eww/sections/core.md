# Core concepts

## Состав конфига

Eww-конфиг обычно состоит из:
- `.yuck` — описание виджетов и окон;
- `.scss` / `.css` — стили;
- shell-скрипты — данные для системы;
- переменные Eww: `defvar`, `defpoll`, `deflisten`, магические переменные.

Стандартная структура:

```text
~/.config/eww/
├── eww.yuck
├── eww.scss
├── widgets/
├── styles/
└── scripts/
```

---

## Предпочитаемая структура проекта

```text
~/.config/eww/
├── eww.yuck
├── eww.scss
├── widgets/
│   ├── bar.yuck
│   ├── modules/
│   │   ├── clock.yuck
│   │   ├── workspaces.yuck
│   │   ├── battery.yuck
│   │   ├── volume.yuck
│   │   ├── brightness.yuck
│   │   ├── network.yuck
│   │   └── media.yuck
│   └── popups/
│       ├── powermenu.yuck
│       ├── calendar.yuck
│       └── audio.yuck
├── styles/
│   ├── _colors.scss
│   ├── _base.scss
│   ├── _bar.scss
│   ├── _modules.scss
│   └── _popups.scss
└── scripts/
    ├── battery.sh
    ├── volume.sh
    ├── brightness.sh
    ├── network.sh
    ├── media.sh
    └── workspaces.sh
```

`eww.yuck` — только include других файлов.
`eww.scss` — только import стилевых модулей.

---

## Индексная модульная структура (для больших конфигов)

```text
~/.config/eww/
├── eww.yuck
├── eww.scss
└── bar/
    ├── index.yuck
    ├── index.scss
    ├── tokens.scss
    ├── base.scss
    ├── bar.yuck
    ├── bar.scss
    └── modules/
        ├── index.yuck
        ├── index.scss
        └── volume/
            ├── index.yuck
            ├── index.scss
            ├── volume.yuck
            ├── volume.scss
            └── volume-state
```

Правила:
- `eww.yuck` и `eww.scss` — тонкие точки входа;
- каждый модуль владеет своими виджетами, переменными, стилями и скриптами;
- скрипты одного модуля лежат рядом с ним;
- токены — в одном файле, не размазаны.
