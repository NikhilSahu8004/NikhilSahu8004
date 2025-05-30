<%@ page import="java.sql.*" %>
<%
    String username = request.getParameter("username");
    String newpassword = request.getParameter("newpassword");

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/presidencymca", "root", "Presidency1"
        );

        PreparedStatement ps = con.prepareStatement("UPDATE users SET password=? WHERE username=?");
        ps.setString(1, newpassword);
        ps.setString(2, username);

        int rows = ps.executeUpdate();

        if (rows > 0) {
            out.println("<script>alert('Password updated successfully.'); location='login1.html';</script>");
        } else {
            out.println("<script>alert('Username not found.'); location='forgot.html';</script>");
        }

        ps.close();
        con.close();
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    }
%>
