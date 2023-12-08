# MiA BSFD QOL Mod

A quality of life mod for MiA: BSFD. Internally nicknamed `AbyssDeep`.

## Current Features

- **Make Madokajacks harmless.** In the 3rd Layer, if you are in certain areas of the wall, the Madokajacks will dive in and aim for you. This stops them from doing that.
- **Decrease spawn rate of raid enemies.** When you are in a map for too long, the game starts spawning enemies around you. The spawn rate is still too high IMO so this decreases them.

### Planned Features

The list of features are just my personal take of what should be changed to make the game less frustrating (based on my gameplay experience).

- [ ] Refine curse triggering mechanic
- [ ] Interactables should not reset (e.g. Glass Layer's stone dominoes) during a trip
- [ ] Make meeting Nanachi mandatory
- [ ] *Other tasks that I can think of (many of them were softlocks that I just don't remember atm)*

## Installation

1. Download [UE4SS Experimental Release v2.5.2-439](https://github.com/UE4SS-RE/RE-UE4SS/releases/tag/experimental) (`UE4SS_v2.5.2-439-g3cea237.zip`).
1. Make a backup of the game's _executable folder_ (`\steamapps\common\MadeInAbyss-BSFD\MadeInAbyss-BSFD\Binaries\Win64`). This is so that you can revert the game back to a clean slate in case something happens.
1. Extract `UE4SS_v2.5.2-439-g3cea237.zip` into the _executable folder_.
1. Grab the latest release of this repository, or just download/clone.
1. In your copy of the repository, paste all the files inside the top folder into the _executable folder_.

## Usage

After doing the above the mod injector (UE4SS) and this mod itself (AbyssDeep) should be installed and you can just run the game.

> [!CAUTION]
> This mod is experimental and might cause your game to crash during gameplay. Please stock up on Mail Balloons and save regularly.

This mod only affects gameplay, so your saves should be unaffected regardless if you have the mod or not, but I'm not 100% sure. **Please create backups always.**

### Uninstalling

To disable just the mod but keep UE4SS, delete `Mods\seekerted-AbyssDeep\enabled.txt`. To re-enable the mod, just re-create it (it's an empty text file).

To uninstall everything, simply revert the _executable folder_ back to the state before you pasted everything in (or just deleting `xinput1_3.dll` should suffice).

### Customizing features

I've made the mod in a way that you can enable/disable each feature. In the `Mods\seekerted-AbyssDeep\Scripts\main.lua` file, there are lines that say `<feature>.SetEnabled(true)` somewhere near the top or so. Change the `true` to `false` to disable and vice versa.

If you're more of an advanced user you can edit the script.

## Credits

Special thanks to:
- [UE4SS](https://github.com/UE4SS-RE/RE-UE4SS)
- UE4SS Discord
- Made in Abyss: Modding Community Discord

## Changelog

```
0.4.0
- Fix code for detecting new instances of MIAEnemyBase
- Upgraded UE4SS version to experimental 439, to simplify installation process and remove the need for custom AOB for FName_ToString.

0.3.6
- Madokajacks cannot detect you
- Tweaked the rate of raid enemies spawning.
```