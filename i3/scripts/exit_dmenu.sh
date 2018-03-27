#!/usr/bin/env bash
#
# File Name:       exit_dmenu.sh
# Created:         08-07-2017
# Last modified:   Mon 10 Jul 2017 03:16:52 PM CEST
# Author:          Thomas Goldbrunner <thomas.goldbrunner@posteo.de>
#
#
# Copyright (c) 2017 Thomas Goldbrunner
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#

options="Lock\nLog Out\nSuspend\nReboot\nShutdown"
my_dmenu="-b -i -nb '#243443' -nf '#f8f8f2' -sb '#888882' -fn 'Source Code Pro-11'"

command=$(echo -e "$options" | eval dmenu "$my_dmenu")

case $command in
  "Lock" )
    ~/.i3/scripts/lock.sh
    ;;
  "Log Out" )
    i3-msg exit
    ;;
  "Suspend" )
    ~/.i3/scripts/lock.sh --suspend
    ;;
  "Reboot" )
    systemctl reboot
    ;;
  "Shutdown" )
    systemctl poweroff
    ;;
esac
