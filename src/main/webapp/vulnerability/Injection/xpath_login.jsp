
 <%@ include file="/header.jsp" %>
   
<form action="<%=path%>/XPathQuery.do" method="post">
<table> 
    <tr><td>UserName: </td><td><input type="text" name="username" /></td></tr>
    <tr><td>Password :</td><td><input type="text" name="password"/></td></tr>
<tr><td><input type="submit" name="Login" value="Login"/></td></tr>
<tr><td></td><td class="fail"><% if(request.getParameter("err")!=null){out.print(request.getParameter("err"));} %></td></tr>

</table>  
</form>
  <br/>
  <%@ include file="/footer.jsp" %>