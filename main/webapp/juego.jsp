<%@ page
	import="java.util.Vector, java.util.HashMap, java.util.Enumeration, java.util.Map, model.Flecha,java.util.Date, model.Escenario, 
	model.Sala, model.SalaOnline,model.MensajeChat, java.net.URLEncoder, model.Invitado,model.Anfitrion,model.Jugador,view.StringHelper,view.DateHelper,view.Icon,model.PartidaOnline,model.Suscriptor"%>
<%
//obtener datos del request/sesion
PartidaOnline partidaOnline = (PartidaOnline) request.getAttribute("partidaOnline");
Escenario escenarioAMostrar = (Escenario) request.getAttribute("escenarioAMostrar");

if (partidaOnline == null) {
	response.sendRedirect("index.jsp");
	System.out.println("NO hay partida en el request");
}
//obtener mas datos de los objetos
int codInvitacion = partidaOnline.getCodInvitacion();
int segundosActuales = partidaOnline.getSegundosTranscurridos();
int segundosObjetivo = partidaOnline.getSegundosObjetivo();
int segundosRestantes = segundosObjetivo - segundosActuales;
int minutos = segundosRestantes / 60;
int segundos = segundosRestantes % 60;

String contenidoTemporizador;
if (segundos < 10) {
    contenidoTemporizador = minutos + ":0" + segundos;
} else {
    contenidoTemporizador = minutos + ":" + segundos;
}
contenidoTemporizador = minutos + ":" + segundos;
Vector<MensajeChat> vectorLineasChat = partidaOnline.getLineasChat();
//obtener el vec de flechas
Vector<Flecha> vectorFlechas = escenarioAMostrar.getFlechas();
System.out.println("Escenario a mostrar "+escenarioAMostrar.getImagen()+" tiene "+vectorFlechas.size()+" flechas.");
/*obtener el vec de objetos
Vector<Flecha> vectorFlechas = (Vector<Flecha>) request.getAttribute("vectorFlechas");
*/
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Juego | BilboSKP</title>
<link rel="stylesheet" href="css/juego.css">
<link rel="stylesheet" href="css/normalize.css">
<link rel="stylesheet" href="css/bilboskp.css">
<link href="https://cdn.jsdelivr.net/npm/remixicon@3.2.0/fonts/remixicon.css" rel="stylesheet">
<link rel="stylesheet" href="https://unpkg.com/boxicons@latest/css/boxicons.min.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@500;600&display=swap" rel="stylesheet">
<link rel="icon" type="image/x-icon" href="img_web/logos/500x400-cuadrado-2.png">
</head>
<body>
	<main>
		<jsp:include page="css/colores.jsp"></jsp:include>
		<section id="escenario">
		</section>
		<section id=interfaz>
			<div id="menu_arriba" class="menu background-image_cuero">
				<h1 id="temporizador"><%=contenidoTemporizador %></h1>
				<!--<a id="Ajustes" href="#"><i class="ri-settings-4-line"></i></a>-->
				<a id="salir" href="./jugar?accion=salir&codInvitacion=<%=codInvitacion%>" title="Quit/Salir"><i class="ri-logout-box-r-line"></i></a>
			</div>
			<div id="menu_abajo" class="menu">
				<a id="Pistas" href="#" title="Pistas" class="background-image_cuero"><i class="ri-question-line"></i></a>
				<a id="botonInventario" title="Inventario" class="background-image_cuero"><i class="ri-red-packet-line"></i></a>
			</div>
			<form action="./jugar" method="post" id="caja_chat" class="menu">
				<input type="hidden" name="accion" value="chatear">
				<input type="hidden" name="escenarioAMostrar" value="<%=escenarioAMostrar.getNombreEscenario()%>">
				<input type="hidden" name="codInvitacion" value="<%=codInvitacion%>">
				<div id="caja_mensajes" class="background_transparent">
				<% for(MensajeChat mensajeChat : vectorLineasChat) {%>
					<div class="caja_mensaje">
						<div class="caja_mensaje_texto"><%=mensajeChat.jugador.getAlias()%>: <%=mensajeChat.texto%></div>
					</div>
				<% } %>
				</div>
				<div id="caja_inputs">
					<input type="text" name="mensajeChat" id="mensaje" class="background_transparent" placeholder="Escribe un mensaje" autocomplete="off">
					<button type="submit" class="i_boton background-image_cuero">
						<i class="ri-send-plane-fill"></i>
						<div>Enviar</div>
					</button>
				</div>
			</form>
			<div id="fondoInventario">
				<div class="objeto">
					<img src="img_salas/objetos/cuadrado.png">
				</div>
			</div>
			<%for(Flecha flecha : vectorFlechas){ 
				int posX = flecha.getPosicionX(); int posY = flecha.getPosicionY(); int dimX = flecha.getdimensionX(); int dimY =flecha.getdimensionY();
				String imagenFlecha = flecha.getImagen(); %>
				<a href="./jugar?accion=cambioEscenario&codInvitacion=<%=codInvitacion%>&idEscenarioDestino=<%=flecha.getIdEscenarioDestino()%>" class="flecha" style="position: fixed; 
				bottom: <%=posY%>%; left: <%=posX%>%; width: <%=dimX%>vw; height:<%=dimY%>vw;">
					<% 	 if(!imagenFlecha.equals("") && imagenFlecha != null){%>
						<img src="img_salas/flechas/<%=imagenFlecha%>.png">
					<% } %> 
				</a>
			<% } %>
		</section>
		<%if (escenarioAMostrar.getJsp()==1) {
			String ruta = "plantillas/"+escenarioAMostrar.getImagen()+".jsp";
		System.out.println(ruta);%>
		<jsp:include page="<%=ruta%>"></jsp:include>
		<% } %>
	</main>
</body>
<style>
main {
	font-size: 2em;
}

.background-image_cuero {
	background-size: cover;
	background-image: url('img_web/texturas/cuero.png');
}

.background_transparent {
	background-color: rgba(25, 25, 25, 0.8);
}

#interfaz {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
}

a {
	text-decoration: none;
	color: inherit;
	cursor: pointer;
}
.flecha{
	display: flex;
}
.flecha a {
	width: 100%;
	height: 100%;
	max-width: 100%;
	max-height: 100%;
}
.flecha a img{
	width: 100%;
	height: 100%;
	max-width: 100%;
	max-height: 100%;
}
body {
	height: 100vh;
}

#escenario{
	background-image: url(img_salas/escenarios/<%=escenarioAMostrar.getImagen()%>.png);
	background-size: cover;
	height: 100%;
	position: absolute;
	z-index: -1;
	width: 100%;
}

i {
	font-size: 2em;
}

.menu {
	position: fixed;
	display: flex;
	flex-direction: row;
	justify-content: space-evenly;
	align-items: center;
	border-radius: 0.5em;
	z-index: 0;
	margin: 1%;
	gap: 1em;
	padding: 1%;
	color: var(--main-color);
	transition: all 0.5s;
}

#menu_arriba {
	top: 0;
	right: 0;
	width: 15%;
	height: 10%;
}

#temporizador {
	user-select: none;
	letter-spacing: 0.1em;
	font-size: 1.75em;
}

#menu>* {
	display: flex;
	justify-content: center;
	align-items: center;
	text-align: center;
	height: 100%;
}

#salir {
	
}

#salir:hover {
	color: var(--text-color);
}

#menu_abajo {
	position: fixed;
	bottom: 0;
	right: 0;
	gap: 0;
	margin: 0.5%;
	width: 18%;
	height: 15%;
	font-weight: bolder;
	font-size: 1.2em;
}

#menu_abajo>* {
	padding: 2%;
	padding-left: 5%;
	padding-right: 5%;
	border: 0.075em solid var(--main-color);
	border-radius: 0.6em;
	background-color: black;
	transition: background-color 0.3s ease;
}

#menu_abajo>*:hover {
	animation: icon_hover 0.3s ease forwards;
}

.i_boton {
	padding: 2%;
	padding-left: 5%;
	padding-right: 5%;
	border: 0.075em solid var(--main-color);
	border-radius: 0.6em;
	background-color: black;
	transition: background-color 0.3s ease;
}

.i_boton:hover {
	animation: icon_hover 0.3s ease forwards;
}

@keyframes icon_hover { 
	0% {
		background-color: #000000;
		transform: scale(1);
		}
	50% {
		transform:scale(0.95);
		}
	100% {
		background-color: rgb(36,36,36);
		border-color: var(--text-color);
		color: var(--text-color);
		transform:scale(1);
		}
}
#caja_chat {
	bottom: 0;
	left: 0;
	margin: 0;
	width: 35%;
	height: 35%;
	flex-direction: column;
	gap: 0.4em;
	font-size: 0.9em;
}

#caja_chat>* {
	width: 100%;
}

#caja_mensajes {
    padding-top: 2%;
    height: 80%;
    border-radius: 0.3em;
    overflow-y: scroll;
    overflow-x: hidden;
    display: flex;
    flex-direction: column;
    padding-right: 6%;
    overflow-wrap: break-word;
    hyphens: auto;
}

.caja_mensaje {
    margin: 1%;
    margin-left: 4%;
    margin-top: 0;
    width: 100%;
    max-height: 30%;
    color: whitesmoke;
    display: flex;
    flex-direction: row;
    justify-content: flex-start;
    gap: 0.2em;
}

.caja_mensaje_texto {
	
}

#caja_inputs {
	height: 20%;
	display: flex;
	flex-direction: row;
	gap: 0.4em;
	font-size: 0.9em;
}

#caja_inputs>* {
	height: 100%;
}

#caja_inputs input {
	width: 80%;
	padding-left: 3%;
	color: whitesmoke;
	font-size: 1.2em;
	border-radius: 0.2em;
}

#caja_inputs input:placeholder {
	color: var(--main-color);
}

}
#caja_inputs input:focus {
	outline: none;
}

#caja_inputs button {
	width: 20%;
	padding: 2%;
	display: flex;
	flex-direction: row;
	justify-content: space-evenly;
	align-items: center;
	font-size: 1.1em;
	border-radius: 0.3em;
	color: var(--main-color);
	user-select: none;
}

#caja_inputs button i {
	font-size: 1em;
}

#botonInventario {
	display: none;
}

.fila {
	display: table-row;
}

.celda {
	display: table-cell;
	border: 1px solid black;
	padding: 5px;
	text-align: center;
	width: 100px;
}

#mensajeContainer {
	height: 10%;
	overflow-y: scroll;
	background-color: #f1f1f1;
	padding: 2%;
	position: absolute;
	width: 21.5%;
	margin-top: 35%;
}

.objeto {
	width: 100%;
	height: 100%;
	max-width: 100px;
	max-height: 100px;
	overflow: hidden;
	object-fit: contain;
	margin-top: -8%;
	padding: 2%;
	display: flex;
}
</style>
	<script>
	  var segundosActuales = <%=segundosActuales%>;
	  var segundosObjetivo = <%=segundosObjetivo%>;
	  var startSeconds = segundosObjetivo - segundosActuales;
	  var timer = setInterval(function() {
	    var minutes = Math.floor(startSeconds / 60);
	    var remainingSeconds = startSeconds % 60;
	    if (remainingSeconds < 10) {
	      remainingSeconds = "0" + remainingSeconds;
	    }
	    document.getElementById("temporizador").innerHTML = minutes + ":" + remainingSeconds;
	    if (startSeconds == 0) {
	      clearInterval(timer);
	      window.location.href = "index.jsp?sec=finalizarPartida";
	    } else {
	      startSeconds--;
	    }
	  }, 1000);
	</script>
</html>
