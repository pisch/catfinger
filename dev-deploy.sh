#! /bin/bash

# Restart the Streamdeck app with a fresh copy of the plugin.

set -exo pipefail

# Get the Xcode DerivedData folder - die if there is more than one.
derived_data="$(echo ~/Library/Developer/Xcode/DerivedData/Catfinger*)"
test -d "$derived_data"

osascript -e 'tell application "Elgato Stream Deck" to quit' || true

cp -p "$derived_data/Build/Products/Debug/Catfinger" Sources/nl.impeto.catfinger.sdPlugin

rsync -av --delete Sources/nl.impeto.catfinger.sdPlugin "$HOME/Library/Application Support/com.elgato.StreamDeck/Plugins/."

sleep 5
open "/Applications/Elgato Stream Deck.app"
