<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.todo.model.todo.Todo" %>
<%
    String errorMessage = request.getParameter("error");
    Todo todo = (Todo) request.getAttribute("todo");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="components/header.jsp" %>
</head>
<body class="bg-gray-100 min-h-screen">
    <%@ include file="components/navbar.jsp" %>
    
    <div class="container mx-auto px-4 py-8">
        <div class="bg-white p-8 rounded-lg shadow-lg w-full max-w-md mx-auto">
            <div class="flex justify-between items-center mb-6">
                <h2 class="text-2xl font-bold text-gray-800">Update To-Do</h2>
                <div class="px-3 py-1 rounded-full <%= todo != null && todo.isCompleted() ? "bg-green-100 text-green-800" : "bg-yellow-100 text-yellow-800" %> flex items-center">
                    <i class="fas <%= todo != null && todo.isCompleted() ? "fa-check" : "fa-clock" %> mr-2"></i>
                    <%= todo != null && todo.isCompleted() ? "Completed" : "Pending" %>
                </div>
            </div>

            <% if (request.getParameter("error") != null) { %>
            <jsp:include page="components/alert.jsp">
                <jsp:param name="type" value="error"/>
                <jsp:param name="message" value='${param.error}'/>
            </jsp:include>
            <% } %>

            <form action="${pageContext.request.contextPath}/update" method="POST" class="space-y-6">
                <input type="hidden" name="id" value="<%= todo != null ? todo.getId() : "" %>">
                <div>
                    <label for="title" class="block text-sm font-medium text-gray-700 mb-1">Title</label>
                    <input type="text" id="title" name="title" value="<%= todo != null ? todo.getTitle() : "" %>" required
                           class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500">
                </div>
                <div>
                    <label for="description" class="block text-sm font-medium text-gray-700 mb-1">Description</label>
                    <textarea id="description" name="description" rows="4" required
                              class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500"><%= todo != null ? todo.getDescription() : "" %></textarea>
                </div>
                <div class="flex items-center mb-6">
                    <label class="inline-flex items-center cursor-pointer">
                        <input type="checkbox" id="completed" name="completed" <%= todo != null && todo.isCompleted() ? "checked" : "" %>
                               class="sr-only peer">
                        <div class="relative w-11 h-6 bg-gray-200 peer-focus:outline-none peer-focus:ring-4 peer-focus:ring-blue-300 rounded-full peer peer-checked:after:translate-x-full rtl:peer-checked:after:-translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:start-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all peer-checked:bg-blue-600"></div>
                        <span class="ml-3 text-sm font-medium text-gray-900">Mark as completed</span>
                    </label>
                </div>
                <div class="flex space-x-4">
                    <button type="submit" class="flex-1 bg-blue-600 text-white py-2 px-4 rounded-md hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2">
                        <i class="fas fa-save mr-2"></i> Update
                    </button>
                    <a href="${pageContext.request.contextPath}/list" class="flex-1 bg-gray-500 text-white py-2 px-4 rounded-md hover:bg-gray-600 focus:outline-none focus:ring-2 focus:ring-gray-500 focus:ring-offset-2 text-center">
                        <i class="fas fa-times mr-2"></i> Cancel
                    </a>
                </div>
            </form>
        </div>
    </div>

</body>
</html>