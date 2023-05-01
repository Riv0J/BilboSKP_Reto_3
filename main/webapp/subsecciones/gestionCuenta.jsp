<%@ page
	import="java.util.HashMap, java.util.Map, java.util.ArrayList, java.io.File, java.text.Normalizer, 
	model.Suscriptor, view.Frases, model.SalaOnline, model.SalaFisica, view.AppConfig, java.util.Date  "%>

<link rel="stylesheet" href="../css/gestionCuenta.css">
<% HttpSession sesion = request.getSession();
Suscriptor sus= (Suscriptor) sesion.getAttribute("suscriptor");
sesion.setAttribute("sus", sus);
%>

    <div class="caja2">
         <div>
                    <h2>Gesti�n de la cuenta</h2>
                    <p>Modifica aqu� tus datos personales. Recuerda que tanto como el alias, nombre y apellidos ser�n
                    pertenecen a tu perfil p�blico.</p>
         </div>
           
         <form action="">
                    <div class="subcaja1">
                        	<img src="img/gato.png" alt="">
                        	<input type="button" value="Modificar" value="<%=%>">
                    </div>
                    <div class="form1">
                        <div class="box0">
                           		<label for="">Nombre:</label>
                            	<input type="text" name="" id="" value="<%=sus.getNombre()%>">
                        </div>
                        <div class="box0">
                            	<label for="">Apellido:</label>
                            	<input type="text" name="" id="" value="<%=sus.getApellidos()%>">
                        </div>
                    </div>
                    <div class="form2">
                        <div class="box0">
                            	<label for="">Email:</label>
                            	<input type="email" name="" id="" value="<%=sus.getEmail()%>">
                        </div>
                        <div class="box0">
                            	<label for="">Alias:</label>
                            	<input type="text" name="" id="" value="<%=sus.getAlias()%>">
                        </div>
                    </div>
                    <div class="form3">
                        <div class="box0">
                            	<label for="">Fecha de nacimiento</label>
                            	<input type="date" name="" id="">
                        </div>
                        <div class="box0">
                            	<label for="">T�lefono:</label>
                            	<input type="" name="" id=""  value="<%=sus.getTelefono()%>">
                        </div>
                    </div>
                    <div class="caja">
                        	<input type="button" value="Guardar" />
                    </div>
           </form>
           <form class="caja4">
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
            </form>
            <div class="caja3">
                    <h2>�Deseas darte de baja?</h2>
                    <p>Al darte de baja se perder�n tus avances y en caso de tener cupones no canjeados
                        se te har� un reembolso</p>
                    <a href="darseBaja.html"><input type="button" value="Darse de baja"></a>
           	</div>
    </div>
  

