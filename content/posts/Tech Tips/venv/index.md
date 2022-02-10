---
title: "Working with Python virtual environments"
date: 2022-02-09
menu:
  sidebar:
    name: Python venv
    identifier: venv
    parent: technotes
    weight: 10
tags: ["Multi-lingual"]

---

Whenever you start a project in Python you probably want to do it in a fresh environment so as
not to have your dependencies clash with those of other projects, prevent version mismatch or 
other unexpected breakage.

The way to do this is by using virtual environments. As far as I know there are several ways to 
do this in Python (as always...) but the most prevalent, it seems to me, is using the builtin `venv`
module.

Since I'm prone to forgetting the syntax and exact setup of such a thing, here's a walkthrough of
how to go about this that may also serve as a cheat sheet, most of all for future me.

Best practices are as follows:

1. Create a new folder for your project
2. Create a new virtual environment with: `python3 -m venv [path_to_project]/venv`
This will create an environment called `venv` inside your project root directory.
3. Activate the environment with `source [path_to_project]/venv/bin/activate`
4. Install any necessary dependencies with `pip install [package_names]`
5. Start coding

For deactivating the environment again you can simply type `deactivate`.

The `venv` folder holding the environment should not be edited manually. Also the project files
do not go in there, they sit next to it in the project root folder.
This ensures that the environment stays clean and portable so you can tear it down and rebuild it 
or distribute it to others.

Also, if you're using version control (which you should for any half-serious project), make sure to 
exclude the `venv` folder from it. When using, e.g., `git` this amounts to adding `venv` to your
`.gitignore` file. Otherwise you'll just pollute whatever online repo you push to with a lot of 
unnecessary stuff.

To ensure portability, create a list of all locally installed dependencies with 
`pip freeze > requirements.txt`
Obviously, you can direct the output to another file or do whatever with it but this is the convention.

When setting up a new environment you can then do `pip install -r requirements.txt` to restore the state
of your previous or someone else's environment.

Note, however, that the Python version within your environment will be the same as the version you used
to create it, which will usually be your system-wide version.

That's all there is to it to be productive with this. Have fun.
