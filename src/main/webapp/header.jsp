 <%@page import="java.io.FileInputStream"%>
<%@page import="java.util.Properties"%>
<%@page import="java.io.File"%>
<%
   String path = request.getContextPath();
   String configPath=getServletContext().getRealPath("/WEB-INF/config.properties");
   
    Properties properties=new Properties();
    properties.load(new FileInputStream(configPath));
    String siteTitle=properties.getProperty("siteTitle");
     %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
	<title><%=siteTitle%></title>
	<link rel="stylesheet" href="<%=path%>/style.css" type="text/css" charset="utf-8" />
           <% out.print("<script src=\""+path+"/jquery.min.js\" type=\"text/javascript\"></script>"); %>
</head>

<body>
<div id="container" >

     <div id="Menu">
		<ul id="menu-bar" style="margin-left: auto ;  margin-right: auto ;" >
			<li class="current"><a href="<%=path%>">Home</a></li>
			
			<li><a href="#">Vulnerability</a>
				<ul><li><a href="#">A1- Injection</a>
					<ul><li><a href="#">SQL Injection</a>
						<ul>
						  <li><a href="<%=path%>/vulnerability/forumposts.jsp?postid=1">Sql Injection 1</a></li>
						  <li><a href="<%=path%>/login.jsp">Authentication Bypass</a></li>
						  <li><a href="<%=path%>/vulnerability/sqli/download.jsp">Blind SQLi 1</a></li>
                                                   <li><a href="<%=path%>/vulnerability/sqli/union2.jsp">Union 2</a></li>
                                                </ul>
                                            </li>
                                                <li><a href="#">XPath Injection</a>
                                                 <ul>
						  <li><a href="<%=path%>/vulnerability/Injection/xpath_login.jsp">Login Bypass</a></li>
                                                 </ul>
                                                </li>
                                                  <li><a href="#">XML Injection</a>
                                                 <ul>
						  <li><a href="<%=path%>/vulnerability/Injection/xxe.jsp">External Entity</a></li>
                                                  <li><a href="<%=path%>/vulnerability/Injection/xslt.jsp?style=1.xsl">XSLT Injection</a></li>
                                                 
                                                 </ul>
                                                </li>
                                           <li><a href="<%=path%>/vulnerability/Injection/orm.jsp?id=1">ORM Injection</a></li>
                                                 
					</ul>
                                     </li>
                                   
                                    <li><a href="#">A2- Broken Authentication & Session Management</a>
                                       <ul>
                                           <li><a href="<%=path%>/ForgotPassword.jsp">UserName Enumeration</a></li>
                                           <li><a href="<%=path%>/login.jsp">Brute Foce Login Page</a></li>
                                           <li><a href="<%=path%>/vulnerability/baasm/URLRewriting.jsp;jsessionid=<%=session.getId()%>">Session ID in URL</a></li>
                                           <li><a href="<%=path%>/vulnerability/baasm/SiteTitle.jsp">Improper Authentication: Privilege Escalation</a></li>
                                       
                                       </ul>
                                     </li>
                                        
			   	       <li><a href="#">A3- XSS</a>
				             <ul>
					       <li><a href="#">Reflected(GET)</a>
					 	 <ul>
							<li> <a href="<%=path%>/vulnerability/xss/search.jsp">Challenge 1</a></li>
							<li> <a href="<%=path%>/vulnerability/xss/xss2.jsp">Challenge 2</a></li>
							<li> <a href="<%=path%>/vulnerability/xss/xss3.jsp">Challenge 3</a></li>
							<li> <a href="<%=path%>/vulnerability/xss/xss4.jsp">Challenge 4</a></li>
					       	 </ul>
					       </li>
						
					       <li><a href="#">Flash Based</a>
						 <ul>
							<li><a href="<%=path%>/vulnerability/xss/flash/xss1.swf?vuln=<%=path%>">Challenge 1</a></li>
						 	<li><a href="<%=path%>/vulnerability/xss/flash/exss.jsp">Challenge 2</a></li>
						 </ul>
						<li><a href="<%=path%>/vulnerability/forum.jsp">Stored XSS(Persistent)</a></li>
				  	    </ul>
						
					</li>
					<li><a href="#">A4-Insecure Direct Object References</a>
					<ul>
                                            <li><a href="<%=path%>/myprofile.jsp?id=<% if(session.getAttribute("userid")!=null){ out.print(session.getAttribute("userid"));} %>" title="Make sure you have logged in ">Viewing Details</a>
						</li>
						<li><a href="<%=path%>/vulnerability/idor/change-email.jsp" title="Make sure you have logged in ">Modifying email ID</a>
						</li>
						<li><a href="<%=path%>/vulnerability/idor/download.jsp">Download Document</a>
						</li>
					</ul>
					</li>
					<li><a href="#">A5-Security Misconfiguration</a>
						<ul>
							<li><a href="<%=path%>/install.jsp">Setup Page not removed</a></li>		
							<li><a href="<%=path%>/admin/">Default Admin Credentials not changed</a></li>
                                                        <li><a href="<%=path%>/vulnerability/securitymisconfig/pages.jsp?id=1">Error Handling</a></li>

							</ul>
					</li>
                                        <li><a href="#">A6-Sensitive Data Exposure</a>
						<ul>
							<li><a href="<%=path%>/changeCardDetails.jsp">Cleartext Transmission of Sensitive Information</a></li>		
							<li><a href="<%=path%>/ForgotPassword.jsp">Storing Login Credentials in Plain Text</a></li>	
                                                        <li><a href="<%=path%>/login.jsp">Storing Login Credentials in Plain Text in a cookie</a></li>
							<li><a href="<%=path%>/vulnerability/sde/hash.jsp">Hashed Credentials</a></li>
							</ul>
					</li>
                                        <li><a href="#">A7- Missing Function Level Access Control</a>
						<ul>                
                                                    <li> <a href="<%=path%>/admin/" title="Hint: Forced Browsing">Challenge 1:Bypass Admin Login</a></li>
                                                    <li> <a href="<%=path%>/admin/AddPage.jsp"> Challenge 2: Add Page</a></li>
                                                    <li> <a href="<%=path%>/admin/Configure.jsp"> Configure</a></li>
                                                     <li> <a href="<%=path%>/vulnerability/mfac/SearchEngines.jsp"> Crawlers</a></li>                                             
                                                </ul>
                                        </li>
					<li><a href="#">A8- CSRF</a>
						<ul>
                                                    <li><a href="<%=path%>/vulnerability/csrf/change-info.jsp">CSRF 1(GET): Change Info</a></li>
							<li><a href="<%=path%>/vulnerability/csrf/changepassword.jsp">CSRF 2(POST): Change Password</a></li>
						</ul>
					</li>
                                        <li><a href="#">A9- Using components with known vulnerabilities</a>
						<ul>
                                                    <li><a href="/VulnerableSpring/error.htm?msg=error.c403">Web Application using Spring Framework</a></li>
                                                </ul>
					</li>
					<li><a href="#">A10. Unvalidated Redirect & Forward..</a>
						<ul>
							<li><a href="<%=path%>/vulnerability/unvalidated/OpenURL.jsp">Open Redirect</a>
							</li>
							<li><a href="<%=path%>/vulnerability/unvalidated/OpenForward.jsp">Open Forward</a>
							</li>
						</ul>
					</li>
					 
			</ul></li>
			<li><a href="<%=path%>/vulnerability/forum.jsp">Forum</a></li>
				<% 
                                if(session.getAttribute("isLoggedIn")!=null && session.getAttribute("isLoggedIn").equals("1"))
                                {
                                    if(session.getAttribute("privilege")!=null && session.getAttribute("privilege").equals("admin"))
                                    {
                                       out.print("<li><a href='"+path+"/admin/admin.jsp'>Admin Panel</a></li>"); 
                                    }
                                    out.print("<li><a href='"+path+"/myprofile.jsp?id="+session.getAttribute("userid")+"'>My Profile</a></li>");
                                     out.print("<li><a href='"+path+"/Logout'>Logout</a></li>");
                                }
                                else
                                {
                                   out.print("<li><a href='"+path+"/login.jsp'>LogIn</a></li>");
                                    out.print("<li><a href='"+path+"/Register.jsp'>Register</a></li>");
                                }
                                %>
			<li><a href="<%=path%>/contact.jsp">Contact</a></li>
		</ul>
	</div>

	<div id="Main-Container">
	<br/>
	<div id="logo">

<h1><%=siteTitle%></h1>
</div>
<br/>
	
		
		<div id="Main">
		