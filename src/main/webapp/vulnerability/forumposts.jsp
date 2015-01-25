 <%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ include file="/header.jsp" %>
 <%@ page import="org.cysecurity.cspf.jvl.model.DBConnect"%>
 <%
 Connection con=new DBConnect().connect(getServletContext().getRealPath("/WEB-INF/config.properties"));
         
   String postid=request.getParameter("postid");
  if(postid!=null)
   {
        Statement stmt = con.createStatement();
             ResultSet rs =null;
             rs=stmt.executeQuery("select * from posts where postid="+postid);
              if(rs != null && rs.next())
              {
                out.print("<b style='font-size:22px'>Title:"+rs.getString("title")+"</b>"); 
                out.print("<br/>-  Posted By "+rs.getString("user")); 
                out.print("<br/><br/>Content:<br/>"+rs.getString("content")); 
              }
    }
    else
    {
        out.print("ID Parameter is Missing");
    }
     
    out.print("<br/><br/><a href='forum.jsp'>Return to Forum &gt;&gt;</a>"); 
  %>

 <%@ include file="/footer.jsp" %>