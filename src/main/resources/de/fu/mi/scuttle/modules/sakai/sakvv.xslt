<xsl:transform version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">

	<xsl:template match="/object">

		<fo:root>

			<fo:layout-master-set>
				<fo:simple-page-master master-name="A4"
					page-height="297mm" page-width="210mm" margin-top="1cm"
					margin-bottom="1cm" margin-left="1cm" margin-right="1cm">
					<fo:region-body margin="2cm" />
					<fo:region-before extent="2cm" />
					<fo:region-after extent="2cm" />
					<fo:region-start extent="2cm" />
					<fo:region-end extent="2cm" />
				</fo:simple-page-master>
			</fo:layout-master-set>

			<xsl:apply-templates select="array[@key = 'studienordnungen']"
				mode="sto" />

		</fo:root>

	</xsl:template>

	<xsl:template match="object" mode="sto">

		<fo:page-sequence master-reference="A4">
			<fo:static-content flow-name="xsl-region-before">
				<fo:block>
					<xsl:value-of select="string[@key='stoName']" />
				</fo:block>
			</fo:static-content>

			<fo:static-content flow-name="xsl-region-after">
				<fo:block>
					<fo:page-number />
				</fo:block>
			</fo:static-content>

			<fo:flow flow-name="xsl-region-body">
				<xsl:apply-templates select=".//array[@key='sites']"
					mode="site" />
			</fo:flow>

		</fo:page-sequence>

	</xsl:template>

	<xsl:template match="object" mode="site">
		<fo:block page-break-after="always" font-family="Helvetica"
			font-size="10pt">
			<fo:block font-size="18pt" margin-bottom="12pt" font-weight="bold">
				<xsl:value-of select="string[@key='siteTitle']" />
			</fo:block>

			<fo:table table-layout="fixed" width="100%">
				<fo:table-column column-width="8cm" />
				<fo:table-column column-width="7cm" />
				<fo:table-body>

					<fo:table-row>
						<fo:table-cell>
							<fo:block font-weight="bold">Dozenten</fo:block>

							<xsl:for-each select="array[@key='lecturers']/object">
								<fo:block margin-top="8pt" margin-bottom="8pt">
									<xsl:value-of select="string[@key = 'firstName']" />
									<xsl:text> </xsl:text>
									<xsl:value-of select="string[@key = 'lastName']" />
									<xsl:if test="string[@key = 'emailAddress']">
										<fo:block />
										<xsl:value-of select="string[@key = 'emailAddress']" />
									</xsl:if>
									<xsl:if test="string[@key = 'homepage']">
										<fo:block />
										<xsl:value-of select="string[@key = 'homepage']" />
									</xsl:if>
								</fo:block>
							</xsl:for-each>

						</fo:table-cell>
						<fo:table-cell>
							<fo:block font-weight="bold">Termine</fo:block>

							<xsl:for-each select="array[@key='termine']/object">
								<fo:block margin-top="8pt" margin-bottom="8pt">
									<xsl:value-of select="string[@key = 'zeit']" />
									<xsl:text> (</xsl:text>
									<xsl:value-of select="string[@key = 'zyklus']" />
									<xsl:text>)</xsl:text>
									<fo:block />
									<xsl:value-of select="string[@key = 'ort']" />
								</fo:block>
							</xsl:for-each>

						</fo:table-cell>
					</fo:table-row>
				</fo:table-body>
			</fo:table>

			<xsl:if test="array[@key='groups']/object">
				<fo:block font-weight="bold">Begleittermine</fo:block>

				<fo:table table-layout="fixed" margin-top="8pt"
					border-collapse="collapse" margin-bottom="8pt" border="1pt solid black"
					width="14cm">
					<fo:table-column column-width="4cm" />
					<fo:table-column column-width="3cm" />
					<fo:table-column column-width="5cm" />
					<fo:table-column column-width="2cm" />

					<fo:table-body>
						<xsl:apply-templates select="array[@key='groups']/object"
							mode="groups">
							<xsl:sort select="string[@key='groupTitle']" />
						</xsl:apply-templates>
					</fo:table-body>
				</fo:table>

			</xsl:if>
		</fo:block>
	</xsl:template>

	<xsl:template match="object" mode="groups">
		<fo:table-row>
			<fo:table-cell border="1pt solid black">
				<fo:block>
					<xsl:value-of select="string[@key='groupTitle']" />
				</fo:block>
			</fo:table-cell>
			<fo:table-cell border="1pt solid black">
				<fo:block>
					<xsl:value-of select="string[@key='weekday']" />
					<xsl:text> </xsl:text>
					<xsl:value-of select="number[@key='start']" />
					<xsl:text> - </xsl:text>
					<xsl:value-of select="number[@key='end']" />
				</fo:block>
			</fo:table-cell>
			<fo:table-cell border="1pt solid black">
				<fo:block>
					<xsl:value-of select="array[@key='groupTA']/string" />
				</fo:block>
			</fo:table-cell>
			<fo:table-cell border="1pt solid black">
				<fo:block>
					<xsl:value-of select="number[@key='studentsCount']" />
					<xsl:text> / </xsl:text>
					<xsl:value-of
						select="object[@key='properties']/string[@key='sections_max_enrollments']" />
				</fo:block>
			</fo:table-cell>
		</fo:table-row>
	</xsl:template>


</xsl:transform>