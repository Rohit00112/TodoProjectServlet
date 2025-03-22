<%@ page import="com.example.todo.model.todo.Todo" %>
<%
    // Get the todo object from request attribute
    Todo todo = (Todo) request.getAttribute("todo");
    if (todo == null) {
        response.sendRedirect(request.getContextPath() + "/list");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="components/header.jsp" %>
    <title>View Todo</title>
</head>
<body class="bg-gray-100 min-h-screen">
    <%@ include file="components/navbar.jsp" %>

    <div class="container mx-auto px-4 py-8">
        <div class="max-w-2xl mx-auto bg-white rounded-lg shadow-md p-6">
            <div class="flex justify-between items-center mb-6">
                <h2 class="text-2xl font-bold text-gray-800">Todo Details</h2>
                <div class="flex space-x-4">
                    <a href="${pageContext.request.contextPath}/update?id=<%= todo.getId() %>" 
                       class="px-4 py-2 bg-blue-600 text-white rounded-md hover:bg-blue-700 transition duration-300 flex items-center">
                        <i class="fas fa-edit mr-2"></i> Edit
                    </a>
                    <form action="${pageContext.request.contextPath}/delete" method="POST" class="inline">
                        <input type="hidden" name="id" value="<%= todo.getId() %>">
                        <button type="submit" 
                                class="px-4 py-2 bg-red-600 text-white rounded-md hover:bg-red-700 transition duration-300 flex items-center">
                            <i class="fas fa-trash-alt mr-2"></i> Delete
                        </button>
                    </form>
                </div>
            </div>

            <div class="space-y-6">
                <div>
                    <h3 class="text-lg font-semibold text-gray-700 mb-2">Title</h3>
                    <p class="text-gray-600"><%= todo.getTitle() %></p>
                </div>

                <div>
                    <h3 class="text-lg font-semibold text-gray-700 mb-2">Description</h3>
                    <p class="text-gray-600 whitespace-pre-line"><%= todo.getDescription() %></p>
                </div>

                <div>
                    <h3 class="text-lg font-semibold text-gray-700 mb-2">Status</h3>
                    <span class="<%= todo.isCompleted() ? "bg-green-100 text-green-800" : "bg-yellow-100 text-yellow-800" %> px-3 py-1 rounded-full text-sm font-medium">
                        <%= todo.isCompleted() ? "Completed" : "Pending" %>
                    </span>
                </div>
            </div>

            <div class="mt-8 flex justify-end">
                <a href="${pageContext.request.contextPath}/list" 
                   class="px-4 py-2 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
                    <i class="fas fa-arrow-left mr-2"></i> Back to List
                </a>
            </div>
        </div>
    </div>
    </div>
</body>
</html>