package com.example.todo.controller.servlets.todo;

import com.example.todo.model.todo.Todo;
import com.example.todo.model.todo.TodoDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "AddTodoServlet", value = "/add")
public class AddTodoServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/view/add-todo.jsp").forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        boolean isCompleted = Boolean.parseBoolean(request.getParameter("completed"));

        Todo todo = new Todo(title,description,isCompleted);
        
        // Get the user ID from the session
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            // User is not logged in, redirect to login page
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        int userId = (int) session.getAttribute("userId");

        try {
            boolean added = TodoDAO.addTodo(todo, userId);
            if (added) {
                response.sendRedirect(request.getContextPath() + "/list?success=added");
            }
            else {
                response.sendRedirect(request.getContextPath() + "/add?error=failed");
            }
        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
    }
}