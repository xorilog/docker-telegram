#!/bin/bash
set -e

# this is kind of an expensive check, so let's not do this twice if we
# are running more than one validate bundlescript
VALIDATE_REPO='https://github.com/xorilog/docker-telegram.git'
VALIDATE_BRANCH='master'

VALIDATE_HEAD="$(git rev-parse --verify HEAD)"

git fetch -q "$VALIDATE_REPO" "refs/heads/$VALIDATE_BRANCH"
VALIDATE_UPSTREAM="$(git rev-parse --verify FETCH_HEAD)"

VALIDATE_COMMIT_DIFF="$VALIDATE_UPSTREAM...$VALIDATE_HEAD"

validate_diff() {
	if [ "$VALIDATE_UPSTREAM" != "$VALIDATE_HEAD" ]; then
		git diff "$VALIDATE_COMMIT_DIFF" "$@"
	else
		git diff HEAD~ "$@"
	fi
}

base="xorilog/telegram"
suite="latest"
build_dir="."


# get the dockerfiles changed
IFS=$'\n'
files=( $(validate_diff --name-only -- '*Dockerfile') )
unset IFS

(
set -x
docker build -t ${base}:${suite} ${build_dir}
)
echo "                       ---                                   "
echo "Successfully built ${base}:${suite} with context ${build_dir}"
echo "                       ---                                   "
