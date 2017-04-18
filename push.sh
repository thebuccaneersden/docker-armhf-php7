#!/usr/bin/env bash
#
# Push all images.

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

  info "Tagging $type..."
  docker tag thebuccaneersden/docker-armhf-php7:$type thebuccaneersden/docker-armhf-php7:$type
  docker push thebuccaneersden/docker-armhf-php7:$type

  if [[ $? -gt 0 ]]; then
    fatal "Tag of $type failed!"
  else
    info "Tag of $type succeeded."
  fi

done

info "All builds successful!"

exit 0
