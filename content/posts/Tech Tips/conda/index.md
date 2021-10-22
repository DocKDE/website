---
title: "Running a script on conda activate"
date: 2021-10-22
menu:
  sidebar:
    name: conda activate
    identifier: conda
    parent: technotes
    weight: 10
tags: ["Multi-lingual"]

---

I recently noticed that using a conda environment can come with a couple inconveniences. For example, since the default
Python executable changes when activating conda, this means that the `$PATH` variable has been modified and
some software can not be found anymore. 

For instance, I can't call PyMol from command line when in a conda environment because it somehow depends on the Python
executable, it seems.

I recently installed some software into a conda env, that needs a couple of environment variables to run but which I 
only really need (or want) when running this software in this conda env because it messes with `$PATH` and disrupts my
workflow otherwise. 

Solution: it's possible to have conda source a (shell) script that is only run when it's actually activated. So put
whatever commands you want (e.g. for setting environment variables) into a small script and place it in 
``` [path_to_your_conda]/envs/[conda env name]/etc/conda/activate.d ```

Done. When you next fire up that env the script will be sourced.