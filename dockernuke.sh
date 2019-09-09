#!/bin/bash
set -e

function check_command() {
  local command_name=$1
  command -v "${command_name}">/dev/null 2>&1 || { error "This script requires ${command_name} but it's not installed.  Aborting." >&2; exit 1; }
}

function check_commands() {
  for command_name in "$@"; do
    check_command "${command_name}"
  done
}

function check_dir() {
if [ ! -d "${dir}" ]; then
    error "Directory ${dir} not present, exiting..."
    exit 1
fi
}

check_commands mv rm docker sudo systemctl

NSTEPS="4"
echo -ne "[1/$NSTEPS] Stopping Docker..."
sudo systemctl stop docker
echo -ne "[OK]\n"

echo -ne "[2/$NSTEPS] Moving directory..."
dir="/var/lib/docker"
olddir="${dir}.old"
if [ -d "${dir}" ]; then
  sudo mv -f ${dir} ${olddir}
fi
echo -ne "[OK]\n"

echo -ne "[3/$NSTEPS] Erasing old directory..."

sudo rm -Rf ${olddir} &
echo -ne "[OK]\n"

sleep 10

echo -ne "[4/$NSTEPS] Starting Docker..."
sudo systemctl start docker
echo -ne "[OK]\n"
