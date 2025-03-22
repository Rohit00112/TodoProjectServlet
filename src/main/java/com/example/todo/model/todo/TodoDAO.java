package com.example.todo.model.todo;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.example.todo.util.DatabaseUtil;

public class TodoDAO {

    private static final DatabaseUtil dbUtil = DatabaseUtil.getInstance();

    public static boolean addTodo(Todo todo, int userId) throws SQLException, ClassNotFoundException {
        Connection conn = dbUtil.getConnection();
        String query = "INSERT INTO todos (title,description,completed,user_id) VALUES (?,?,?,?)";
        PreparedStatement ps = conn.prepareStatement(query);
        ps.setString(1,todo.getTitle());
        ps.setString(2,todo.getDescription());
        ps.setBoolean(3,todo.isCompleted());
        ps.setInt(4, userId);
        return ps.executeUpdate() > 0;
    }

    public static List<Todo> getAllTodos() throws SQLException, ClassNotFoundException {
        ArrayList<Todo> todos = new ArrayList<>();
        Connection conn = dbUtil.getConnection();
        String query = "SELECT * FROM todos";
        PreparedStatement ps = conn.prepareStatement(query);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            int id = rs.getInt("id");
            String title = rs.getString("title");
            String description = rs.getString("description");
            boolean completed = rs.getBoolean("completed");

            Todo todo = new Todo(id,title,description,completed);
            todos.add(todo);
        }

        return todos;
    }
    
    public static List<Todo> getTodosByUserId(int userId) throws SQLException, ClassNotFoundException {
        ArrayList<Todo> todos = new ArrayList<>();
        Connection conn = dbUtil.getConnection();
        String query = "SELECT * FROM todos WHERE user_id = ?";
        PreparedStatement ps = conn.prepareStatement(query);
        ps.setInt(1, userId);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            int id = rs.getInt("id");
            String title = rs.getString("title");
            String description = rs.getString("description");
            boolean completed = rs.getBoolean("completed");

            Todo todo = new Todo(id,title,description,completed);
            todos.add(todo);
        }

        return todos;
    }

    public static boolean deleteTodo(int id) throws SQLException, ClassNotFoundException {
        Connection conn = dbUtil.getConnection();
        String query = "DELETE FROM todos WHERE id = ?";
        PreparedStatement ps = conn.prepareStatement(query);
        ps.setInt(1,id);
        return ps.executeUpdate() > 0;
    }
    
    public static boolean deleteTodoByIdAndUserId(int todoId, int userId) throws SQLException, ClassNotFoundException {
        Connection conn = dbUtil.getConnection();
        String query = "DELETE FROM todos WHERE id = ? AND user_id = ?";
        PreparedStatement ps = conn.prepareStatement(query);
        ps.setInt(1, todoId);
        ps.setInt(2, userId);
        return ps.executeUpdate() > 0;
    }
    
    public static boolean isTodoOwnedByUser(int todoId, int userId) throws SQLException, ClassNotFoundException {
        Connection conn = dbUtil.getConnection();
        String query = "SELECT COUNT(*) FROM todos WHERE id = ? AND user_id = ?";
        PreparedStatement ps = conn.prepareStatement(query);
        ps.setInt(1, todoId);
        ps.setInt(2, userId);
        ResultSet rs = ps.executeQuery();
        
        if (rs.next()) {
            return rs.getInt(1) > 0;
        }
        
        return false;
    }
    
    public static Todo getTodoById(int todoId) throws SQLException, ClassNotFoundException {
        Connection conn = dbUtil.getConnection();
        String query = "SELECT * FROM todos WHERE id = ?";
        PreparedStatement ps = conn.prepareStatement(query);
        ps.setInt(1, todoId);
        ResultSet rs = ps.executeQuery();
        
        if (rs.next()) {
            String title = rs.getString("title");
            String description = rs.getString("description");
            boolean completed = rs.getBoolean("completed");
            return new Todo(todoId, title, description, completed);
        }
        
        return null;
    }
    
    public static boolean updateTodo(Todo todo) throws SQLException, ClassNotFoundException {
        Connection conn = dbUtil.getConnection();
        String query = "UPDATE todos SET title = ?, description = ?, completed = ? WHERE id = ?";
        PreparedStatement ps = conn.prepareStatement(query);
        ps.setString(1, todo.getTitle());
        ps.setString(2, todo.getDescription());
        ps.setBoolean(3, todo.isCompleted());
        ps.setInt(4, todo.getId());
        return ps.executeUpdate() > 0;
    }

}
