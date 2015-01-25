 <%@page import="org.cysecurity.cspf.jvl.model.HashMe"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="org.cysecurity.cspf.jvl.model.DBConnect"%>
<%@page import="java.sql.Connection"%>
<%
if(request.getParameter("Login")!=null)
{
     Connection con=new DBConnect().connect(getServletContext().getRealPath("/WEB-INF/config.properties"));
     String user=request.getParameter("username");
     String pass=HashMe.hashMe(request.getParameter("password")); //Hashed Password 
     try
             {
                    if(con!=null && !con.isClosed())
                               {
                                   ResultSet rs=null;
                                   Statement stmt = con.createStatement();  
                                   rs=stmt.executeQuery("select * from users where username='"+user+"' and password='"+pass+"' and privilege='admin'");
                                   if(rs != null && rs.next()){
                                   session.setAttribute("isLoggedIn", "1");
                                   session.setAttribute("userid", rs.getString("id"));
                                   session.setAttribute("user", rs.getString("username"));
                                   session.setAttribute("avatar", rs.getString("avatar"));
                                   session.setAttribute("privilege", rs.getString("privilege"));
                                   
                                   Cookie privilege=new Cookie("privilege","admin");
                                    privilege.setPath(request.getContextPath());
                                   response.addCookie(privilege);
                                   
                                   response.sendRedirect("admin.jsp");
                                   }
                                   else
                                   {
                                	   response.sendRedirect("adminlogin.jsp?err=<span style='color:red'>Username/Password is wrong</span>");
                                   }
                                    
                               }
                }
               catch(SQLException ex)
                {
                         response.sendRedirect("adminlogin.jsp?err=<span style='color:red'>Something went wrong</span>");
                
                }
			     catch(Exception e)
			     {
			    	 response.sendRedirect("adminlogin.jsp?err="+e);			
			     }
}
%>
<%@ include file="/header.jsp" %>
 <b>Admin Login Page:</b><br/>
<form action="adminlogin.jsp" method="post">
<table> 
<tr><td>UserName: </td><td><input type="text" name="username" /></td></tr>
<tr><td>Password :</td><td><input type="password" name="password"/></td></tr>
<tr><td><input type="submit" name="Login" value="Login"/></td></tr>
<tr><td></td><td class="fail"><% if(request.getParameter("err")!=null){out.print(request.getParameter("err"));} %></td></tr>
</table>  
</form>

 <%@ include file="/footer.jsp" %>