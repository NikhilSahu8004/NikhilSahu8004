<%@ page import="java.sql.*" %>
<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");
   

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/presidencymca", "root", "Presidency1"
        );

        // Pehle check karo username pehle se hai ya nahi
        PreparedStatement check = con.prepareStatement("SELECT * FROM users WHERE username=?");
        check.setString(1, username);
        ResultSet rs = check.executeQuery();

        if (rs.next()) {
            // Username already hai
            out.println("<script>alert('Username already exists.'); location='register.html';</script>");
        } else {
            // Naya user insert karo
            PreparedStatement ps = con.prepareStatement("INSERT INTO users(username, password) VALUES (?, ?)");
            ps.setString(1, username);
            ps.setString(2, password);
            

            int rows = ps.executeUpdate();

            if (rows > 0) {
                out.println("<script>alert('User created successfully!'); location='login1.html';</script>");
            } else {
                out.println("<script>alert('Failed to create user.'); location='register.html';</script>");
            }

            ps.close();
        }

        rs.close();
        check.close();
        con.close();
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    }
%>
