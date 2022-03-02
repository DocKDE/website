---
title: "Commit to someone else's pull request"
date: 2021-03-02
menu:
  sidebar:
    name: commit to other PR
    identifier: git other
    parent: technotes
    weight: 10
tags: ["Multi-lingual"]

---

I'm currently experiencing the pleasure of collaborating on an open source project with someone else
on GitHub and I love doing it. There was an issue with runtime performance and we looked into it,
discussed ideas and coded up several prototypic solutions (I admit mine were rather dirty).
At one point I reviewed someone else's pull request and wanted to add something to it.
Sure, I can use the online editing features of GitHub but that doesn't really tie in well
with my code-writing workflow, not to mention that all the autocompletion, linting and inline
compiler errors won't be present.
So I looked for a way to push a commit to someone else's pull request that I could prepare locally. I
searched and found a good solution which I'm gonna write up here as reference for future me.

Note: everything in square brackets needs to be substituted by appropriate values, same content of bracket
indicates that the same subsituted value is necessary.

- If you haven't already done so, clone the repository. It doesn't matter whether it's the
original one or your fork. 
- Add a remote for your local copy: 
{{<alert type="info">}} 
`git remote add [arbitrary remote name] [URL of repo]` 
{{</alert>}}
- Fetch the branch of interest from the remote: 
{{<alert type="info">}} 
`git fetch [arbitrary remote name] [branch name]`
{{</alert>}}
- Create and check out to a matching local branch: 
{{<alert type="info">}} 
`git checkout -b [new local branch name] [arbitrary remote name]/[branch name]`
{{</alert>}}
- Add whatever changes you want.
- Push to remote:
{{<alert type="info">}} 
`git push [arbitrary remote name] HEAD:[branch name]`
{{</alert>}}

Depending on your purpose you may want to squash the commit you made into the previous one. In my case
I didn't.
