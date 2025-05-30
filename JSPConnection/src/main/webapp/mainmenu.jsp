<%@ page language="java" session="true" %>
<%
    // Check if user is logged in
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("login1.html");
        return;
    }

    // Disable caching
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
%>
