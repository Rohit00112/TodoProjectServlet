<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<nav class="bg-white shadow-lg mb-8">
    <div class="max-w-6xl mx-auto px-4">
        <div class="flex justify-between items-center h-16">
            <div class="flex items-center">
                <a href="${pageContext.request.contextPath}/" class="text-gray-800 text-xl font-bold">
                    <i class="fas fa-check-circle text-blue-600"></i> Todo App
                </a>
            </div>
            <div class="flex space-x-4">
                <a href="${pageContext.request.contextPath}/list" class="text-gray-600 hover:text-blue-600 px-3 py-2 rounded-md text-sm font-medium transition duration-300">
                    <i class="fas fa-list-ul"></i> View Todos
                </a>
                <a href="${pageContext.request.contextPath}/add" class="text-gray-600 hover:text-blue-600 px-3 py-2 rounded-md text-sm font-medium transition duration-300">
                    <i class="fas fa-plus"></i> Add Todo
                </a>
                <form action="${pageContext.request.contextPath}/logout" method="GET" class="inline">
                    <button type="submit" class="text-gray-600 hover:text-red-600 px-3 py-2 rounded-md text-sm font-medium transition duration-300">
                        <i class="fas fa-sign-out-alt"></i> Logout
                    </button>
                </form>
            </div>
        </div>
    </div>
</nav>