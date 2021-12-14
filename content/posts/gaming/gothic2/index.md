---
title: "How to run Gothic 2 on Linux"
date: 2021-12-14
menu:
  sidebar:
    name: Gothic 2 on Linux
    identifier: gothic2
    parent: gaming
    weight: 10
tags: ["Multi-lingual"]
---

There are many challenges when it comes to gaming on Linux but it's even more difficult to get something up and running that's so old that it's a hassle to do it under Windows as well.

In essence you have to deal with the setup you'd do in Windows (which is already nontrivial) and apply all of it through the layer of abstraction that is running Windows software on Linux. Fun.

Anyway, Gothic 2 is one of my favourite games of all times and I recently discovered that there are some very interesting mods for it out there which I've never tried. I know I'm like 10 years late with this realization, so sue me.

As a note to others (and most of all myself), here's how to do it:

1. Install the game in a wine prefix (the gog version via Lutris is usually most convenient but doing it by hand or through proton on Steam should also work)
2. Add `vcrun2008`, `vcrun2010` and `directmusic` libraries with winetricks in prefix. Make sure `wine-mono` is installed globally (use protontricks for Steam install).
3. Run `winecfg` in prefix and make sure that the `dsound` library override is *exactly* set to "(builtin, native)"
    - It is possible that this must be done via command line and not with the built-in Lutris `winecfg` button.

From here on out, it depends on what you wanna do. It is recommended to install several patches, namely 
- [fix-2.6.0.0-rev2](https://www.worldofgothic.de/dl/download_278.htm)
- [playerkit-2.6f](https://www.worldofgothic.de/dl/download_168.htm)
- [SystemPack-1.8](https://www.worldofgothic.de/dl/download_597.htm)

especially if you want to mod the game (which I wanted when I installed this).
There are other things that can be modded and installed, especially the [D3D11 Renderer](https://www.worldofgothic.de/dl/download_590.htm) is often mentioned but I've got to admit I didn't notice any difference with that (I'm not much of a graphics connoisseur though).

Afterwards, any mods may be installed, e.g. "L'Hiver" or "Legend of Ahssûn" by running the downloaded exe files.

Finally the executable must be changed to the newly created "GothicStarter.exe" (or some workaround therefor) to run these mods (for the vanilla version just leave the exe as is).

Enjoy one of the coolest RPGs ever created!