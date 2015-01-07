 <%@page import="java.io.FileOutputStream"%>
<%@ include file="/header.jsp" %>
 <%
 if(session.getAttribute("isLoggedIn")!=null)
{

 %> 
  <form action="Configure.jsp" method="POST">
<table> 
    <tr><td>Website Title:</td> <td><input type="text" name="siteTitle" value=""/></td></tr>
    <tr><td></td><td><input type="submit" name="save" value="save"/></td></tr>
</table>  
</form>
 
 <%
     if(request.getParameter("save")!=null)
    {
        Properties props=new Properties();
       
        props.load(new FileInputStream(configPath));
        props.setProperty("siteTitle",request.getParameter("siteTitle"));
        FileOutputStream fileout = new FileOutputStream(configPath);
        props.store(fileout, null); 
        fileout.close();
        out.print("<b class='success'> Configuration saved </b>");
    }
  }
 else
 {
     out.print("<b style='color:red'> x You Are not Authorized to view this Page x </b>");
 }
 %>
 <%@ include file="/footer.jsp" %>