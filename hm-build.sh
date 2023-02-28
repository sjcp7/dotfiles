#!/bin/sh
pushd ~/.dotfiles
nix build .#homeConfigurations.samuka.activationPackage
./result/activate
popd
