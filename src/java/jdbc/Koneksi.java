package jdbc;


import com.mysql.jdbc.*;
import java.sql.DriverManager;
import java.sql.SQLException;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author matri
 */
public class Koneksi {
    public Connection bukaKoneksi()throws SQLException{
        Connection connect;
        try{
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            connect = (Connection) DriverManager.getConnection("jdbc:mysql://localhost:3306/uas_jwp", "root", "");
            return connect;
        } catch (Exception e) {
            
        }
        return null;
    }
}
