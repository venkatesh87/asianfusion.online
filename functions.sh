#!/bin/bash

# Suppress MySQL password warning
no_pw_warning() {
    "$@" 2>/dev/null | grep -v "mysql: [Warning] Using a password on the command line interface can be insecure."
}

# Suppress command output
no_output() {
    "$@" > /dev/null 2>&1
}

# Get password
function get-password {
  password=$(openssl rand -base64 12)
  echo $password
}
