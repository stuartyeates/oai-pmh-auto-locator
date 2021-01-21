<xsl:stylesheet version="1.0"  
	xmlns:oai="http://www.openarchives.org/OAI/2.0/"
	xmlns:kit="http://oai.dlib.vt.edu/OAI/metadata/toolkit"
	xmlns:ide="http://www.openarchives.org/OAI/2.0/oai-identifier"
	xmlns:dc="http://purl.org/dc/elements/1.1/"
	xmlns:oai_dc="http://www.openarchives.org/OAI/2.0/oai_dc/"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
 <xsl:output method="text"/>

  	<xsl:template match="oai:OAI-PMH[oai:Identify]">
		<xsl:text>,ISTARTI,</xsl:text>
		<xsl:value-of select="oai:request/@verb"/>
		<xsl:text>,</xsl:text>
		<xsl:value-of select="oai:request/text()"/>
		<xsl:text>,</xsl:text>
		<xsl:value-of select="oai:responseDate/text()"/>
  		<xsl:text>,</xsl:text>
		<xsl:value-of select="oai:Identify/oai:repositoryName/text()"/>
		<xsl:text>,</xsl:text>
		<xsl:value-of select="oai:Identify/oai:baseURL/text()"/>
		<xsl:text>,</xsl:text>
		<xsl:value-of select="oai:Identify/oai:protocolVersion/text()"/>
		<xsl:text>,</xsl:text>
		<xsl:value-of select="oai:Identify/oai:adminEmail/text()"/>
		<xsl:text>,</xsl:text>
		<xsl:value-of select="oai:Identify/oai:earliestDatestamp/text()"/>
		<xsl:text>,</xsl:text>
		<xsl:value-of select="oai:Identify/oai:deletedRecord/text()"/>
		<xsl:text>,</xsl:text>
		<xsl:value-of select="oai:Identify/oai:granularity/text()"/>
		<xsl:text>,</xsl:text>
		<xsl:value-of select="oai:Identify/oai:compression[1]/text()"/>
		<xsl:text>,</xsl:text>
		<xsl:value-of select="oai:Identify/oai:compression[2]/text()"/>
		<xsl:text>,</xsl:text>
		<xsl:value-of select="oai:Identify/oai:compression[3]/text()"/>
		<xsl:text>,</xsl:text>
		<xsl:value-of select="oai:Identify/oai:description/kit:toolkit/kit:title/text()"/>
		<xsl:text>,</xsl:text>
		<xsl:value-of select="oai:Identify/oai:description/kit:toolkit/kit:author/kit:name/text()"/>
		<xsl:text>,</xsl:text>
		<xsl:value-of select="oai:Identify/oai:description/kit:toolkit/kit:version/text()"/>
		<xsl:text>,</xsl:text>
		<xsl:value-of select="oai:Identify/oai:description/kit:toolkit/kit:URL/text()"/>
		<xsl:text>,IENDI,</xsl:text>
	</xsl:template>

	<xsl:template match="oai:OAI-PMH[oai:ListRecords]">
		<xsl:text>,LSTARTL,</xsl:text>
		<xsl:value-of select="oai:request/@verb"/>
		<xsl:text>,</xsl:text>
                <xsl:value-of select="oai:request/@metadataprefix"/>
                <xsl:text>,</xsl:text>
		<xsl:value-of select="oai:request/text()"/>
		<xsl:text>,</xsl:text>
		<xsl:value-of select="oai:responseDate/text()"/>
		<xsl:text>,</xsl:text>

		<xsl:apply-templates select="oai:ListRecords/oai:record[position() &lt; 101]"/>
		<xsl:text>,
</xsl:text>
        </xsl:template>


	<xsl:template match="oai:record">

		<xsl:value-of select="oai:header/oai:identifier/text()"/>
		<xsl:text>,</xsl:text>
		<xsl:value-of select="oai:header/oai:datestamp/text()"/>
		<xsl:text>,</xsl:text>
		<xsl:value-of select="oai:header/oai:setSpec/text()"/>
		<xsl:text>,LMIDL,</xsl:text>
		<xsl:value-of select="oai:metadata/dc:title/text()"/>
		<xsl:text>,</xsl:text>
		<xsl:value-of select="oai:metadata/dc:creator/text()"/>
		<xsl:text>,</xsl:text>

                <xsl:for-each select="oai:metadata/*/dc:contributor/text()">
 		<xsl:call-template name="string-replace-all">
			<xsl:with-param name="text" select="normalize-space(.)" />
			<xsl:with-param name="replace" select="','" />
			<xsl:with-param name="by" select="'%2C'" />
		</xsl:call-template>
   			<xsl:if test="position() != last()">
      				<xsl:text>||</xsl:text>
   			</xsl:if>
		</xsl:for-each>

		<xsl:text>,</xsl:text>

	<xsl:for-each select="oai:metadata/*/dc:coverage/text()">
		<xsl:call-template name="string-replace-all">
			<xsl:with-param name="text" select="normalize-space(.)" />
			<xsl:with-param name="replace" select="','" />
			<xsl:with-param name="by" select="'%2C'" />
		</xsl:call-template>
		<xsl:if test="position() != last()">
			<xsl:text>||</xsl:text>
		</xsl:if>
	</xsl:for-each>

		<xsl:text>,</xsl:text>

	<xsl:for-each select="oai:metadata/*/dc:creator/text()">
		<xsl:call-template name="string-replace-all">
			<xsl:with-param name="text" select="normalize-space(.)" />
			<xsl:with-param name="replace" select="','" />
			<xsl:with-param name="by" select="'%2C'" />
		</xsl:call-template>
		<xsl:if test="position() != last()">
			<xsl:text>||</xsl:text>
		</xsl:if>
	</xsl:for-each>

		<xsl:text>,</xsl:text>

	<xsl:for-each select="oai:metadata/*/dc:date/text()">
		<xsl:call-template name="string-replace-all">
			<xsl:with-param name="text" select="normalize-space(.)" />
			<xsl:with-param name="replace" select="','" />
			<xsl:with-param name="by" select="'%2C'" />
		</xsl:call-template>
		<xsl:if test="position() != last()">
			<xsl:text>||</xsl:text>
		</xsl:if>
	</xsl:for-each>

		<xsl:text>,</xsl:text>

	<xsl:for-each select="oai:metadata/*/dc:description/text()">
		<xsl:call-template name="string-replace-all">
			<xsl:with-param name="text" select="normalize-space(.)" />
			<xsl:with-param name="replace" select="','" />
			<xsl:with-param name="by" select="'%2C'" />
		</xsl:call-template>
		<xsl:if test="position() != last()">
			<xsl:text>||</xsl:text>
		</xsl:if>
	</xsl:for-each>

		<xsl:text>,</xsl:text>

	<xsl:for-each select="oai:metadata/*/dc:format/text()">
		<xsl:call-template name="string-replace-all">
			<xsl:with-param name="text" select="normalize-space(.)" />
			<xsl:with-param name="replace" select="','" />
			<xsl:with-param name="by" select="'%2C'" />
		</xsl:call-template>
		<xsl:if test="position() != last()">
			<xsl:text>||</xsl:text>
		</xsl:if>
	</xsl:for-each>

		<xsl:text>,</xsl:text>

	<xsl:for-each select="oai:metadata/*/dc:identifer/text()">
		<xsl:call-template name="string-replace-all">
			<xsl:with-param name="text" select="normalize-space(.)" />
			<xsl:with-param name="replace" select="','" />
			<xsl:with-param name="by" select="'%2C'" />
		</xsl:call-template>
		<xsl:if test="position() != last()">
			<xsl:text>||</xsl:text>
		</xsl:if>
	</xsl:for-each>

		<xsl:text>,</xsl:text>

	<xsl:for-each select="oai:metadata/*/dc:language/text()">
		<xsl:call-template name="string-replace-all">
			<xsl:with-param name="text" select="normalize-space(.)" />
			<xsl:with-param name="replace" select="','" />
			<xsl:with-param name="by" select="'%2C'" />
		</xsl:call-template>
		<xsl:if test="position() != last()">
			<xsl:text>||</xsl:text>
		</xsl:if>
	</xsl:for-each>

		<xsl:text>,</xsl:text>

	<xsl:for-each select="oai:metadata/*/dc:publisher/text()">
		<xsl:call-template name="string-replace-all">
			<xsl:with-param name="text" select="normalize-space(.)" />
			<xsl:with-param name="replace" select="','" />
			<xsl:with-param name="by" select="'%2C'" />
		</xsl:call-template>
		<xsl:if test="position() != last()">
			<xsl:text>||</xsl:text>
		</xsl:if>
	</xsl:for-each>

		<xsl:text>,</xsl:text>

	<xsl:for-each select="oai:metadata/*/dc:relation/text()">
		<xsl:call-template name="string-replace-all">
			<xsl:with-param name="text" select="normalize-space(.)" />
			<xsl:with-param name="replace" select="','" />
			<xsl:with-param name="by" select="'%2C'" />
		</xsl:call-template>
		<xsl:if test="position() != last()">
			<xsl:text>||</xsl:text>
		</xsl:if>
	</xsl:for-each>

		<xsl:text>,</xsl:text>

	<xsl:for-each select="oai:metadata/*/dc:rights/text()">
		<xsl:call-template name="string-replace-all">
			<xsl:with-param name="text" select="normalize-space(.)" />
			<xsl:with-param name="replace" select="','" />
			<xsl:with-param name="by" select="'%2C'" />
		</xsl:call-template>
		<xsl:if test="position() != last()">
			<xsl:text>||</xsl:text>
		</xsl:if>
	</xsl:for-each>

		<xsl:text>,</xsl:text>

		<xsl:for-each select="oai:metadata/*/dc:source/text()">
		<xsl:call-template name="string-replace-all">
			<xsl:with-param name="text" select="normalize-space(.)" />
			<xsl:with-param name="replace" select="','" />
			<xsl:with-param name="by" select="'%2C'" />
		</xsl:call-template>
			<xsl:if test="position() != last()">
				<xsl:text>||</xsl:text>
			</xsl:if>
		</xsl:for-each>

		<xsl:text>,</xsl:text>

		<xsl:for-each select="oai:metadata/*/dc:subject/text()">
		<xsl:call-template name="string-replace-all">
			<xsl:with-param name="text" select="normalize-space(.)" />
			<xsl:with-param name="replace" select="','" />
			<xsl:with-param name="by" select="'%2C'" />
		</xsl:call-template>
			<xsl:if test="position() != last()">
				<xsl:text>||</xsl:text>
			</xsl:if>
		</xsl:for-each>

		<xsl:text>,</xsl:text>

		<xsl:for-each select="oai:metadata/*/dc:title/text()">
		<xsl:call-template name="string-replace-all">
			<xsl:with-param name="text" select="normalize-space(.)" />
			<xsl:with-param name="replace" select="','" />
			<xsl:with-param name="by" select="'%2C'" />
		</xsl:call-template>
			<xsl:if test="position() != last()">
				<xsl:text>||</xsl:text>
			</xsl:if>
		</xsl:for-each>

		<xsl:text>,</xsl:text>

		<xsl:for-each select="oai:metadata/*/dc:type/text()">
		<xsl:call-template name="string-replace-all">
			<xsl:with-param name="text" select="normalize-space(.)" />
			<xsl:with-param name="replace" select="','" />
			<xsl:with-param name="by" select="'%2C'" />
		</xsl:call-template>
			<xsl:if test="position() != last()">
				<xsl:text>||</xsl:text>
			</xsl:if>
		</xsl:for-each>


		<xsl:text>,</xsl:text>


	</xsl:template> 

<xsl:template name="string-replace-all">
    <xsl:param name="text" />
    <xsl:param name="replace" />
    <xsl:param name="by" />
    <xsl:choose>
        <xsl:when test="$text = '' or $replace = ''or not($replace)" >
            <!-- Prevent this routine from hanging -->
            <xsl:value-of select="$text" />
        </xsl:when>
        <xsl:when test="contains($text, $replace)">
            <xsl:value-of select="substring-before($text,$replace)" />
            <xsl:value-of select="$by" />
            <xsl:call-template name="string-replace-all">
                <xsl:with-param name="text" select="substring-after($text,$replace)" />
                <xsl:with-param name="replace" select="$replace" />
                <xsl:with-param name="by" select="$by" />
            </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
            <xsl:value-of select="$text" />
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>



  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>

