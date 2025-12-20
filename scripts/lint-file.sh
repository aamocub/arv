#!/bin/sh

set -x
set -e

if [[ $# -eq 0 ]]; then
        echo "No arguments supplied"
        exit 1
fi
if [[ $# -ge 2 ]]; then
        echo "Too many arguments, more than allowed"
        exit 1
fi

if [[ ! -f $1 ]]; then
        echo "File does not exist"
        exit 1
fi

if ! command -v verilator >/dev/null 2>&1
then
        echo "Verilator could not be found"
        exit 1
fi

verilator -Irtl -Irtl/include -Ibench --lint-only --sv -Wall -Wno-MODDUP -Wno-MULTITOP $1
