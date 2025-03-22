<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>To-Do App - Organize Your Tasks</title>
    <script src="https://kit.fontawesome.com/0d2ae3546c.js" crossorigin="anonymous"></script>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gradient-to-br from-gray-50 to-gray-100 min-h-screen">
    <div class="container mx-auto px-4 py-12">
        <div class="max-w-4xl mx-auto">
            <!-- Hero Section -->
            <div class="text-center mb-16">
                <h1 class="text-5xl font-bold text-gray-900 mb-4 animate-fade-in">
                    <i class="fas fa-check-circle text-blue-600"></i> To-Do App
                </h1>
                <p class="text-xl text-gray-600 mb-8">Streamline your tasks, boost your productivity</p>
            </div>

            <!-- Feature Cards -->
            <div class="grid md:grid-cols-2 gap-8 mb-12">
                <div class="bg-white rounded-xl shadow-md p-6 transform hover:scale-105 transition duration-300">
                    <div class="flex items-center mb-4">
                        <i class="fas fa-list-ul text-2xl text-blue-600 mr-3"></i>
                        <h2 class="text-xl font-semibold text-gray-800">Task Management</h2>
                    </div>
                    <p class="text-gray-600">Create, organize, and track your tasks with ease</p>
                </div>
                <div class="bg-white rounded-xl shadow-md p-6 transform hover:scale-105 transition duration-300">
                    <div class="flex items-center mb-4">
                        <i class="fas fa-chart-line text-2xl text-cyan-500 mr-3"></i>
                        <h2 class="text-xl font-semibold text-gray-800">Progress Tracking</h2>
                    </div>
                    <p class="text-gray-600">Monitor your productivity and task completion</p>
                </div>
            </div>

            <!-- Action Buttons -->
            <div class="flex flex-col sm:flex-row justify-center items-center space-y-4 sm:space-y-0 sm:space-x-6">
                <a href="${pageContext.request.contextPath}/list" 
                   class="w-full sm:w-auto bg-blue-600 text-white py-4 px-8 rounded-lg hover:bg-blue-700 transition duration-300 flex items-center justify-center">
                    <i class="fas fa-tasks mr-2"></i> View To-Dos
                </a>
                <a href="${pageContext.request.contextPath}/add" 
                   class="w-full sm:w-auto bg-cyan-500 text-white py-4 px-8 rounded-lg hover:bg-cyan-600 transition duration-300 flex items-center justify-center">
                    <i class="fas fa-plus mr-2"></i> Add To-Do
                </a>
            </div>
        </div>
    </div>


    <style>
        @keyframes fade-in {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .animate-fade-in {
            animation: fade-in 0.6s ease-out;
        }
    </style>
</body>
</html>
