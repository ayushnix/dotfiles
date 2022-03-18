# SPDX-License-Identifier: ISC
#
# Copyright (c) 2022 Ayush Agarwal
#
# Permission to use, copy, modify, and /or distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH
# REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY
# AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
# INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
# LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
# OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
# PERFORMANCE OF THIS SOFTWARE.
#
# -----------------------------------------------------------------------------
#
# This file is meant to be sourced and used by other bash and POSIX sh scripts
# to execute frequently used functions. Consequently, this file should also be
# POSIX sh compatible.
#
# because this file is intended to be sourced, there's no need for a shebang
# shellcheck disable=SC2148
#
# the variables defined here won't be used in this file
# shellcheck disable=SC2034
#
# -----------------------------------------------------------------------------

# red color for errors
readonly redclr="\033[31m"
# yellow color for warnings
readonly yelclr="\033[33m"
readonly resclr="\033[0m"

is_installed() {
  if command -v "$1" > /dev/null 2>&1; then
    return 0
  else
    return 1
  fi
}

chmox() {
  if [ -f "$1" ]; then
    chmod +x "$1" || _die "unable to make $1 an executable file"
  else
    _die "unable to find $1"
  fi
}

_confirm() {
  local msg
  msg="${1:-do you want to continue? (Y/n)}"
  while true; do
    printf "%s" "$msg "
    read -r choice
    case "$choice" in
      [nN]*) _die ;;
      [yY]*) break ;;
      *) _warn "please provide valid input" ;;
    esac
  done
}

_die() {
  if [ -n "$1" ]; then
    printf "%b%s%b\n" "$redclr" "$1" "$resclr" >&2
  fi
  exit 1
}

_warn() {
  if [ -n "$1" ]; then
    printf "%b%s%b\n" "$yelclr" "$1" "$resclr" >&2
  fi
}
