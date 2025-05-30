<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Delete Student</title>
    <style>
        body { font-family: Arial; background: #f1f1f1; text-align: center; padding-top: 50px; }
        .message {
            display: inline-block;
            padding: 20px;
            border-radius: 10px;
            background: #fff;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            color: #333;
        }
        .success { border-left: 6px solid #28a745; }
        .error { border-left: 6px solid #dc3545; }
    </style>
</head>
<body>
<%
    String studnumberStr = request.getParameter("studnumber");

    if (studnumberStr != null && !studnumberStr.isEmpty()) {
        try {
            int studnumber = Integer.parseInt(studnumberStr);

            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/presidencymca", "root", "Presidency1");

            PreparedStatement ps = con.prepareStatement("DELETE FROM student WHERE studnumber=?");
            ps.setInt(1, studnumber);

            int rows = ps.executeUpdate();

            if (rows > 0) {
%>
                <div class="message success">
                    <h2>Success</h2>
                    <p>Student with number <strong><%= studnumber %></strong> deleted successfully.</p>
                </div>
<%
            } else {
%>
                <div class="message error">
                    <h2>Not Found</h2>
                    <p>No student found with number <strong><%= studnumber %></strong>.</p>
                </div>
<%
            }

            ps.close();
            con.close();
        } catch (Exception e) {
%>
            <div class="message error">
                <h2>Error</h2>
                <p><%= e.getMessage() %></p>
            </div>
<%
        }
    } else {
%>
        <div class="message error">
            <h2>Invalid Input</h2>
            <p>Please enter a valid student number.</p>
        </div>
<%
    }
%>
</body>
</html>
