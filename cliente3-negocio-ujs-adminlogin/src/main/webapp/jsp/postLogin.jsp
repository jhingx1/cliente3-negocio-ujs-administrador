<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<h1>Post Login</h1>

	<h2>Request</h2>
	<%="usuario: "+request.getAttribute("usuario") +" contraseņa" + request.getAttribute("contrasena")%>
	<h2>Sesion</h2>
	<%="usuario: "+session.getAttribute("usuario") +" contraseņa" + session.getAttribute("contrasena")%>
	<h2>Contexto</h2>	
	<%="usuario: "+application.getAttribute("usuario") +" contraseņa" + application.getAttribute("contrasena")%>
	 
</body>
</html>