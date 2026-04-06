#!/bin/sh

CONFIG_FILE="./server.properties"

# Function to vverride a property
set_prop() {
  KEY="$1"
  VALUE="$2"

  if grep -q "^${KEY}=" "$CONFIG_FILE"; then
    sed -i "s|^${KEY}=.*|${KEY}=${VALUE}|" "$CONFIG_FILE"
  fi
}

# Override the properties
[ -n "$MAX_PLAYERS" ] && set_prop "max-players" "$MAX_PLAYERS"
[ -n "$DIFFICULTY" ] && set_prop "difficulty" "$DIFFICULTY"

# Start the server
exec java -jar mcserver.jar nogui
