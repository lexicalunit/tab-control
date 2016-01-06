# Tab Control

[![apm package][apm-ver-link]][releases]
[![][travis-ci-badge]][travis-ci]
[![][david-badge]][david]
[![][dl-badge]][apm-pkg-link]
[![][mit-badge]][mit]

[Atom](https://atom.io/) package that provides more and easier control over tab settings such as tab length and soft tabs.

![dialog](https://cloud.githubusercontent.com/assets/1903876/7946403/06e492ba-093c-11e5-82bd-dbe5a2cca026.png)
## Status Indicator

Optionally enable a status bar indicator that can be clicked to pull up the tab control dialog.

![status](https://cloud.githubusercontent.com/assets/1903876/7946402/06e2e7bc-093c-11e5-8563-3572f2568a98.png)

## Tabs To Spaces Integration

When [tabs-to-spaces](https://atom.io/packages/tabs-to-spaces) is also installed, its commands will be displayed in the control dialog window for convenience.

![tabs-to-spaces](https://cloud.githubusercontent.com/assets/1903876/7946401/06e2d92a-093c-11e5-95da-aa03f86e75ee.png)

## Settings

| Setting | Description |
| ------ | ----- |
| **Auto&nbsp;Save&nbsp;Changes** | Automatically saves grammar specific settings to your Atom config. |
| **Display&nbsp;In&nbsp;Status&nbsp;Bar** | Toggles on/off status bar indicator. |

## Future Work

- Improve test coverage.
- Add indicator toggle command.
- Formatting/position options for status-bar indicator.
- Popup window on indicator click rather than bringing down the command palette. Blocked by [atom/atom#5756](https://github.com/atom/atom/issues/5756).
- Move away from atom-space-pen-views. Blocked by [atom/atom#5756](https://github.com/atom/atom/issues/5756).
- Save soft tabs setting. Blocked by [atom/atom#3719](https://github.com/atom/atom/issues/3719).

---

[MIT][mit] © [lexicalunit][author] et [al][contributors]

[mit]:              http://opensource.org/licenses/MIT
[author]:           http://github.com/lexicalunit
[contributors]:     https://github.com/lexicalunit/tab-control/graphs/contributors
[releases]:         https://github.com/lexicalunit/tab-control/releases
[mit-badge]:        https://img.shields.io/apm/l/tab-control.svg
[apm-pkg-link]:     https://atom.io/packages/tab-control
[apm-ver-link]:     https://img.shields.io/apm/v/tab-control.svg
[dl-badge]:         http://img.shields.io/apm/dm/tab-control.svg
[travis-ci-badge]:  https://travis-ci.org/lexicalunit/tab-control.svg?branch=master
[travis-ci]:        https://travis-ci.org/lexicalunit/tab-control
[david-badge]:      https://david-dm.org/lexicalunit/tab-control.svg
[david]:            https://david-dm.org/lexicalunit/tab-control
