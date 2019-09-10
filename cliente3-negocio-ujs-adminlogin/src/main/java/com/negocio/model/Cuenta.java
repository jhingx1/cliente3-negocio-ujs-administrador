package com.negocio.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

import com.negocio.beans.Administrador;

public class Cuenta {

	private Connection con;
	private static final Logger log = LogManager.getLogger("Cuenta : ");
	
	// conexion
	public Cuenta(Connection con) {
		this.con = con;
	}	

	public boolean login(String email, String contrasena) {
		String sql = "select count(*) as count from administrador where email = ? and contrasena = ?";
		int cta = 0;

		try {
			PreparedStatement st = con.prepareStatement(sql);
			st.setString(1, email);
			st.setString(2, contrasena);

			// almacenar la consulta
			ResultSet rs = st.executeQuery();
			// verificando si la consutla tiene filas
			if (rs.next()) {
				cta = rs.getInt("count");
			}

			rs.close();
		} catch (Exception e) {
			log.error("Error al realizar un login : " + e.getMessage());
			return false;
		}
		
		if(cta == 0){
			return false;
		}else {
			return true;
		}

	}
	
	//Debuelve un arrayList con los objetos de tipo administrador
		public ArrayList<Administrador> consultarAdministradores() {

			// creando un arrayalist que aceptar objetos de tipo administradores
			ArrayList<Administrador> administradores = new ArrayList<Administrador>();

			String sql = "select * from administrador";

			try {
				PreparedStatement st = con.prepareStatement(sql);

				ResultSet rs = st.executeQuery();

				// este tiene valores y necesitamos atrapar varios valores
				// hay que iterar en las filas
				while (rs.next()) {

					// creando una instancia de administradores
					// este ojteto guarda los datos de una fila de base de datos
					Administrador administrador = new Administrador(
							rs.getString("email"), 
							rs.getString("contrasena"),
							rs.getString("nombre"), 
							rs.getString("respuesta"), 
							rs.getString("urlImagen"),
							rs.getInt("id"));

					// agregando a el arrayList
					// este arrayList tendra a los tres administradores
					administradores.add(administrador);

				}
				rs.close();
			} catch (SQLException e) {
				// si ubo una excepcion debo de borrar todo lo que esta en el
				// arrayList
				administradores.clear();
				e.printStackTrace();
				log.error("Al consultar administradores " + e.getMessage());
			}
			return administradores;
		}
	
		public int obtenerIdAdmin(String emailAdmin){
			
			String sql = "select idAdmin from administrador where email = ?";
			
			try {
				PreparedStatement st = con.prepareStatement(sql);
				st.setString(1, emailAdmin);
				ResultSet rs = st.executeQuery();
				
				if(rs.next()){
					return rs.getInt("idAdmin");
				}else{
					return 0;
				}
								
			} catch (SQLException e) {			
				e.printStackTrace();
				return 0;
			}
			
		}
		
		public boolean registrarAdministrador(Administrador administrador){
			String sql = "insert into administrador(email,contrasena,nombre,respuesta,urlImagen,id) values(?,?,?,?,?,?)";		
			
			try {
				PreparedStatement st = con.prepareStatement(sql);
				st.setString(1,administrador.getEmail());
				st.setString(2,administrador.getContrasena());
				st.setString(3,administrador.getNombre());
				st.setString(4,administrador.getRespuesta());
				st.setString(5,administrador.getUrlImagen());
				st.setInt(6,administrador.getId());
				
				st.executeUpdate();
				st.close();
				
				return true; //si todo va bien
				
			} catch (SQLException e) {
				log.error("Error al registrar administradores " + e.getMessage());
				e.printStackTrace();
				return false;
			}
		}
		
		public boolean existeAdministrador(String email){
			String sql = "select * from administrador where email = ?";
			
			try {						
				PreparedStatement st = con.prepareStatement(sql);
				st.setString(1, email);
				ResultSet rs = st.executeQuery();
				
				if(rs.next()){	//coloca el cursor atraz del dato.			
					return true;				
				}else{
					return false;
				}			
			} catch (SQLException e) {
				log.error("Al consultar existencia de administrador" + e.getMessage());
				e.printStackTrace();
				return false;
			}

		}
		
}
