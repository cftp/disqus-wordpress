README_FILENAME=disqus/readme.txt
SCRIPT_FILENAME=disqus/disqus.php
PWD=`pwd`
VERSION=$(shell awk '/Version: (.+)$$/ {print $$2}' "${SCRIPT_FILENAME}")
OUT=$(shell mktemp -d -t disqus-wordpress.XXXXXX)


update:
	git submodule foreach git pull origin master

zip: update
	@echo "Generating package in $(OUT)"

	cp -r disqus ${OUT}

	ls ${OUT}

	# $(sed "s/Stable tag: .+$$/Stable tag: ${VERSION}/" "${README_FILENAME}")

	rm -f "${PWD}/disqus-wordpress-${VERSION}.zip"
	zip -r "${PWD}/disqus-wordpress-${VERSION}.zip" disqus -x "*.git*"

install:
	@echo "${PWD}/../disqus/"
	rm -rf "${PWD}/../disqus/"
	cp -r "${PWD}/disqus" "${PWD}/../disqus/"
