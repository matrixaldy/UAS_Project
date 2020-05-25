/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package beans;

import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.sql.*;
import jdbc.Koneksi;

/**
 *
 * @author matri
 */
@WebServlet (name = "validate", urlPatterns={"/validate"})
public class validate extends HttpServlet {
    protected void doPost (HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out=response.getWriter();
        HttpSession session = request.getSession();  
        try{
            Koneksi konek= new Koneksi();
            Connection conn = konek.bukaKoneksi();
            Statement st=conn.createStatement();
            if(request.getParameterMap().containsKey("btnLogin") == true) {
                String user = request.getParameter("user");
                String pass = request.getParameter("pass");
                String sql = "SELECT * FROM pegawai WHERE user='"+user+"' AND password='"+pass+"'";
                ResultSet res  = st.executeQuery(sql);
                if(res.next()) {
                    session.setAttribute("status", "pegawai");
                    RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
                    rd.forward(request, response);
                } else {
                    out.println("<script>alert('You have entered incorrect password')</script>");
                    RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
                    rd.include(request, response);
                }
            }
            
            if(request.getParameterMap().containsKey("btnRegister") == true) {
                String user = request.getParameter("user");
                String pass = request.getParameter("pass");
                String nama = request.getParameter("nama");
                String email = request.getParameter("email");
                String hp = request.getParameter("hp");
                String alamat = request.getParameter("alamat");
                
                String sql = "SELECT * FROM pegawai WHERE user='"+user+"'";
                ResultSet res  = st.executeQuery(sql);
                if(res.next()) {
                    out.println("<script>alert('Username sudah ada')</script>");
                    RequestDispatcher rd = request.getRequestDispatcher("register.jsp");
                    rd.include(request, response);
                } else {
                    String sql1 = "INSERT INTO pegawai(nama, alamat, nohp, email, user, password)"
                        + " VALUES('"+nama+"', '"+alamat+"', '"+hp+"', '"+email+"', '"+user+"', '"+pass+"')";
                    st.executeUpdate(sql1);
                    out.println("<script>window.alert('Registrasi Berhasil, Silahkan Login!!');"
                            + "window.location.href = 'index.jsp';</script>");
                }
            }
        } catch (SQLException ex) {
            out.print(ex);
        } finally {
            out.close();
        }
    }
}
