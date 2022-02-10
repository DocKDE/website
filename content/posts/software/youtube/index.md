---
title: "Migrating my YouTube video consumption to the command line (and on digital minimalism)"
date: 2022-02-10
menu:
  sidebar:
    name: Terminal YouTube 
    identifier: youtube
    parent: software
    weight: 10
tags: ["Multi-lingual"]

---

I've recently realized something. My use of the Linux operating system and all it offers has been evolving
in something of a wave-like pattern.

When I started out, the first thing I tried was Linux Mint which is something a former Windows user might do
as it works in a fairly familiar way. I quickly realized that I wanted to dive deeper and do more things
than what Mint let me do easily. In hindsight that's probably in large part due to me not knowing much
about what I was doing but I do remember that I felt constricted and startet distrohopping.

I went through a few distros and eventually ended up with Arch. I know, it's a cliché. But the 
philosophy of Arch resonated with me. I had, by that time, become fed up with how bloated Windows had become
and how much it takes control away from its users. Arch was the complete opposite. It drops the user
in a root shell after installation and leaves you to it.

This got me in touch with all those minimalist Linux nerds out there who do everything from command line,
even stuff that really shouldn't be done that way. I got myself a severely outdated laptop and started 
playing around with it like that. I did the whole minimalism thing: tiling window manager, terminal based
file manager, mail client, video and music players, application launcher, feed reader, you name it.

It was all fun and games until I realized how much time and energy it takes to configure all of this.
After some more time I then realized that this is time I don't necessarily want to spend and, as of now,
don't have.

So I went the complete other direction after some time and installed Fedora with GNOME on my main machine,
the epitome of the "point-and-click" environments. And I enjoyed the change. GNOME makes basically all 
choices for you and offers a simple and elegant user interface which was a welcome change after spending
so much time with poring over documentation for config files for terminal hacky stuff.

But well... this comes at a price. Quite a few applications on Fedora come as Flatpaks. What's more, even
more applications are electron-based which means they're basically browser windows running a web app with
all the penalties to resource demand that implies.

After discussing it with people who feel rather strongly about the topic on [fosstodon](https://fosstodon.org)
I decided to make a few changes. I ditched VSCodium for neovim (I may write a separate post about this) and
immediately felt the need to CONFIGURE ALL THE THINGS! I try to find a sweet spot between finding a setup
that works well for me with all the necessary features and settings and not being stuck in config hell.
It's a delicate balance but I feel my coding has become more efficient because I can now leverage
all my vim muscle memory much more readily and especially developing in Rust is a joyful experience with
the setup I have compiled (not literally compiled).

Long story short: for those reasons I decided to make changes in my YouTube video consuming workflow.
I won't describe the whole journey there and it might also not be finished yet but I feel I arrived at a 
decent setup.

I have basically four distinct use cases for YouTube:
1. There are a select few channels I look up regularly and whose videos I watch
2. Every once in a while I look for tutorial, informational or other such videos without knowing exactly
what I want yet
3. I come across a video online, usually embedded somewhere, that I want to watch
4. Listening to music

Whereas it is probably possible to unite all this in a single application, I ended up using a couple 
different ones:

1. After a bit of research I realized that YouTube channels are available as RSS feeds. This enables
users to leverage all the RSS ecosystems including all the available applications to consume the feeds.
I chose [`newsboat`](https://newsboat.org/), a terminal-based one. I added the appropriate URLs for all
the channels I'm interested in and set up [`mpv`](https://mpv.io/) as "browser" to open the respective links.
`mpv` is a terminal-based video player that supports streaming videos from the internet when called with
a URL. Setting it as the browser application for newsboat results in the video being streamed when opening
the URL. Obviously this precluded using newsboat for any other non-video-streaming RSS feeds but that's fine 
for me as I don't consume RSS feeds otherwise.
2. For the second use case I came across [`ytfzf`](https://github.com/pystardust/ytfzf) which is a shell 
script that serves to perform fuzzy finding on YouTube videos with a variety of options. It supports searching
for channels and playlists, various sorting options, selecting the video quality, thumbnails and a lot
more. I ended up up with the following setup: when calling `ytfzf` it opens a 
[`rofi`](https://github.com/davatorium/rofi) window containing the video selection. When I select one it will
open up `mpv` and stream the chosen video with it. The detour via `rofi` is not necessary but I like the 
visuals better.
I have a couple of shell aliases in place to simplify searching channels, playlists, sorting for recent
videos and the like.
3. This use case is very easy to satisfy. I can just copy the URL of the video in question and call
`mpv` with it as argument. I also set up a keyboard shortcut to call `rofi` and handle this because I like 
the looks of `rofi`, I could also just do this in the terminal. However, doing it like this also reduces the
number of terminal windows I have open.
4. For listening to music, one can just pass the appropriate option (`-m`) to `ytfzf` which will then proceed
to stream the audio stream of the video via `mpv`.

In conclusion I am using a combination of a terminal-based RSS feed reader, the `ytfzf` shell script and `mpv`
to do all the heavy lifting for me. Additionally, I use `rofi` for eye candy.

As a nice bonus, `ytfzf` actually doesn't stream from actual YouTube but uses an 
[Invidious](https://github.com/iv-org/invidious) instance so when using this workflow my privacy is better
protected that it used to be. I stopped using [FreeTube](https://freetubeapp.io/) for watching videos
which is an amazing app but still electron-based and somewhat slow and resource-hungry.

Since I don't get recommended videos in the side bar anymore (as there is none), I'm less likely to be
sidetracked by watching endless videos that don't have anything to do with my original intention for coming
to the platform in the first place anymore. So added bonus for digital autonomy and my personal time. Yay!

P.S. If you're interested in the details of the setup, hit me up on [mastodon](https://fosstodon.org/@theDoctor)!
