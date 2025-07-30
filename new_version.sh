version=$(cat pubspec.yaml | grep "version:" | awk '{print $2}')

echo "Current version: $version"

git tag -a "v$version" -m "v$version"
git push origin "v$version"