package com.example.todo.controller.servlets.todo;

import com.example.todo.model.todo.Todo;
import com.example.todo.model.todo.TodoDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "ViewTodoServlet", value = "/list")
public class ViewTodoServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Get the user ID from the session
            HttpSession session = request.getSession(false);
            if (session != null && session.getAttribute("userId") != null) {
                int userId = (int) session.getAttribute("userId");
                
                // Get todos for the specific user
                List<Todo> todo = TodoDAO.getTodosByUserId(userId);
                request.setAttribute("todoList", todo);
                
                // Add username to request for display
                request.setAttribute("username", session.getAttribute("username"));
            }
            
            request.getRequestDispatcher("/view/todo-list.jsp").forward(request,response);
        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}