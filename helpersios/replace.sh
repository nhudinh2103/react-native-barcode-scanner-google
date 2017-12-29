#! /bin/bash

SYMBOLS="([^0-9a-zA-Z_])(RemoveLogSink|AddLogSink|FLAGS_[0-9a-zA-Z_]*)"
SEDSYMS=$(echo $SYMBOLS | sed 's/|/\\\|/g' | sed 's/(/\\\(/g' | sed 's/)/\\\)/g')

find node_modules/react-native/third-party \
      -iname "*.c" -o -iname "*.cc" \
      -o -iname "*.in" -o -iname "*.h" \
      | xargs egrep -l "$SYMBOLS" \
      | xargs sed -i "s/$SEDSYMS/\1REACT\2/g"
