<%
    session.invalidate(); // Remove all session data
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
    response.sendRedirect("login1.html");
%>
