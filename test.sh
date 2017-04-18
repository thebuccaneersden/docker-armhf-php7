#!/usr/bin/env bash
#
# Run a test for all images.

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

  info "Testing PHP version within the container for the type $type..."
  docker run thebuccaneersden/docker-armhf-php7:$type php7 -v

  if [[ $? -gt 0 ]]; then
    fatal "Test of $type failed!"
  else
    info "Test of $type succeeded."
  fi

done

info "All tests successful!"

exit 0
