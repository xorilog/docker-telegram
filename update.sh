#!/bin/bash

# Gather latest version of telegram
version=$(curl --head https://tdesktop.com/linux/ |grep Location |cut -d '/' -f 5 |cut -d '.' -f 2-4)
sed -i 's/Telegram\ Version\ [0-9]*\.[0-9]*\.[0-9]*$/\Telegram\ Version\ '$version'/' Dockerfile
sed -i 's/tsetup.*.tar.xz\ \-O/tsetup.'$version'.tar.xz\ \-O/' Dockerfile
git commit -am "Telegram version $version" -S
git tag -am "Telegram version $version" $version
git push --follow-tags
