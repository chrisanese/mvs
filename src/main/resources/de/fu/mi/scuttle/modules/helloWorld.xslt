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

			<fo:page-sequence master-reference="A4">

				<fo:static-content flow-name="xsl-region-before">
					<fo:block>
						<xsl:text>Dieses Dokument wurde generiert @ </xsl:text>
						<xsl:value-of select="string[@key='currentTime']" />
					</fo:block>
				</fo:static-content>

				<fo:static-content flow-name="xsl-region-after">
					<fo:block>
						<fo:page-number />
					</fo:block>
				</fo:static-content>

				<fo:flow flow-name="xsl-region-body">
					<fo:block font-family="Helvetica" font-size="20pt">
						Hello, world!
					</fo:block>
				</fo:flow>

			</fo:page-sequence>

		</fo:root>

	</xsl:template>

</xsl:transform>