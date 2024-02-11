# MiABSFD QOL Mod

A quality of life mod for MiABSFD. In which I attempt to make changes to the game to make it a tiny bit better to play. I also plan to fix some bugs in the game that I can do something about.

Internally nicknamed `AbyssDeep`.

## Current Features

- **Make Madokajacks harmless.** In the 3rd Layer, if you are in certain areas of the wall, the Madokajacks will dive in and aim for you. This stops them from doing that.
- **Decrease spawn rate of raid enemies.** When you are in a map for too long, the game starts spawning enemies around you. The spawn rate is still too high IMO so this decreases them.

### Planned Features

The list of features are just my personal take of what should be changed to make the game less frustrating (based on my gameplay experience).

- [ ] Refine curse triggering mechanic
- [ ] Interactables should not reset (e.g. Glass Layer's stone dominoes) during a trip
- [ ] Make meeting Nanachi mandatory
- [ ] *Other tasks that I can think of (many of them were softlocks that I just don't remember atm)*

## Game Bugfixes

- Fix the bug where the Seeker Camp Interior nameplate displays "???" instead of "Seeker Camp".

> [!WARNING]
> This mod is experimental and might cause your game to crash during gameplay. Please stock up on Mail Balloons and save regularly.

## Installation

Get and install this mod via Nexus Mods and Vortex (guide also in the link): (todo)

## Manual / Advanced Installation

1. Get and install UE4SS by following the instructions on this page here: <https://seekerted.github.io/MiABSFD-UE4SS-Guide/>
1. Grab the latest release of this mod.
1. Extract and paste the files into the _executable folder_.

### Uninstalling

To disable just the mod but keep UE4SS, delete `Mods\<this mod's folder>\enabled.txt`. To re-enable the mod, just re-create it (it's an empty text file).

To uninstall everything, simply revert the _executable folder_ back to the state before you pasted everything in.

### Disabling features

I've made the mod in a way that you can disable a feature or bugfix. In the `Mods\seekerted-AbyssDeep\Scripts\main.lua` file, there are lines that say `require("...")`. These are named accordingly and correspond to each feature or bugfix. If you want to disable them, add `-- ` to the beginning of the line (i.e `-- require("...")`).

## Credits

Special thanks to:
- [UE4SS](https://github.com/UE4SS-RE/RE-UE4SS)
- UE4SS Discord
- Made in Abyss: Modding Community Discord

## Changelog

```text
0.4.0
- Fix code for detecting new instances of MIAEnemyBase
- Upgraded UE4SS version to experimental 439, to simplify installation process and remove the need for custom AOB for FName_ToString.

0.3.6
- Madokajacks cannot detect you
- Tweaked the rate of raid enemies spawning.
```