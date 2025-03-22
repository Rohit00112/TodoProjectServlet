package com.example.todo.model.user;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.example.todo.util.DatabaseUtil;

public class UserDAO {
    
    private static final DatabaseUtil dbUtil = DatabaseUtil.getInstance();
    
    public static User authenticateUser(String username, String password) throws SQLException, ClassNotFoundException {
        Connection conn = dbUtil.getConnection();
        String query = "SELECT * FROM users WHERE username = ? AND password = ?";
        PreparedStatement ps = conn.prepareStatement(query);
        ps.setString(1, username);
        ps.setString(2, password); // In a real application, use password hashing
        
        ResultSet rs = ps.executeQuery();
        
        if (rs.next()) {
            int id = rs.getInt("id");
            String email = rs.getString("email");
            
            return new User(id, username, password, email);
        }
        
        return null; // Authentication failed
    }
    
    public static boolean registerUser(User user) throws SQLException, ClassNotFoundException {
        Connection conn = dbUtil.getConnection();
        
        // Check if username already exists
        if (getUserByUsername(user.getUsername()) != null) {
            return false; // Username already taken
        }
        
        String query = "INSERT INTO users (username, password, email) VALUES (?, ?, ?)";
        PreparedStatement ps = conn.prepareStatement(query);
        ps.setString(1, user.getUsername());
        ps.setString(2, user.getPassword()); // In a real application, use password hashing
        ps.setString(3, user.getEmail());
        
        return ps.executeUpdate() > 0;
    }
    
    public static User getUserByUsername(String username) throws SQLException, ClassNotFoundException {
        Connection conn = dbUtil.getConnection();
        String query = "SELECT * FROM users WHERE username = ?";
        PreparedStatement ps = conn.prepareStatement(query);
        ps.setString(1, username);
        
        ResultSet rs = ps.executeQuery();
        
        if (rs.next()) {
            int id = rs.getInt("id");
            String password = rs.getString("password");
            String email = rs.getString("email");
            
            return new User(id, username, password, email);
        }
        
        return null;
    }
    
    public static User getUserById(int userId) throws SQLException, ClassNotFoundException {
        Connection conn = dbUtil.getConnection();
        String query = "SELECT * FROM users WHERE id = ?";
        PreparedStatement ps = conn.prepareStatement(query);
        ps.setInt(1, userId);
        
        ResultSet rs = ps.executeQuery();
        
        if (rs.next()) {
            String username = rs.getString("username");
            String password = rs.getString("password");
            String email = rs.getString("email");
            
            return new User(userId, username, password, email);
        }
        
        return null;
    }
}