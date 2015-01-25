 <%@ include file="/header.jsp" %>
 <%
 if(session.getAttribute("privilege")!=null && session.getAttribute("privilege").equals("admin"))
{
 %> 
 
 <form action="AddPage.do" method="POST">
<table> 
    <tr><td>File Name:</td> <td><input type="text" name="filename" value=""/></td></tr>
    <tr><td>Content :</td><td><textarea name="content" cols="50" rows="10"></textarea></td></tr>
    <tr><td></td><td><input type="submit" name="Create" value="Create"/></td></tr>
</table>  
</form>
 <%
  }
 else
 {
     out.print("<b class='fail'> x You Are not Authorized to view this Page x </b>");
 }
 %>
 <%@ include file="/footer.jsp" %>