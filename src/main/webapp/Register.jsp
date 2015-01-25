<%-- 
    Document   : Register
    Created on : 2 Dec, 2014, 10:47:44 AM
    Author     : breakthesec
--%>
 <%@ include file="header.jsp" %>
     <script type="text/javascript">  
              $(document).ready(function(){  
                  $("#username").change(function(){  
                      var username = $(this).val();  
                      $.getJSON("UsernameCheck.do","username="+username,function(result)
                      {
                          if(result.available==0)
                          {
                          $("#status").html("<b style='color:green'>&#10004; Available</b>");
                           }
                           else
                           {
                               $("#status").html("<b style='color:red'>&#10006; Username is already taken</b>");
                           }
                          
                      });
                  });  
                   $("#email").change(function(){  
                      var email = $(this).val();  
                      $.getJSON("EmailCheck.do","email="+email,function(result)
                      {
                          if(result.available==0)
                          {
                          $("#emailStatus").html("<b style='color:green'>&#10004;</b>");
                           }
                           else
                           {
                               $("#emailStatus").html("<b style='color:red'>&#10006; Email is already in Use</b>");
                           }
                          
                      });
                  });  
              });  
            </script> 
<form action="AddUser" method="post">
<table> 
<tr><td>UserName: </td><td><input type="text" name="username" id="username" /></td><td><span id="status"></span></td></tr>
<tr><td>Email:</td><td><input type="text" name="email" id="email"/></td><td><span id="emailStatus"></span></td></tr>
<tr><td>Describer Yourself:</td><td><input type="text" name="About" /></td></tr>
<tr><td>What's Your Pet's name?:</td><td><input type="text" name="secret"  /></td></tr>
<tr><td>Password :</td><td><input type="password" name="password"/></td></tr>
<tr><td><input type="submit" name="Register" value="Register"/></td></tr>
</table>  
</form>
<%@ include file="footer.jsp" %>