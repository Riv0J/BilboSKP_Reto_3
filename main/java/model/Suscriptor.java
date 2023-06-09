package model;

import java.util.Date;

public class Suscriptor {
	private int idSuscriptor, telefono;
	private String email, alias, nombre, apellidos, imagen;
	private int activo;
	private Date fech_nac;
	private String fecha_string;
	
	//constructor la fecha es un string
	public Suscriptor( int telefono, String email, String alias, String nombre,
			String apellidos, String fech_nac) {
		super();
	
		setTelefono(telefono);
		setEmail(email);
		setAlias(alias);
		setNombre(nombre);
		setApellidos(apellidos);	
		setfecha_string(fecha_string);
		System.out.println(fecha_string);
	}
	
	//Fecha STRING
	public String getfecha_string() {
		return fecha_string;
	}

	public void setfecha_string(String fecha_string) {
		this.fecha_string= fecha_string;
	}
	
	
	
	public Suscriptor(int idSuscriptor, int telefono, String email, String alias, String nombre,
			String apellidos, String imagen, int activo, Date fech_nac) {
		super();
		setIdSuscriptor(idSuscriptor);
		setTelefono(telefono);
		setEmail(email);
		setAlias(alias);
		setNombre(nombre);
		setApellidos(apellidos);
		setImagen(imagen);
		setActivo(activo);
		setFech_nac(fech_nac);
	}

	public int getIdSuscriptor() {
		return idSuscriptor;
	}

	public void setIdSuscriptor(int idSuscriptor) {
		this.idSuscriptor = idSuscriptor;
	}

	public int getTelefono() {
		return telefono;
	}

	public void setTelefono(int telefono) {
		this.telefono = telefono;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}


	public String getAlias() {
		return alias;
	}

	public void setAlias(String alias) {
		this.alias = alias;
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public String getApellidos() {
		return apellidos;
	}

	public void setApellidos(String apellidos) {
		this.apellidos = apellidos;
	}

	public String getImagen() {
		return imagen;
	}

	public void setImagen(String imagen) {
		this.imagen = imagen;
	}

	public int getActivo() {
		return activo;
	}

	public void setActivo(int activo) {
		this.activo = activo;
	}

	public Date getFech_nac() {
		return fech_nac;
	}

	public void setFech_nac(Date fech_nac) {
		this.fech_nac = fech_nac;
	}
	
	

}
