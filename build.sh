#!/bin/bash
#
# Run a build for all images.

set -uo pipefail

info() {
  printf "%s\n" "$@"
}

fatal() {
  printf "**********\n"
  printf "%s\n" "$@"
  printf "**********\n"
  exit 1
}

cd $(cd ${0%/*} && pwd -P);

types=( "$@" )
if [ ${#types[@]} -eq 0 ]; then
  types=( */ )
fi
types=( "${types[@]%/}" )

for type in "${types[@]}"; do

  info "Building $type..."
  docker build -t thebuccaneersden/docker-armhf-php7:$type $type

  if [[ $? -gt 0 ]]; then
    fatal "Build of $type failed!"
  else
    info "Build of $type succeeded."
  fi

done

info "All builds successful!"

exit 0
