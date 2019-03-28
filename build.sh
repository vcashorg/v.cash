#!/bin/bash

set -e

langs=(zh-cn en)

for lang in "${langs[@]}"; do
	file="README.${lang}.md"
	if [ ! -f "$file" ]; then
		echo "ERR ${file} not found" > /dev/stderr
		exit 1
	fi

	content=`marked "$file"`
	upper=`echo "$lang" | tr a-z A-Z`
	slot='{SLOT_'"$upper"'}'
	replace-in-file "$slot" "<div class=\"markdown-body lang-$lang hidden\">${content}</div>" index.html
done