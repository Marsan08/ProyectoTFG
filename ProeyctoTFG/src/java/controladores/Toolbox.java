package controladores;

import com.mysql.jdbc.Connection;
import com.mysql.jdbc.Statement;
import java.sql.DriverManager;

import java.sql.PreparedStatement;
import java.sql.ResultSet;

import java.sql.SQLException;

import javax.swing.JOptionPane;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 *
 * @author DAW208
 */
public class Toolbox {
    //login y contraseña utilizados para la conectarse a la base de datos
    private static String loginBD = "admin";
    private static String passwordBD = "1234";
    
    /**
     * metodo que realiza la conexion a la base de datos gestionParcelas
     * @return una conexion a la base de datos gestionParcelas
     * @throws ClassNotFoundException
     * @throws InstantiationException
     * @throws IllegalAccessException
     * @throws SQLException 
     */
    private static Connection realizaConexion() throws ClassNotFoundException, InstantiationException, IllegalAccessException, SQLException {
        Class.forName("com.mysql.jdbc.Driver").newInstance();
        String url = "jdbc:mysql://localhost/gestionparcelas";
        return (Connection) DriverManager.getConnection(url, loginBD, passwordBD);
    }
    
    public static boolean validacion(String user, String pass) {
        java.sql.Connection conn = null;
        java.sql.Statement stmt = null;
        try {
            conn=realizaConexion();
            stmt = (Statement) conn.createStatement();
            String sqlStr = "SELECT * FROM usuario where nombre='" + user + "' and pass='" + pass + "';";
            //PARA DEPURACIÓN
            System.out.println("La consulta sql es " + sqlStr);
            //Ejecutar la sentencia SQL a través de los objetos Statement 
            ResultSet rset = stmt.executeQuery(sqlStr);

            while (rset.next()) {
                return true;
            }

            // Cerramos el resto de recursos
            if (stmt != null) {
                stmt.close();
            }
            if (conn != null) {
                conn.close();
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return false;
    }
    
    public static int rol(String user, String pass) {
        Connection conn = null;
        Statement stmt = null;
        int validar = 0;
        int id = 0;
        try {
            conn=realizaConexion();
            stmt = (Statement) conn.createStatement();
            String sqlStr = "SELECT * FROM usuario WHERE nombre='" + user + "' and pass='" + pass + "'";
            ResultSet rset = stmt.executeQuery(sqlStr);

            while (rset.next()) {
                id = rset.getInt("idusuario");
                System.out.println(id);
            }
            sqlStr = "SELECT * FROM usuario WHERE idusuario = '" + id + "'";
            rset = stmt.executeQuery(sqlStr);
            while (rset.next()) {
                validar = rset.getInt("idrol");
                System.out.println("ENTRA");
            }

            if (stmt != null) {
                stmt.close();
            }
            if (conn != null) {
                conn.close();
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            System.out.println("NO ENTRA");
        }
        return validar;

    }

    public static int idUser(String user) {

        Connection conn = null;
        Statement stmt = null;
        int validar = 0;
        int id = 0;
        try {
            conn=realizaConexion();
            stmt = (Statement) conn.createStatement();
            String sqlStr = "SELECT * FROM usuario WHERE nombre='" + user + "'";
            ResultSet rset = stmt.executeQuery(sqlStr);

            while (rset.next()) {
                id = rset.getInt("idusuario");
                System.out.println(id);
            }
            sqlStr = "SELECT * FROM usuario WHERE nombre='" + user + "'";
            rset = stmt.executeQuery(sqlStr);
            while (rset.next()) {
                validar = rset.getInt("idusuario");
                System.out.println("ENTRA");
            }

            if (stmt != null) {
                stmt.close();
            }
            if (conn != null) {
                conn.close();
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            System.out.println("NO ENTRA");
        }
        return validar;

    }

    public static int idProp(int iduser) {

        Connection conn = null;
        Statement stmt = null;
        int validar = 0;
        int id = 0;
        try {

            conn=realizaConexion();
            stmt = (Statement) conn.createStatement();

            String sqlStr = "SELECT * FROM propietario WHERE idusuario='" + iduser + "';";
            ResultSet rset = stmt.executeQuery(sqlStr);

            while (rset.next()) {
                validar = rset.getInt("idpropietario");
                System.out.println("ENTRA");
            }

            if (stmt != null) {
                stmt.close();
            }
            if (conn != null) {
                conn.close();
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            System.out.println("NO ENTRA");
        }
        return validar;

    }

    public static Connection Conexion() throws ClassNotFoundException, InstantiationException, SQLException {

        Connection conn = null;
        Statement stmt = null;
        try {
            //Paso 1: Cargar el driver JDBC.
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            // Paso 2: Conectarse a la Base de Datos utilizando la clase Connection
            String userName = "admin";
            String password = "admin";
            //URL de la base de datos(equipo, puerto, base de datos)
            String url = "jdbc:mysql://localhost/gestionparcelas";
            conn = (Connection) DriverManager.getConnection(url, userName, password);
        } catch (Exception ex) {
            ex.printStackTrace();
        }

        return conn;
    }

    public static String getNextPage(String estado) {
        String nextPage = "";
        if (estado == null) {
            nextPage = "/index.jsp";
        } else if (estado.equals("menu")) {
            nextPage = "/menu.jsp";
        } else if (estado.equals("gestionusuarios")) {
            nextPage = "/menusuario.jsp";
        } else if (estado.equals("gestionespecies")) {
            nextPage = "/menuespecie.jsp";
        } else if (estado.equals("gestionparcelas")) {
            nextPage = "/menuparcela.jsp";
        } else if (estado.equals("modificarusuario")) {
            nextPage = "/modificaUsuario.jsp";
        } else if (estado.equals("irinsertespecie")) {
            nextPage = "/insertarespecies.jsp";
        } else if (estado.equals("irinsertparcela")) {
            nextPage = "/insertarparcela.jsp";
        } else if (estado.equals("modificarparcela")) {
            nextPage = "/modificaparcela.jsp";
        }
        return nextPage;
    }

    public int existeUsuario(String usuario) throws SQLException {
        PreparedStatement ps = null;
        ResultSet rs = null;
        Connection con = getConexion();
        String sql = "SELECT count(id) FROM usuarios WHERE usuario = ?";

        try {
            ps = con.prepareStatement(sql);
            ps.setString(1, usuario);
            rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt(1);
            }

            return 1;

        } catch (SQLException e) {
            JOptionPane.showMessageDialog(null, e.toString());
            return 1;
        } finally {
            con.close();
        }
    }

    private Connection getConexion() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

}