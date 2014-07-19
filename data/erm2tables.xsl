<xsl:transform version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="xml" indent="yes" />

	<xsl:template match="/erm">
		<tables>
			<xsl:apply-templates select="entity" />

			<xsl:apply-templates select="relation[count(many) > 1]"
				mode="complex" />
		</tables>
	</xsl:template>

	<xsl:template match="entity">

		<xsl:variable name="name" select="@name" />

		<table>
			<xsl:copy-of select="@name" />
			<xsl:copy-of select="title" />
			<xsl:copy-of select="desc" />
			<xsl:copy-of select="key" />
			<xsl:copy-of select="attr" />

			<xsl:for-each select="/erm/relation[count(one) = 2 and one[@ref = $name]]">
				<xsl:variable name="fst" select="one[not(@ref = $name)]" />
				<xsl:variable name="snd" select="one[@ref = $name]" />
				<attr type="int">
					<xsl:attribute name="name">
						<xsl:value-of select="fst/@ref" />
					</xsl:attribute>
					<xsl:attribute name="ref">
						<xsl:value-of select="fst/@ref" />
					</xsl:attribute>
					<xsl:attribute name="debt">
						<xsl:choose>
							<xsl:when test="fst/@debt = 'some'">
								<xsl:text>optional</xsl:text>
							</xsl:when>
							<xsl:otherwise>
								<xsl:text>required</xsl:text>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:attribute>
				</attr>
			</xsl:for-each>

			<xsl:for-each
				select="/erm/relation[count(many) = 1 and count(one) = 1 and many/@ref = $name]">
				<attr type="int" debt="required">
					<xsl:attribute name="ref">
						<xsl:value-of select="one/@ref" />
					</xsl:attribute>
					<xsl:attribute name="name">
						<xsl:value-of select="one/@ref" />
					</xsl:attribute>
				</attr>
			</xsl:for-each>
		</table>

	</xsl:template>

	<xsl:template match="relation" mode="complex">

		<table>
			<xsl:copy-of select="@name" />
			<xsl:copy-of select="title" />

			<key>
				<xsl:attribute name="unique">
					<xsl:for-each select="many/@ref">
						<xsl:value-of select="." />
						<xsl:if test="not(last() = position())">
							<xsl:text> </xsl:text>
						</xsl:if>
					</xsl:for-each>
				</xsl:attribute>
			</key>

			<xsl:copy-of select="desc" />
			<xsl:copy-of select="attr" />

			<xsl:for-each select="many">
				<attr type="int" debt="required">
					<xsl:attribute name="ref">
						<xsl:value-of select="@ref" />
					</xsl:attribute>
					<xsl:attribute name="name">
						<xsl:value-of select="@ref" />
					</xsl:attribute>
				</attr>
			</xsl:for-each>
		</table>

	</xsl:template>

</xsl:transform>
