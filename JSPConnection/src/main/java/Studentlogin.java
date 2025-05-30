import java.io.*;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.sql.*;

@SuppressWarnings("serial")
public class Studentlogin extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("user");
        String password = request.getParameter("pwd");

        boolean isValid = false;

        try {
           
            Class.forName("com.mysql.cj.jdbc.Driver");

            
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/presidencymca",
 	               "root", "Presidency1");

            
            PreparedStatement ps = con.prepareStatement("SELECT * FROM users WHERE username=? AND password=?");
            ps.setString(1, username);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                isValid = true;
            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        
        if (isValid) {
            request.setAttribute("username", username);
            RequestDispatcher rd = request.getRequestDispatcher("databaseconnection2.jsp");
            rd.forward(request, response);
        } else {
            request.setAttribute("error", "Invalid username or password.");
            RequestDispatcher rd = request.getRequestDispatcher("login.html");
            rd.forward(request, response);
        }
    }
}
