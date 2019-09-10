<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<!-- cliente2-negocio-Ujs-adminlogin : contexto de mi aplicacion -->
<!-- Importar resurso estatico -->
<!-- url:/cliente2-negocio-Ujs-adminlogin/js/ajax.js -->
	<script type="text/javascript" src='<c:url value="/js/ajax.js" />'></script> 
<!-- <script type="text/javascript" src='<c:url value="/js/jquery-1.8.2.min.js" />'></script> -->


<!-- Latest compiled and minified CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
	integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u"
	crossorigin="anonymous">

<!-- <script src="js/lib/jquery-2.1.4.min.js"></script> -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<!-- Optional theme -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css"
	integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp"
	crossorigin="anonymous">

<!-- Latest compiled and minified JavaScript -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"
	integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa"
	crossorigin="anonymous"></script>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Registro Admininistrador</title>

</head>
<body>

	<header>
	  <!-- Static navbar -->
      <nav class="navbar navbar-inverse navbar-static-top" role="navigation">
           <div class="container">

             <div class="navbar-header">
               <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navegacion-fm" aria-expanded="false" aria-controls="navbar">
                 <span class="sr-only">Desplegar / Ocultar Menu</span>
                 <span class="icon-bar"></span>
                 <span class="icon-bar"></span>
                 <span class="icon-bar"></span>
               </button>
               <a class="navbar-brand" href="#">Sistemas-UNAC</a>
             </div>

             <!-- Inicial Menu-->

             <div id="navegacion-fm" class="navbar-collapse collapse">
               <ul class="nav navbar-nav">
                 <li class=""><a href="#">Inicio</a></li>               
                 <li class="active"><a href="#">Registrar Admin</a></li>
                 <li><a href="#">Consultar Admin</a></li>
                 <li><a href="#">Registrar Pregunta</a></li>
                 <li><a href="#">Enviar Correo</a></li>                 
               </ul>

               <ul class="nav navbar-nav navbar-right">
		      <li><a href="#"><span class="glyphicon glyphicon-user"></span> <%=session.getAttribute("usuario") %> </a></li>
		      <li><a href="?accion=logout"><span class="glyphicon glyphicon-log-out"></span> Salir</a></li>
		    </ul>
               
             </div>
           </div>
         </nav>

    </header>

	<section class="jumbotron">            
        <div class="container">            
            <h1 class="titulo-blog">Registro de Administrador</h1>
            <p>Completar Formulario</p>            
        </div>                            
    </section>
    
    <c:out value="${requestScope.msg}"/> <br/>
    
    <div class="container">
       
      	   <div class="col-md-4">&nbsp;</div>
      	   <div class="col-md-4">
	       <form action="?accion=registrarAdmin" method="post">
	            <div class="form-group">
	                <label for="">Correo Electronico</label>
	                <input class="form-control input-sm" name="email" type="text" placeholder="Correo Electronico">
	                <label for="">Password</label>
	                <input class="form-control input-sm" id="contrasena" name="contrasena" type="password" placeholder="Password">
	                <label for="">Repite Password</label>
	                <input class="form-control input-sm"  type="text">
	                <label for="">Nombre completo</label>
	                <input class="form-control input-sm" name="nombre" type="text" placeholder="Nombre completo">
	                <label for="">Elige una pregunta secreta</label>
	                <!-- Manejo de excepciones --> 
					<c:catch var="ex">
						<!-- Para compartir la variables de admin para consutar a la tabla pregunta. -->
						<c:set var="id" value="${admin.id}" />
						<!-- Variable para conectarla con tb pregunta -->
						<sql:query var="rs" dataSource="jdbc/novellius">
							SELECT * from pregunta;
						</sql:query>
						<!-- iterar las filas que no debueve las filas -->
		                <select class="form-control" name="pregunta">
		                	<option value="">[--Seleccionar--]</option>
		                	<c:forEach var="row" items="${rs.rows}">
								<!-- nos debuelve todas las filas que esten incluidas en el datasource = rs -->								
							  	<option value="${row.id}">${row.pregunta}</option>
						  	</c:forEach>
						</select>
					</c:catch> 
					<c:if test="${ex != null }">
						<span style="color: red;"> * Error en la Conexion. </span>
					</c:if>

					<label for="">Respuesta de Pregunta Secreta</label>
	                <input class="form-control input-sm" name="respuesta" type="text" placeholder="Respuesta de Pregunta Secreta">
	                
	                <label for="">Seleccione una foto</label>
   					<input type="file" class="form-control" id="file">    					
   					<button type="button" value="cargar" onclick="cargarImagen()" class="btn btn-info btn-xs">Cargar</button>
   					<div id="respuesta" style="font-weight:bold"></div>

	            </div>                   

	            <div class="form-group">
	                <div class="">
	                    <button type="submit" value="Crear" class="btn btn-primary">Enviar</button>
	                </div>
	            </div>

	        </form>
        </div>
       
    </div>

</body>
</html>