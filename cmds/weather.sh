#!/bin/bash

version="v0.0.1"
spacer="\e[38;2;255;123;0m+======================================================+\e[0m"

usage() {
    echo -e "$spacer"
    echo "  -f    Show temperature in Fahrenheit"
    echo "  -v, --version  Show version info"
    echo "  -a, --about    Show about info"
    echo "  -h, --help    Shows this exact menu lol"
    echo -e "$spacer"
    exit 1
}

about() {
    clear
    figlet "Weather"
    echo -e "$spacer"
    echo "This was created by DevHollo on github (https://github.com/DevHollo)"
    echo "This was made out of pure bordom."
    echo "Thats really all you need to know go run the command or something."
    echo -e "$spacer"
}

unit="m"
location=""

if [[ $# -eq 0 ]]; then
  usage
fi

for arg in "$@"; do
    if [[ "$arg" == "-v" || "$arg" == "--version" ]]; then
        echo "Weather Command's version is: $version"
        exit 0
    fi
done

for arg in "$@"; do
    if [[ "$arg" == "-a" || "$arg" == "--about" ]]; then
        about
        exit 0
    fi
done

for arg in "$@"; do
    if [[ "$arg" == "-h" || "$arg" == "--help" ]]; then
        usage
        exit 0
    fi
done

if [[ $1 == "-f" ]]; then
    unit="u"
    shift
fi

if [[ $# -eq 0 ]]; then
    usage
fi

location="$*"

weather=$(curl -s "wttr.in/${location}?format=3&${unit}")

echo -e "\e[1;34m🌤️  Weather for $location:\e[0m"
echo -e "\e[1;33m$weather\e[0m"
