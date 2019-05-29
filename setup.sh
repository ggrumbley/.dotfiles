#!/usr/bin/env bash

if [ "$(uname)" == "Darwin" ]; then
  source mac.sh
elif [ "$(uname)" == "Linux" ]; then
  source linux.sh
else
  echo "This is not a supported OS."
fi
