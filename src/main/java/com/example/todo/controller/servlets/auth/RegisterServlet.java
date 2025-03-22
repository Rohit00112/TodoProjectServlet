package com.example.todo.controller.servlets.auth;

import com.example.todo.model.user.User;
import com.example.todo.model.user.UserDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "RegisterServlet", value = "/register")
public class RegisterServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check if user is already logged in
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            // User is already logged in, redirect to home page
            response.sendRedirect(request.getContextPath() + "/list");
            return;
        }
        
        // Forward to register page
        request.getRequestDispatcher("/view/auth/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String email = request.getParameter("email");
        
        // Validate input
        if (username == null || username.trim().isEmpty() ||
            password == null || password.trim().isEmpty() ||
            email == null || email.trim().isEmpty()) {
            
            request.setAttribute("error", "All fields are required");
            request.getRequestDispatcher("/view/auth/register.jsp").forward(request, response);
            return;
        }
        
        // Check if passwords match
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match");
            request.getRequestDispatcher("/view/auth/register.jsp").forward(request, response);
            return;
        }
        
        // Create new user
        User user = new User(username, password, email);
        
        try {
            boolean registered = UserDAO.registerUser(user);
            
            if (registered) {
                // Registration successful, redirect to login page
                response.sendRedirect(request.getContextPath() + "/login?success=registered");
            } else {
                // Registration failed (likely username already exists)
                request.setAttribute("error", "Username already exists");
                request.getRequestDispatcher("/view/auth/register.jsp").forward(request, response);
            }
        } catch (SQLException | ClassNotFoundException e) {
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/view/auth/register.jsp").forward(request, response);
        }
    }
}