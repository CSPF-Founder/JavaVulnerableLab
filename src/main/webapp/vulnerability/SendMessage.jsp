  <%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ include file="/header.jsp" %>
 <%@ page import="org.cysecurity.cspf.jvl.model.DBConnect"%>
<%
 if(session.getAttribute("isLoggedIn")!=null) 
 {
      if(request.getParameter("status")!=null)
   {
       out.print(request.getParameter("status")); //Displaying any error message
   }
    
%>
<br/><br/>
<form action="../SendMessage.do" method="POST">
<table> 
<tr><td>Recipient: </td><td><input type="text" name="recipient" value="<% if(request.getParameter("recipient")!=null){ out.print(request.getParameter("recipient")); } %>"/></td></tr>
<tr><td>Subject :</td><td><input type="text" name="subject"/></td></tr>
<tr><td>Message :</td><td><textarea name="msg"></textarea></td></tr>
<tr> <td><input type="hidden" name="sender" value="<%=session.getAttribute("user")%>"/></td></tr>
<tr><td><input type="submit" name="send" value="send"/></td></tr>
</table>  
</form>
<% 
 
 }
 else
 {
  out.print("<span style='color:red'>* Please login to send message</span>");   
 }
%>

 <%@ include file="/footer.jsp" %>