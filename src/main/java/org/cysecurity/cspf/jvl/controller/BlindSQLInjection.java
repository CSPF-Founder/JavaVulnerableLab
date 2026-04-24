package org.cysecurity.cspf.jvl.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.cysecurity.cspf.jvl.model.DBConnect;
import org.json.JSONObject;

/**
 * Blind SQL Injection Vulnerability Example
 *
 * This servlet demonstrates a blind SQL injection vulnerability where the application
 * doesn't directly return database data but provides indirect feedback through
 * different responses based on query results.
 *
 * Vulnerability Type: Blind SQL Injection
 * Attack Vector: User Profile Existence Check
 * Risk Level: High
 *
 * Educational Purpose:
 * - Shows how blind SQL injection differs from error-based injection
 * - Demonstrates boolean-based blind SQL injection
 * - Illustrates time-based blind SQL injection possibilities
 *
 * @author JavaVulnerableLab
 */
public class BlindSQLInjection extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        String userId = request.getParameter("userId");
        JSONObject jsonResponse = new JSONObject();

        if (userId == null || userId.trim().isEmpty()) {
            jsonResponse.put("status", "error");
            jsonResponse.put("message", "User ID parameter is required");
            out.print(jsonResponse.toString());
            return;
        }

        try {
            DBConnect dbConnect = new DBConnect();
            Connection con = dbConnect.connect();

            if (con != null) {
                Statement stmt = con.createStatement();

                // VULNERABLE CODE: Direct concatenation enables blind SQL injection
                // Attacker can inject SQL conditions that will change the boolean result
                // Examples of malicious payloads:
                // userId = "1 AND 1=1"  -> Returns "exists" (true condition)
                // userId = "1 AND 1=2"  -> Returns "not found" (false condition)
                // userId = "1 AND (SELECT COUNT(*) FROM users WHERE username LIKE 'a%')>0" -> Boolean-based enumeration
                // userId = "1 AND (SELECT SLEEP(5))"  -> Time-based blind injection (MySQL)
                // userId = "1 AND (SELECT COUNT(*) FROM information_schema.tables WHERE table_schema=database())>10" -> Schema enumeration

                String query = "SELECT COUNT(*) as count FROM users WHERE id=" + userId;

                // Log the query for educational purposes (in real apps, this would be logged secretly)
                System.out.println("Executing query: " + query);

                ResultSet rs = stmt.executeQuery(query);

                if (rs.next()) {
                    int count = rs.getInt("count");

                    if (count > 0) {
                        // User exists - different response
                        jsonResponse.put("status", "success");
                        jsonResponse.put("exists", true);
                        jsonResponse.put("message", "User profile found");
                        jsonResponse.put("timestamp", System.currentTimeMillis());
                    } else {
                        // User doesn't exist - different response
                        jsonResponse.put("status", "success");
                        jsonResponse.put("exists", false);
                        jsonResponse.put("message", "User profile not found");
                        jsonResponse.put("timestamp", System.currentTimeMillis());
                    }
                }

                rs.close();
                stmt.close();
                con.close();

            } else {
                jsonResponse.put("status", "error");
                jsonResponse.put("message", "Database connection failed");
            }

        } catch (Exception e) {
            // Even error handling can leak information in blind SQLi
            jsonResponse.put("status", "error");
            if (e.getMessage().contains("syntax error") || e.getMessage().contains("SQL")) {
                // Generic error message to prevent information disclosure
                jsonResponse.put("message", "Invalid request format");
            } else {
                jsonResponse.put("message", "System error occurred");
            }
            // Log actual error for debugging (but don't expose to user)
            System.err.println("BlindSQLInjection Error: " + e.getMessage());
        }

        out.print(jsonResponse.toString());
    }
}