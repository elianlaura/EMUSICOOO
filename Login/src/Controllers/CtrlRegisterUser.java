package Controllers;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import Model.User;
import org.json.JSONObject;


/**
 * Servlet implementation class CtrlRegisterUser
 */
@WebServlet("/CtrlRegisterUser")
public class CtrlRegisterUser extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private User m_user;   
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CtrlRegisterUser() {
        super();
        m_user = new User();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		int result = m_user.RegisterUser(request.getParameter("name"), request.getParameter("email"), request.getParameter("password"));
		String text;
		
		JSONObject json = new JSONObject();		
				
		if(result == 1){
			json.put("result", 1);		
			
		}else{
			json.put("result", 0);			
		}
		
		PrintWriter out = response.getWriter();
		
		text = json.toString();
		
		System.out.println(text);
		
		out.println(text);
	    
		
		
		
        //out.close();
		
		
		
		/* otra manera de usar el JSON
		 * 
		 * 
		Map<String, Long> map = new HashMap<String, Long>();
        map.put("A", 10L);
        map.put("B", 20L);
        map.put("C", 30L);
         
        JSONObject json = new JSONObject();
        json.accumulateAll(map);
         
        System.out.println(json.toString());
 
         
        List<String> list = new ArrayList<String>();
        list.add("Sunday");
        list.add("Monday");
        list.add("Tuesday");
         
        json.accumulate("weekdays", list);
        System.out.println(json.toString());
         
		 * */
        
	}

}
