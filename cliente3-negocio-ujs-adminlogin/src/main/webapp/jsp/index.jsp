<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<!-- Latest compiled and minified CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
	integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u"
	crossorigin="anonymous">

<!-- Optional theme -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css"
	integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp"
	crossorigin="anonymous">

<!-- <script src="js/lib/jquery-2.1.4.min.js"></script> -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<!-- Latest compiled and minified JavaScript -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"
	integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa"
	crossorigin="anonymous"></script>

<style type="text/css">

	.login{	    	    
	    margin: 10px auto;	    
	}

</style>

<title>Administrador</title>
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
                 <li class="active"><a href="?accion=principal">Inicio</a></li>
                 <li class="dropdown">
                   <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Categorias <span class="caret"></span></a>
                   <ul class="dropdown-menu" role="menu">
                       <li><a href="#">Categoria 1</a></li>
                       <li><a href="#">Categoria 2</a></li>
                       <li><a href="#">Categoria 3</a></li>
                       <li role="separator" class="divider"></li>
                       <li class="dropdown-header">Nav header</li>
                       <li><a href="#">Categoria 3</a></li>
                       <li><a href="#">One more separated link</a></li>
                   </ul>
                   </li>
                 <li><a href="#">Blog</a></li>
                 <li><a href="#">Contacto</a></li>                  
               </ul>

               <ul class="nav navbar-nav navbar-right">
		      <li><a href="#"><span class="glyphicon glyphicon-user"></span> <%=session.getAttribute("usuario") %> </a></li>
		      <li><a href="?accion=logout"><span class="glyphicon glyphicon-log-out"></span> Salir</a></li>
		    </ul>
               
             </div><!--/.nav-collapse -->
           </div><!--/.container-fluid -->
         </nav>

       </header>
       
      <section class="jumbotron">            
          <div class="container">            
              <h1 class="titulo-blog">Gestion Administradores</h1>
              <p>Pagina de Administracion de Usuarios</p>
          </div>                            
      </section>
      
	 <div class="container">
		<div class="row login">
			<div class="panel-group">
				<div class="panel panel-primary">
					 <div class="panel-heading">
	                       	Opciones - Administradores
	                    </div>
	                    <div class="panel-body">
	                   						
							<p><a href="?accion=registroAdmin">Registrar Administrador</a></p>
							<p><a href="?accion=consultarAdministradores">Consultar Administradores</a></p>
							<p><a href="?accion=registroPregunta">Registrar pregunta</a></p>
							<p><a href="?accion=envioCorreo">Enviar Correo - Electronico</a></p>															
	                    </div>                    
				</div>				
			</div>
		</div>
	</div>
	

</body>
</html>