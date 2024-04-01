#!/usr/bin/env bash

appName="memos"
builtAt="$(date +'%F %T %z')"
goVersion=$(go version | awk '{print $3}')
gitAuthor="Your Name <your_email@example.com>"
gitCommit=$(git log --pretty=format:"%h" -1)
version=$(git describe --long --tags --dirty --always)
webVersion=$(wget -qO- -t1 -T2 "https://api.github.com/repos/usememos/memos/releases/latest" | grep "tag_name" | head -n 1 | awk -F ":" '{print $2}' | sed 's/\"//g;s/,//g;s/ //g')

ldflags="\
-w -s \
-X 'github.com/usememos/memos/internal/conf.BuiltAt=$builtAt' \
-X 'github.com/usememos/memos/internal/conf.GoVersion=$goVersion' \
-X 'github.com/usememos/memos/internal/conf.GitAuthor=$gitAuthor' \
-X 'github.com/usememos/memos/internal/conf.GitCommit=$gitCommit' \
-X 'github.com/usememos/memos/internal/conf.Version=$version' \
-X 'github.com/usememos/memos/internal/conf.WebVersion=$webVersion' \
"

go build -ldflags="$ldflags" -tags=jsoniter .
