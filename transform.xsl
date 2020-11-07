<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
  version="1.1"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.w3.org/1999/xhtml">

  <xsl:output method="xml" indent="yes" encoding="UTF-8"/>

  <xsl:template match="/season">
    <html lang="en">
      <head>
        <meta charset="UTF-8" />
        <title>
            <xsl:value-of select="@team" />
            <xsl:text>-</xsl:text>
            <xsl:value-of select="@name" />
        </title>
        <link rel="stylesheet" type="text/css" href="assets/sheet.css" />
      </head>
      <body>
        <div class="container">
          <xsl:apply-templates select="match">
          </xsl:apply-templates>
        </div>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="match">
    <div>
      <xsl:variable name="state">
        <xsl:choose>
          <xsl:when test="result/team = ''">
            <xsl:value-of select="'coming'" />
          </xsl:when>
          <xsl:otherwise>
            <xsl:choose>
              <xsl:when test="result/team/@penalty &gt; result/opponent/@penalty">
                <xsl:value-of select="'win'" />
              </xsl:when>
              <xsl:when test="result/team/@penalty = result/opponent/@penalty">
                <xsl:value-of select="'draw'" />
              </xsl:when>
              <xsl:when test="result/team/@penalty &lt; result/opponent/@penalty">
                <xsl:value-of select="'loss'" />
              </xsl:when>
              <xsl:when test="result/team &gt; result/opponent">
                <xsl:value-of select="'win'" />
              </xsl:when>
              <xsl:when test="result/team = result/opponent">
                <xsl:value-of select="'draw'" />
              </xsl:when>
              <xsl:when test="result/team &lt; result/opponent">
                <xsl:value-of select="'loss'" />
              </xsl:when>
            </xsl:choose>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      <xsl:attribute name="class">termin <xsl:value-of select="$state" /></xsl:attribute>

      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <xsl:template match="competition">
      <div class="competition">
        <span><xsl:value-of select="." /></span>
      </div>
  </xsl:template>

  <xsl:template match="result">
      <xsl:variable name="team">
        <xsl:choose>
          <xsl:when test="team/@penalty != ''">
            <xsl:value-of select="team/@penalty" />
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="team" />
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      <xsl:variable name="opponent">
        <xsl:choose>
              <xsl:when test="opponent/@penalty">
            <xsl:value-of select="opponent/@penalty" />
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="opponent" />
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      <div class="result">
        <span>
          <xsl:if test="team != ''">
            <xsl:value-of select="$team" />
            <xsl:text>:</xsl:text>
            <xsl:value-of select="$opponent" />
          </xsl:if>
        </span>
      </div>
  </xsl:template>

  <xsl:template match="opponent">
      <div class="opponent">
        <span>
          <xsl:value-of select="." />
        </span>
      </div>
  </xsl:template>
</xsl:stylesheet>
