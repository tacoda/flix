#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
DIR=/flix/tmp/pids
FILE=/flix/tmp/pids/server.pid
[ -d "$DIR" ] && [ -f "$FILE" ] && rm -f $FILE

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
