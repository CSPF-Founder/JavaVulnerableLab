<%@page import="java.io.DataInputStream"%>
<%@page import="java.io.FileInputStream"%>
 <%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.SQLException"%>

<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="java.sql.ResultSet"%>
<%@ page import="java.util.*,java.io.*"%>
<%@ page import="org.cysecurity.cspf.jvl.model.DBConnect"%>


<%@page import="java.io.File"%>
<%
  String path = request.getContextPath();
  try
  {
    String fileid=request.getParameter("fileid");
    if(fileid!=null && !fileid.equals(""))
   {
     Connection con=new DBConnect().connect(getServletContext().getRealPath("/WEB-INF/config.properties"));
            Statement stmt = con.createStatement();
             ResultSet rs =null;
             rs=stmt.executeQuery("select * from FilesList where fileid="+fileid);         
              if(rs != null && rs.next())
              {
                
                int BUFSIZE = 4096;
                String filePath=rs.getString("path");
                  
                 File file = new File(getServletContext().getRealPath(path));
                file = new File(file.getParent()+filePath);       
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
                  out.print("File Not Found");
              }
    }
    else
    {
        out.print("File Parameter is missing");
    }
  }
  catch(Exception e)
  {
       out.print("Oops, Something Went wrong");
  }
    %>