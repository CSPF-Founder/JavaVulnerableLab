/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package org.cysecurity.cspf.jvl.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.cysecurity.cspf.jvl.model.DBConnect;
 
/**
 *
 * @author breakthesec
 */
public class SendMessage extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
             try
             {
                 PrintWriter out = response.getWriter();
                 Connection con=new DBConnect().connect(getServletContext().getRealPath("/WEB-INF/config.properties"));
                            String recipient=request.getParameter("recipient");
                    String subject=request.getParameter("subject");
                 String msg=request.getParameter("msg");
                 String sender=request.getParameter("sender");
                    if(con!=null && !con.isClosed() && request.getParameter("send")!=null)
                        {
                           //PreparedStatement to Prevent SQL Injection attack:       
                            PreparedStatement pstmt=con.prepareStatement("INSERT into UserMessages(recipient, sender, subject, msg) values (?,?,?,?)");
                            pstmt.setString(1, recipient);
                            pstmt.setString(2, sender);
                            pstmt.setString(3, subject);
                            pstmt.setString(4, msg);
                            pstmt.executeUpdate();
                            response.sendRedirect(request.getContextPath()+"/vulnerability/SendMessage.jsp?status=<b style='color:green'>* Message successfully sent *</b>");
                                    
                               }
                    else
                    {
                           response.sendRedirect(request.getContextPath()+"/vulnerability/SendMessage.jsp?status=<b style='color:red'>* Something Went Wrong</b>");
                           
                    }
                }
               catch(Exception ex)
                {
                       response.sendRedirect(request.getContextPath()+"/vulnerability/SendMessage.jsp?status=<b style='color:red'>* Something Went Wrong</b><br/>"+ex);
                           
                }                 
            
       
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
