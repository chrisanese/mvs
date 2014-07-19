#!/bin/bash
mvn -Djava.awt.headless=true package javadoc:javadoc surefire-report:report cobertura:cobertura
rm -rf site/apidocs site/coverage
cp -R target/site/apidocs site/apidocs
cp -R target/site/cobertura site/coverage
cp target/site/surefire-report.html site/surefire-report.html
mkdir -p site/download
cp target/scuttle.war site/download/scuttle.war

