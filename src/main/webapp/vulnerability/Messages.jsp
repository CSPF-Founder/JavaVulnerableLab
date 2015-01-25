 <%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ include file="/header.jsp" %>
 <%@ page import="org.cysecurity.cspf.jvl.model.DBConnect"%>
 <%
      if(session.getAttribute("isLoggedIn")!=null) 
 {
       Connection con=new DBConnect().connect(getServletContext().getRealPath("/WEB-INF/config.properties"));
        if(con!=null && !con.isClosed())
          {
             Statement stmt = con.createStatement();
             ResultSet rs =null;
             rs=stmt.executeQuery("select * from UserMessages where recipient='"+session.getAttribute("user")+"'");
             out.print("</br></br>Message: </br>");
             out.println("<ol>");
             while (rs.next()) 
            {
                out.print("<li><a href='DisplayMessage.jsp?msgid="+rs.getString("msgid")+" '>"+rs.getString("subject")+"</a></li>");
                
            }
            out.println("</ol>");
       }
     out.print("<br/><br/><a href='"+path+"/myprofile.jsp?id="+session.getAttribute("userid")+"'>Return to Profile Page &gt;&gt;</a>"); 
    
 }
 else
 {
  out.print("<span style='color:red'>* Please login to send message</span>");   
 }
       %>

 <%@ include file="/footer.jsp" %>