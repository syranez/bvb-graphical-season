.PHONY: compile

compile:
	xsltproc transform.xsl data/data.xml > index.html
