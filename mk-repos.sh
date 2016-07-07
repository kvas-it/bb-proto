#!/bin/sh

if [ -d repos ]; then
    rm -Rf repos
fi

mkdir repos

cp -r repo.tmpl repos/git-repo
sed -i '' "s|VCS-TYPE|Git|g" repos/git-repo/README.txt
git -C repos/git-repo init
git -C repos/git-repo add .
git -C repos/git-repo commit -m 'Initial commit'

cp -r repo.tmpl repos/hg-repo
sed -i '' "s|VCS-TYPE|Mercurial|g" repos/hg-repo/README.txt
hg --cwd repos/hg-repo init
hg --cwd repos/hg-repo add .
hg --cwd repos/hg-repo commit -m 'Initial commit'
