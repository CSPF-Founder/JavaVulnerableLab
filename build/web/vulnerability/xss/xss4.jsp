<%@ include file="/header.jsp" %>
 <% String keyword = request.getParameter("keyword"); %>
 <h1>[incomplete]</h1>
 Please enter only words and search:<br/><br/>
		<form action="xss4.jsp" method="get">
		<input type="text" name="keyword" value=<% if (keyword != null){ out.print(keyword);} %>>
		<br/><br/><input type="submit" name="Search" value="Search"/>
		</form>
		<br/>
                <%
                 
		 if (keyword != null)
		 {
                   %>
                    Search Results for <%=keyword%> 
                 <%
                  }
                 %>
<br/>
<br/>
<br/>
<br/>
 
 <%@ include file="/footer.jsp" %>