#!/bin/bash

readonly PHPMYADMIN_PORT=$(jq -r ".docker.phpmyadmin.port" ./app.json)

# Open in browser
open http://localhost:$PHPMYADMIN_PORT
