package model;

import java.util.HashMap;
import java.util.Map;

import control.BilboSKP;

public class SalaOnline extends Sala{
	//este hashmap contendrá todas las salas online disponibles
	private static HashMap<Integer, SalaOnline> salasOnlineCargadas = new HashMap<Integer, SalaOnline>();
	private Escenario escenarioInicio;
	private int disponible;
	private HashMap<String,Escenario> mapaEscenarios = new HashMap<String,Escenario>();
	public SalaOnline(int idSala, String nombre, String dificultad, String tematica, String descripcion,
int tiempoMax, int jugadoresMin, int jugadoresMax, int edad_recomendada, Escenario escenarioInicio, HashMap<String,Escenario> mapaEscenarios, int disponible) {
		super(idSala, nombre, dificultad, tematica, descripcion, tiempoMax, jugadoresMin, jugadoresMax, edad_recomendada);
		setEscenarioInicio(escenarioInicio);
		setMapaEscenarios(mapaEscenarios);
		setDisponible(disponible);
	}
	public SalaOnline(int idSala, String nombre, String dificultad, String tematica, String descripcion) {
		super(idSala,nombre,dificultad,tematica,descripcion);
	}
	public static HashMap<Integer, SalaOnline> getSalasCargadas() {
		//si no hay salas online cargadas, trata de consultarlas de nuevo y establecerlas
		if (salasOnlineCargadas.size()==0) {
			try {
				BilboSKP.cargarSalasOnline();
			} catch (Throwable e) {
				e.printStackTrace();
			}
		}
		return salasOnlineCargadas;
	}
	public static void setSalasCargadas(HashMap<Integer, SalaOnline> salasPorCargar) {
		salasOnlineCargadas = salasPorCargar;
	}
	public static SalaOnline getSalaPorId(int idSalaOnline) {
		return salasOnlineCargadas.get(idSalaOnline);
	}
	public static void clearSalasCargadas() {
		salasOnlineCargadas.clear();
	}
	public Escenario getEscenarioInicio() {
		return escenarioInicio;
	}
	public void setEscenarioInicio(Escenario escenarioInicio) {
		if(escenarioInicio!=null) {
			System.out.println("ESCENARIO DE INICIO = "+escenarioInicio.getNombreEscenario());
		}
		this.escenarioInicio = escenarioInicio;
	}
	public HashMap<String,Escenario> getMapaEscenarios() {
		return mapaEscenarios;
	}
	public void setMapaEscenarios(HashMap<String,Escenario> mapaEscenarios) {
		this.mapaEscenarios = mapaEscenarios;
		/*System.out.println("Escenarios establecidos: ");
		for(Map.Entry<String, Escenario> par :mapaEscenarios.entrySet()) {
			System.out.println(par.getKey());
		}*/
	}
	public Escenario getEscenarioPorNombre(String nombreEscenario) {
		return mapaEscenarios.get(nombreEscenario);
	}
	public int getDisponible() {
		return disponible;
	}
	public void setDisponible(int disponible) {
		this.disponible = disponible;
	}
}
