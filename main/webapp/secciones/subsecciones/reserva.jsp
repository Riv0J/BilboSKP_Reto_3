<%@ page
	import="java.util.HashMap, java.util.Map, java.util.ArrayList, java.io.File, java.text.Normalizer, 
	model.Reserva, view.Frases, model.SalaOnline, model.SalaFisica, view.AppConfig, java.util.Date  "%>   
<link rel="stylesheet" href="../css/reserva.css">

      <section id="caja0">
            <section id="caja1">
                <h1>Administra tus reservas</h1>
                <p>Puedes ver o cancelar tus reservas para las salas de escape f�sicas.Ten en cuenta que tus reservas se mostrar�n por orden
                de fecha de caducidad m�s cercana.</p>
            </section>
            <section id="caja2">
                <div class="title">
                    <p><strong>Pr�ximas reservas</strong></p>
                </div>
                <div id="subcaja2">
                    <ul class="menu">
                        <div class="menu1">
                            <li>Informaci�n reserva</li>
                        </div>
                        <div class="menu3">
                            <li>N�reserva</li>
                        </div>
                        <div class="menu3">
                         <li>Fecha</li>
                        </div>
                        <div class="menu3">
                            <li>Hora</li>
                        </div>
                        <div class="menu3">
                            <li>Estado</li>
                        </div>   
                    </ul>
                </div>
                <div class="subcaja3">
                    <div class="info1"> 
                        <div class="cajita">
                            <label for="">Sala de escape:</label>
                            <input type="text" value="Sala de escape">
                        </div>
                        <div class="cajita">
                            <label for="">T�matica:</label>
                            <input type="text" value="T�matica">
                        </div>
                        <div class="cajita">
                            <label for="">Duraci�n:</label>
                            <input type="text" value="Duraci�n">
                        </div>
                        <div class="cajita">
                            <label for="">N� jugadores:</label>
                            <input type="text" value="N�reserva">
                        </div>
                    </div>
                    <div class="info">
                        <input type="text" value="N�reserva">
                        <input type="text" value="Fecha">
                        <input type="text" value="Hora">
                        <input type="text" value="Estado">
                    </div>
                </div>
            </section>
            <section id="caja4">
                <div class="subcaja4">
                    <input type="button" value="Cancelar reserva">
                </div>
            </section>
        </section>  


