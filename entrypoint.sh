#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
FILE=/flix/tmp/pids/server.pid
if [[ -f "$FILE" ]]; then
    rm -f $FILE
fi

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
