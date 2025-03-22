<%@ page import="com.example.todo.model.todo.Todo" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<% String successMessage = request.getParameter("success"); %>
<% String errorMessage = request.getParameter("error"); %>

<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="components/header.jsp" %>
</head>
<body class="bg-gray-100 min-h-screen">
    <%@ include file="components/navbar.jsp" %>
    <div class="container mx-auto px-4 py-8">
        <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
            <div class="bg-white rounded-lg shadow-lg p-6">
                <div class="flex items-center justify-between">
                    <h2 class="text-xl font-semibold text-gray-800">Total Tasks</h2>
                    <i class="fas fa-tasks text-blue-500 text-2xl"></i>
                </div>
                <p class="text-3xl font-bold text-gray-900 mt-4"><%= request.getAttribute("todoList") != null ? ((List<Todo>)request.getAttribute("todoList")).size() : 0 %></p>
            </div>
            <div class="bg-white rounded-lg shadow-lg p-6">
                <div class="flex items-center justify-between">
                    <h2 class="text-xl font-semibold text-gray-800">Completed</h2>
                    <i class="fas fa-check-circle text-green-500 text-2xl"></i>
                </div>
                <p class="text-3xl font-bold text-gray-900 mt-4"><%= request.getAttribute("todoList") != null ? ((List<Todo>)request.getAttribute("todoList")).stream().filter(Todo::isCompleted).count() : 0 %></p>
            </div>
            <div class="bg-white rounded-lg shadow-lg p-6">
                <div class="flex items-center justify-between">
                    <h2 class="text-xl font-semibold text-gray-800">Pending</h2>
                    <i class="fas fa-clock text-yellow-500 text-2xl"></i>
                </div>
                <p class="text-3xl font-bold text-gray-900 mt-4"><%= request.getAttribute("todoList") != null ? ((List<Todo>)request.getAttribute("todoList")).stream().filter(t -> !t.isCompleted()).count() : 0 %></p>
            </div>
        </div>

        <div class="bg-white rounded-lg shadow-lg p-6">
            <div class="flex justify-between items-center mb-6">
                <h1 class="text-2xl font-bold text-gray-800">To-Do List</h1>
                <a href="${pageContext.request.contextPath}/add" class="inline-flex items-center px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
                    <i class="fas fa-plus mr-2"></i> Add New Todo
                </a>
            </div>

              <% if (successMessage != null) { %>
  <div class="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded relative mb-4" role="alert">
    <span class="block sm:inline"><i class="fas fa-check-circle"></i> <%= successMessage %></span>
    <span class="absolute top-0 bottom-0 right-0 px-4 py-3 cursor-pointer" onclick="this.parentElement.style.display='none';">
      <i class="fas fa-times"></i>
    </span>
  </div>
  <% } %>

  <% if (errorMessage != null) { %>
  <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative mb-4" role="alert">
    <span class="block sm:inline"><i class="fas fa-exclamation-circle"></i> <%= errorMessage %></span>
    <span class="absolute top-0 bottom-0 right-0 px-4 py-3 cursor-pointer" onclick="this.parentElement.style.display='none';">
      <i class="fas fa-times"></i>
    </span>
  </div>
  <% } %>

  <div class="overflow-x-auto">
    <table class="min-w-full divide-y divide-gray-200">
      <thead class="bg-gray-50">
      <tr>
        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">ID</th>
        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Title</th>
        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Description</th>
        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Status</th>
        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
      </tr>
      </thead>
      <tbody class="bg-white divide-y divide-gray-200">
      <%
        List<Todo> todos = (List<Todo>) request.getAttribute("todoList");
        if (todos != null && !todos.isEmpty()) {
          for (Todo todo : todos) {
      %>
      <tr class="hover:bg-gray-50">
        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500"><%= todo.getId() %></td>
        <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900"><%= todo.getTitle() %></td>
        <td class="px-6 py-4 text-sm text-gray-500"><%= todo.getDescription() %></td>
        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
          <% if (todo.isCompleted()) { %>
            <span class="px-3 py-1 inline-flex items-center gap-1.5 text-xs font-semibold rounded-full bg-green-100 text-green-800">
              <i class="fas fa-check-circle"></i> Completed
            </span>
          <% } else { %>
            <span class="px-3 py-1 inline-flex items-center gap-1.5 text-xs font-semibold rounded-full bg-yellow-100 text-yellow-800">
              <i class="fas fa-clock"></i> Pending
            </span>
          <% } %>
        </td>
        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500 space-x-4">
          <a href="${pageContext.request.contextPath}/update?id=<%= todo.getId() %>" class="text-blue-600 hover:text-blue-900 focus:outline-none inline-block mr-4">
            <i class="fas fa-edit"></i>
          </a>
          <form action="${pageContext.request.contextPath}/delete" method="post" class="inline" onsubmit="return confirm('Are you sure you want to delete this?');">
            <input type="hidden" name="id" value="<%= todo.getId() %>">
            <button type="submit" class="text-red-600 hover:text-red-900 focus:outline-none">
              <i class="fas fa-trash-alt"></i>
            </button>
          </form>
        </td>
      </tr>
      <%
        }
      } else {
      %>
      <tr>
        <td colspan="5" class="px-6 py-4 text-center text-sm text-gray-500">
          <i class="fas fa-inbox text-gray-400 text-xl mb-2"></i>
          <p>No todos found.</p>
        </td>
      </tr>
      <% } %>
      </tbody>
    </table>
  </div>
  
  <div class="mt-6 text-center">
    <a href="${pageContext.request.contextPath}/add" class="inline-flex items-center px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
      <i class="fas fa-plus mr-2"></i> Add New Todo
    </a>
  </div>
</div>
</body>
</html>
