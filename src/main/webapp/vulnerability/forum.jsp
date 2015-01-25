<%-- 
    Document   : forum
    Created on : 1 Dec, 2014, 3:22:09 PM
    Author     : breakthesec
--%>

<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.SQLException"%>

<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="java.sql.ResultSet"%>
<%@ page import="java.util.*,java.io.*"%>
<%@ page import="org.cysecurity.cspf.jvl.model.DBConnect"%>
 

<%@page contentType="text/html" pageEncoding="UTF-8"%>
 
  <%@ include file="/header.jsp" %>
<%
         Connection con=new DBConnect().connect(getServletContext().getRealPath("/WEB-INF/config.properties"));
               if(session.getAttribute("isLoggedIn")!=null && session.getAttribute("isLoggedIn").equals("1"))
               {
                   out.print("Hello "+session.getAttribute("user")+", Welcome to Our Forum !");
               }
     %>
     <br/>  <br/>
        <h3>Create Post:</h3>
       <form action="forum.jsp" method="POST">
       Title : <input type="text" name="title" value="" size="50"/><br/>
       Message: <br/><textarea name="content" rows="2" cols="50"></textarea>
       <input type="hidden" name="user" value="<% if(session.getAttribute("user")!=null){out.print(session.getAttribute("user"));} else { out.print("Anonymous"); } %>" size="50"/><br/>
       <input type="submit" value="Post" name="post"/>
       </form>

<br/>
<%
                                    
     if(request.getParameter("post")!=null) 
                                 {
                                    String user=request.getParameter("user");
                                    String content=request.getParameter("content");
                                    String title=request.getParameter("title");
                                    if(con!=null && !con.isClosed())
                                        {
                                           Statement stmt = con.createStatement();   
                                           //Posting Content
                                          stmt.executeUpdate("INSERT into posts(content,title,user) values ('"+content+"','"+title+"','"+user+"')");
                                            out.print("Successfully posted");
                                        }
                                    }
                                                                    
    %>
     <h3>List of Posts:</h3> 
    <%
      if(con!=null && !con.isClosed())
          {
             Statement stmt = con.createStatement();
             ResultSet rs =null;
             rs=stmt.executeQuery("select * from posts");
             out.println("<table border='1'>");
             while (rs.next()) 
            {
                out.print("<tr>");
                out.print("<td><a href='forumposts.jsp?postid="+rs.getString("postid")+"'>"+rs.getString("title")+"</a></td>");
                out.print("<td> - Posted By ");
                if(!rs.getString("user").equalsIgnoreCase("anonymous"))
                {
                out.print("<a href='UserDetails.jsp?username="+rs.getString("user")+"'>"+rs.getString("user")+"</a>");
                }
                else
                {
                    out.print(rs.getString("user"));
                }
                out.println("</td></tr>");
                
            }
            out.println("</table>");
       }
        out.print("<br/> <a href='forumUsersList.jsp'>Forum Users list &gt;&gt;</a>");                                     
     %>
       <%@ include file="/footer.jsp" %>