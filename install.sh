#!/bin/bash -x
echo "installing apache-knox"

# add test to error out if java isn't installed
# java required for knox: https://knox.apache.org/books/knox-1-3-0/user-guide.html#Introduction
java -version || exit 0

# unzip required for installation
unzip -v || exit 0

# download knox
wget <insert-knox-download-url-here>.zip

# extract knox
unzip knox-{VERSION}.zip

