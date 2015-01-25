 <%@ include file="/header.jsp" %>
  <%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="org.cysecurity.cspf.jvl.model.DBConnect"%>
<%@page import="java.sql.Connection"%>

 <%
   Connection con=new DBConnect().connect(getServletContext().getRealPath("/WEB-INF/config.properties"));
    Statement stmt = con.createStatement(); 
 if(request.getParameter("delete")!=null)
 {
     String user=request.getParameter("user");      
     stmt.executeUpdate("Delete from users where username='"+user+"'");                      
 }
 %>	
<form action="manageusers.jsp" method="POST">	
<%
 ResultSet rs=stmt.executeQuery("select * from users where privilege='user'");
 while(rs.next())
 {
     out.print("<input type='radio' name='user' value='"+rs.getString("username")+"'/> "+rs.getString("username")+"<br/>");
 }
 %>
<br/>
<input type="submit" value="Delete" name="delete"/>

</form>
<br/>
<a href="admin.jsp"> Back to Admin Panel</a>
 <%@ include file="/footer.jsp" %>