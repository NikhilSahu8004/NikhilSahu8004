<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Database Connection</title>
</head>
<body>
  <%int uid;
	 String pwd;	 
	 Connection conn = null;
	try 
	       {
	         Class.forName("com.mysql.cj.jdbc.Driver");
	         conn = DriverManager.getConnection(
	               "jdbc:mysql://localhost:3306/presidencymca",
	               "root", "Presidency1");
	         PreparedStatement st = conn.prepareStatement("insert into users values(?, ?)");
	         st.setString(1, request.getParameter("user")); 
	         st.setString(2, request.getParameter("pwd"));
	          st.executeUpdate(); 
	          
	          out.println("<html><body><b>Successfully Inserted"
	                        + "</b></body></html>"); 
	       }
	      catch(Exception e)
	    {
	    	  out.println(e.getMessage());
	    }
	%>
</body>
</html>
