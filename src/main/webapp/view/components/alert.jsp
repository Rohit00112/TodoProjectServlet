<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String type = request.getParameter("type");
    String message = request.getParameter("message");
    String bgColor = type != null && type.equals("success") ? "green" : "red";
    String icon = type != null && type.equals("success") ? "check-circle" : "exclamation-circle";
%>

<% if (message != null) { %>
<div class="bg-<%= bgColor %>-100 border border-<%= bgColor %>-400 text-<%= bgColor %>-700 px-4 py-3 rounded relative mb-4" role="alert">
    <span class="block sm:inline"><i class="fas fa-<%= icon %>"></i> <%= message %></span>
    <span class="absolute top-0 bottom-0 right-0 px-4 py-3 cursor-pointer" onclick="this.parentElement.style.display='none';">
        <i class="fas fa-times"></i>
    </span>
</div>
<% } %>