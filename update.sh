#!/usr/bin/env bash

set -e

# Gather latest version of telegram
version=$(curl -XGET --head https://telegram.org/dl/desktop/linux |grep location |cut -d '/' -f 5 |cut -d '.' -f 2-4)
sed -i 's/\(Telegram Version \)[0-9]*\.[0-9]*\.[0-9]*$/\1'"${version}"'/' Dockerfile

# Local build to validate
docker build --build-arg telegram_version="${version}" -t "local-build/telegram:${version}" .

# Commit with signature, tag and push code.
git commit -am "Telegram version ${version}" -S
git tag -am "Telegram version ${version}" "${version}"
git push --follow-tags

# Tag and Push to GitHub Packages
docker tag "local-build/telegram:${version}" "xorilog/telegram:${version}"
docker tag "local-build/telegram:${version}" "xorilog/telegram:latest"
docker push "xorilog/telegram:${version}"
docker push "xorilog/telegram:latest"

# Tag and Push to GitHub Packages
docker tag "local-build/telegram:${version}" "docker.pkg.github.com/xorilog/docker-telegram/telegram:${version}"
docker push "docker.pkg.github.com/xorilog/docker-telegram/telegram:${version}"

# Tag and Push to GitHub Container Registry
docker tag "local-build/telegram:${version}" "ghcr.io/xorilog/telegram:${version}"
docker push "ghcr.io/xorilog/telegram:${version}"

# Tag and Push as latest to GitHub Packages
docker tag "local-build/telegram:${version}" "docker.pkg.github.com/xorilog/docker-telegram/telegram:latest"
docker push "docker.pkg.github.com/xorilog/docker-telegram/telegram:latest"

# Tag and Push as latest to GitHub Container Registry
docker tag "local-build/telegram:${version}" "ghcr.io/xorilog/telegram:latest"
docker push "ghcr.io/xorilog/telegram:latest"
