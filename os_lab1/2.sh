#!/bin/bash

# Считывать строки с клавиатуры, пока не будет введена строка "q". После этого вывести
# последовательность считанных строк в виде одной строки.

tmp=$(mktemp)
input=""

while [[ $input != "q" ]]; do
  read input
  echo "$input" >> "$tmp"
done

echo "Output: "
cat "$tmp"
rm "$tmp"
