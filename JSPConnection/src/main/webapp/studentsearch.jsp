<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Student List</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f9f9f9; }
        table { border-collapse: collapse; width: 80%; margin: 30px auto; }
        th, td { border: 1px solid #ccc; padding: 10px; text-align: center; }
        th { background-color: #1877f2; color: white; }
        h2 { text-align: center; color: #333; }
        p { text-align: center; color: red; }
    </style>
</head>
<body>
<%
    String coursename = request.getParameter("coursename");

    if (coursename != null) {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/presidencymca", "root", "Presidency1");

            String sql = "SELECT studnumber, studname, coursename FROM student WHERE coursename = ?";
            ps = con.prepareStatement(sql);
            ps.setString(1, coursename);
            rs = ps.executeQuery();

            out.println("<h2>List of " + coursename + " Students</h2>");
            out.println("<table>");
            out.println("<tr><th>Student Number</th><th>Name</th><th>Course</th></tr>");

            boolean hasData = false;
            while (rs.next()) {
                hasData = true;
                out.println("<tr>");
                out.println("<td>" + rs.getString("studnumber") + "</td>");
                out.println("<td>" + rs.getString("studname") + "</td>");
                out.println("<td>" + rs.getString("coursename") + "</td>");
                out.println("</tr>");
            }
            out.println("</table>");

            if (!hasData) {
                out.println("<p>No students found for selected course.</p>");
            }

        } catch (Exception e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
        } finally {
            if (rs != null) try { rs.close(); } catch (Exception e) {}
            if (ps != null) try { ps.close(); } catch (Exception e) {}
            if (con != null) try { con.close(); } catch (Exception e) {}
        }
    } else {
        out.println("<p>No course selected!</p>");
    }
%>
</body>
</html>
