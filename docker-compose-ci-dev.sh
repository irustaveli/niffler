#!/bin/bash

echo '### Java version ###'
java --version
echo '### Gradle version ###'
gradle --version

if [[ $1 = "gql" ]]; then a="$c"; else a="$d"; fi

var front
if [[ "$1" = "gql" ]]; then front="./niffler-frontend-gql/"; else front="./niffler-frontend/"; fi

if [ "$1" = "push" ] || [ "$2" = "push" ]; then
  echo "### Build & push images (front: $front) ###"
  bash ./gradlew clean build dockerPush -x :niffler-e-2-e-tests:test
  cd "$front" || exit
  bash ./docker-build.sh dev push
else
  echo "### Build images (front: $front) ###"
  bash ./gradlew clean build dockerTagLatest -x :niffler-e-2-e-tests:test
  cd "$front" || exit
  bash ./docker-build.sh dev
fi