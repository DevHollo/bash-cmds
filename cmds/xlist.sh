#!/bin/bash

BLUE="\e[1;34m"
YELLOW="\e[1;33m"
GREEN="\e[1;32m"
ORANGE="\e[38;5;208m"
CYAN="\e[1;38;2;55;215;210m"
RESET="\e[0m"

DIR="${1:-.}"

if [ ! -d "$DIR" ]; then
    echo "Error: '$DIR' is not a directory."
    exit 1
fi

shopt -s nullglob
files=("$DIR"/*)
if [ ${#files[@]} -eq 0 ]; then
    echo "Directory is empty."
    exit 0
fi

for item in "${files[@]}"; do
    name=$(basename "$item")

    if [ -L "$item" ]; then
        target=$(readlink "$item")
        echo -e "${name} -> ${target}: ${CYAN}symlink${RESET}"
    elif [ -d "$item" ]; then
        echo -e "${name}: ${BLUE}folder${RESET}"
    elif [ -f "$item" ]; then
        if [[ "$name" == *.desktop ]]; then
            echo -e "${name}: ${ORANGE}shortcut${RESET}"
        elif [ -x "$item" ]; then
            if [[ "$name" == *.sh ]]; then
                echo -e "${name}: ${GREEN}compiled bash script${RESET}"
            else
                echo -e "${name}: ${GREEN}executable file${RESET}"
            fi
        else
            echo -e "${name}: ${YELLOW}file${RESET}"
        fi
    else
        echo "${name}: unknown type"
    fi
done
