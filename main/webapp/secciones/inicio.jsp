<%@ page
	import="model.Suscriptor, model.SalaOnline, control.BilboSKP, view.Mensaje, java.util.Vector, java.io.File"%>

<%
Vector<SalaOnline> vectorSalasMasJugadas = new Vector<SalaOnline>();
try {
	vectorSalasMasJugadas = BilboSKP.getSalasMasJugadas(3);
} catch (Throwable e) {
	e.printStackTrace();
}
%>
<link rel="stylesheet" href="css/inicio.css">
<main>
	<section class="principal">
		<div id="caja_principal">
			<h1 class="bilbosk_h1">Experimenta nuestras salas de escape</h1>
			<p class="bilboskp_p">Sum�rgete en una experiencia de juego �nica
				sin salir de tu casa con nuestras emocionantes salas de escape
				virtuales. �Est�s listo para poner a prueba tus habilidades mentales
				y tu capacidad de resoluci�n de problemas?</p>
			<div class="flex_center">
				<a class="flex_center" href=#><button
						class="bilboskp_icon_button">Jugar Ahora</button></a> <a
					class="flex_center" href=#><button
						class="bilboskp_icon_button_inverted">Unirse a partida</button></a>
			</div>
		</div>
		<div class="llave">
			<img src="img_web/inicio/lampara.png" alt="">
		</div>
	</section>

	<section class="titulo">
		<h2 class="bilbosk_h2">�descubre nuestras salas online m�s
			jugadas!</h2>
	</section>
	<section class="card-container">
		<% for (SalaOnline so : vectorSalasMasJugadas) {
			String rutaImagenPortada = "img_salas/portadas/SO" + so.getIdSala() + ".png";
			File archivoImagenPortada = new File(getServletContext().getRealPath("/") + rutaImagenPortada);
			if (!archivoImagenPortada.exists()) {
				rutaImagenPortada = "img_salas/portadas/Question.png";
			}%>
		<div class="card">
			<img src="<%=rutaImagenPortada%>" alt="Foto Scape room">
			<div class="card-content">
				<h2><%=so.getNombre()%></h2>
				<p><%=so.getDescripcion()%></p>
			</div>
		</div>
		<% } %>
	</section>
	<section class="titulo2">
		<h2 class="bilbosk_h2">�descubre nuestras salas mas jugadas!</h2>
	</section>
	<section class="card-container2">
		<div class="card">
			<img src="img_web/inicio/card2.jpg" alt="Foto del scape room">
			<div class="card-content">
				<h2>SOLO O CON AMIGOS</h2>
				<p>Puedes realizar cualquiera de nuestros escapes de forma
					individual o en grupo. Si no das con la tecla quiz�s otro/a si lo
					haga. El precio NO cambia.
				</p>
			</div>
		</div>
		<div class="card">
			<img src="img_web/inicio/card2.jpg" alt="Foto del scape room">
			<div class="card-content">
				<h2>M�LTIPLES AVENTURAS</h2>
				<p>Tenemos actualmente varias historias, y estamos trabajando en
					muchas m�s. Cada una, tiene tanto una dificultad como un tiempo
					estimado diferente.</p>
			</div>
		</div>
		<div class="card">
			<img src="img_web/inicio/card2.jpg" alt="Foto del scape room">
			<div class="card-content">
				<h2>�C�MO FUNCIONA?</h2>
				<p>Resuelve puzzles y encuentra la soluci�n en tiempo limitado.
					Trabaja solo o en equipo y comun�cate a trav�s de chat en salas de
					escape online.</p>
			</div>
		</div>
	</section>
</main>