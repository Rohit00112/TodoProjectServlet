package com.example.todo.controller.servlets.auth;

import com.example.todo.model.user.User;
import com.example.todo.model.user.UserDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "LoginServlet", value = "/login")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check if user is already logged in
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            // User is already logged in, redirect to home page
            response.sendRedirect(request.getContextPath() + "/list");
            return;
        }
        
        // Forward to login page
        request.getRequestDispatcher("/view/auth/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String rememberMe = request.getParameter("rememberMe");
        
        try {
            User user = UserDAO.authenticateUser(username, password);
            
            if (user != null) {
                // Authentication successful
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                session.setAttribute("userId", user.getId());
                session.setAttribute("username", user.getUsername());
                
                // Set session timeout - default 30 minutes
                session.setMaxInactiveInterval(30 * 60);
                
                // Handle remember me functionality
                if (rememberMe != null && rememberMe.equals("on")) {
                    // Create a persistent cookie that lasts for 30 days
                    Cookie userCookie = new Cookie("user_remember", username);
                    userCookie.setMaxAge(30 * 24 * 60 * 60); // 30 days in seconds
                    userCookie.setPath("/");
                    response.addCookie(userCookie);
                }
                
                // Redirect to todo list page
                response.sendRedirect(request.getContextPath() + "/list");
            } else {
                // Authentication failed
                request.setAttribute("error", "Invalid username or password");
                request.getRequestDispatcher("/view/auth/login.jsp").forward(request, response);
            }
        } catch (SQLException | ClassNotFoundException e) {
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/view/auth/login.jsp").forward(request, response);
        }
    }
}