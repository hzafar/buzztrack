<?xml version="1.0"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html"/>
<xsl:template match="packet">
    <html>
    <head>
        <link rel="stylesheet" type="text/css" href="../REQUIRE/style.css"/>
    </head>
    <body>
    <script src="../REQUIRE/jquery-1.9.1.js"></script>
    <script src="../REQUIRE/buzztrack.js"></script>
    <h1><xsl:value-of select="@name"/></h1>
    <a href="#" class="genstats">generate stats</a>
    <xsl:comment>
    <a href="#" id="leadins">leadins</a><xsl:text> </xsl:text>
    <a href="#" id="middles">middle clues</a><xsl:text> </xsl:text>
    <a href="#" id="giveaways">giveaways</a><xsl:text> </xsl:text>
    <a href="#" id="wholeqn">whole question</a><xsl:text> </xsl:text>
    <a href="#" id="backToTossups">back to tossups</a>
    </xsl:comment>
    <br />
    <br />
    <div id="tossups">
    <h4>Tossups</h4>
        <ol>
            <xsl:apply-templates select="tossup"/>
        </ol>
    </div>
    <a href="#" class="genstats">generate stats</a>
    </body>
    </html>
</xsl:template>

<xsl:template match="tossup">
    <li>
        <xsl:apply-templates select="question"/>
        <xsl:apply-templates select="answerline"/>
    </li>
</xsl:template>

<xsl:template match="question">
    <xsl:for-each select="leadin/clue">
        <span class="leadin clue"><xsl:apply-templates /><xsl:text> </xsl:text></span>
    </xsl:for-each>
    <xsl:for-each select="middle/clue">
        <span class="middle clue"><xsl:apply-templates /><xsl:text> </xsl:text></span>
    </xsl:for-each>
    <xsl:for-each select="giveaway/clue">
        <span class="giveaway clue"><xsl:apply-templates /><xsl:text> </xsl:text></span>
    </xsl:for-each>
</xsl:template>

<xsl:template match="answerline">
    <p>
    ANSWER: <xsl:apply-templates select="accepted"/><xsl:if test="accepted/@condition != ''"> (<xsl:value-of select="accepted/@condition"/>)</xsl:if>
    <xsl:if test="alternates/alternate"> [accept <xsl:apply-templates select="alternates"/>]</xsl:if>
    <xsl:if test="prompts/prompt"> [prompt on <xsl:apply-templates select="prompts"/>]</xsl:if>
    </p>
</xsl:template>

<xsl:template match="answerline/accepted">
    <xsl:apply-templates/>
</xsl:template>

<xsl:template match="answerline/alternates">
    <xsl:for-each select="alternate">
        <xsl:apply-templates/>
        <xsl:if test="@condition != ''"><xsl:text> </xsl:text><xsl:value-of select="@condition"/></xsl:if> 
        <xsl:if test="not(position() = last())"> or </xsl:if>
    </xsl:for-each>
</xsl:template>

<xsl:template match="answerline/prompts">
    <xsl:for-each select="prompt">
        "<xsl:value-of select="."/>"<xsl:if test="not(position() = last())"> or </xsl:if>
    </xsl:for-each>
</xsl:template>

<xsl:template match="//required">
    <b><u><xsl:value-of select="."/></u></b>
</xsl:template>

<xsl:template match="//majtitle">
    <i><xsl:value-of select="."/></i>
</xsl:template>

<xsl:template match="bonus">
    <li>
        <xsl:value-of select="intro"/><br />
        <xsl:for-each select="part">
            [<xsl:value-of select="@points"/>] <xsl:value-of select="question"/><br />
            <xsl:apply-templates/><br />
        </xsl:for-each>
    </li>
</xsl:template>

</xsl:stylesheet>
