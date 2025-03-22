package com.example.todo.controller.servlets.todo;

import com.example.todo.model.todo.Todo;
import com.example.todo.model.todo.TodoDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "UpdateTodoServlet", value = "/update")
public class UpdateTodoServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Get the todo ID from request parameter
            int todoId = Integer.parseInt(request.getParameter("id"));
            
            // Get user ID from session
            HttpSession session = request.getSession();
            int userId = (int) session.getAttribute("userId");
            
            // Check if the todo belongs to the user
            if (TodoDAO.isTodoOwnedByUser(todoId, userId)) {
                // Get the todo details
                Todo todo = TodoDAO.getTodoById(todoId);
                if (todo != null) {
                    request.setAttribute("todo", todo);
                    request.getRequestDispatcher("/view/update-todo.jsp").forward(request, response);
                    return;
                }
            }
            
            // If todo not found or doesn't belong to user, redirect to list
            response.sendRedirect(request.getContextPath() + "/list");
            
        } catch (NumberFormatException | SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/list");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Get user ID from session
            HttpSession session = request.getSession();
            int userId = (int) session.getAttribute("userId");
            
            // Get todo details from form
            int todoId = Integer.parseInt(request.getParameter("id"));
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            boolean completed = request.getParameter("completed") != null;
            
            // Check if the todo belongs to the user
            if (TodoDAO.isTodoOwnedByUser(todoId, userId)) {
                // Update the todo
                Todo todo = new Todo(todoId, title, description, completed);
                boolean updated = TodoDAO.updateTodo(todo);
                
                if (updated) {
                    response.sendRedirect(request.getContextPath() + "/list");
                    return;
                }
            }
            
            // If update fails, redirect back to update page
            response.sendRedirect(request.getContextPath() + "/update?id=" + todoId);
            
        } catch (NumberFormatException | SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/list");
        }
    }
}