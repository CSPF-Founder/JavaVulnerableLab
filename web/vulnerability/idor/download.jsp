<%@page import="java.io.DataInputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%
         if(request.getParameter("file")!=null)
        {
             String context = request.getContextPath();
             
            int BUFSIZE = 4096;
               String filePath;
            filePath = request.getParameter("file");
            File file = new File(getServletContext().getRealPath(context));
            file = new File(file.getParent()+"/docs/"+filePath);       
            int length   = 0;
            ServletOutputStream outStream = response.getOutputStream();
            response.setContentType("text/html");
            response.setContentLength((int)file.length());
            String fileName = (new File(filePath)).getName();
            response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");

            byte[] byteBuffer = new byte[BUFSIZE];
            DataInputStream in = new DataInputStream(new FileInputStream(file));

            while ((in != null) && ((length = in.read(byteBuffer)) != -1))
            {
            outStream.write(byteBuffer,0,length);
            }

            in.close();
            outStream.close();
        }
        else
        {
    %>
     <%@ include file="/header.jsp" %>
 <h3> Download Files: </h3><br/>
 <ul>
     <li><a href="download.jsp?file=doc1.pdf"> Doc1.pdf </a>  </li>
    <li><a href="download.jsp?file=exampledoc.pdf"> ExampleDoc.pdf </a></li>
 </ul>
     
  <%@ include file="/footer.jsp" %>
  <%
        }
        %>