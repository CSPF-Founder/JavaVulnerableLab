
 <%@ include file="header.jsp" %>
   
 <%
 String username="";
 String password="";
 Cookie[] cookies = request.getCookies();
 if (cookies != null)
  for (Cookie c : cookies) {
        if ("username".equals(c.getName())) {
         username= c.getValue();
        }
        else if("password".equals(c.getName()))
        {
            password= c.getValue();
        }
  }

 %>
<form action="LoginValidator" method="post">
<table> 
    <tr><td>UserName: </td><td><input type="text" name="username" value="<%=username%>" /></td></tr>
<tr><td>Password :</td><td><input type="text" name="password" value="<%=password%>"/></td></tr>
<tr><td>Remember me: </td><td><input type="checkbox" name="RememberMe" checked/></td></tr>
<tr><td><input type="submit" name="Login" value="Login"/></td></tr>
<tr><td></td><td class="fail"><% if(request.getParameter("err")!=null){out.print(request.getParameter("err"));} %></td></tr>
</table>  
</form>
  <br/>
  <a href="ForgotPassword.jsp">Forgot Password?</a>
  <%@ include file="footer.jsp" %>