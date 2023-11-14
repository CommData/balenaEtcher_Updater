#!/bin/bash
# GitHub repository owner and name
OWNER="balena-io"
REPO="etcher"
file_path="$HOME/.apps/balenaEtcher/currVer.txt"
if [ -e "$file_path" ]; then
  current_version=$(cat "$file_path")
else
  current_version="1.18.11"
fi
# # Get the latest release information using GitHub API
 latest_release=$(curl --request GET \
 --url "https://api.github.com/repos/$OWNER/$REPO/releases/latest")

# # Get the tag name of the latest release
 latest_tag=$(echo "$latest_release" | jq -r .tag_name)
# # Compare the versions
if [[ "$latest_tag" != "v$current_version" ]]; then
   echo "A new version ($latest_tag) is available!"
   echo "Downloading latest version"
   wget "https://github.com/balena-io/etcher/releases/download/$latest_tag/balenaEtcher-"${latest_tag:1}"-x64.AppImage"
   mv "balenaEtcher-"${latest_tag:1}"-x64.AppImage" "bE.AppImage"
   chmod +x bE.AppImage
  echo "${latest_tag:1}" > "$file_path"
else
 echo "latest version present"
fi