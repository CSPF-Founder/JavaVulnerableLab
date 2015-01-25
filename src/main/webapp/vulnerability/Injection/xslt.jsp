 
<%@ include file="/header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>
<form >
   Select Style: <select name="style">
        <option value="1.xsl">Style 1</option>
         <option value="2.xsl">Style 2</option> 
    </select>
    <input type="submit" value="change"/>
</form><br/>
 <c:import url="courses.xml" var="xml"/>
 
<c:import url='${param["style"]}' var="xslt"/>
<x:transform xml="${xml}" xslt="${xslt}"/>

  <%@ include file="/footer.jsp" %>