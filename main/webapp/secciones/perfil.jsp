<%

String subseccion = request.getParameter("sub");
if (subseccion == null)  {
	response.sendRedirect("./perfil");
}
String rutaJspSeccion = "subsecciones/" + subseccion + ".jsp";
System.out.println(rutaJspSeccion);
%>

<link rel="stylesheet" href="css/perfil.css">

<section>
        <div class="caja1">
                <h1>Mi perfil</h1>
                <ul>

                    <li class="gc"><a href="<%=subseccion%>">Gesti�n de la cuenta</a></li>
                    <li><a href="">Mis reservas</a></li>
                    <li><a href="">Mis cupones</a></li>
                    <li><a href="">Cerrar sesi�n</a></li>
                </ul>
            </div> 
            
        <div class="caja2">
        	<%-- <jsp:include page="plantillas/mensaje.jsp"></jsp:include>--%>
			<jsp:include page="<%=rutaJspSeccion%>"></jsp:include>
        </div>         
</section>     

		


