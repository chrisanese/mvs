#!/bin/bash
echo "Version number for this release: "
read VERSION

rm -rf ../scuttle/src
cp -R src ../scuttle

cat src/main/java/de/fu/mi/scuttle/Scuttle.java \
    | sed 's/boolean DEBUG = true;/boolean DEBUG = false;/g' \
    | sed "s/String RELEASE_DATE = \"[^\"]*\";/String RELEASE_DATE = \"`date`\";/g" \
    | sed "s/String VERSION = \"[^\"]*\";/String VERSION = \"$VERSION\";/g" \
    > ../scuttle/src/main/java/de/fu/mi/scuttle/Scuttle.java
cp ../scuttle/src/main/java/de/fu/mi/scuttle/Scuttle.java src/main/java/de/fu/mi/scuttle/Scuttle.java

cat pom.xml \
    | sed "s/<version><!-- VERSION -->[^<]*</<version><!-- VERSION -->$VERSION</g" \
    > ../scuttle/pom.xml
cp ../scuttle/pom.xml pom.xml

sed -i '' "s/<span class=\"version\">[^<]*</<span class=\"version\">$VERSION</g" 'site/index.htm'
sed -i '' "s/<span class=\"release\">[^<]*</<span class=\"release\">`date`</g" 'site/index.htm'


