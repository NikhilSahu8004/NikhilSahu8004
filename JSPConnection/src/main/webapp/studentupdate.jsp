<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <title>Update Result</title>
  <style>
    body { font-family: Arial; background: #f9f9f9; text-align: center; padding-top: 60px; }
    .message {
      display: inline-block;
      padding: 20px;
      border-radius: 8px;
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
    String studname = request.getParameter("studname");
    String coursename = request.getParameter("coursename");

    if (studnumberStr != null && studname != null && coursename != null &&
        !studnumberStr.isEmpty() && !studname.isEmpty() && !coursename.isEmpty()) {
        try {
            int studnumber = Integer.parseInt(studnumberStr);

            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/presidencymca", "root", "Presidency1");

            PreparedStatement ps = con.prepareStatement("UPDATE student SET studname=?, coursename=? WHERE studnumber=?");
            ps.setString(1, studname);
            ps.setString(2, coursename);
            ps.setInt(3, studnumber);

            int rows = ps.executeUpdate();

            if (rows > 0) {
%>
              <div class="message success">
                <h2>Success</h2>
                <p>Student record updated successfully for student number <strong><%= studnumber %></strong>.</p>
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
        <p>Please fill in all fields.</p>
      </div>
<%
    }
%>
</body>
</html>
