package control;

import java.io.IOException;
import java.sql.SQLException;
import java.text.Normalizer;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Vector;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.Sala;
import model.SalaFisica;
import model.SalaOnline;
import view.AppConfig;
import view.Mensaje;
import view.StringHelper;

@WebServlet("/salas")
public class ServletSalas extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("Doget Salas");
		try {
			HashMap<String, Sala> mapaSalas = Sala.getTodasLasSalasCargadas();
			HashMap<String, Sala> salasAMostrar = new HashMap<String, Sala>();

			// Obtener los parámetros de búsqueda de la solicitud HTTP
			String paramBuscar = request.getParameter("buscar");
			
			String paramModalidad = request.getParameter("m");
			String paramTematica = request.getParameter("t");
			String paramDificultad = request.getParameter("d");
			
			if(paramBuscar==null) { paramBuscar = "todas"; }
			if(paramTematica==null) { paramTematica = "todas"; }
			if(paramModalidad==null) { paramModalidad = "todas"; }
			if(paramDificultad==null) { paramDificultad = "todas"; }
			
			if (paramBuscar != null) {
				// normalizar(quitar acentos y poner minusculas)
				paramBuscar = StringHelper.normalizarTexto(paramBuscar);
			} else {
				paramBuscar = "todas";
			}

			// Iterar el mapa de salas cargadas y agregar las que cumplen los criterios de
			// búsqueda al mapa de salas a mostrar
			for (Map.Entry<String, Sala> entry : mapaSalas.entrySet()) {
				Sala sala = entry.getValue();

				// filtrar valor de busqueda
				if (paramBuscar != null) {
					if (!paramBuscar.equals("todas")) {
						// se tiene que normalizar el texto(minusculas y sin acentos)
						// si el nombre de la sala no contiene el parametro buscar, se salta esta sala
						String nombreSalaNormalizada = StringHelper.normalizarTexto(sala.getNombre());
						if (!nombreSalaNormalizada.contains(paramBuscar))
							continue;
					}
				}
				// filtrar valor de modalidad
				if (paramModalidad != null) {
					switch (paramModalidad) {
					case "online":
						if (!(sala instanceof SalaOnline)) {
							continue;
						}
						break;
					case "fisicas":
						if (!(sala instanceof SalaFisica)) {
							continue;
						}
						break;
					default:
					}
				}

				// filtrar valor de tematica
				if (paramTematica != null) {

					String tematicaNormalizada = StringHelper.normalizarTexto(sala.getTematica());
					// si el tematica de la sala no es igual el parametro tematica, se salta esta
					// sala
					if (!paramTematica.equals("todas") && !paramTematica.equals(tematicaNormalizada)) {
						continue;
					}
				}

				// filtrar valor de dificultad
				if (paramDificultad != null) {
					String dificultadNormalizada = StringHelper.normalizarTexto(sala.getDificultad());
					// si la dificultad de la sala no es igual el parametro dificultad, se salta
					// esta sala
					if (!paramDificultad.equals("todas") && !paramDificultad.equals(dificultadNormalizada)) {
						continue;
					}
				}

				// si pasa todos los filtros, se agrega al hashmap de las salas a mostrar
				salasAMostrar.put(entry.getKey(), sala);
			}

			// agregar los atributos al request
			request.setAttribute("mapaSalas", salasAMostrar);
			request.setAttribute("tematicasDisponibles", Sala.getTematicasCargadas());
			request.setAttribute("dificultadesDisponibles", Sala.getDificultadesCargadas());
			
			//establecer la url a otorgar como url previa
			String urlPrevia = "./salas?buscar=" + paramBuscar + "&m=" + paramModalidad + "&t="
					+ paramTematica + "&d=" + paramDificultad;
			
			System.out.println("ServletSalas urlprevia establecida = "+urlPrevia);
			HttpSession sesion = request.getSession();
			sesion.setAttribute("urlPrevia", urlPrevia);
			
			String rutaDestino = "index.jsp?sec=salas&buscar=" + paramBuscar + "&m=" + paramModalidad + "&t="
					+ paramTematica + "&d=" + paramDificultad;
			// Enviar la respuesta al usuario
			request.getRequestDispatcher(rutaDestino).forward(request, response);
		} catch (Throwable e) {
			e.printStackTrace();
			System.out.println("hubo un error en serv salas");
			request.getRequestDispatcher("index.jsp").forward(request, response);
		}
	}

	@Override
	public void init(ServletConfig config) throws ServletException {
		BilboSKP.cargarInfoSalas();
	}
}
