<xsl:transform version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template match="/schema">
		<html>
			<head>
				<meta charset="utf-8" />
				<title>Evento Datenbank</title>
				<script type="text/javascript" src="sorttable.js"></script>
			</head>
			<body>
				<h1>Inhaltsverzeichnis</h1>
				<table class="sortable">
					<xsl:apply-templates select="table" mode="toc">
						<xsl:sort select="@name" />
					</xsl:apply-templates>
				</table>

				<h1>Tabellen</h1>
				<xsl:apply-templates select="table" mode="body">
					<xsl:sort select="@name" />
				</xsl:apply-templates>

				<h1>Views</h1>
				<xsl:apply-templates select="table" mode="body">
					<xsl:sort select="@name" />
				</xsl:apply-templates>

				<h1>Tabellentypen</h1>

				<h1>Datentypen</h1>
			</body>
		</html>
	</xsl:template>

	<xsl:template match="table" mode="toc">
		<tr>
			<td>
				<a>
					<xsl:attribute name="href">
                        <xsl:text>#table_</xsl:text>
                        <xsl:value-of select="@name" />
                    </xsl:attribute>
					<xsl:value-of select="@name" />
				</a>
			</td>
			<td>
				<xsl:value-of select="@type" />
			</td>
		</tr>
	</xsl:template>

	<xsl:template match="table" mode="body">
		<a>
			<xsl:attribute name="id">
			    <xsl:text>#table_</xsl:text>
                <xsl:value-of select="@name" />
            </xsl:attribute>
		</a>
	</xsl:template>

</xsl:transform>