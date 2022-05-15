#!/usr/bin/env bash
#
# Helper function newline before echo
function necho () {
  echo "\n$1";
}

# Color output functions
function echo_red() {
  necho "$(tput setaf 1)${1}$(tput sgr0)";
}

function echo_green() {
  echo "$(tput setaf 2)${1}$(tput sgr0)";
}

function echo_yellow() {
  necho "$(tput setaf 3)${1}$(tput sgr0)";
}

function echo_cyan() {
  necho "$(tput setaf 6)${1}$(tput sgr0)";
}