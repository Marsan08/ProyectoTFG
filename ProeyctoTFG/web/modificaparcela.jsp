<%-- 
    Document   : modificaparcela
    Created on : 09-may-2021, 22:31:31
    Author     : Luis
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head><%
        session = request.getSession();
        String sessionId = session.getId();
        if ((Boolean) session.getAttribute("usuarioValido")) {
            
    %>
    <body>
        <%      
            int idparcela = (Integer) session.getAttribute("idparcela");
            int hectareas = (Integer)session.getAttribute("hectareas");
            String nombreprop = (String) session.getAttribute("nombreprop");
            String nombrestado = (String) session.getAttribute("nombrestado");
            String nombretipo = (String) session.getAttribute("nombretipo");
            int referencia = (Integer) session.getAttribute("referencia");        
                        
        
             
        %>

        <h1>Modificar estado de la parcela</h1> 
        <form action="controlador" method="POST">
            <input type="hidden" name="todo" value="ejecutarUpdateParcela">
            <table border="1" width="2" cellspacing="2" cellpadding="2">
                <thead>
                    <tr>

                        <th>ID de la parcela</th>
                        <th>Hectáreas de la parcela</th>
                        <th>ID propietario</th>
                        <th>Tipo de parcela</th>
                        <th>Referencia</th>
                        <th>ID estado</th>

                </thead>
                <tbody> 
                    
                    <tr>

                    <td><%=idparcela%></td>
                    <td><%=hectareas%></td>
                    <td><%=nombreprop%></td>
                    <td><%=nombretipo%></td>
                    <td><%=referencia%></td>
                        <td><select name="idestado">


                                <%  

                                    Connection conn2 = controladores.Toolbox.Conexion();
                                    Statement stmt2 = conn2.createStatement();
                                    String sql = "select * from estado";
                                    ResultSet rset2 = stmt2.executeQuery(sql);

                                    while (rset2.next()) {

                                %>

                                <option value="<%=rset2.getInt("idestado")%>"><%= rset2.getString("nombrestado")%></option>

                                <% }
                                    rset2.close();
                                    stmt2.close();
                                    conn2.close();
                                %>                            </select>
                        </td>
                    </tr>
                </tbody>
            </table>

            <%
                //Cierre de recursos 

            %>
            <input type="submit" value="Cambiar estado">

        </form>
        <% } else { %>
        <h1>NO TIENES ACCESO</h1>
        <a href="index.jsp">Inicio</a>
        <% }%>
    </body>

</html>