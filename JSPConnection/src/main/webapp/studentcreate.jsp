<%@ page import="java.sql.*" %>
<%
    String studnumberStr = request.getParameter("studnumber");
    String studname = request.getParameter("studname");
    String coursename = request.getParameter("coursename");

    if(studnumberStr != null && studname != null && coursename != null && !coursename.isEmpty()) {
        int studnumber = Integer.parseInt(studnumberStr);

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/presidencymca", "root", "Presidency1");

            String sql = "INSERT INTO student (studnumber, studname, coursename) VALUES (?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, studnumber);
            ps.setString(2, studname);
            ps.setString(3, coursename);

            int rows = ps.executeUpdate();

            if(rows > 0) {
                out.println("<p style='color:green; text-align:center;'>Student added successfully!</p>");
            } else {
                out.println("<p style='color:red; text-align:center;'>Failed to add student.</p>");
            }

            ps.close();
            con.close();
        } catch(Exception e) {
            out.println("<p style='color:red; text-align:center;'>Error: " + e.getMessage() + "</p>");
        }
    } else {
        out.println("<p style='color:red; text-align:center;'>Please fill all fields correctly.</p>");
    }
%>
