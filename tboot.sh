#!/bin/sh
echo "Compiling sources..."

( cd lapis/rest ; moonc * )
( cd spec/server ; moonc app.moon )

echo "Installing rock..."
sudo luarocks make
eval `luarocks path`
busted "$@"
