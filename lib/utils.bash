#!/usr/bin/env bash

set -euo pipefail

# TODO: Ensure this is the correct GitHub homepage where releases can be downloaded for git.
GH_REPO="https://github.com/git/git"

fail() {
  echo -e "asdf-git: $*"
  exit 1
}

curl_opts=(-fsSL)

# NOTE: You might want to remove this if git is not hosted on GitHub releases.
if [ -n "${GITHUB_API_TOKEN:-}" ]; then
  curl_opts=("${curl_opts[@]}" -H "Authorization: token $GITHUB_API_TOKEN")
fi

sort_versions() {
  sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
    LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_github_tags() {
  git ls-remote --tags --refs "$GH_REPO" |
    grep -Eo 'refs/tags/v[0-9][0-9.]*(-rc[0-9]+)?' | cut -d/ -f3- |
    sed 's/^v//'
}

list_all_versions() {
  list_github_tags
}

download_release() {
  local version filename url
  version="$1"
  filename="$2"

  # TODO: Adapt the release URL convention for git
  url="$GH_REPO/archive/v${version}.tar.gz"

  echo "* Downloading git release $version..."
  curl "${curl_opts[@]}" -o "$filename" -C - "$url" || fail "Could not download $url"
}

install_version() {
  local install_type="$1"
  local version="$2"
  local install_path="$3"

  if [ "$install_type" != "version" ]; then
    fail "asdf-git supports release installs only"
  fi

  local tmp_dir
  tmp_dir=$(mktemp -d "${TMPDIR:-/tmp}/asdf-git.XXXX")
  (
    cd "$tmp_dir"

    local release_file="ditsfiles/git-$version.tar.gz"
    mkdir -p "$(dirname "$release_file")"
    download_release "$version" "$release_file"
    tar -xzf "$release_file" --strip-components=1 || fail "Could not extract $release_file"
    rm "$release_file"

    build "$install_path"

    local tool_cmd="$install_path/bin/git"
    test -x "$tool_cmd" || fail "Expected $tool_cmd to be executable."

    echo "git $version installation was successful!"
  ) || (
    fail "An error ocurred while installing git $version."
  )
  rm -rf "$tmp_dir"
}

build() {
  local install_path=$1
  make prefix="$install_path" all man
  make prefix="$install_path" install install-man
}
