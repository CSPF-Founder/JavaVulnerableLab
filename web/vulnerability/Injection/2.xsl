<?xml version="1.0" encoding="UTF-8"?>

<!--
    Document   : courses.xsl
    Created on : 21 January, 2015, 9:31 PM
    Author     : breakthesec
    Description:
        Purpose of transformation follows.
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="html"/>

    <!-- TODO customize transformation rules 
         syntax recommendation http://www.w3.org/TR/xslt 
    -->
    <xsl:template match="/">
        <h1> List of Courses: </h1>
             
                    <ul>
                     <xsl:for-each select="courses/course-details">
                        <li>
                             <xsl:element name="a">
                                <xsl:attribute name="href">
                                <xsl:value-of select="url"/>
                                </xsl:attribute> 
                                        <xsl:value-of select="title"/>
                                  </xsl:element>
                        </li>
                         
                    </xsl:for-each>
                    </ul>
    </xsl:template>

</xsl:stylesheet>
