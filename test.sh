#!/usr/bin/env bash

read -p "Enter your name [Richard]: " name
name=${name:-Richard}
echo $name

read -r version
version=${version:-0.9.4}
echo "Version selected is v${version}"
