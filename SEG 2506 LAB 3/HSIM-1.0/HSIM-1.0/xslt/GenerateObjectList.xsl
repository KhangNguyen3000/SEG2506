<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" encoding="iso-8859-1" omit-xml-declaration="no" indent="yes"/>
	<xsl:strip-space elements="*"/>
	<xsl:template match="pnml">	
		<xsl:element name="pntools">
			<xsl:attribute name="id"><xsl:value-of select="net/@id"/></xsl:attribute>	
			<xsl:attribute name="type"><xsl:value-of select="net/@type"/></xsl:attribute>		
			<xsl:apply-templates select="net"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="net">
		<xsl:apply-templates select="labels"/>
		<xsl:apply-templates select="place"/>
		<xsl:apply-templates select="transition"/>
		<xsl:apply-templates select="arc"/>
		<xsl:apply-templates select="page"/>
		<xsl:apply-templates select="module"/>				
	</xsl:template>
	<xsl:template match="page">
		<xsl:apply-templates select="labels"/>
		<xsl:apply-templates select="place"/>
		<xsl:apply-templates select="transition"/>
		<xsl:apply-templates select="arc"/>
		<xsl:apply-templates select="module"/>		
	</xsl:template>
	<xsl:template match="module">
		<xsl:apply-templates select="labels"/>
		<xsl:apply-templates select="place"/>
		<xsl:apply-templates select="transition"/>
		<xsl:apply-templates select="arc"/>
		<xsl:apply-templates select="interface"/>		
	</xsl:template>
	<xsl:template match="labels">
		<xsl:element name="labels">
			<xsl:attribute name="xPosition"><xsl:value-of select="@x"/></xsl:attribute>
			<xsl:attribute name="yPosition"><xsl:value-of select="@y"/></xsl:attribute>
			<xsl:attribute name="w"><xsl:value-of select="@width"/></xsl:attribute>
			<xsl:attribute name="h"><xsl:value-of select="@height"/></xsl:attribute>
			<xsl:attribute name="border"><xsl:value-of select="@border"/></xsl:attribute>
			<xsl:attribute name="txt"><xsl:value-of select="text"/></xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="place">
		<xsl:element name="place">
			<xsl:call-template name="place-transition"/>
			<xsl:attribute name="initialMarking">
				<xsl:value-of select="initialMarking/value"/>
			</xsl:attribute>
                        <xsl:attribute name="capacity">
				<xsl:value-of select="capacity/value"/>
			</xsl:attribute>
			<xsl:attribute name="markingOffsetX">
				<xsl:value-of select="initialMarking/graphics/offset/@x"/>
			</xsl:attribute>
			<xsl:attribute name="markingOffsetY">
				<xsl:value-of select="initialMarking/graphics/offset/@x"/>
			</xsl:attribute>
		</xsl:element>	
	</xsl:template>
	<xsl:template match="transition">
		<xsl:element name="transition">
			<xsl:attribute name="firingDelay"><xsl:value-of select="firingDelay/value"/></xsl:attribute>
                        <xsl:attribute name="firingDelayOffsetX">
			    <xsl:value-of select="firingDelay/graphics/offset/@x"/>
		        </xsl:attribute>
		        <xsl:attribute name="firingDelayOffsetY">
			    <xsl:value-of select="firingDelay/graphics/offset/@y"/>
		        </xsl:attribute>  
			<xsl:attribute name="firingFunction"><xsl:value-of select="firingFunction/value"/></xsl:attribute>
                        <xsl:attribute name="firingFunctionOffsetX">
			    <xsl:value-of select="firingFunction/graphics/offset/@x"/>
		        </xsl:attribute>
		        <xsl:attribute name="firingFunctionOffsetY">
			    <xsl:value-of select="firingFunction/graphics/offset/@y"/>
		        </xsl:attribute>
			<xsl:attribute name="angle"><xsl:value-of select="angle/value"/></xsl:attribute>
			<xsl:call-template name="place-transition"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="arc">
		<xsl:element name="arc">
			<xsl:call-template name="place-transition-arc"/>
			<xsl:attribute name="source">
				<xsl:value-of select="@source"/>
			</xsl:attribute>
			<xsl:attribute name="target">
				<xsl:value-of select="@target"/>
			</xsl:attribute>
                        <xsl:attribute name="arctype">
			        <xsl:value-of select="arctype/value"/>
		        </xsl:attribute>
			<xsl:attribute name="inscription">
				<xsl:value-of select="inscription/value"/>
			</xsl:attribute>
			<xsl:attribute name="inscriptionPositionX">
               			<xsl:value-of select="inscription/graphics/position/@x"/>
            		</xsl:attribute>
			<xsl:attribute name="inscriptionPositionY">
              			<xsl:value-of select="inscription/graphics/position/@y"/>
            		</xsl:attribute>
			<xsl:apply-templates select="arcpath"/>		
		</xsl:element>
	</xsl:template>
	<xsl:template name="place-transition">
		<xsl:call-template name="place-transition-arc"/>	
		<xsl:attribute name="name">
			<xsl:value-of select="name/value"/>
		</xsl:attribute>
                <xsl:attribute name="place-transitiontype">
			<xsl:value-of select="place-transitiontype/value"/>
		</xsl:attribute>
		<xsl:attribute name="nameOffsetX">
			<xsl:value-of select="name/graphics/offset/@x"/>
		</xsl:attribute>
		<xsl:attribute name="nameOffsetY">
			<xsl:value-of select="name/graphics/offset/@y"/>
		</xsl:attribute>                
                <xsl:attribute name="scale">
			<xsl:value-of select="scale/value"/>
		</xsl:attribute>				
	</xsl:template>	
	<xsl:template name="place-transition-arc">
		<xsl:attribute name="id">
			<xsl:value-of select="@id"/>
		</xsl:attribute>	
		<xsl:attribute name="positionX">
			<xsl:value-of select="graphics/position/@x"/>
		</xsl:attribute>
		<xsl:attribute name="positionY">
			<xsl:value-of select="graphics/position/@y"/>
		</xsl:attribute>
                <xsl:attribute name="showLabelPosition1">
			<xsl:value-of select="showLabel/position1"/>
		</xsl:attribute>
                <xsl:attribute name="showLabelPosition2">
			<xsl:value-of select="showLabel/position2"/>
		</xsl:attribute>
                <xsl:attribute name="showLabelPosition3">
			<xsl:value-of select="showLabel/position3"/>
		</xsl:attribute>

	</xsl:template>
    	<xsl:template match="arcpath">
    		<xsl:element name="arcpath">
        		<xsl:attribute name="x">
					<xsl:value-of select="@x"/>
				</xsl:attribute>
          			<xsl:attribute name="y">
					<xsl:value-of select="@y"/>
				</xsl:attribute>	
          			<xsl:attribute name="arcPointType">
					<xsl:value-of select="@curvePoint"/>
				</xsl:attribute>
			</xsl:element>
    	</xsl:template>      
	<xsl:template match="interface">
		<xsl:element name="arc">
			<xsl:attribute name="id">InterfaceArc</xsl:attribute>	
			<xsl:attribute name="positionX"/>
			<xsl:attribute name="positionY"/>
			<xsl:attribute name="source">
				<xsl:value-of select="../referencePlace/@id"/>
			</xsl:attribute>
			<xsl:attribute name="target">
				<xsl:value-of select="importPlace/@target"/>
			</xsl:attribute>
			<xsl:attribute name="inscription"/>
			<xsl:attribute name="inscriptionOffsetX"/>
			<xsl:attribute name="inscriptionOffsetY"/>
		</xsl:element>
        <xsl:element name="arc">
			<xsl:attribute name="id">InterfaceArc</xsl:attribute>	
			<xsl:attribute name="positionX"/>
			<xsl:attribute name="positionY"/>
			<xsl:attribute name="source">
				<xsl:value-of select="exportPlace/@id"/>
			</xsl:attribute>
			<xsl:attribute name="target">
				<xsl:value-of select="exportPlace/@ref"/>
			</xsl:attribute>
			<xsl:attribute name="inscription"/>
			<xsl:attribute name="inscriptionPositionX"/>
			<xsl:attribute name="inscriptionPositionY"/>
		</xsl:element>		
	</xsl:template>
</xsl:stylesheet>
