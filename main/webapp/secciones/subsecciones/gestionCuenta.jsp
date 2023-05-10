<%@ page
	import="java.util.HashMap, java.util.Map, java.util.ArrayList, java.io.File, java.text.Normalizer, 
	model.Suscriptor, view.Frases, model.SalaOnline, model.SalaFisica, view.AppConfig, java.util.Date"%>

<link rel="stylesheet" href="css/gestionCuenta.css">
<%
HttpSession sesion = request.getSession();
Suscriptor sus= (Suscriptor) sesion.getAttribute("suscriptor");
sesion.setAttribute("sus", sus);
%>

<div class="caja2">
                <div class="parte1">
                    <h2>Gesti�n de la cuenta</h2>
                    <p>Modifica aqu� tus datos personales. Recuerda que tanto como el alias, nombre y apellidos
                    pertenecen a tu perfil p�blico.</p>
                </div>
                <form action="./perfil" method="post">
                    <div class="subcaja1">
                   		<img src="img_suscriptores/<%=sus.getImagen()%>" alt="">                   	
                    </div>
                    <div class="form1">
                        <div class="box0">
                            <label for=""><strong>Nombre:</strong></label>
                            <div class="edit">
                                <input type="text" name="nombre" id="nombre" value="<%=sus.getNombre()%>">
                              	<%--  <img src="img_web/icons/edit_icon.png" alt="">--%> 
                            </div>
                        </div>
                        <div class="box0">
                            <label for="">Apellido:</label>
                            <div class="edit">
                                <input type="text" name="apellido" id="apellido" value="<%=sus.getApellidos()%>">
                            	<%--  <img src="img_web/icons/edit_icon.png" alt="">--%> 
                            </div>
                        </div>
                    </div>
                    <div class="form2">
                        <div class="box0">
                            <label for="">Email:</label>
                            <div class="edit">
                                <input type="email" name="email" id="email" value="<%=sus.getEmail()%>">
                                <%--  <img src="img_web/icons/edit_icon.png" alt="">--%> 
                            </div>
                            
                        </div>
                        <div class="box0">
                            <label for="">Alias:</label>
                            <div class="edit">
                                <input type="text" name="alias" id="alias" value="<%=sus.getAlias()%>">
                              <%--  <img src="img_web/icons/edit_icon.png" alt="">--%> 
                            </div>
                        </div>
                    </div>
                    <div class="form3">
                        <div class="box0">
                            <label for="">Fecha de nacimiento</label>
                            <div class="edit">
                                <input type="date" name="fecha_nacimiento" id="fecha_nacimiento" value="<%=sus.getFech_nac()%>">
                                <%--  <img src="img_web/icons/edit_icon.png" alt="">--%> 
                            </div>
                        </div>
                        <div class="box0">
                            <label for="">T�lefono:</label>
                            <div class="edit">
                                <input type="text" name="telefono" id="telefono" value="<%=sus.getTelefono()%>">
                                <%--  <img src="img_web/icons/edit_icon.png" alt="">--%> 
                            </div>
                        </div>
                    </div>
                    <%--
                    <div class="form4">
                        <div class="box0">
                            <label for="">Contrase�a</label>
                            <div class="edit">
                                <input type="password" name="" id="">
                                <img src="img_web/icons/edit_icon.png" alt="">
                            </div>
                        </div>
                        <div class="box0">
                            <label for="">T�lefono:</label>
                            <div class="edit">
                                <input type="text" name="" id="">
                               	<img src="img_web/icons/edit_icon.png" alt="">
                            </div>
                        </div>
                        
                    </div>--%>
                   	<div class="form5">
                     	<input type="submit" value="Guardar cambios"> 
                    </div>
                </form>
                <!--<form class="caja4">
                    <h2>Cambiar contrase�a</h2>
                    <div class="box1">
                        <label for="">Introduce la contrase�a actual </label>
                        <input type="password" name="" id="">
                    </div>
                    <div class="box1">
                        <label for="">Introduce la nueva contrase�a</label>
                        <input type="password" name="" id="">
                    </div>
                    <div class="box1">
                        <label for="">Repite la nueva contrase�a</label>
                        <input type="password" name="" id="">
                    </div>
                </form>-->
                <div class="caja3">
                    <h2>�Deseas darte de baja?</h2>
                    <p>Al darte de baja, pasar�s a estado inactivo y no se perder�n tus datos, avances y/o cupones comprados</p>
                 	<div class="interruptor">
                 		<p>Activo</p>
                 		<label class="switch">
  							<input type="checkbox">
  							<span class="slider round"></span>
						</label>
                 	
                 	</div>
                  	
               
				</div>
    
  

