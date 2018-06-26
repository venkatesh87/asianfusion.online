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
get_password() {
  password=$(openssl rand -base64 29 | tr -d "=+/" | cut -c1-25)
  echo $password
}

ec2_ssh_run_cmd() {
  CMD=$1
  ssh ${SSH_USER}@${PUBLIC_IP} -i $KEY_PATH -p $SSH_PORT "$CMD"
}

end() {
  echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
  echo
  exit
}
