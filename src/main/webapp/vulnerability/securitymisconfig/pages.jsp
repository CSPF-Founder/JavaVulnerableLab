 <%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ include file="/header.jsp" %>
 <%@ page import="org.cysecurity.cspf.jvl.model.DBConnect"%>
 <%
    try
   {
       Connection con=new DBConnect().connect(getServletContext().getRealPath("/WEB-INF/config.properties"));
         
        String id=request.getParameter("id");

         if(id!=null && !id.equals(""))
         {
             int idNumber=Integer.parseInt(id);
              Statement stmt = con.createStatement();
                   ResultSet rs =null;
                   rs=stmt.executeQuery("select * from posts where postid="+idNumber);
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
   }
    catch(SQLException e)
    {
        out.print(e.getMessage());
    }
    out.print("<br/><br/><a href='forum.jsp'>Return to Forum &gt;&gt;</a>"); 
  %>

 <%@ include file="/footer.jsp" %>