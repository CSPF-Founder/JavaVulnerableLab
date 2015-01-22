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
                <table border="1">
                    <tr>
                    <th>Course Name</th>
                    <th>URL</th>
                    </tr>
                     <xsl:for-each select="courses/course-details">
                        <tr>
                        <td><xsl:value-of select="title"/></td>
                        <td width="120px" style='text-align:center' >  
                                <xsl:element name="a">
                                <xsl:attribute name="href">
                                <xsl:value-of select="url"/>
                                </xsl:attribute> Sign Up
                                </xsl:element>
                        </td>
                         </tr>
                    </xsl:for-each>
                    
                </table>
       
    </xsl:template>

</xsl:stylesheet>
