package com.negocio.controlador;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import org.apache.log4j.BasicConfigurator;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

import com.negocio.beans.Administrador;
import com.negocio.model.Cuenta;
import com.negocio.util.ManejadorCorreos;
import com.negocio.util.VerificarRecaptcha;

public class Servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private static final Logger log = LogManager.getLogger("Servlet : ");

	// conexion con la vista
	private DataSource ds;
	private Connection con;

	private String rutaJsp;

	@Override
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		rutaJsp = config.getInitParameter("rutaJsp");

		BasicConfigurator.configure();

		// Para usar la conexion de JNDI sin necesidad de conocer el usuario y
		// contraseña
		try {
			InitialContext initContext = new InitialContext();
			Context env = (Context) initContext.lookup("java:comp/env");

			ds = (DataSource) env.lookup("jdbc/novellius");
		} catch (NamingException e) {
			log.error("Al configurar JNDI" + e.getMessage());
		}

	}

	public RequestDispatcher setRespuestaControlador(String vista) {
		String url = rutaJsp + vista + ".jsp";
		return getServletContext().getRequestDispatcher(url);
	}

	public Servlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String accion = request.getParameter("accion");
		
		//Creando un session - luego la vamos a destruir
		HttpSession sesion = request.getSession();
		
		//Creando la conexion con el model-dao DB
		try {
			con = ds.getConnection();
		} catch (SQLException e) {
			//Enviar a una vista de error
			log.error("Error al crear conexion "  + e.getMessage());
		}

		if (accion != null) {

			if (accion.equals("login")) {
				setRespuestaControlador(accion).forward(request, response);
			} else if (accion.equals("inicio")) {
				getServletContext().getRequestDispatcher("/jsp/index.jsp").forward(request, response);
			} else if (accion.equals("logout")) {  //para destruir la sesscion.
				sesion.invalidate();
				log.info("sesion destruida");
				setRespuestaControlador("principal").forward(request, response);
			}else if(accion.equals("consultarAdministradores")){
				//Cuenta cuenta = new Cuenta(con); se puede simplificar con la instanciacion anonima
				ArrayList<Administrador> administradores = new Cuenta(con).consultarAdministradores();
				
				if(administradores.isEmpty()){//si esta vacio
					request.setAttribute("mensaje", "No se encotraron administradores");
				}else{
					//esto se colocara en el ambito_scopes(que existen 3) de una sesion					
					request.setAttribute("mensaje", "Administradores encontrados");		
					//para comunicarlo con la vista jsp atraves de la session, para luego iterarlos
					sesion.setAttribute("administradores", administradores);		
				}
				
				//redirigiendo a una pagina jsp, asi no encuetre administradores.				
				setRespuestaControlador("consultaAdministradores").forward(request, response);
				
			}else if(accion.equals("registroPregunta")){
				setRespuestaControlador(accion).forward(request, response);
			}else if(accion.equals("registrarPregunta")){
				setRespuestaControlador(accion).forward(request, response);
			}else if(accion.equals("envioCorreo")){
				setRespuestaControlador(accion).forward(request, response);
			}else if(accion.equals("registroAdmin")){
				setRespuestaControlador(accion).forward(request, response);
			}
		} else {
			getServletContext().getRequestDispatcher("/jsp/principal.jsp").forward(request, response);			
		}

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		//Para que respete las tildes, el correo electronico
		request.setCharacterEncoding("UTF-8");

		String accion = request.getParameter("accion");
		
		//variable para la sesion
		HttpSession sesion = request.getSession();

		// creando la conexion
		try {
			con = ds.getConnection();
		} catch (Exception e) {
			log.error("Error al crear la conexion" + e.getMessage());
		}

		if (accion != null) {
			if (accion.equals("iniciarSession")) {

				String usuario = request.getParameter("usuario");
				String contrasena = request.getParameter("contrasena");
				
				//COOKIE
				try {
					//si esta marcado
					if(request.getParameter("ckbox").equals("on")){
						//creamos un cookie
						Cookie cookie = new Cookie("usuario",usuario);
						cookie.setMaxAge(60*60*24); //timepo de vida
						response.addCookie(cookie);
						log.info("Cookie creada");
					}
				} catch (NullPointerException e) {
					log.info("No marco el check");
					//mejorar el codigo para el cookie
				}
				
				Cuenta cuenta = new Cuenta(con);
				if(cuenta.login(usuario, contrasena)){
					
					log.info("Ingresado correctamente como: " +  usuario);
					
					sesion.setAttribute("usuario", usuario);
					sesion.setAttribute("contrasena", contrasena);
					
					//obteniendo el id del administrador para usarlo en el filter
					sesion.setAttribute("id",new Cuenta(con).obtenerIdAdmin(usuario));
					
					setRespuestaControlador("index").forward(request, response);
					
				}else{					
					log.error("error login");
					//error en la amisma pagina
					request.setAttribute("error", "Nombre de usuario o Contraseña incorrectos");
					setRespuestaControlador("inicio").forward(request, response);
				}

			}else if(accion.equals("envioCorreo")){
				//para usar el metodo de la clase.
				ManejadorCorreos manejadorCorreos = new ManejadorCorreos();
				try {
					manejadorCorreos.enviarCorreo(request.getParameter("destino"),request.getParameter("mensaje"));
					log.info("Correo Enviado Correctamente");
					request.setAttribute("mensaje", "Correo Electronico enviado Correctamente");
				} catch (Exception e) {		
					log.error("Al enviar correo : "+ e.getMessage());
					e.printStackTrace();
					request.setAttribute("mensaje", "Error al Enviar Correo Electronico");
					//setRespuestaControlador("errorCorreo").forward(request, response);				
				}
				setRespuestaControlador("postEnvioCorreo").forward(request, response);
			}else if(accion.equals("registrarAdmin")){
				
				Administrador administrador = new Administrador();
				administrador.setEmail(request.getParameter("email"));
				administrador.setContrasena(request.getParameter("contrasena"));
				administrador.setNombre(request.getParameter("nombre"));
				administrador.setRespuesta(request.getParameter("respuesta"));
				
				
				if (sesion.getAttribute("urlImagen") != null) {
					//para cargar la imagen
					if (!sesion.getAttribute("urlImagen").equals("")) {
						administrador.setUrlImagen((String) sesion.getAttribute("urlImagen"));
					} 
				}
				administrador.setId(Integer.parseInt(request.getParameter("pregunta")));
				
				//para insertar un administrador
				Cuenta cuenta = new Cuenta(con);
				
				if (administrador.isValidAdministrador()) {
					//validando usuario
					if (!cuenta.existeAdministrador(request.getParameter("email"))) {
						if (cuenta.registrarAdministrador(administrador)) {//True si se pudo registra el admin
							log.info("Ingresado correctamente como: ");
							request.setAttribute("msg", "<span style='color:blue'>Administrador Creado Correctamente</span>");
						} else {
							log.error("El admin no fue creado");
							//error en la amisma pagina
							request.setAttribute("msg", "Error al crear el administrador");
						}
					} else {
						log.error("el admin ya fue creado");
						//error en la amisma pagina
						request.setAttribute("msg", "Admin. duplicado");
					} 
				}else{
					request.setAttribute("msg", administrador.getErroresForm());
				}
				
				//se queda en la misma pagina
				setRespuestaControlador("registroAdmin").forward(request, response);
				
			}else if(accion.equals("registrarPregunta")){
				
				String gRecaptchaResponse = request.getParameter("g-recaptcha-response");
		        System.out.println(gRecaptchaResponse);
		        
		        //el metodo verificar es un metodo estatico
		        //por eso puedo llamar solo con llamar a la clase.
		        boolean verificado = VerificarRecaptcha.verificar(gRecaptchaResponse);
		        System.out.println("captcha: " + verificado);
				
		        if(verificado){
		        	setRespuestaControlador(accion).forward(request, response);
		        }else{
		        	
		        	request.setAttribute("error", "*ReCapcha invalido Intentar Nuevamente");
		        	setRespuestaControlador("registroPregunta").forward(request, response);
		        }
			}
			
		}else {
			//redirigiendo hacia otra pagina
			//setRespuestaControlador("index.jsp").forward(request, response);
			setRespuestaControlador("login.jsp").forward(request, response);
		}

		// Liberando la conexion
		try {
			con.close();
		} catch (Exception e) {
			log.error("Error al cerrar la conexion" + e.getMessage());
		}
	}
}
