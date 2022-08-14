# new-hospital (WIP)

Go to the `modules` folder and edit `config.json` to fit your needs.

[Cfx.re](https://forum.cfx.re/t/free-hospital-system/4874580)

## Current State
Resource is mostly done, and is classified as 'production-ready'. However, some features are still missing *(statebags, and some damages)*. While numerous people have said they will finish it, none have yet to do so.

[Current state preview](https://www.youtube.com/watch?v=QNayoNlLq24)

## Dependencies
- [ox_lib](https://github.com/overextended/ox_lib) This ensures the lowest resource ms possible, running at `0.01 ms` utilizing points; instead of zones, markers, and or distance checks. This is also used for all UI elements, *i.e.* notifications, progress circle, context, and cache.
- [ox_inventory](https://github.com/overextended/ox_inventory)

## Usage
- `debug:effect` Will stop all player/screen effects. ***You must have some type of effect currently going on for this.***
- `debug:bleed` Will set the player health below 150 to the bleeding state.
- `debug:heal` Will set the player health to 200.
- `debug:menu` Will open the hospital context menu.
- `toggle:hospital` Sets the hospital state to 'open', and or 'closed'. ***Default state = open; running this will set state = closed.***

## Contributing
Please make all pull request towards the [**main branch**](https://github.com/arl0fonseca/qp_hospital/tree/main). If you have any suggestions for improvements please contact `Qpr#2530` on **Discord**.