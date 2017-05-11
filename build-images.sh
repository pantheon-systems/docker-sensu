#!/bin/bash

set -eou pipefail

# versions from http://sensu.global.ssl.fastly.net/apt/pool/jessie/main/s/sensu/
# NOTE: we are not currently building all of the versions, only the ones we have used or intend to use.
SENSU_VERSIONS=(
0.25.5-1
0.26.5-2
0.29.0-10
)

IMAGE="quay.io/getpantheon/sensu"

action="${1:-}"

case "$action" in
  build)
    for version in "${SENSU_VERSIONS[@]}"; do
      docker build -t "$IMAGE:$version" --build-arg SENSU_VERSION="$version" .
    done
    ;;
  push)
    for version in "${SENSU_VERSIONS[@]}"; do
      docker push "$IMAGE:$version"
    done
    ;;
  *)
    echo "Usage: $0 [build|push]"
    exit 1
    ;;
esac
