
 <%@page import="org.cysecurity.cspf.jvl.model.DBConnect"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@ include file="header.jsp" %>
     <script type="text/javascript">  
              $(document).ready(function(){  
                  $("#username").change(function(){  
                      var username = $(this).val();  
                      $.getJSON("UsernameCheck.do","username="+username,function(result)
                      {
                          if(result.available==1)
                          {
                          $("#status").html("<b style='color:green'>&#10004;</b>");
                           }
                           else
                           {
                               $("#status").html("<b style='color:red'>&#10006; username doesn't exist</b>");
                           }
                          
                      });
                  });  
              });  
            </script> 
            
Password Recovery: 
<form action="ForgotPassword.jsp" method="post">
<table> 
<tr><td>Username: </td><td><input type="text" name="username" id="username"/></td><td><span id="status"></span></td></tr>
<tr><td>What's Your Pet's name?: </td><td><input type="text" name="secret" /></td></tr>
<tr><td><input type="submit" name="GetPassword" value="GetPassword"/></td></tr>
</table>  
</form><br/>
 
<%
if(request.getParameter("secret")!=null)
             {
                 Connection con=new DBConnect().connect(getServletContext().getRealPath("/WEB-INF/config.properties"));
                  ResultSet rs=null;
                  Statement stmt = con.createStatement();  
                  rs=stmt.executeQuery("select * from users where username='"+request.getParameter("username").trim()+"' and secret='"+request.getParameter("secret")+"'");
                  if(rs != null && rs.next()){
                      out.print("Hello "+rs.getString("username")+", <b class='success'> Your Password is: "+rs.getString("password"));
                  }
                  else
                  {
                      out.print("<b class='fail'> Secret/Email is wrong</b>");
                  }
             }
                  
%>
               
  <%@ include file="footer.jsp" %>