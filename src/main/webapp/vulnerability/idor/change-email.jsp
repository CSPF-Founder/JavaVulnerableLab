 <%@ include file="/header.jsp" %>
 <%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.SQLException"%>

<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="java.sql.ResultSet"%>
<%@ page import="java.util.*,java.io.*"%>
<%@ page import="org.cysecurity.cspf.jvl.model.DBConnect"%>


<%
if(session.getAttribute("isLoggedIn")!=null)
{
    %>
    Enter the New Email:<br/><br/>
		<form action="change-email.jsp" method="POST">
		New Email ID: <input type="text" name="email" value=""/>
		<input type="hidden" name="id" value="<% out.print(session.getAttribute("userid"));%>"/>
		<br/><br/><input type="submit" name="change" value="Change"/>
		
		</form>
		<br/>
    <%
 Connection con=new DBConnect().connect(getServletContext().getRealPath("/WEB-INF/config.properties"));
         
   String email=request.getParameter("email");
   String id=request.getParameter("id");
   if(email!=null && !email.equals("") && id!=null)
   {
        Statement stmt = con.createStatement();
            stmt.executeUpdate("Update users set email='"+email+"' where id="+id);
          out.print("<b class='success'>email Changed</b>");
   }
      
    out.print("<br/><br/><a href='"+path+"/myprofile.jsp?id="+session.getAttribute("userid")+"'>Return to Profile Page &gt;&gt;</a>"); 
    
}
else
{
    out.print("Please login to see Your Profile");
}

  %>
  
  <!-- CSRF  -->
<!-- Insecure Direct Object Reference 2 -->
  
 <%@ include file="/footer.jsp" %>