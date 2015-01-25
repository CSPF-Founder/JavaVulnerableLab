<%-- 
    Document   : search
    Created on : 1 Dec, 2014, 2:15:38 PM
    Author     : breakthesec
--%>
 <%@ include file="/header.jsp" %> 
        <form id="form1" name="form1" method="GET" action="search.jsp">
			    	<label>Please Enter Keyword:
					<input  type="text" name="keyword"/>
		        </label>
				<br>
				<input type="submit" name="action" value="Search"/>
			</form>
        <br/>
       <%  
			String searchedName = request.getParameter("keyword");
			if (searchedName != null)
			{
			//code for searching pages related to the given keyword goes here..
			%>
				Search Results for <%=searchedName%> 
                                <br/>...
                                <br/>...
			<%
			//Show result pages
                        
			}
			%>
 <%@ include file="/footer.jsp" %>