 <%@page import="model.HashMe"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="model.DBConnect"%>
<%@page import="java.sql.Connection"%>
<%@ include file="/header.jsp" %>

 <b>Admin Login Panel:</b><br/>
<form action="adminlogin.jsp" method="post">
<table> 
<tr><td>UserName: </td><td><input type="text" name="username" /></td></tr>
<tr><td>Password :</td><td><input type="password" name="password"/></td></tr>
<tr><td><input type="submit" name="Login" value="Login"/></td></tr>
</table>  
</form>
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
                                    privilege.setPath(path);
                                   response.addCookie(privilege);
                                   
                                   response.sendRedirect("admin.jsp");
                                   }
                                   else
                                   {
                                         out.print("<span style='color:red'>Username/Password is wrong</span>");
                                   }
                                    
                               }
                }
               catch(SQLException ex)
                {
                         
                            response.sendRedirect("<span style='color:red'>Something went wrong</span>");
                }
}
%>
 <%@ include file="/footer.jsp" %>