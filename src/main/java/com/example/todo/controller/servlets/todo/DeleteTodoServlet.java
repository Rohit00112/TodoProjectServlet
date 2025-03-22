package com.example.todo.controller.servlets.todo;

import com.example.todo.model.todo.Todo;
import com.example.todo.model.todo.TodoDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "DeleteTodoServlet", value = "/delete")
public class DeleteTodoServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int todoId = Integer.parseInt(request.getParameter("id"));
        
        // Get the user ID from the session
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            // User is not logged in, redirect to login page
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        int userId = (int) session.getAttribute("userId");
        
        try {
            // Check if the todo belongs to the user before deleting
            if (TodoDAO.isTodoOwnedByUser(todoId, userId)) {
                boolean deleted = TodoDAO.deleteTodoByIdAndUserId(todoId, userId);
                
                if(deleted) {
                    response.sendRedirect(request.getContextPath() + "/list?success=deleted");
                } else {
                    response.sendRedirect(request.getContextPath() + "/list?error=deleteFailed");
                }
            } else {
                // Todo doesn't belong to the user
                response.sendRedirect(request.getContextPath() + "/list?error=unauthorized");
            }
        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        doGet(request, response);

    }
}