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
            <div class="caja1">
            	<h1>Mi perfil</h1>
                <ul>
                    <li><a href="">Gesti�n de la cuenta</a></li>
                    <li><a href="">Mis reservas</a></li>
                    <li><a href="">Mis cupones</a></li>
                    <li><a href="">Cerrar sesi�n</a></li>
                </ul>
            </div>
            <div class="caja2">
            	<jsp:include page="<%=rutaJspSeccion%>"></jsp:include>
            </div>
</div>



		


