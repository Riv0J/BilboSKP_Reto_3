<%

String subseccion = request.getParameter("sub");
if (subseccion == null)  {
	response.sendRedirect("./perfil");
}
String rutaJspSeccion = "subsecciones/" + subseccion + ".jsp";
System.out.println(rutaJspSeccion);
%>

<link rel="stylesheet" href="css/perfil.css">

<div id="caja0">
            <div class="cajaPerfil">
            	<h1>Mi perfil</h1>
                <ul>


                    <li class="gc"><a href="./perfil?sub=gestionCuenta">Gesti�n de la cuenta</a></li>
                    <li><a href="./perfil?sub=reserva">Mis reservas</a></li>
                    <li><a href="./perfil?sub=cupones">Mis cupones</a></li>

                    <li><a href="./perfil?sec=inicio">Cerrar sesi�n</a></li>
                </ul>
            </div>
            <div class="cajaSubseccion">
            	<jsp:include page="<%=rutaJspSeccion%>"></jsp:include>
            </div>
</div>



		


