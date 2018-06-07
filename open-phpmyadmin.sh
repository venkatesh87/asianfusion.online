#!/bin/bash

readonly WP_PORT=$(jq -r ".docker.phpmyadmin.port" ./app.json)

# Open in browser
open http://localhost:$WP_PORT
