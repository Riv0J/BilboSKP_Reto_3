package model;

import java.util.HashMap;

public class SalaFisica extends Sala{
	private String direccion;
	private int telefono;
	//este hashmap contendra todas las salas fisicas disponibles
	private static HashMap<String, SalaFisica> salasFisicasCargadas = new HashMap<String, SalaFisica>();
	
	public SalaFisica(String idSala, String nombre, String dificultad, String tematica, String descripcion,
			int tiempoMax, int jugadoresMin, int jugadoresMax, int edad_recomendada, String direccion, int telefono) {
		super(idSala, nombre, dificultad, tematica, descripcion, tiempoMax, jugadoresMin, jugadoresMax,
				edad_recomendada);
		this.direccion = direccion;
		this.telefono = telefono;
	}

	public String getDireccion() {
		return direccion;
	}

	public void setDireccion(String direccion) {
		this.direccion = direccion;
	}

	public int getTelefono() {
		return telefono;
	}

	public void setTelefono(int telefono) {
		this.telefono = telefono;
	}

	public static void setSalasCargadas(HashMap<String, SalaFisica> salasPorCargar) {
		salasFisicasCargadas = salasPorCargar;
	}
	public static HashMap<String, SalaFisica> getSalasCargadas() {
		return salasFisicasCargadas;
	}
	public static void clearSalasCargadas() {
		salasFisicasCargadas.clear();
	}
	public static SalaFisica datosSalaFisica(String idSala) {
		SalaFisica salafisica = (SalaFisica) salasFisicasCargadas.get(idSala);
		return salafisica;
	}
}
