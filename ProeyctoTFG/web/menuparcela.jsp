<%@page import="java.sql.*" %>  

<%
    session = request.getSession();
    String sessionId = session.getId();
    String user = (String) session.getAttribute("usuario");
    String pass = (String) session.getAttribute("contra");
    request.getAttribute("contra");
    if ((Boolean) session.getAttribute("usuarioValido")) {
        if (controladores.Toolbox.rol(user, pass) == 1) {
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Men�</title>
    </head>

    <body>
        <header><p>Bienvenido propietario <%= user%> </p><div><nav>AQUI VIENE EL NAVEGADOR</nav></div></header>


        <%
           Connection conn = controladores.Toolbox.Conexion();

            Statement stmt = conn.createStatement();

            String sqlStr = "SELECT * FROM parcela INNER JOIN propietario ON parcela.idpropietario = propietario.idpropietario INNER JOIN tipoparcela ON parcela.idtipoparcela = tipoparcela.idtipoparcela + tipoparcela.nombretipo INNER JOIN estado ON parcela.idestado = estado.idestado + estado.nombrestado";

            System.out.println("La consulta sql es " + sqlStr);

            ResultSet rset = stmt.executeQuery(sqlStr);
            
            
        %> 
        <h1>Parcelas</h1>
        <table border="1" width="2" cellspacing="2" cellpadding="2">
            <thead>
                <tr>

                    <th>ID de la parcela</th>
                    <th>Hect�reas de la parcela</th>
                    <th>ID propietario</th>
                    <th>ID estado</th>
                    <th>Tipo de parcela</th>
                    <th>Referencia</th>
                    <th>Modificar</th>
                    <th>Borrar</th>
                </tr>
            </thead>
            <tbody> 
                <%
                    while (rset.next()) {
                        session.setAttribute("idparcela", rset.getInt("idparcela"));
                        session.setAttribute("hectareas", rset.getInt("hectareas"));
                        session.setAttribute("nombreprop", rset.getString("propietario.nombre"));
                        session.setAttribute("nombrestado", rset.getString("estado.nombrestado"));
                        session.setAttribute("nombretipo", rset.getString("tipoparcela.nombretipo"));
                        session.setAttribute("referencia", rset.getInt("referencia"));
                        
                %>
                <tr>
                    
                    <td><%=rset.getInt("idparcela")%></td>
                    <td><%=rset.getInt("hectareas")%></td>
                    <td><%=rset.getString("propietario.nombre")%></td>
                    <td><%=rset.getString("estado.nombrestado")%></td>
                    <td><%=rset.getString("tipoparcela.nombretipo")%></td>
                    <td><%=rset.getInt("referencia")%></td>
                    <td><form action="controlador" method="post"><input type="hidden" value="modificarparcela" name="todo"><input type="hidden" value='<%=rset.getInt("idparcela")%>' name="idparcela"><input type="submit" value="Modificar"></form></td>
                        <td><form action="controlador" method="post"><input type="hidden" value="ejecutarbparcela" name="todo"><input type="hidden" value='<%=rset.getInt("idparcela")%>' name="idparcela"><input type="submit" value="Borrar"></form></td>
                </tr>

                <%

                    }
                %>
            </tbody>
        </table>

        <%
            //Cierre de recursos 
            rset.close();
            stmt.close();
            conn.close();

        %>
        
        <form action="controlador" method="post" id="irinsertparcela">
        
                    
                   
                    <input type="hidden" value="irinsertparcela" name="todo"/>
                    <input type="submit" value="Insertar otra parcela">
                   
        
                </form>

        <form action="controlador" method="post">

            <input type="hidden" value="menu" name="menu">
            <input type="submit" value="MENU">
        </form>


    </body>

</html>


<% } else if (controladores.Toolbox.rol(user, pass) == 2) {
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Men�</title>
    </head>

    <body>
        <header><p>Bienvenido administrador <%= user%> </p></header>


        <form action="controlador" method="post">

            <input type="hidden" value="menu" name="todo">
            <input type="submit" value="Volver al men�">
        </form>


    </body>

</html>

<% } else {%>


<html>

    <body>

    <head>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Error de acceso</title>

    </head>

    <h1>No tienes permisoshhh <%=  user%>  </h1>
    <a href="index.jsp">Inicio</a>

</body>




</html>


<% }
} else { %>

<html>

    <body>

    <head>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Error de acceso</title>

    </head>

    <h1>El usuario no es valido.</h1>
    <a href="index.jsp">Inicio</a>

</body>




</html>


<% }%>
