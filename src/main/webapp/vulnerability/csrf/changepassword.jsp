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
    String id=session.getAttribute("userid").toString();
    %>
    Enter the New Password: <br/><br/>
    <table>
		<form action="changepassword.jsp" method="POST">
                    <tr><td>New Password:</td><td><input type="text" name="password" value=""/></td></tr>
                <tr><td>Confirm Password: </td><td><input type="text" name="confirmpassword" value=""/></td></tr>
                    <tr><td></td><td><input type="submit" name="change" value="Change"/></td></tr>
		
		</form>
    </table>
		<br/>
    <%
 Connection con=new DBConnect().connect(getServletContext().getRealPath("/WEB-INF/config.properties"));
         
   String action=request.getParameter("change");
    if(action!=null)
    {
        String pass=request.getParameter("password");
        String confirmPass=request.getParameter("confirmpassword");
        if(pass!=null && confirmPass!=null && !pass.equals("") )
        {
            if(pass.equals(confirmPass) )
            {
          Statement stmt = con.createStatement();
              stmt.executeUpdate("Update users set password='"+pass+"' where id="+id);
            out.print("<b class='success'>Password Changed</b>");
            out.print("<br/><br/><b><a href='changepassword.jsp'>Return to the Previous page </a></b>");
            }
            else
            {
                 out.print("Passwords didn't match");
            }

        }
        else
        {
            out.print("Password can't be empty");
        }
    }
  }
   
  %>
  
  <!-- CSRF  -->
<!-- Insecure Direct Object Reference 2 -->
  
 <%@ include file="/footer.jsp" %>