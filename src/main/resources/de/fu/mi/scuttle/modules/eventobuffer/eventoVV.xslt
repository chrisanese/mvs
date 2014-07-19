<xsl:transform version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">

	<xsl:template match="/object">

		<fo:root font-size="8pt">
			<fo:layout-master-set>
				<fo:simple-page-master master-name="A4-landscape"
					page-height="210mm" page-width="297mm" margin-top="1cm"
					margin-bottom="0.5cm" margin-left="0.5cm" margin-right="0">
					<fo:region-body margin-top="5mm"/>
					<fo:region-before />
					<fo:region-after />
					<fo:region-start />
					<fo:region-end />
				</fo:simple-page-master>
			</fo:layout-master-set>

            <fo:page-sequence master-reference="A4-landscape">
                <fo:static-content flow-name="xsl-region-after">
                    <fo:block>
                        <fo:page-number />
                    </fo:block>
                </fo:static-content>
                <fo:flow flow-name="xsl-region-body">
                    <fo:table table-layout="fixed" width="100%" border="1pt solid black">
                        <fo:table-column column-width="5%"/>
                        <fo:table-column column-width="5%"/>
                        <fo:table-column column-width="15%"/>
                        <fo:table-column column-width="25%"/>
                        <fo:table-column column-width="3%"/>
                        <fo:table-column column-width="32%"/>
                        <fo:table-column column-width="10%"/>
                        <fo:table-header>
                            <fo:table-row background-color="#999999" border="1pt solid black">
                                <fo:table-cell padding="2pt" border="1pt solid black">
                                    <fo:block>Version</fo:block>
                                </fo:table-cell>
                                <fo:table-cell padding="2pt" border="1pt solid black">
                                    <fo:block>Nummer</fo:block>
                                </fo:table-cell>
                                <fo:table-cell padding="2pt" border="1pt solid black">
                                    <fo:block>Art</fo:block>
                                </fo:table-cell>
                                <fo:table-cell padding="2pt" border="1pt solid black">
                                    <fo:block>Titel</fo:block>
                                </fo:table-cell>
                                <fo:table-cell padding="2pt" border="1pt solid black">
                                    <fo:block>SWS</fo:block>
                                </fo:table-cell>
                                <fo:table-cell padding="2pt" border="1pt solid black">
                                    <fo:block>Termine</fo:block>
                                </fo:table-cell>
                                <fo:table-cell padding="2pt" border="1pt solid black">
                                    <fo:block>Dozenten</fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </fo:table-header>
                        <fo:table-body>
                            <xsl:apply-templates select="."
                                                 mode="sto" />
                        </fo:table-body>
                    </fo:table>
                </fo:flow>

            </fo:page-sequence>
		</fo:root>
	</xsl:template>

    <xsl:template match="object" mode="semester">
        <fo:static-content flow-name="xsl-region-before">
            <fo:block><xsl:value-of select="string[@key='description']" /></fo:block>
        </fo:static-content>
    </xsl:template>

    <xsl:key name="versionDistinct" match="object" use="string" />
    <xsl:key name="lvDistinct" match="object" use="string" />
    <xsl:template match="array" mode="sto">
        <xsl:for-each select="..//object[generate-id() = generate-id(key('versionDistinct', string[@key='stoWithoutVersion'])[1])]">
            <xsl:choose>
                <xsl:when test="starts-with(string[@key='stoNr'], 'E')"></xsl:when>
                <xsl:otherwise>
                    <fo:table-row background-color="#666666">
                        <fo:table-cell padding="2pt" number-columns-spanned="7"><fo:block><xsl:value-of select="string[@key='stoName-deutsch']"/>(<xsl:value-of
                                select="string[@key='stoWithoutVersion']" />)</fo:block></fo:table-cell>
                    </fo:table-row>
                    <xsl:variable name="withoutVersion" select="string[@key='stoWithoutVersion']" />

                    <xsl:for-each select="..//object[string[@key='stoWithoutVersion']/text() = $withoutVersion/text()]//array[@key='stoPhasen']//object/array[@key='studienarten']//object/array[@key='module']//object/array[@key='verlinkteKurse']//object[generate-id() = generate-id(key('lvDistinct', string[@key='lvcomb'])[1])]">
                        <xsl:sort select="substring(string[@key='lvNr'], 1, 6)" />
                        <xsl:choose>
                            <xsl:when test="contains(string[@key='status'], 'a.Publiziert')">
                                <fo:table-row border="1pt solid black" page-break-inside="avoid">
                                    <fo:table-cell padding="2pt" border="1pt solid black">
                                        <fo:block>
                                            <xsl:variable name="d" select="string[@key='lvcomb']">
                                                
                                            </xsl:variable>
                                            <xsl:for-each select="../../../../../../../../..//object[string[@key='stoWithoutVersion'] = $withoutVersion and array[@key='stoPhasen']//object//array[@key='studienarten']//object//array[@key='module']//object//array[@key='verlinkteKurse']//object[string[@key='lvcomb'] = $d/text()]]">
                                                <xsl:value-of select="substring(string[@key='stoNr'], 4, 1)" />
                                            </xsl:for-each>
                                        </fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell padding="2pt" border="1pt solid black"><fo:block><xsl:value-of select="string[@key='lvNr']" /></fo:block></fo:table-cell>
                                    <fo:table-cell padding="2pt" border="1pt solid black"><fo:block><xsl:value-of select="string[@key='typ-deutsch']" /></fo:block></fo:table-cell>
                                    <fo:table-cell padding="2pt" border="1pt solid black"><fo:block><xsl:value-of select="string[@key='titel-deutsch']" /></fo:block></fo:table-cell>
                                    <fo:table-cell padding="2pt" border="1pt solid black"><fo:block><xsl:value-of select="string[@key='sws']" /></fo:block></fo:table-cell>
                                    <fo:table-cell padding="2pt" border="1pt solid black">
                                        <xsl:choose>
                                            <xsl:when test="array[@key='haupttermine']/object/string[@key='serienzeit']">
                                                <fo:block>Haupttermine:</fo:block>
                                                <xsl:for-each select="array[@key='haupttermine']/object">
                                                    <fo:block>
                                                        <xsl:value-of select="string[@key='serienzeit']" />
                                                        <xsl:text xml:space="preserve"> Uhr </xsl:text>
                                                        <xsl:value-of select="array[@key='serienTermine']/object/array[@key='raueme']/object/string[@key='gebauedename']" />
                                                        <xsl:text> </xsl:text>
                                                        <xsl:value-of select="array[@key='serienTermine']/object/array[@key='raueme']/object/string[@key='raumname']" />
                                                    </fo:block>
                                                </xsl:for-each>
                                                <xsl:if test="array[@key='begleittermine']">
                                                    <fo:block>Begleittermine:</fo:block>
                                                    <xsl:for-each select="array[@key='begleittermine']/object">
                                                        <fo:block>
                                                            <xsl:value-of select="string[@key='serienzeit']" />
                                                            <xsl:text xml:space="preserve"> Uhr </xsl:text>
                                                            <xsl:value-of select="array[@key='serienTermine']/object/array[@key='raueme']/object/string[@key='gebauedename']" />
                                                            <xsl:text> </xsl:text>
                                                            <xsl:value-of select="array[@key='serienTermine']/object/array[@key='raueme']/object/string[@key='raumname']" />
                                                        </fo:block>
                                                    </xsl:for-each>
                                                </xsl:if>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <fo:block></fo:block>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </fo:table-cell>
                                    <xsl:if test="array[@key='haupttermine']/object/array[@key='serienTermine']/object/array[@key='dozenten']/object">
                                        <fo:table-cell padding="2pt" border="1pt solid black">
                                            <fo:block></fo:block>
                                            <xsl:for-each select="array[@key='haupttermine']/object[1]/array[@key='serienTermine']/object[1]/array[@key='dozenten']/object">
                                                <fo:block>
                                                    <xsl:value-of select="string[@key='titel']" />
                                                    <xsl:text> </xsl:text>
                                                    <xsl:value-of select="string[@key='vorname']" />
                                                    <xsl:text> </xsl:text>
                                                    <xsl:value-of select="string[@key='nachname']" />
                                                </fo:block>
                                            </xsl:for-each>
                                        </fo:table-cell>
                                    </xsl:if>
                                </fo:table-row>
                            </xsl:when>
                            <xsl:otherwise />
                        </xsl:choose>
                    </xsl:for-each>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:for-each>
	</xsl:template>

    <xsl:template match="object" mode="verlinkteKurse">

    </xsl:template>
    <xsl:template match="*"></xsl:template>
</xsl:transform>