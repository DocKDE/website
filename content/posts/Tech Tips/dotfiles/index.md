---
title: "Managing dotfiles with bare git repo"
date: 2022-01-11
menu:
  sidebar:
    name: Manage dotfiles
    identifier: dotfiles
    parent: technotes
    weight: 10
tags: ["Multi-lingual"]

---

A tale as old as time: you configure and tweak your personal machine that you use for work, coding, fun and games or whatever and at some point you wonder how you might preserve all those tweaks. Either, you want to back them up (which is always sensible) or you want to transfer to a new machine or want to show them to other people online so they can just download your setup and get going immediately.

There are many ways and quite a few dedicated tools to achieve this. You could symlink everything to a central place and use version control to keep track of the files. I have seen people use gnu `stow` or something like `chezmoi` or `yadm` but somehow none of these ever really clicked with me. 

I remember having read/heard about using bare git repositories quite a while back but I couldn't make sense of it back then or the tutorials I found were weird, I don't quite remember. Today, however, I once again hazarded a look at the results of my favourite search engine concerning this topic and voilà: I found what I needed. 

Disclaimer: none of what I write here is my own idea so I don't take credit or responsibility. With that said, here goes:

{{<alert type="info">}} 
`git init --bare $HOME/.cfg` \
`alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'` \
`config config --local status.showUntrackedFiles no`
{{</alert>}}

That's basically all.

The first command initializes a bare git repo in a folder called `.cfg` (name is arbitrary of course), meaning it does not contain a working tree.
The second defines an alias for using this repo.

This should be saved to whatever your shell config file is so you don't have to define this every time you open a 
terminal. It allows you to perform git commands for the defined repo when outside of it. It also defines the `$HOME` 
directory as your working tree and stores the history of it in `.cfg`. 

The last line changes the local git config so that untracked files are no longer shown. Otherwise every single file in your home folder would pop up here which we clearly are not interested in.

Now the repo can be added to, committed and pushed somewhere:
   
{{<alert type="info">}} 
`config add .vimrc` \
`config -m "first commit"`\
`config remote add origin <url>`\
`config push -u origin master`
{{</alert>}}

And done. On a side note: after defining the file completion in bash or zsh doesn't work anymore. For zsh this can be
changed by simply adding the following line to your `.zshrc`:

{{<alert type="info">}} 
`setopt complete_aliases`
{{</alert>}}

For bash [this Arch wiki entry](https://wiki.archlinux.org/title/Dotfiles) has some suggestions.

To install the dotfiles on another machine a similar workflow applies.

Clone your repo: 

{{<alert type="info">}} 
`git clone --bare <url> $HOME/.cfg`
{{</alert>}}

Define the alias as above, change config as above so untracked files are not shown.

Checkout to move the files to their destinations: 

{{<alert type="info">}} 
`config checkout`
{{</alert>}}

The last step will throw an error if some of the files already exist. In that case they need to be moved somewhere else or deleted. If you're sure, you don't need any of the already present files, you can force the checkout:

{{<alert type="info">}} 
`config checkout -f`
{{</alert>}}
