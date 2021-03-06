<%-- 
    Document   : modificaparcela
    Created on : 09-may-2021, 22:31:31
    Author     : Luis
--%>

<%@page import="java.util.Iterator"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    session = request.getSession();

    String user = (String) session.getAttribute("usuario");
    String pass = (String) session.getAttribute("contra");
    String sessionId = session.getId();
    if ((Boolean) session.getAttribute("usuarioValido")) {


%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Modifica parcela</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <link rel="stylesheet" href="css/css.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script> <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
        <style>
            /* Remove the navbar's default margin-bottom and rounded borders */ 
            .navbar {
                margin-bottom: 0;
                border-radius: 0;
            }

            /* Set height of the grid so .sidenav can be 100% (adjust as needed) */
            .row.content {height: 450px}

            /* Set gray background color and 100% height */
            .sidenav {
                padding-top: 20px;
                background-color: #f1f1f1;
                height: 100%;
            }

            /* Set black background color, white text and some padding */
            footer {
                background-color: #555;
                color: white;
                padding: 15px;
            }

            /* On small screens, set height to 'auto' for sidenav and grid */
            @media screen and (max-width: 767px) {
                .sidenav {
                    height: auto;
                    padding: 15px;
                }
                .row.content {height:auto;} 
            }
        </style>
    </head>

    <body>

        <%        if (controladores.Toolbox.rol(user, pass) == 1) {

                int iduser = ClasesBD.UsuarioBD.idUser(user);
                int idprop = ClasesBD.PropietarioBD.idProp(iduser);
                ClasesBD.PropietarioBD.cargarParcelas(idprop);

                int parcela = Integer.parseInt(request.getParameter("idparcela"));

                session.setAttribute("parcela", parcela);

                out.println("el id de la parcela es " + request.getParameter("idparcela"));


        %>




        <nav class="navbar navbar-inverse navbar-fixed-top" >
            <div class="container-fluid">
                <div class="navbar-header">
                    <a class="navbar-brand" href="#">Bienvenido <%=user%></a>
                </div>
                <ul class="nav navbar-nav">
                    <li><a href="menu.jsp">Inicio</a></li>
                    <li class="active"><a href="menuparcela.jsp">Parcelas</a></li>
                    <li><a href="menuespecies.jsp">Especies</a></li>
                    <li><a href="menuanimales.jsp">Animales</a></li>
                    <li><a href="menuplantaciones.jsp">Plantaciones</a></li>
                    <li><a href="menusuario.jsp">Usuarios</a></li>
                </ul>
                <ul
        </div>
    </nav>

    <div class="container-fluid text-center" style="margin-top: 100px; background-color: rgba(255, 255, 255, 0.8); padding: 30px;">    
        <div class="row content">

            <div class="col-sm-8 text-left"> 

                <div class="container" >

                    <div id="myCarousel" class="carousel slide" data-ride="carousel" style="width: 100%">
                        <!-- Indicators -->
                        <ol class="carousel-indicators">
                            <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
                            <li data-target="#myCarousel" data-slide-to="1"></li>
                            <li data-target="#myCarousel" data-slide-to="2"></li>
                        </ol>

                        <!-- Wrapper for slides -->
                        <div class="carousel-inner">

                            <div class="item active">
                                <img src="img/carrusel1.jpg" alt="Campo" style="width:100%;">
                                <div class="carousel-caption">

                                </div>
                            </div>

                            <div class="item">
                                <img src="img/carrusel2.jpg" alt="Vacas" style="width:100%;">
                                <div class="carousel-caption">

                                </div>
                            </div>

                            <div class="item">
                                <img src="img/carrusel3.jpg" alt="Vacas" style="width:100%;">
                                <div class="carousel-caption">

                                </div>
                            </div>

                        </div>

                        <!-- Left and right controls -->
                        <a class="left carousel-control" href="#myCarousel" data-slide="prev">
                            <span class="glyphicon glyphicon-chevron-left"></span>
                            <span class="sr-only">Anterior</span>
                        </a>
                        <a class="right carousel-control" href="#myCarousel" data-slide="next">
                            <span class="glyphicon glyphicon-chevron-right"></span>
                            <span class="sr-only">Siguiente</span>
                        </a>
                    </div>
                </div>



                <div class="centrar">
                    <div class="centrartabla">
                        <form action="controlador" method="POST">
                            <input type="hidden" name="todo" value="ejecutarUpdateParcela">
                            <h1 style="margin-top: 70px;">Modificar esta parcela</h1>
                            <table class="table table-hover">

                                <thead>
                                    <tr>


                                        <th>Hect??reas de la parcela</th>
                                        <th>ID propietario</th>
                                        <th>Tipo de parcela</th>
                                        <th>Referencia</th>
                                        <th>ID estado</th>

                                </thead>
                                <tbody> 

                                    <%
                                        out.println("<tr>");
                                        //out.println(parcela);
                                        out.println("<td>" + ClasesBD.ParcelaBD.sacarHectareas(parcela) + "</td>");
                                        out.println("<td>" + ClasesBD.ParcelaBD.sacarProp(parcela) + "</td>");
                                        out.println("<td>" + ClasesBD.TipoBD.getNombre(ClasesBD.ParcelaBD.sacarTipo(parcela)) + "</td>");
                                        out.println("<td>" + ClasesBD.ParcelaBD.sacarReferencia(parcela) + "</td>");

                                        out.println("<td> <select name='idestado'>");

                                        //CREAMOS UNA CONSULTA QUE SAQUE LOS ESTADOS COMO EN EL TIPO DE PARCELA
                                        if (ClasesBD.ParcelaBD.sacarTipo(parcela) == 1) {
                                            ClasesBD.EstadoBD.cargarEstadosA();
                                            for (int i = 0; i < ClasesBD.EstadoBD.estadosASize(); i++) {

                                                out.println("<option value=" + ClasesBD.EstadoBD.getIdA(i) + "> " + ClasesBD.EstadoBD.getNombreA(i) + "</option>");
                                            }

                                        } else if (ClasesBD.ParcelaBD.sacarTipo(parcela) == 2) {

                                            ClasesBD.EstadoBD.cargarEstadosG();
                                            for (int i = 0; i < ClasesBD.EstadoBD.estadosGSize(); i++) {

                                                out.println("<option value=" + ClasesBD.EstadoBD.getIdG(i) + "> " + ClasesBD.EstadoBD.getNombreG(i) + "</option>");

                                            }
                                        }

                                        out.println("</select></td>");
                                        out.println("</tr>");
                                    %>

                                </tbody>
                            </table>
                            <div class="insermenu" style="    display: flex;
                                 justify-content: center;
                                 align-items: center;
                                 flex-direction: row;
                                 align-content: center;
                                 flex-wrap: wrap;
                                 width: 100%;">
                                <input type="submit" name="enviar" value="Aceptar y cambiar" class="boton">
                            </div>
                        </form>

                        <form action="controlador" method="post">

                            <input type="hidden" value="menu" name="todo">
                            <input type="submit" value="Men?? principal" class="boton">
                        </form>

                    </div>
                </div>

            </div>
        </div>
    </div>

    <% } else if (controladores.Toolbox.rol(user, pass) == 2) {

        int idparcela = Integer.parseInt(request.getParameter("idparcela"));

        session.setAttribute("parcela", idparcela);

        

    %>


    <nav class="navbar navbar-inverse navbar-fixed-top">
        <div class="container-fluid">
            <div class="navbar-header">
                <a class="navbar-brand" href="#">Bienvenido <%=user%></a>
            </div>
            <ul class="nav navbar-nav">
                <li><a href="menu.jsp">Inicio</a></li>
                <li class="active" ><a href="menuparcela.jsp">Parcela</a></li>
                <li><a href="menuanimales.jsp">Animales</a></li>
                <li><a href="menuplantaciones.jsp">Plantaciones</a></li>

            </ul>
            <ul
    </div>
</nav>

<div class="container-fluid text-center" style="margin-top: 100px; background-color: rgba(255, 255, 255, 0.8); padding: 30px;">    
    <div class="row content">
        <div class="col-sm-8 text-left"> 

            <div class="container" >

                <div id="myCarousel" class="carousel slide" data-ride="carousel" style="width: 100%">
                    <!-- Indicators -->
                    <ol class="carousel-indicators">
                        <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
                        <li data-target="#myCarousel" data-slide-to="1"></li>
                        <li data-target="#myCarousel" data-slide-to="2"></li>
                    </ol>

                    <!-- Wrapper for slides -->
                    <div class="carousel-inner">

                        <div class="item active">
                            <img src="img/carrusel1.jpg" alt="Campo" style="width:100%;">
                            <div class="carousel-caption">

                            </div>
                        </div>

                        <div class="item">
                            <img src="img/carrusel2.jpg" alt="Vacas" style="width:100%;">
                            <div class="carousel-caption">

                            </div>
                        </div>

                        <div class="item">
                            <img src="img/carrusel3.jpg" alt="Vacas" style="width:100%;">
                            <div class="carousel-caption">

                            </div>
                        </div>

                    </div>

                    <!-- Left and right controls -->
                    <a class="left carousel-control" href="#myCarousel" data-slide="prev">
                        <span class="glyphicon glyphicon-chevron-left"></span>
                        <span class="sr-only">Anterior</span>
                    </a>
                    <a class="right carousel-control" href="#myCarousel" data-slide="next">
                        <span class="glyphicon glyphicon-chevron-right"></span>
                        <span class="sr-only">Siguiente</span>
                    </a>
                </div>
            </div>

            <div class="centrar">
                <div class="centrartabla">
                    <form action="controlador" method="POST">
                        <input type="hidden" name="todo" value="ejecutarUpdateParcela">
                        <h1 style="margin-top: 70px;">Modificar esta parcela</h1>
                        <br>
                        <table class="table table-hover">

                            <thead>
                                <tr>


                                    <th>Hect??reas de la parcela</th>
                                    <th>ID propietario</th>
                                    <th>Tipo de parcela</th>
                                    <th>Referencia</th>
                                    <th>ID estado</th>

                            </thead>
                            <tbody> 


                                <%      out.println("<tr>");
                                    out.println("<td>" + ClasesBD.ParcelaBD.sacarHectareas(idparcela) + "</td>");
                                    out.println("<td>" + ClasesBD.ParcelaBD.sacarProp(idparcela) + "</td>");
                                    out.println("<td>" + ClasesBD.TipoBD.getNombre(ClasesBD.ParcelaBD.sacarTipo(idparcela)) + "</td>");
                                    out.println("<td>" + ClasesBD.ParcelaBD.sacarReferencia(idparcela) + "</td>");

                                    out.println("<td> <select name='idestado'>");

                                    //CREAMOS UNA CONSULTA QUE SAQUE LOS ESTADOS COMO EN EL TIPO DE PARCELA
                                    if (ClasesBD.ParcelaBD.sacarTipo(idparcela) == 1) {
                                        ClasesBD.EstadoBD.cargarEstadosA();
                                        for (int i = 0; i < ClasesBD.EstadoBD.estadosASize(); i++) {

                                            out.println("<option value=" + ClasesBD.EstadoBD.getIdA(i) + "> " + ClasesBD.EstadoBD.getNombreA(i) + "</option>");
                                        }

                                    } else if (ClasesBD.ParcelaBD.sacarTipo(idparcela) == 2) {

                                        ClasesBD.EstadoBD.cargarEstadosG();
                                        for (int i = 0; i < ClasesBD.EstadoBD.estadosGSize(); i++) {

                                            out.println("<option value=" + ClasesBD.EstadoBD.getIdG(i) + "> " + ClasesBD.EstadoBD.getNombreG(i) + "</option>");

                                        }
                                    }

                                    out.println("</select></td>");
                                    out.println("</tr>");
                                %>
                            </tbody>
                        </table>
                        <div class="insermenu" style="    display: flex;
                             justify-content: center;
                             align-items: center;
                             flex-direction: row;
                             align-content: center;
                             flex-wrap: wrap;
                             width: 100%;">
                            <input type="submit" name="enviar" value="Aceptar y cambiar" class="boton">
                        </div>
                    </form>

                    <form action="controlador" method="post">

                        <input type="hidden" value="menu" name="todo">
                        <input type="submit" value="Men?? principal" class="boton">
                    </form>

                </div>
            </div>

        </div>
    </div>
</div>

<%} else { %>


<h1>NO TIENES ACCESO</h1>
<a href="index.jsp">Inicio</a>



<% }
} else {%>

<h1>NO TIENES ACCESO</h1>
<a href="index.jsp">Inicio</a>


</body>

</html>

<% }%>