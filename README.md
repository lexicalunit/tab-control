# Tab Control

[![apm package][apm-ver-link]][releases]
[![travis-ci][travis-ci-badge]][travis-ci]
[![appveyor][appveyor-badge]][appveyor]
[![circle-ci][circle-ci-badge]][circle-ci]
[![david][david-badge]][david]
[![download][dl-badge]][apm-pkg-link]
[![mit][mit-badge]][mit]

[Atom](https://atom.io/) package that provides more and easier control over tab settings such as tab
length and soft tabs.

![dialog][img_dialog]

## Status Indicator

Optionally enable a status bar indicator. Click it to pull up the tab control dialog.

![status][img_status]

## Tabs To Spaces Integration

When [tabs-to-spaces][tabs-to-spaces] is also installed, conveniently access its commands via the
control dialog window.

![tabs-to-spaces][img_tabs]

## Settings

| Setting | Description |
| ------ | ----- |
| **Auto&nbsp;Save&nbsp;Changes** | Automatically saves grammar specific settings to your Atom config. |
| **Display&nbsp;In&nbsp;Status&nbsp;Bar** | Toggles on/off status bar indicator. |

## Future Work

- Improve test coverage.
- Add indicator toggle command.
- Formatting/position options for status-bar indicator.
- Popup window on indicator click instead of bringing down the command palette.
  Blocked by [atom/atom#5756](https://github.com/atom/atom/issues/5756).
- Move away from atom-space-pen-views.
  Blocked by [atom/atom#5756](https://github.com/atom/atom/issues/5756).
- Save soft tabs setting.
  Blocked by [atom/atom#3719](https://github.com/atom/atom/issues/3719).

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
[appveyor]:         https://ci.appveyor.com/project/lexicalunit/tab-control?branch=master
[appveyor-badge]:   https://ci.appveyor.com/api/projects/status/0v29bt6rg78odrpd/branch/master?svg=true
[circle-ci]:        https://circleci.com/gh/lexicalunit/tab-control/tree/master
[circle-ci-badge]:  https://circleci.com/gh/lexicalunit/tab-control/tree/master.svg?style=shield
[david-badge]:      https://david-dm.org/lexicalunit/tab-control.svg
[david]:            https://david-dm.org/lexicalunit/tab-control

[img_dialog]:       https://cloud.githubusercontent.com/assets/1903876/7946403/06e492ba-093c-11e5-82bd-dbe5a2cca026.png
[img_status]:       https://cloud.githubusercontent.com/assets/1903876/7946402/06e2e7bc-093c-11e5-8563-3572f2568a98.png
[img_tabs]:         https://cloud.githubusercontent.com/assets/1903876/7946401/06e2d92a-093c-11e5-95da-aa03f86e75ee.png
[tabs-to-spaces]:   https://atom.io/packages/tabs-to-spaces
