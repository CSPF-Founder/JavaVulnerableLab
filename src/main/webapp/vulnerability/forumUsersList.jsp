 <%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ include file="/header.jsp" %>
 <%@ page import="org.cysecurity.cspf.jvl.model.DBConnect"%>
 <%
 Connection con=new DBConnect().connect(getServletContext().getRealPath("/WEB-INF/config.properties"));
   String username=request.getParameter("username");
   
        Statement stmt = con.createStatement();
             ResultSet rs =null;
             rs=stmt.executeQuery("select * from users");
             out.print("Users: ");
             out.print("<ol>");
              while( rs.next())
              {
                out.print("<li>");
                out.print("<a href='UserDetails.jsp?username="+rs.getString("username")+"'>"+rs.getString("username")+"</a>");
                out.print("</li>");
              }
              out.print("</ol");
       
   
      
      out.print("<br/><br/><a href='forum.jsp'>Return to Forum &gt;&gt;</a>"); 
  %>

 <%@ include file="/footer.jsp" %>