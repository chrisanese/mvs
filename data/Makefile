create.sql: tables.xml
	xsltproc --stringparam table_prefix scuttle_ tables2mysql.xsl tables.xml > create.sql

check:
	xmllint --valid --noout tables.xml

