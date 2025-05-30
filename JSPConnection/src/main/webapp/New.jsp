<%@ page import="java.sql.*" %>
<html>
<head>
    <title>Database Connection Example</title>
    <style>
        table {
            border-collapse: collapse;
            width: 60%;
            margin: 20px auto;
        }
        th, td {
            border: 1px solid #555;
            padding: 8px;
            text-align: center;
        }
        th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
<%
   Connection con = null;
   Statement stmt = null;
   ResultSet rs = null;
   try {
      Class.forName("com.mysql.cj.jdbc.Driver");
      con = DriverManager.getConnection("jdbc:mysql://localhost:3306/presidencymca", "root", "Presidency1");
      stmt = con.createStatement();
      rs = stmt.executeQuery("SELECT * FROM faculty");

      out.println("<table>");
      out.println("<tr><th>Faculty ID</th><th>Faculty Name</th><th>Course Name</th></tr>");
      while(rs.next()) {
         out.println("<tr>");
         out.println("<td>" + rs.getInt(1) + "</td>");
         out.println("<td>" + rs.getString(2) + "</td>");
         out.println("<td>" + rs.getString(3) + "</td>");
         out.println("</tr>");
      }
      out.println("</table>");
   } catch (ClassNotFoundException e) {
      out.println("Driver not found: " + e.getMessage());
   } catch (SQLException e) {
      out.println("SQL Error: " + e.getMessage());
   } finally {
      try {
         if (rs != null) rs.close();
         if (stmt != null) stmt.close();
         if (con != null) con.close();
      } catch (SQLException e) {
         out.println("Closing Error: " + e.getMessage());
      }
   }
%>
</body>
</html>