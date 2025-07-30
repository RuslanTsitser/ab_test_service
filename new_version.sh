version=$(cat pubspec.yaml | grep "version:" | awk '{print $2}')

echo "Current version: $version"

git tag "$version"
git push --tags