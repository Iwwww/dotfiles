# Styling rules

Eww использует GTK CSS, не браузерный CSS.

Ограничения:
- нет flexbox;
- нет CSS grid;
- нет float;
- нет absolute positioning;
- нет браузерного `width`/`height` layout;
- нет браузерных keyframe-анимаций.

Используй layout-виджеты Eww, не CSS-трюки.

## Design tokens (для больших конфигов)

```scss
/* tokens.scss */
$font-family-main: "JetBrainsMono Nerd Font", "Noto Sans", sans-serif;
$fg-primary: #fdf6e3;
$fg-muted: #b8b8b8;
$module-bg: rgba(21, 26, 31, 0.64);
$module-bg-hover: rgba(44, 98, 133, 0.96);
$state-accent: #f3a131;
$state-danger-bg: rgba(62, 28, 32, 0.64);
$state-danger-border: #b56c7c;
$radius-md: 8px;
$transition-fast: 120ms;
```

Правила:
- токены импортируются раньше всех;
- сырые цвета только в токенах;
- в модулях используй семантические имена (`$module-bg`, `$popup-bg`);
- новые цвета выводи из палитры;
- не разбрасывай hex/rgba по модулям.

## Base SCSS

```scss
* {
  all: unset;
  font-family: "JetBrainsMono Nerd Font", "Noto Sans", sans-serif;
  font-size: 13px;
}

.bar {
  background: rgba(20, 20, 24, 0.92);
  color: #f0f0f0;
}

.module {
  padding: 0 8px;
  border-radius: 8px;
}

.module:hover {
  background: rgba(255, 255, 255, 0.08);
  transition: 150ms;
}

.critical {
  color: #ff6b6b;
}
```

Используй SCSS-партиалы для больших конфигов.
