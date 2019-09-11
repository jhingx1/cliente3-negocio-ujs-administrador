//https://www.youtube.com/watch?v=khuVsCc6ahE


$(document).ready(function(){
	
	 $.validator.addMethod('letras', function(value,element) 
	  {
	    return this.optional(element)|| /^[a-zA-Z]+$/i.test(value);
	  });
	
   $( "#frmadministrador" ).validate({
       rules: {
    	   email: {
               required: true,
               minlength: 4,
               email:true,
               maxlength: 20
           },
           contrasena: {
               required: true,
               minlength: 4,
               maxlength: 20
           },
           repcontrasena: {
               required: true,
               minlength: 4,
               maxlength: 20
           },
           nombre: {
               required: true,
               minlength: 4,
               maxlength: 20,
               letras:true
           },
           pregunta: {
               required: true,
               minlength: 4,
               maxlength: 20
           },
           respuesta: {
               required: true,
               minlength: 4,
               maxlength: 20
           },
           foto: {
               required: true,
               minlength: 4,
               maxlength: 20
           }
           
           
           
       },
       messages: {
    	   email: {
               required: "Completar Correo Electronico",
               email:"Escribir un Email Correcto",
               minlength: $.format("Necesitamos por lo menos {0} caracteres"),
               maxlength: $.format("{0} caracteres son demasiados!")
           },
           contrasena: {
               required: "Escriba un Password",
               minlength: $.format("Necesitamos por lo menos {0} caracteres"),
               maxlength: $.format("{0} caracteres son demasiados!")
           },
           repcontrasena: {
               required: "Repetir Password",
               minlength: $.format("Necesitamos por lo menos {0} caracteres"),
               maxlength: $.format("{0} caracteres son demasiados!")
           },
           nombre: {
               required: "Es necesario Nombre Completo",
               letras:"Solo se permiten Letras",
               minlength: $.format("Necesitamos por lo menos {0} caracteres"),
               maxlength: $.format("{0} caracteres son demasiados!")
           },
           pregunta: {
               required: "Elija una pregunta secreta",               
               minlength: $.format("Necesitamos por lo menos {0} caracteres"),
               maxlength: $.format("{0} caracteres son demasiados!"),
               
           },
           respuesta: {
               required: "Completar Respuesta",
               minlength: $.format("Necesitamos por lo menos {0} caracteres"),
               maxlength: $.format("{0} caracteres son demasiados!")
           },
           foto: {
               required: "Subir un Foto",
               minlength: $.format("Necesitamos por lo menos {0} caracteres"),
               maxlength: $.format("{0} caracteres son demasiados!")
           }
       		
       
       }
   });
});

