 <%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ include file="/header.jsp" %>
 <%@ page import="org.cysecurity.cspf.jvl.model.DBConnect"%>
 <%
 Connection con=new DBConnect().connect(getServletContext().getRealPath("/WEB-INF/config.properties"));
   String username=request.getParameter("username");
   if(username!=null && !username.equals(""))
   {
        Statement stmt = con.createStatement();
             ResultSet rs =null;
             rs=stmt.executeQuery("select * from users where username='"+username+"'");
              if(rs != null && rs.next())
              {
                out.print("<br>About "+rs.getString("username")+": <br>"+rs.getString("about")); 
  
              }
        
        if(session.getAttribute("isLoggedIn")!=null && !session.getAttribute("user").equals(username))
        {
             out.print("<br/><br/>");
            out.print("<a href='SendMessage.jsp?recipient="+username+"'>Send Message to "+username+"</a>");
        }
   }
   else
   {
       out.print("Username Parameter is Missing");
   }
      
      out.print("<br/><br/><a href='forum.jsp'>Return to Forum &gt;&gt;</a>"); 
  %>

 <%@ include file="/footer.jsp" %>