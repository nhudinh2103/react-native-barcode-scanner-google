#! /bin/bash

SYMBOLS="([^0-9a-zA-Z_])(RemoveLogSink|AddLogSink|FLAGS_[0-9a-zA-Z_]*)"
SEDSYMS=$(echo $SYMBOLS | gsed 's/|/\\\|/g' | gsed 's/(/\\\(/g' | gsed 's/)/\\\)/g')

find node_modules/react-native/third-party \
      -iname "*.c" -o -iname "*.cc" \
      -o -iname "*.in" -o -iname "*.h" \
      | xargs egrep -l "$SYMBOLS" \
      | xargs gsed -i "s/$SEDSYMS/\1REACT\2/g"
