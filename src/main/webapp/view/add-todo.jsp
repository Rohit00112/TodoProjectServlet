<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="components/header.jsp" %>
</head>
<body class="bg-gray-100 min-h-screen">
    <%@ include file="components/navbar.jsp" %>
    <div class="container mx-auto px-4 py-8 flex justify-center">
        <div class="bg-white p-8 rounded-lg shadow-lg w-full max-w-md">
            <div class="flex items-center justify-between mb-6">
                <h2 class="text-2xl font-bold text-gray-800">Add New To-Do</h2>
                <a href="${pageContext.request.contextPath}/list" class="text-gray-600 hover:text-blue-600 transition duration-300">
                    <i class="fas fa-arrow-left"></i>
                </a>
            </div>

            <% if (request.getParameter("error") != null) { %>
            <jsp:include page="components/alert.jsp">
                <jsp:param name="type" value="error"/>
                <jsp:param name="message" value='${param.error}'/>
            </jsp:include>
            <% } %>

    <form action="${pageContext.request.contextPath}/add" method="POST" class="space-y-6">
        <div>
            <label for="title" class="block text-sm font-medium text-gray-700 mb-1">Title</label>
            <div class="relative">
                <span class="absolute inset-y-0 left-0 pl-3 flex items-center text-gray-500">
                    <i class="fas fa-tasks"></i>
                </span>
                <input type="text" id="title" name="title" required
                       class="pl-10 w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent">
            </div>
        </div>

        <div>
            <label for="description" class="block text-sm font-medium text-gray-700 mb-1">Description</label>
            <div class="relative">
                <span class="absolute top-2 left-0 pl-3 flex items-center text-gray-500">
                    <i class="fas fa-align-left"></i>
                </span>
                <textarea id="description" name="description" required
                          class="pl-10 w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent h-32"></textarea>
            </div>
        </div>

        <div>
            <label for="completed" class="block text-sm font-medium text-gray-700 mb-1">Status</label>
            <div class="relative">
                <span class="absolute inset-y-0 left-0 pl-3 flex items-center text-gray-500">
                    <i class="fas fa-check-circle"></i>
                </span>
                <select id="completed" name="completed"
                        class="pl-10 w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent appearance-none">
                    <option value="false"><i class="fas fa-times-circle"></i> Not Completed</option>
                    <option value="true"><i class="fas fa-check-circle"></i> Completed</option>
                </select>
                <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-500">
                    <i class="fas fa-chevron-down"></i>
                </div>
            </div>
        </div>

        <div class="flex justify-between space-x-4">
            <a href="${pageContext.request.contextPath}/list"
               class="flex-1 flex justify-center items-center px-4 py-2 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
                <i class="fas fa-arrow-left mr-2"></i> Back
            </a>
            <button type="submit" 
                    class="flex-1 flex justify-center items-center px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
                <i class="fas fa-plus mr-2"></i> Add Todo
            </button>
        </div>
    </form>
</div>
    </div>
</body>
</html>
