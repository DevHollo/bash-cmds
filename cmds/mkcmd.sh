#!/bin/bash

print_green() {
    echo -e "\e[38;2;0;255;0m$1\e[0m"
}

if [ -z "$1" ]; then
    echo "Usage: $0 [-c|--copy] <script>"
    exit 1
fi

use_copy=false

if [[ "$1" == "-c" || "$1" == "--copy" ]]; then
    use_copy=true
    shift
fi

file="$1"
if [ ! -f "$file" ]; then
    echo "Error: File '$file' does not exist."
    exit 1
fi

filename="$(basename "$file")"
name_without_ext="${filename%.*}"

if ! sudo sh -c "test -w /usr/local/bin"; then
    echo "Error: No write permission to /usr/local/bin"
    exit 1
fi

target="/usr/local/bin/$name_without_ext"

if [ -e "$target" ]; then
    read -p $'\e[38;2;255;123;0mWarning: '"$target"$' already exists. Overwrite? (y/N): \e[0m' ans
    case "$ans" in
        [Yy]* ) ;;
        * ) echo "Aborted."; exit 1;;
    esac
fi

chmod +x "$file"

if [ "$use_copy" = true ]; then
    sudo cp "$file" "$target"
    print_green "Copied to $target (Run with '$name_without_ext')"
else
    sudo mv "$file" "$target"
    print_green "Successfully made command '$name_without_ext'. (Try running it!)"
fi
