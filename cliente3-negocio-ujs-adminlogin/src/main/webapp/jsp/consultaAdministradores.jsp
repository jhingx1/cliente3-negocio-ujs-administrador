<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<style type="text/css">
	table{
	  border-collapse: collapse;
	}
	
	table, th, td {
	  border: 1px solid black;
	}
</style>

<title>Insert title here</title>
</head>
<body>
	<h1>Consulta Administradores</h1>
	<br />
	<!-- Iteramos el arrayList -->

	<c:out value="${requestScope.mensaje}" />
	<br />
	<table>
		<tr>
			<td>Email</td>
			<td>Nombre Completo</td>
			<td>Pregunta Secreta</td>
			<td>Respuesta Secreta</td>
			<td>Foto</td>
		</tr>
		<c:forEach var="admin" items="${sessionScope.administradores}">
			<tr>
				<td>${admin.email}</td>
				<td>${admin.nombre}</td>
				<td>
					<!-- Manejo de excepciones --> <c:catch var="ex">
						<!-- Para compartir la variables de admin para consutar a la tabla pregunta. -->
						<c:set var="id" value="${admin.id}" />
						<!-- Variable para conectarla con tb pregunta -->
						<sql:query var="rs" dataSource="jdbc/novellius">
							SELECT id,pregunta from pregunta where id = id;
						</sql:query>

						<!-- iterar las filas que no debueve las filas -->
						<c:forEach var="row" items="${rs.rows}">
							<!-- nos debuelve todas las filas que esten incluidas en el datasource = rs -->
							<c:if test="${admin.id == row.id}">
								<c:out value="${row.pregunta}" />
							</c:if>
							<!-- <c:out value="${row.pregunta}"/> -->
						</c:forEach>
						<br />
					</c:catch> <c:if test="${ex != null }">
						<span style="color: red;"> * Error en la Conexion. </span>
					</c:if>
				</td>
				<td>${admin.respuesta}</td>
				<td><img src="<c:url value='${admin.urlImagen}'/>"></td>
			</tr>			

		</c:forEach>
	</table>
</body>
</html>