package com.example.todo.controller.filters;

import com.example.todo.model.user.User;
import com.example.todo.model.user.UserDAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebFilter(filterName = "AuthenticationFilter", urlPatterns = {"/list", "/add", "/delete"})
public class AuthenticationFilter implements Filter {
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization code if needed
    }
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) 
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        
        // Get the current session without creating a new one
        HttpSession session = httpRequest.getSession(false);
        
        // Check if user is already authenticated
        boolean isAuthenticated = (session != null && session.getAttribute("user") != null);
        
        if (!isAuthenticated) {
            // Check for remember-me cookie
            Cookie[] cookies = httpRequest.getCookies();
            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    if (cookie.getName().equals("user_remember")) {
                        String username = cookie.getValue();
                        try {
                            // Get user by username
                            User user = UserDAO.getUserByUsername(username);
                            if (user != null) {
                                // Create a new session and authenticate the user
                                session = httpRequest.getSession(true);
                                session.setAttribute("user", user);
                                session.setAttribute("userId", user.getId());
                                session.setAttribute("username", user.getUsername());
                                isAuthenticated = true;
                                break;
                            }
                        } catch (SQLException | ClassNotFoundException e) {
                            // Log the error but continue without auto-login
                            e.printStackTrace();
                        }
                    }
                }
            }
        }
        
        if (isAuthenticated) {
            // User is authenticated, proceed with the request
            chain.doFilter(request, response);
        } else {
            // User is not authenticated, redirect to login page
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login");
        }
    }
    
    @Override
    public void destroy() {
        // Cleanup code if needed
    }
}