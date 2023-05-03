package control;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.PartidaOnline;
import model.Sala;
import model.SalaOnline;
import model.Suscriptor;

/**
 * Servlet implementation class ServletOrganizar
 */
@WebServlet("/organizar")
public class ServletOrganizar extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ServletOrganizar() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("doget Organizar sala");
		
		String idSala = request.getParameter("idSala");
		
		HttpSession sesion = request.getSession();
		Object suscriptor = (Object) sesion.getAttribute("suscriptor");
		if(suscriptor instanceof Suscriptor) {
			Suscriptor anfitrion = (Suscriptor) suscriptor;
			System.out.println(anfitrion.getAlias());
			System.out.println(idSala);
			Sala sala=SalaOnline.getSalaPorId(idSala);
			System.out.println(sala.getNombre());
			PartidaOnline partidaOnline= new PartidaOnline(sala, anfitrion, sala.getJugadoresMax(), idSala);
			partidaOnline.getCodInvitacion();
			System.out.println(partidaOnline.getCodInvitacion());
			request.setAttribute("partidaOnline", partidaOnline);
		}
		
		
		request.getRequestDispatcher("index.jsp?sec=organizar").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
