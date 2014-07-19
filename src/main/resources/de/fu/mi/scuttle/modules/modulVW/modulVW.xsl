<xsl:transform version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format">

    <xsl:param name="sId" />
    <xsl:template match="/object">

        <fo:root font-size="8pt">
            <fo:layout-master-set>
                <fo:simple-page-master master-name="A4-landscape" page-height="210mm"
                    page-width="297mm" margin-top="1cm" margin-bottom="0.5cm" margin-left="0.5cm"
                    margin-right="0">
                    <fo:region-body margin-top="5mm"/>
                    <fo:region-before/>
                    <fo:region-after/>
                    <fo:region-start/>
                    <fo:region-end/>
                </fo:simple-page-master>
            </fo:layout-master-set>

            <fo:page-sequence master-reference="A4-landscape">
                <fo:static-content flow-name="xsl-region-after">
                    <fo:block>
                        <fo:page-number/>
                    </fo:block>
                </fo:static-content>
                <fo:flow flow-name="xsl-region-body">
                    <xsl:apply-templates select="array[@key='fachbereiche']" mode="fachbereiche"/>
                </fo:flow>

            </fo:page-sequence>
        </fo:root>
    </xsl:template>

    <xsl:template match="object" mode="fachbereiche">
        <fo:block>
            <xsl:value-of select="string[@key='fbName']"/>
        </fo:block>
        <fo:table table-layout="fixed" width="100%" border="1pt solid black">
            <fo:table-column column-width="6%" border="1pt solid black"/>
            <fo:table-column column-width="6%" border="1pt solid black"/>
            <fo:table-column column-width="10%" border="1pt solid black"/>
            <fo:table-column column-width="25%" border="1pt solid black"/>
            <fo:table-column column-width="3%" border="1pt solid black"/>
            <fo:table-column column-width="3%" border="1pt solid black"/>
            <fo:table-column column-width="25%" border="1pt solid black"/>
            <fo:table-column column-width="15%" border="1pt solid black"/>
            <fo:table-header>
                <fo:table-row background-color="#999999" border="1pt solid black">
                    <fo:table-cell padding="2pt" border="1pt solid black">
                        <fo:block>Nummer</fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="2pt" border="1pt solid black">
                        <fo:block>ModulNr</fo:block>
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
                        <fo:block>ECTS</fo:block>
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
                <xsl:apply-templates select="array[@key='institute']" mode="institute"/>
            </fo:table-body>
        </fo:table>
    </xsl:template>

    <xsl:template match="object" mode="institute">
        <xsl:apply-templates select="array[@key='sta']" mode="sta"/>
    </xsl:template>

    <xsl:template match="object" mode="sta">
        <fo:table-row background-color="#666666">
            <fo:table-cell padding="2pt" number-columns-spanned="8">
                <fo:block>
                    <xsl:value-of select="string[@key='stoName']"/>
                </fo:block>
            </fo:table-cell>
        </fo:table-row>
        <xsl:apply-templates select="array[@key='semester']" mode="semester"/>
    </xsl:template>

    <xsl:template match="object[number[@key='sId']=$sId]" mode="semester">
        <xsl:apply-templates select="array[@key='module']/object | array[@key='nRModule']/object | array[@key='module-min']/object" mode="module"/>
    </xsl:template>

    <xsl:template match="object[array[@key='dozenten']//object]" mode="lvs">
        <fo:table-row border="1pt solid black">
            <fo:table-cell padding="1mm">
                <fo:block>
                    <xsl:value-of select="string[@key='lvNummer']"/>
                </fo:block>
            </fo:table-cell>
            <fo:table-cell padding="1mm">
                <fo:block>
                    <xsl:value-of select="../../../../string[@key='mNummer']"/>
                    <xsl:for-each select="../../../../array[@key='huelsen']/object">
                    	<fo:block><xsl:value-of select="string[@key='hKuerzel']"/></fo:block>
                    </xsl:for-each>
                </fo:block>
            </fo:table-cell>
            <fo:table-cell padding="1mm">
                <fo:block>
                    <xsl:value-of select="string[@key='lvTyp']"/>
                </fo:block>
            </fo:table-cell>
            <fo:table-cell padding="1mm">
                <fo:block>
                    <xsl:value-of select="string[@key='lvName']"/>
                </fo:block>
            </fo:table-cell>
            <fo:table-cell padding="1mm">
                <fo:block>
                    <xsl:value-of select="string[@key='lvSws']"/>
                </fo:block>
            </fo:table-cell>
            <fo:table-cell padding="1mm">
                <fo:block>
                    <xsl:value-of select="../../../../string[@key='mEcts']"/>
                </fo:block>
            </fo:table-cell>
            <fo:table-cell padding="1mm">
                <fo:block>
                    <xsl:for-each select="array[@key='termine']/object">
                            <fo:block><xsl:value-of select="string[@key='tTag']"/>, <xsl:value-of select="string[@key='tVon']"/> - <xsl:value-of select="string[@key='tBis']"/> Uhr (<xsl:value-of select="string[@key='gKuerzel']"/> - <xsl:value-of select="string[@key='rId']"/>)</fo:block>
                    </xsl:for-each>
                </fo:block>
            </fo:table-cell>
            <fo:table-cell padding="1mm">
                <fo:block>
                    <xsl:for-each select="array[@key='dozenten']//object[string[@key='lNachname']]">
                        <fo:block><xsl:value-of select="string[@key='lNachname']"/>, <xsl:value-of select="string[@key='lVorname']"/></fo:block>
                    </xsl:for-each>
                </fo:block>
            </fo:table-cell>
        </fo:table-row>
    </xsl:template>
    
    <xsl:template match="object" mode="module">
    	<xsl:apply-templates select="array[@key='mlvs']/object" mode="mlvs"/>      
    </xsl:template>
    
    <xsl:template match="object" mode="mlvs">
    	<xsl:apply-templates select="array[@key='lvs']/object" mode="lvs">
            <xsl:sort select="substring(string[@key='lvNummer'], 1, 8)"/>
        </xsl:apply-templates>
    </xsl:template>

    <xsl:template match="*|node()"/>
</xsl:transform>
