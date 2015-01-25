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
            if(request.getParameter("msgid")!=null)
             {
              Statement stmt = con.createStatement();
             ResultSet rs =null;
             rs=stmt.executeQuery("select * from UserMessages where msgid="+request.getParameter("msgid"));
                if(rs.next())
                {
                    out.print("<b>Sender:</b> "+rs.getString("sender"));
                    out.print("<br/><b>Subject:</b>"+rs.getString("subject"));
                    out.print("<br/><b>Message:</b> <br/>"+rs.getString("msg"));
                }
                else
                {
                    out.print("No Message Found");
                }
             }
            else
            {
                out.print("Message Id Parameter is missing");

            }
              out.print("<br/><br/><a href='"+path+"/vulnerability/Messages.jsp'>Return to Messages &gt;&gt;</a>"); 
    
              out.print("<br/><br/><a href='"+path+"/myprofile.jsp?id="+session.getAttribute("userid")+"'>Return to Profile Page &gt;&gt;</a>"); 
    
       }
     
 }
 else
 {
  out.print("<span style='color:red'>* Please login to send message</span>");   
 }
       %>

 <%@ include file="/footer.jsp" %>