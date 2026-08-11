#!/bin/sh
# Patches the Suwayomi WebUI's PWA name after it's downloaded to /tmp on
# each container start (that directory isn't persisted, so this has to
# re-run every boot rather than being a one-time build step).
APP_NAME="${APP_DISPLAY_NAME:-InkStream}"
SERVE_DIR=/tmp/Tachidesk/webUI-serve

while true; do
  if [ -f "$SERVE_DIR/site.webmanifest" ] && [ ! -f "$SERVE_DIR/.renamed" ]; then
    sed -i "s/Suwayomi/$APP_NAME/g" "$SERVE_DIR/index.html" "$SERVE_DIR/site.webmanifest"
    touch "$SERVE_DIR/.renamed"
  fi
  sleep 5
done
