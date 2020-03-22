#!/bin/bash

set -eu

exec diff -u <(sed -e 's/secure: "[^"]*"/secure: "SECURE"/g' "$1") "$2"
