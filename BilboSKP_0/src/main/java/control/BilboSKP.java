package control;

import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Vector;
import java.text.SimpleDateFormat;
import java.time.LocalDate;

import connection.DBC;
import connection.SQLHelper;
import model.Cupon;
import model.Horario;
import model.Partida;
import model.PartidaOnline;
import model.Reserva;
import model.Sala;
import model.SalaFisica;
import model.SalaOnline;
import model.Suscriptor;

public class BilboSKP extends DBC {
	private static final String dbUrl = "localhost:3306/bilboskpdb";
	private static final String user = "bilboskp";
	private static final String pass = "bilboskp";
	private static boolean estadoRanking = true;

	public BilboSKP() throws Throwable {
		super(DBC.DRIVER_MYSQL, dbUrl, user, pass);
	}
	
	protected static void setEstadoRanking(boolean nuevoEstado) {
		estadoRanking = nuevoEstado;
	}
	protected static boolean getEstadoRanking() {
		return estadoRanking;
	}
	// conectarse a la BD y obtener todas las salas online @Rivo
	public static Vector<SalaOnline> getSalasOnline() throws Throwable {
		try {
			// crear el vector que vamos a devolver
			Vector<SalaOnline> vectorSalasOnline = new Vector<SalaOnline>();
			// hacer sentencia sql select todas las salas
			String sentenciaSQL = "select * from salaonline order by idSala;";
			// hacer una conexion
			BilboSKP conexion = new BilboSKP();
			ResultSet resultado = conexion.SQLQuery(sentenciaSQL);
			// hacer un bucle de cada fila que tiene el resultset
			while (resultado.next()) {
				// obtener los campos de cada columna para esta fila
				int idSala = resultado.getInt("idSala");
				String nombre = resultado.getString("nombre");
				String dificultad = resultado.getString("dificultad");
				String tematica = resultado.getString("tematica");
				String descripcion = resultado.getString("descripcion");
				int tiempoMax = resultado.getInt("tiempoMax");
				int jugadoresMin = resultado.getInt("jugadoresMin");
				int jugadoresMax = resultado.getInt("jugadoresMax");
				int edadRecomendada = resultado.getInt("edad_Recomendada");

				SalaOnline sala = new SalaOnline(idSala, nombre, dificultad, tematica, descripcion, tiempoMax,
						jugadoresMin, jugadoresMax, edadRecomendada);
				// agregar sala al vector
				vectorSalasOnline.add(sala);
			}

			// hacer syso de las salas obtenidas
			System.out.println("Salas obtenidas:");
			if (vectorSalasOnline.size() > 0) {
				for (int i = 0; i < vectorSalasOnline.size(); i++) {
					Sala SO = vectorSalasOnline.get(i);
					System.out.println(SO.getIdSala() + " > " + SO.getNombre());
				}
			}
			conexion.cerrarFlujo();
			return vectorSalasOnline;
		} catch (Exception e) {
			BilboSKP.sysoError("Error en getSalasOnline");
			e.printStackTrace();
		}
		return null;
	}

	// actualizar las salas en una coleccion clave-valor en el hashmap de la clase
	// @Rivo
	public static boolean cargarSalasOnline() throws Throwable {
		try {
			// limpiar todas las salas cargadas anteriormente
			SalaOnline.clearSalasCargadas();

			// obtener las salas de la bd
			Vector<SalaOnline> vectorSalasOnline = BilboSKP.getSalasOnline();

			// crear un nuevo hashmap(coleccion clave-valor)
			HashMap<Integer, SalaOnline> salasPorCargar = new HashMap<Integer, SalaOnline>();

			// si hay un vector de salas
			if (vectorSalasOnline != null) {
				// por cada sala la agregamos al hashmap
				for (SalaOnline sala : vectorSalasOnline) {
					// clave: el codigo de sala, valor: la sala
					salasPorCargar.put(sala.getIdSala(), sala);
				}
				// si vectorSalasOnline tiene tamaño 0 quiere decir que no habian salas en el
				// vector
				if (vectorSalasOnline.size() == 0) {
					BilboSKP.sysoError("No se encontraron salas que cargar");
				}
				// hacer un set a las salas cargadas
				SalaOnline.setSalasCargadas(salasPorCargar);
				return true;
			}

		} catch (Exception e) {
			BilboSKP.sysoError("Error en cargarSalas");
			e.printStackTrace();
		}
		return false;

	}

	private static void sysoError(String mensaje) {
		System.out.println("DBC_BilboSKP: " + mensaje);
	}

	// conectarse a la BD y obtener todas las salas fisicas @Urko
	public static Vector<SalaFisica> getSalasFisicas() throws Throwable {
		try {
			// crear el vector que vamos a devolver
			Vector<SalaFisica> vectorSalasFisicas = new Vector<SalaFisica>();
			// hacer sentencia sql select todas las salas
			String sentenciaSQL = "select * from salafisica order by idSala;";
			// hacer una conexion
			BilboSKP conexion = new BilboSKP();
			ResultSet resultado = conexion.SQLQuery(sentenciaSQL);
			// hacer un bucle de cada fila que tiene el resultset
			while (resultado.next()) {
				// obtener los campos de cada columna para esta fila
				int idSala = resultado.getInt("idSala");
				String nombre = resultado.getString("nombre");
				String dificultad = resultado.getString("dificultad");
				String tematica = resultado.getString("tematica");
				String descripcion = resultado.getString("descripcion");
				int tiempoMax = resultado.getInt("tiempoMax");
				int jugadoresMin = resultado.getInt("jugadoresMin");
				int jugadoresMax = resultado.getInt("jugadoresMax");
				int edad_recomendada = resultado.getInt("edad_recomendada");
				String direccion = resultado.getString("direccion");
				int telefono = resultado.getInt("telefono");

				SalaFisica sala = new SalaFisica(idSala, nombre, dificultad, tematica, descripcion, tiempoMax,
						jugadoresMin, jugadoresMax, edad_recomendada, direccion, telefono);
				// agregar sala al vector
				vectorSalasFisicas.add(sala);
			}

			// hacer syso de las salas obtenidas
			System.out.println("Salas obtenidas:");
			if (vectorSalasFisicas.size() > 0) {
				for (int i = 0; i < vectorSalasFisicas.size(); i++) {
					Sala SO = vectorSalasFisicas.get(i);
					System.out.println(SO.getIdSala() + " > " + SO.getNombre());
				}
			}
			conexion.cerrarFlujo();
			return vectorSalasFisicas;
		} catch (Exception e) {
			BilboSKP.sysoError("Error en getSalasFisicas");
			e.printStackTrace();
		}
		return null;
	}

	// actualizar las salas en una coleccion clave-valor en el hashmap de la clase
	// @Urko
	public static boolean cargarSalasFisicas() throws Throwable {
		try {
			// limpiar todas las salas cargadas anteriormente
			SalaFisica.clearSalasCargadas();

			// obtener las salas de la bd
			Vector<SalaFisica> vectorSalasFisicas = BilboSKP.getSalasFisicas();

			// crear un nuevo hashmap(coleccion clave-valor)
			HashMap<Integer, SalaFisica> salasPorCargar = new HashMap<Integer, SalaFisica>();

			// si hay un vector de salas
			if (vectorSalasFisicas != null) {
				// por cada sala la agregamos al hashmap
				for (SalaFisica sala : vectorSalasFisicas) {
					// clave: el codigo de sala, valor: la sala
					salasPorCargar.put(sala.getIdSala(), sala);
				}
				// si vectorSalasFisicas tiene tamaÃ±o 0 quiere decir que no habian salas en el
				// vector
				if (vectorSalasFisicas.size() == 0) {
					BilboSKP.sysoError("No se encontraron salas que cargar");
				}
				// hacer un set a las salas cargadas
				SalaFisica.setSalasCargadas(salasPorCargar);
				return true;
			}

		} catch (Exception e) {
			BilboSKP.sysoError("Error en cargarSalas");
			e.printStackTrace();
		}
		return false;
	}

	// conectarse a la BD y obtener todos los horarios de la sala fisica @Urko
	public static Vector<Horario> obtenerFechasFisica(String idSala) throws Throwable {
		try {
			// crear el vector que vamos a devolver
			Vector<Horario> vectorFechasSalasFisicas = new Vector<Horario>();

			// hacer sentencia sql select todas las reservas de la sala que queremos
			String sentenciaSQL = "select * from horario where idSalaFisica= '" + idSala
					+ "' and disponible=1 order by date(fechaHora);";
			// hacer una conexion
			BilboSKP conexion = new BilboSKP();
			ResultSet resultado = conexion.SQLQuery(sentenciaSQL);
			// hacer un bucle de cada fila que tiene el resultset
			while (resultado.next()) {
				// obtener los campos de cada columna para esta fila
				String idSalaFisica = resultado.getString("idSalaFisica");
				Timestamp fechaHora = resultado.getTimestamp("fechaHora");
				boolean disponible = resultado.getBoolean("disponible");

				Horario horario = new Horario(idSalaFisica, fechaHora, disponible);
				// agregar horario al vector
				vectorFechasSalasFisicas.add(horario);
			}

			// hacer syso de los horarios obtenidos
			System.out.println("Horarios disponibles en la sala con id " + idSala + ":");
			if (vectorFechasSalasFisicas.size() > 0) {
				for (int i = 0; i < vectorFechasSalasFisicas.size(); i++) {
					Horario ho = vectorFechasSalasFisicas.get(i);
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
					String fechaHoraString = sdf.format(ho.getFechaHora());
					System.out.println(fechaHoraString);
					// System.out.println(HO.getFechaHora());
				}
			}
			conexion.cerrarFlujo();
			return vectorFechasSalasFisicas;
		} catch (Exception e) {
			BilboSKP.sysoError("Error en getFechasSalasFisicas");
			e.printStackTrace();
		}
		return null;
	}

	// obtener los datos de un suscriptor dado su id @Torni
	public static Suscriptor getDatosSuscriptor(int idSuscriptor) throws Throwable {
		// hacer sentencia sql select todas las salas
		String sentenciaSQL = "select * from suscriptor where idSuscriptor = " + idSuscriptor + ";";
		// hacer una conexion
		BilboSKP conexion = new BilboSKP();
		// se hace una consulta sql con la conexion y se guarda en el resultset
		ResultSet resultado = conexion.SQLQuery(sentenciaSQL);
		// hacer un bucle de cada fila que tiene el resultset resultado
		resultado.next();
		// obtener los campos de cada columna para esta fila
		int telefono = resultado.getInt("telefono");
		String email = resultado.getString("email");
		String pass = resultado.getString("pass");
		String alias = resultado.getString("alias");
		String nombre = resultado.getString("nombre");
		String apellidos = resultado.getString("apellidos");
		String imagen = resultado.getString("imagen");
		int activo = resultado.getInt("activo");
		Date fech_nac = resultado.getDate("fech_nac");

		Suscriptor suscriptor = new Suscriptor(idSuscriptor, telefono, email, pass, alias, nombre, apellidos, imagen,
				activo, fech_nac);

		return suscriptor;
	}

	// Verificar si el email y pass son correctos, devuelve el suscriptor. @Torni
	public static Suscriptor loginSuscriptor(String email, String pass) throws Throwable {

		// hacer sentencia sql select todas las salas
		String sentenciaSQL = "select * from suscriptor where email = '" + email + "' and pass='" + Security.encriptarPass(pass) + "';";
		// hacer una conexion
		BilboSKP conexion = new BilboSKP();
		// se hace una consulta sql con la conexion y se guarda en el resultset
		// resultado
		ResultSet resultado = conexion.SQLQuery(sentenciaSQL);
		// hacer un if de cada fila que tiene el resultset resultado
		if (resultado.next()) {
			int telefono = resultado.getInt("telefono");
			String alias = resultado.getString("alias");
			String nombre = resultado.getString("nombre");
			String apellidos = resultado.getString("apellidos");
			String imagen = resultado.getString("imagen");
			int activo = resultado.getInt("activo");
			Date fech_nac = resultado.getDate("fech_nac");
			int idSuscriptor = resultado.getInt("idSuscriptor");

			Suscriptor suscriptor = new Suscriptor(idSuscriptor, telefono, email, pass, alias, nombre, apellidos,
					imagen, activo, fech_nac);
			System.out.println("Bienvenido, tu email es: " + suscriptor.getEmail());
			return suscriptor;
		} else {
			System.out.println("USUARIO O PASS INCORRECTO EN LOGIN");
		}
		return null;
	}

	// metodo que pide los campos de un suscriptor y crea una suscripcion @Torni
	public static Suscriptor crearSuscripcion(String email, String pass, int telefono, String alias, String nombre,
			String apellidos, String fech_nac) throws Throwable {
		// hacer sentencia sql select todas las salas
		/*
		 * String sentenciaSQL =
		 * "INSERT INTO `suscriptor` (`email`, `pass`, `alias`, `nombre`, `apellidos`, `fech_nac`, `telefono`) VALUES ('"
		 * + email + "', '" + pass + "', '" + alias + "', '" + nombre + "', '" +
		 * apellidos + "', '" + fech_nac + "', '" + telefono + "');";
		 */
		String[] arrayColumnas = { "email", "pass", "alias", "nombre", "apellidos", "fech_nac", "telefono" };
		Object[] arrayValores = { email, Security.encriptarPass(pass), alias, nombre, apellidos, fech_nac, telefono };
		String sentenciaSQL = SQLHelper.obtenerSentenciaSQLInsert("suscriptor", arrayColumnas, arrayValores);
		System.out.println(sentenciaSQL);
		// hacer una conexion
		BilboSKP conexion = new BilboSKP();
		// se hace una consulta sql con la conexion y se guarda en el resultset
		// resultado
		int filasAfectadas = conexion.SQLUpdate(sentenciaSQL);
		if (filasAfectadas == 1) {
			return loginSuscriptor(email, pass);

		} else {
			System.out.println("no se pudo crear suscriptor");
			return null;
		}
	}

	// obtener las reservas de un suscriptor de la bd @Paula
	public static Vector<Reserva> obtenerReserva(int idSuscriptor) throws Throwable {
		Vector<Reserva> reservas = new Vector<Reserva>();
		String sentenciaSQL = "SELECT * FROM reserva WHERE idSuscriptor=" + idSuscriptor + " order by fechaHora ";
		BilboSKP conexion = new BilboSKP();
		ResultSet resultado = conexion.SQLQuery(sentenciaSQL);

		while (resultado.next()) {
			// String idSuscriptor= resultado.getString(idSuscriptor);
			String idReserva = resultado.getString("idReserva");
			String idSalaFisica = resultado.getString("idSalaFisica");
			int numJugadores = resultado.getInt("numJugadores");
			Date fechaHora = resultado.getDate("fechaHora");

			Reserva reserva = new Reserva(idReserva, idSalaFisica, numJugadores, numJugadores, fechaHora);
			reservas.add(reserva);
		}

		if (reservas.size() > 0) {
			for (int i = 0; i < reservas.size(); i++) {
				Reserva r = reservas.get(i);
				System.out.println(r.getIdReserva());
			}
			return reservas;
		} else {

		}
		return reservas;
	}

	// obtener ranking dado un id sala online @Urko
	public static Vector<PartidaOnline> obtenerRankingSalaOnline(int idSala) throws Throwable {
		try {
			// crear el vector que vamos a devolver
			Vector<PartidaOnline> vectorPartidas = new Vector<PartidaOnline>();
			// hacer sentencia sql para crear el ranking
			String sentenciaSQL = "SELECT * FROM `partidaonline` where idSalaOnline='" + idSala
					+ "' order by puntaje desc limit 10;";
			// hacer conexion
			BilboSKP conexion = new BilboSKP();
			ResultSet resultado = conexion.SQLQuery(sentenciaSQL);
			// hacer un bucle de cada fila que tiene el resultset
			while (resultado.next()) {
				// obtener los campos de cada columna para esta fila
				int idPartida = resultado.getInt("idPartida");
				int idSalaOnline = resultado.getInt("idSalaOnline");
				int idAnfitrion = resultado.getInt("idAnfitrion");
				int puntaje = resultado.getInt("puntaje");
				int numeroJugadores = resultado.getInt("numeroJugadores");
				String nombreGrupo = resultado.getString("nombreGrupo");
				Timestamp fechaInicio = resultado.getTimestamp("fechaInicio");
				Timestamp fechaFin = resultado.getTimestamp("fechaFin");

				PartidaOnline partida = new PartidaOnline(SalaOnline.getSalaPorId(idSalaOnline),
						getDatosSuscriptor(idAnfitrion), idPartida, puntaje, numeroJugadores, nombreGrupo, fechaInicio,
						fechaFin);
				vectorPartidas.add(partida);
			}

			// hacer syso de los horarios obtenidos
			System.out.println("Mejores puntos la sala con id " + idSala + ":");
			if (vectorPartidas.size() > 0) {
				for (int i = 0; i < vectorPartidas.size(); i++) {
					Partida pa = vectorPartidas.get(i);
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
					String fechaHoraString = sdf.format(pa.getFechaInicio());
					System.out.println(pa.getNombreGrupo() + ", " + pa.getPuntaje() + " puntos, " + fechaHoraString);
				}
			}
			conexion.cerrarFlujo();
			return vectorPartidas;
		} catch (Exception e) {
			BilboSKP.sysoError("Error en obtenerRankingSalaOnline");
			e.printStackTrace();
		}
		return null;
	}

	// obtener ranking dado un id sala fisica @Urko
	public static Vector<Partida> obtenerRankingSalaFisica(int idSala) throws Throwable {
		try {
			// crear el vector que vamos a devolver
			Vector<Partida> vectorPartidas = new Vector<Partida>();
			// hacer sentencia sql para crear el ranking
			String sentenciaSQL = "SELECT * FROM `partidafisica` where idSalaFisica='" + idSala
					+ "' order by puntaje desc limit 10;";
			// hacer conexion
			BilboSKP conexion = new BilboSKP();
			ResultSet resultado = conexion.SQLQuery(sentenciaSQL);
			// hacer un bucle de cada fila que tiene el resultset
			while (resultado.next()) {
				// obtener los campos de cada columna para esta fila
				int idPartida = resultado.getInt("idPartida");
				String idSalaFisica = resultado.getString("idSalaFisica");
				String idReserva = resultado.getString("idReserva");
				int idAnfitrion = 0;
				int puntaje = resultado.getInt("puntaje");
				int numeroJugadores = resultado.getInt("numeroJugadores");
				String nombreGrupo = resultado.getString("nombreGrupo");
				Timestamp fechaInicio = resultado.getTimestamp("fechaInicio");
				Timestamp fechaFin = resultado.getTimestamp("fechaFin");

				Partida partida = new Partida(SalaFisica.datosSalaFisica(idSalaFisica), getDatosSuscriptor(idAnfitrion),
						idPartida, puntaje, numeroJugadores, nombreGrupo, fechaInicio, fechaFin);
				vectorPartidas.add(partida);
			}

			// hacer syso de los horarios obtenidos
			System.out.println("Mejores puntos la sala con id " + idSala + ":");
			if (vectorPartidas.size() > 0) {
				for (int i = 0; i < vectorPartidas.size(); i++) {
					Partida pa = vectorPartidas.get(i);
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
					String fechaHoraString = sdf.format(pa.getFechaInicio());
					System.out.println(pa.getNombreGrupo() + ", " + pa.getPuntaje() + " puntos, " + fechaHoraString);

				}
			}
			conexion.cerrarFlujo();
			return vectorPartidas;

		} catch (Exception e) {
			BilboSKP.sysoError("Error en obtenerRankingSalaFisica");
			e.printStackTrace();
		}
		return null;
	}

	// guardar una partida online en la bd @Rivo
	public static boolean guardarPartidaOnline(PartidaOnline PO) {
		try {
			if (getEstadoRanking() == false) {
				System.out.println("Error guardando Partida Online. El ranking está cerrado.");
				return false;
			}
			// hacer una sentencia sql
			int idSala = PO.getSala().getIdSala();
			int idAnfitrion = PO.getAnfitrion().getIdSuscriptor();
			int puntaje = PO.getPuntaje();
			int numeroJugadores = PO.getNumJugadores();
			String NG = PO.getNombreGrupo();
			java.sql.Date fechaSQLInicio = SQLHelper.convertirFechaUtilASql(PO.getFechaInicio());
			java.sql.Date fechaSQLFin = SQLHelper.convertirFechaUtilASql(PO.getFechaFin());
			
			if (fechaSQLFin == null || fechaSQLInicio == null) {
				System.out.println("Error guardando Partida Online. Fechas no asignadas correctamente.");
				return false;
			}
			
			/*
			 * String sentenciaSQL =
			 * "INSERT INTO partidasonline (idSalaOnline, idAnfitrion, puntaje, numeroJugadores, nombreGrupo, fechaInicio, fechaFin) "
			 * + "VALUES (" + idSala + ", " + idAnfitrion + ", " + puntaje + ", " +
			 * numeroJugadores + ", '" + NG + "', '" + fechaSQLInicio + "', '" + fechaSQLFin
			 * + "')";
			 */

			String[] arrayColumnas = { "idSalaOnline", "idAnfitrion", "puntaje", "numeroJugadores", "nombreGrupo",
					"fechaInicio", "fechaFin" };
			Object[] arrayValores = { idSala, idAnfitrion, puntaje, numeroJugadores, NG, fechaSQLInicio, fechaSQLFin };
			String sentenciaSQL = SQLHelper.obtenerSentenciaSQLInsert("partidaonline", arrayColumnas, arrayValores);

			// hacer una consulta sql con la conexion y se guarda en el resultset resultado
			BilboSKP conexion = new BilboSKP();
			int filasAfectadas = conexion.SQLUpdate(sentenciaSQL);
			if (filasAfectadas == 1) {
				return true;
			} else {
				System.out.println("No se pudo guardar partida online");
				return false;
			}
		} catch (Throwable e) {
			System.out.println("Error guardando Partida Online");
			e.printStackTrace();
			return false;
		}
	}
/*
	// CUPONES
	// Cambiar el estado del cupon de Activo / En uso / Gastado / Caducado
	public static Cupon CambiarEstado(Cupon cupon) throws Throwable {
		LocalDate FechaActual = LocalDate.now();
		LocalDate FechaCaducidad = cupon.getFechaCaducidad().toLocalDate();
		String disponibilidad = cupon.getEstado();

		// Si un cupon tiene estado entra en en la condicion
		if (disponibilidad != null) {
			if (disponibilidad.equalsIgnoreCase("ACTIVO")) {

				// Si esta activo significa que puede estar caducado
				if (FechaActual.isBefore(FechaCaducidad)) {
					// Si no esta caducado se cambia el estado a EN USO
					String sentenciaSQL = "UPDATE cupon SET estado = 'En uso' WHERE idCupon = " + cupon.getId() + ";";
					BilboSKP conexion = new BilboSKP();
					ResultSet resultado = conexion.SQLQuery(sentenciaSQL);
					cupon.setEstado("EN USO");

					// Si no esta caducado se cambia el estado a EN USO
				} else if (FechaActual.isAfter(FechaCaducidad)) {
					cupon.setEstado("CADUCADO");
					String sentenciaSQL = "UPDATE cupon SET estado = 'Caducado' WHERE idCupon = " + cupon.getId() + ";";
					BilboSKP conexion = new BilboSKP();
					ResultSet resultado = conexion.SQLQuery(sentenciaSQL);
					return cupon;
				} else {
					System.out.println("Caduca hoy");
					return cupon;
				}

				// Si no esta caducado igual esta en uso
			} else if (disponibilidad.equalsIgnoreCase("EN USO")) {
				cupon.setEstado("GASTADO");
				String sentenciaSQL = "UPDATE cupon SET estado = 'Gastado' WHERE idCupon = " + cupon.getId() + ";";
				BilboSKP conexion = new BilboSKP();
				ResultSet resultado = conexion.SQLQuery(sentenciaSQL);
				return cupon;
			} else {
				System.out.println("Esta inutilizable");
			}
			return cupon;
		} else {
			cupon.setEstado("ACTIVO");
			String sentenciaSQL = "UPDATE cupon SET estado = 'Gastado' WHERE idCupon = " + cupon.getId() + ";";
			BilboSKP conexion = new BilboSKP();
			ResultSet resultado = conexion.SQLQuery(sentenciaSQL);
		}
		return cupon;
	}

	// Conseguir los cupones de un suscriptor por su id
	public static Vector<Cupon> getCuponesSuscriptor(int idSuscriptor) throws Throwable {
		Vector<Cupon> vectorCupones = new Vector<Cupon>();
		// hacer sentencia sql select todas las salas
		String sentenciaSQL = "select * from cupon where idSuscriptor = " + idSuscriptor + ";";
		// hacer una conexion
		BilboSKP conexion = new BilboSKP();
		// se hace una consulta sql con la conexion y se guarda en el resultset
		// resultado
		ResultSet resultado = conexion.SQLQuery(sentenciaSQL);
		// hacer un bucle de cada fila que tiene el resultset resultado
		while (resultado.next()) {
			// obtener los campos de cada columna para esta fila
			String idCupon = resultado.getString("idCupon");
			Date fechaCaducidad = resultado.getDate("fechaCaducidad");
			String Estado = resultado.getString("estado");
			System.out.println(idCupon);
			Cupon cupon = new Cupon(idCupon, Estado, (java.sql.Date) fechaCaducidad);
			// agregar cupon al vector
			vectorCupones.add(cupon);
		}

		return vectorCupones;
	}

	// Enviar cupon de bienvenida
	public void RecibirCuponBienvenida(int idSuscriptor) throws Throwable {

		LocalDate fechaCaducidad = LocalDate.of(2070, 12, 31);
		String sentenciaSQL = "INSERT INTO cupon( idSuscrioptor, fechaCaducidad, estado) VALUES ('" + idSuscriptor + ","
				+ fechaCaducidad + ",'ACTIVO' );";
		BilboSKP conexion = new BilboSKP();
		ResultSet resultado = conexion.SQLQuery(sentenciaSQL);
	}
	*/
}
