<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" encoding="iso-8859-1" omit-xml-declaration="no" indent="yes" version="1.0"/>
	<xsl:template match="/">
		<xsl:element name="pnml">
			<xsl:apply-templates select="pnml"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="pnml">
		<xsl:element name="net">
			<xsl:attribute name="id">
				<xsl:value-of select="net/@id"/>
			</xsl:attribute>
			<xsl:attribute name="type">
				<xsl:value-of select="net/@type"/>
			</xsl:attribute>
			<xsl:apply-templates select="net/labels">
				<xsl:sort select="@text" data-type="text"/>
			</xsl:apply-templates>
			<xsl:apply-templates select="net/place">
				<xsl:sort select="@id" data-type="text"/>
			</xsl:apply-templates>
			<xsl:apply-templates select="net/transition">
				<xsl:sort select="@id" data-type="text"/>
			</xsl:apply-templates>
			<xsl:apply-templates select="net/arc">
				<xsl:sort select="@id" data-type="text"/>
			</xsl:apply-templates>
		</xsl:element>
	</xsl:template>
	<xsl:template   match="net/place">
		<xsl:element name="place">
			<xsl:call-template name="place-transition"/>
			<xsl:call-template name="initialMarking"/> 
                        <xsl:call-template name="capacity"/>                        
		</xsl:element>
	</xsl:template>
	<xsl:template   match="net/labels">
		<xsl:element name="labels">
			<xsl:attribute name="x">
				<xsl:value-of select="@positionX"/>
			</xsl:attribute>
			<xsl:attribute name="y">
				<xsl:value-of select="@positionY"/>
			</xsl:attribute>
			<xsl:attribute name="width">
				<xsl:value-of select="@width"/>
			</xsl:attribute>
			<xsl:attribute name="height">
				<xsl:value-of select="@height"/>
			</xsl:attribute>
			<xsl:attribute name="border">
				<xsl:value-of select="@border"/>
			</xsl:attribute>
			<xsl:element name="text">			
				<xsl:value-of select="@text"/>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	<xsl:template   match="net/transition">
		<xsl:element name="transition">
			<xsl:call-template name="place-transition"/>
			<xsl:call-template name="angle"/>
			<xsl:call-template name="firingDelay"/> 
                        <xsl:call-template name="firingFunction"/>
		</xsl:element>
	</xsl:template>
	<xsl:template   name="place-transition">
		<xsl:attribute name="id">
			<xsl:value-of select="@id"/>
		</xsl:attribute>
		<xsl:call-template name="graphics"/>
		<xsl:call-template name="name"/>
                <xsl:call-template name="place-transitiontype"/>
                <xsl:call-template name="showLabel"/>
                <xsl:call-template name="scale"/>
	</xsl:template>
	<xsl:template match="net/arc">
		<xsl:element name="arc">
			<xsl:attribute name="id">
				<xsl:value-of select="@id"/>
			</xsl:attribute>
			<xsl:attribute name="source">
				<xsl:value-of select="@source"/>
			</xsl:attribute>
			<xsl:attribute name="target">
				<xsl:value-of select="@target"/>
			</xsl:attribute>
                        <xsl:call-template name="arctype"/>
                        <xsl:call-template name="showLabel"/>
			<xsl:call-template name="graphics"/>
			<xsl:call-template name="inscription"/>
			<xsl:apply-templates select="arcpath">
				<xsl:sort select="@id" data-type="text"/>
			</xsl:apply-templates>
		</xsl:element>
	</xsl:template>
        <xsl:template name="arctype">
		<xsl:element name="arctype">
			<xsl:element name="value">
				<xsl:value-of select="@arctype"/>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	<xsl:template match="arcpath">
		<xsl:element name = "arcpath">
			<xsl:attribute name = "id">
				<xsl:value-of select ="@id"/>
			</xsl:attribute>
			<xsl:attribute name = "x">
				<xsl:value-of select ="@xCoord"/>
			</xsl:attribute>
			<xsl:attribute name = "y">
				<xsl:value-of select ="@yCoord"/>
			</xsl:attribute>
			<xsl:attribute name = "curvePoint">
				<xsl:value-of select="@arcPointType"/>
			</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template name="graphics">
		<xsl:element name="graphics">
			<xsl:if test="(string-length(@positionX) > 0)  and (string-length(@positionY) > 0)">
				<xsl:element name="position">
					<xsl:attribute name="x">
						<xsl:value-of select="@positionX"/>
					</xsl:attribute>
					<xsl:attribute name="y">
						<xsl:value-of select="@positionY"/>
					</xsl:attribute>
				</xsl:element>
			</xsl:if>
		</xsl:element>
	</xsl:template>
	<xsl:template name="name">
		<xsl:element name="name">
			<xsl:element name="value">
				<xsl:value-of select="@name"/>
			</xsl:element>
			<xsl:element name="graphics">
				<xsl:if test="(string-length(@nameOffsetX) > 0)  and (string-length(@nameOffsetY) > 0)">
					<xsl:element name="offset">
						<xsl:attribute name="x">
							<xsl:value-of select="@nameOffsetX"/>
						</xsl:attribute>
						<xsl:attribute name="y">
							<xsl:value-of select="@nameOffsetY"/>
						</xsl:attribute>
					</xsl:element>
				</xsl:if>
			</xsl:element>
		</xsl:element>
	</xsl:template>
        <xsl:template name="place-transitiontype">
		<xsl:element name="place-transitiontype">
			<xsl:element name="value">
				<xsl:value-of select="@place-transitiontype"/>
			</xsl:element>
		</xsl:element>
	</xsl:template>
        <xsl:template name="showLabel">
		<xsl:element name="showLabel">
			<xsl:element name="position1">
				<xsl:value-of select="@showLabelPosition1"/>
			</xsl:element>
			<xsl:element name="position2">
				<xsl:value-of select="@showLabelPosition2"/>
			</xsl:element>
			<xsl:element name="position3">
				<xsl:value-of select="@showLabelPosition3"/>
			</xsl:element>
		</xsl:element>
	</xsl:template>
        <xsl:template name="scale">
		<xsl:element name="scale">
			<xsl:element name="value">
				<xsl:value-of select="@scale"/>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	<xsl:template name="initialMarking">
		<xsl:element name="initialMarking">
			<xsl:element name="value">
				<xsl:value-of select="@initialMarking"/>
			</xsl:element>
			<xsl:element name="graphics">
				<xsl:if test="(string-length(@markingOffsetX) > 0)  and (string-length(@markingOffsetY) > 0)">
					<xsl:element name="offset">
						<xsl:attribute name="x">
							<xsl:value-of select="@markingOffsetX"/>
						</xsl:attribute>
						<xsl:attribute name="y">
							<xsl:value-of select="@markingOffsetY"/>
						</xsl:attribute>
					</xsl:element>
				</xsl:if>
			</xsl:element>
		</xsl:element>
	</xsl:template>
        <xsl:template name="capacity">
		<xsl:element name="capacity">
			<xsl:element name="value">
				<xsl:value-of select="@capacity"/>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	<xsl:template name="inscription">
		<xsl:element name="inscription">
			<xsl:element name="value">
				<xsl:value-of select="@inscription"/>
			</xsl:element>
                        <xsl:element name="graphics">
				<xsl:if test="(string-length(@inscriptionPositionX) > 0)  and (string-length(@inscriptionPositionY) > 0)">
					<xsl:element name="position">
						<xsl:attribute name="x">
							<xsl:value-of select="@inscriptionPositionX"/>
						</xsl:attribute>
						<xsl:attribute name="y">
							<xsl:value-of select="@inscriptionPositionY"/>
						</xsl:attribute>
					</xsl:element>
				</xsl:if>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	<xsl:template  name="firingDelay">
		<xsl:element name = "firingDelay">
			<xsl:element name = "value">
				<xsl:value-of select="@firingDelay"/>
			</xsl:element>
                        <xsl:element name="graphics">
				<xsl:if test="(string-length(@firingDelayOffsetX) > 0)  and (string-length(@firingDelayOffsetY) > 0)">
					<xsl:element name="offset">
						<xsl:attribute name="x">
							<xsl:value-of select="@firingDelayOffsetX"/>
						</xsl:attribute>
						<xsl:attribute name="y">
							<xsl:value-of select="@firingDelayOffsetY"/>
						</xsl:attribute>
					</xsl:element>
				</xsl:if>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	<xsl:template  name="firingFunction">
		<xsl:element name = "firingFunction">
			<xsl:element name = "value">
				<xsl:value-of select="@firingFunction"/>
			</xsl:element>
                        <xsl:element name="graphics">
				<xsl:if test="(string-length(@firingFunctionOffsetX) > 0)  and (string-length(@firingFunctionOffsetY) > 0)">
					<xsl:element name="offset">
						<xsl:attribute name="x">
							<xsl:value-of select="@firingFunctionOffsetX"/>
						</xsl:attribute>
						<xsl:attribute name="y">
							<xsl:value-of select="@firingFunctionOffsetY"/>
						</xsl:attribute>
					</xsl:element>
				</xsl:if>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	<xsl:template  name="angle">
		<xsl:element name = "angle">
			<xsl:element name = "value">
				<xsl:value-of select="@angle"/>
			</xsl:element>
		</xsl:element>
	</xsl:template>
</xsl:stylesheet>
