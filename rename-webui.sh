#!/bin/sh
# Patches the Suwayomi WebUI's PWA name/icons after it's downloaded to /tmp
# on each container start (that directory isn't persisted, so this has to
# re-run every boot rather than being a one-time build step).
APP_NAME="${APP_DISPLAY_NAME:-InkStream}"
SERVE_DIR=/tmp/Tachidesk/webUI-serve
ICONS_DIR=/opt/inkstream-icons

while true; do
  if [ -f "$SERVE_DIR/site.webmanifest" ] && [ ! -f "$SERVE_DIR/.renamed" ]; then
    sed -i "s/Suwayomi/$APP_NAME/g" "$SERVE_DIR/index.html" "$SERVE_DIR/site.webmanifest"
    # Suwayomi's favicon.svg takes priority over favicon.ico in most browsers;
    # dropping the link makes them fall back to our replaced favicon.ico instead.
    sed -i '/favicon\.svg/d' "$SERVE_DIR/index.html"
    cp "$ICONS_DIR/favicon-96x96.png" "$SERVE_DIR/favicon-96x96.png"
    cp "$ICONS_DIR/apple-touch-icon.png" "$SERVE_DIR/apple-touch-icon.png"
    cp "$ICONS_DIR/web-app-manifest-192x192.png" "$SERVE_DIR/web-app-manifest-192x192.png"
    cp "$ICONS_DIR/web-app-manifest-512x512.png" "$SERVE_DIR/web-app-manifest-512x512.png"
    cp "$ICONS_DIR/favicon.ico" "$SERVE_DIR/favicon.ico"
    touch "$SERVE_DIR/.renamed"
  fi
  sleep 5
done
