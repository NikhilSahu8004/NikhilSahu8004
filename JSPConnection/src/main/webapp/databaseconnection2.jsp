<%@ page import="java.sql.*" %>
<%
    String user = request.getParameter("user");
    String pass = request.getParameter("pwd");

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/presidencymca", "root", "Presidency1"
        );

        PreparedStatement ps = con.prepareStatement("SELECT * FROM users WHERE username=? AND password=?");
        ps.setString(1, user);
        ps.setString(2, pass);

        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            
            session.setAttribute("username", user);

            
            response.sendRedirect("mainmenu.html");
        } else {
            out.println("<script>alert('Invalid username or password!'); location='login1.html';</script>");
        }

        rs.close();
        ps.close();
        con.close();
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    }
%>
