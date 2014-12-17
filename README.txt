=========
git quick
=========
$ git init
Reinitialized existing Git repository in /home/adc/src/zmaster/zmaster_tool_git/xmlservice/.git/
$ git remote add origin https://rangercairns@bitbucket.org/inext/xmlservice-rpg.git
$ echo "Tony Cairns" >> contributors.txt
$ git add .
$ git commit -m 'Initial commit with contributors'
[master (root-commit) 602b7c0] Initial commit with contributors
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 contributors.txt
$ git push -u origin master
Counting objects: 3, done.
Writing objects: 100% (3/3), 239 bytes, done.
Total 3 (delta 0), reused 0 (delta 0)
To https://rangercairns@bitbucket.org/inext/xmlservice-rpg.git
 * [new branch]      master -> master
Branch master set up to track remote branch master from origin.
$ 

