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
    Change Details About You:<br/><br/>
		<form action="change-info.jsp" method="GET">
		Description: <input type="text" name="info" value=""/>
		<br/><br/><input type="submit" name="change" value="Change"/>
		
		</form>
		<br/>
    <%
 Connection con=new DBConnect().connect(getServletContext().getRealPath("/WEB-INF/config.properties"));
         
   String info=request.getParameter("info");
   String id=session.getAttribute("userid").toString();
   if(info!=null && !info.equals("") && id!=null)
   {
        Statement stmt = con.createStatement();
            stmt.executeUpdate("Update users set about='"+info+"' where id="+id);
          out.print("<b class='fail'>info Changed</b>");
   }
      
    out.print("<br/><br/><a href='"+path+"/myprofile.jsp?id="+id+"'>Return to Profile Page &gt;&gt;</a>"); 
    
}
else
{
    out.print("Please login to see Your Profile");
}

  %>
  
  <!-- CSRF  -->
<!-- Insecure Direct Object Reference 2 -->
  
 <%@ include file="/footer.jsp" %>