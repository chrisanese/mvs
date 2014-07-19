<?xml version="1.0" encoding="UTF-8" ?>

<xsl:transform version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:param name="table_prefix" select="'scuttle_'" />
	<xsl:param name="primary_key" select="'id'" />

	<xsl:output method="text" />


	<xsl:template match="/tables">
		<xsl:apply-templates select="table" mode="basic" />
		<xsl:apply-templates select="table" mode="keys" />
	</xsl:template>


	<xsl:template match="table" mode="basic">

		<xsl:variable name="table_name" select="concat($table_prefix, @name)" />

		<xsl:text>CREATE TABLE </xsl:text>
		<xsl:value-of select="$table_name" />
		<xsl:text> ( &#xA;  </xsl:text>

		<xsl:value-of select="$primary_key" />
		<xsl:text> INTEGER PRIMARY KEY</xsl:text>

		<xsl:for-each select="attr">
			<xsl:text>,&#xA;  </xsl:text>
			<xsl:choose>
				<xsl:when test="@ref">
					<xsl:text>f_</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>a_</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:value-of select="@name" />
			<xsl:text> </xsl:text>

			<xsl:choose>
				<xsl:when test="@ref">
					<xsl:text>INTEGER</xsl:text>
				</xsl:when>
				<xsl:when test="@type = 'int'">
					<xsl:text>INTEGER</xsl:text>
				</xsl:when>
				<xsl:when test="@type = 'text' or number(@maxlen) >= 256">
					<xsl:text>TEXT</xsl:text>
				</xsl:when>
				<xsl:when test="number(@maxlen) > 0 and 256 > number(@maxlen)">
					<xsl:text>VARCHAR (</xsl:text>
					<xsl:value-of select="@maxlen" />
					<xsl:text>)</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>VARCHAR (255)</xsl:text>
				</xsl:otherwise>
			</xsl:choose>

			<xsl:text> </xsl:text>
			<xsl:choose>
				<xsl:when test="@debt = 'optional'">
					<xsl:text>NULL</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>NOT NULL</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>

		<xsl:for-each select="key[@unique]">
			<xsl:text>,&#xA;  UNIQUE KEY (</xsl:text>
			<xsl:call-template name="unique_keys">
				<xsl:with-param name="string" select="normalize-space(@unique)" />
				<xsl:with-param name="attrs" select="attr" />
			</xsl:call-template>
			<xsl:text>)</xsl:text>
		</xsl:for-each>

		<xsl:for-each select="key[@index]">
			<xsl:text>,&#xA;  INDEX (</xsl:text>
			<xsl:call-template name="unique_keys">
				<xsl:with-param name="string" select="normalize-space(@index)" />
				<xsl:with-param name="attrs" select="attr" />
			</xsl:call-template>
			<xsl:text>)</xsl:text>
		</xsl:for-each>


		<xsl:text>&#xA;); &#xA;&#xA;</xsl:text>

	</xsl:template>


	<xsl:template match="table" mode="keys">

		<xsl:variable name="table_name" select="concat($table_prefix, @name)" />

		<xsl:for-each select="attr[@ref]">
			<xsl:text>ALTER TABLE </xsl:text>
			<xsl:value-of select="$table_name" />
			<xsl:text> ADD FOREIGN KEY (</xsl:text>
			<xsl:value-of select="concat('f_', @name)" />
			<xsl:text>) REFERENCES </xsl:text>
			<xsl:value-of select="concat($table_prefix, @ref)" />
			<xsl:text> (</xsl:text>
			<xsl:value-of select="$primary_key" />
			<xsl:text>);&#xA;</xsl:text>
		</xsl:for-each>

	</xsl:template>


	<xsl:template name="unique_keys">

		<xsl:param name="string" />
		<xsl:param name="attrs" />

		<xsl:choose>
			<xsl:when test="contains($string, ' ')">
				<xsl:choose>
					<xsl:when test="$attrs[name = substring-before($string, ' ') and @ref]">
						<xsl:text>f_</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>a_</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:value-of select="substring-before($string, ' ')" />
				<xsl:text>, </xsl:text>
				<xsl:call-template name="unique_keys">
					<xsl:with-param name="string" select="substring-after($string, ' ')" />
					<xsl:with-param name="attrs" select="$attrs" />
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="$attrs[name = $string and @ref]">
						<xsl:text>f_</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>a_</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:value-of select="$string" />
			</xsl:otherwise>
		</xsl:choose>

	</xsl:template>


</xsl:transform>


