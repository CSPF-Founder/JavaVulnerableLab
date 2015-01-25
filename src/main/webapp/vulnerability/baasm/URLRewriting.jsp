 <%@ include file="/header.jsp" %>

  <%
  out.print("<b class='success'>Your Session ID:</b>"+session.getId());
  %>
  <br/>
  <br/>
   <b class='fail'>X Never Expose Session IDs in URL. X </b><br/>
 <%@ include file="/footer.jsp" %>