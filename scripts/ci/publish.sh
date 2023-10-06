#!/usr/bin/env bash

[ "${DOMAIN}" = '' ] && echo "❌ 'DOMAIN' env var not set" && exit 1

[ "${DOCKER_PASSWORD}" = '' ] && echo "❌ 'DOCKER_PASSWORD' env var not set" && exit 1
[ "${DOCKER_USER}" = '' ] && echo "❌ 'DOCKER_USER' env var not set" && exit 1
[ "${DOCKER_IMAGES}" = '' ] && echo "❌ 'DOCKER_IMAGES' env var not set" && exit 1
[ "${GITHUB_SHA}" = '' ] && echo "❌ 'GITHUB_SHA' env var not set" && exit 1
[ "${GITHUB_BRANCH}" = '' ] && echo "❌ 'GITHUB_BRANCH' env var not set" && exit 1
[ "${GITHUB_REPO_REF}" = '' ] && echo "❌ 'GITHUB_REPO_REF' env var not set" && exit 1

DOCKER_VERSION="$1"

set -eu

# login to registry
echo "🔐 Logging into docker registry..."
echo "${DOCKER_PASSWORD}" | helm registry login "${DOMAIN}" -u "${DOCKER_USER}" --password-stdin

SHA="$(echo "${GITHUB_SHA}" | head -c 6)"

old_IFS="$IFS"
IFS=','
for docker_image in ${DOCKER_IMAGES}; do
  echo "🚀 Publishing ${docker_image}..."
  echo "📝 Generating Image tags..."
  IMAGE_ID="${DOMAIN}/${GITHUB_REPO_REF}/${docker_image//[._-]*$//}"
  SHA_IMAGE_REF="${IMAGE_ID}:${SHA}"
  SEMANTIC_IMAGE_REF="${IMAGE_ID}:${DOCKER_VERSION}"
  echo "📝 SHA     : ${SHA_IMAGE_REF}"
  echo "📝 Semantic: ${SEMANTIC_IMAGE_REF}"
  echo "⬇️ Pulling image..."
  docker pull "${SHA_IMAGE_REF}"
  docker tag "${SHA_IMAGE_REF}" "${SEMANTIC_IMAGE_REF}"
  echo "⬆️ Pushing image..."
  docker push "${SEMANTIC_IMAGE_REF}"
  echo "✅ Successfully published ${docker_image}!"
done
IFS="$old_IFS"
echo "✅ Successfully published all images!"
