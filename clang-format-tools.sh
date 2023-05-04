#!/bin/bash
echo "clang-format -i --style='{BasedOnStyle: llvm, ColumnLimit: 99, AccessModifierOffset: -4}' $@"
