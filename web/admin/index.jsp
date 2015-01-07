 <%@ include file="/header.jsp" %>
 <%
 if(session.getAttribute("privilege")!=null && session.getAttribute("privilege").equals("admin"))
{
    response.sendRedirect("admin.jsp");
}
else
 {
     response.sendRedirect("adminlogin.jsp");
 }
 %> 
 <%@ include file="/footer.jsp" %>