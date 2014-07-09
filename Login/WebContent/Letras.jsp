<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ page import="java.util.Vector" language="java" %>
<%@page import="Model.Cancion" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
 <head>
        <title>EMusicoOo</title>
    
    
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="keywords" content="music, audio, html5, player, playlist, template, portfolio, artist, band, albums, discography, jquery"/>
		<link rel="shortcut icon" href="../favicon.ico" type="image/x-icon"/>
		
        <link rel="stylesheet" href="css/style.css" type="text/css" media="screen"/>
    	<link rel="stylesheet" href="css/style2.css" type="text/css" media="screen"/>
    	<link rel="stylesheet" href="css/skin.css" type="text/css" media="screen"/>
    	
		<link href="css/jplayer.codrops.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
		<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.2/jquery-ui.min.js"></script>
		<script src="js/jquery.jcarousel.min.js" type="text/javascript"></script>
		<script src="js/cufon-yui.js" type="text/javascript"></script>
		<script type="text/javascript" src="js/jquery.jplayer.min.js"></script>
		<script src="js/ChunkFive_400.font.js" type="text/javascript"></script>
		<script src="js/script.js" type="text/javascript"></script>
		<script src="js/superfish.js"></script>
		<script type="text/javascript">
			Cufon.replace('h2,h3,a',{
				textShadow: '1px 1px 1px #000000'
			});
			</script>
			
<script type="text/javascript">
    
	    $(document).ready(function() {
	    	 
	        //Stops the submit request
	        $("#RegisterUserForm").submit(function(e){
	               e.preventDefault();
	        });
	        
	        //checks for the button click event
	        $("#btnRegistrarUsuario").click(function(e){
	        	//get the form data and then serialize that
                dataString = $("#RegisterUserForm").serialize();
                
                //get the form data using another method 
                //var name = $("input#name").val(); 
                //var email = $("input#email").val(); 
                //var pass = $("input#password").val();     
                //dataString = "name=" + name;
                
				//make the AJAX request, dataType is set to json
                //meaning we are expecting JSON data in response from the server
                $.ajax({
                    type: "POST",
                    url: "CtrlVerLetra",
                    data: dataString,
                    dataType: "json",
                    
                    //if received a response from the server
                    success: function( data, textStatus, jqXHR) {
                        //our country code was correct so we have some information to display
                         alert(data.msg);	
                         alert(data.result);	
                        
                        /*if(data.success){
							alert(data.msg);							
                         } 
                         //display error message
                         else {
                             $("#ajaxResponse").html("<div><b>Country code in Invalid!</b></div>");
                         }*/
                    },
                    
                    //If there was no resonse from the server
                    error: function(jqXHR, textStatus, errorThrown){
                         console.log("Something really bad happened " + textStatus);
                          $("#ajaxResultLetras").html(jqXHR.responseText);
                    },
                    
                    //capture the request before it was sent to server
                    beforeSend: function(jqXHR, settings){
                        //adding some Dummy data to the request
                        settings.data += "&dummyData=whatever";
                        //disable the button until we get the response
                        $('#btnBuscarLetras').attr("disabled", true);
                    },
                    
                    //this is called after the response or error functions are finsihed
                    //so that we can take some action
                    complete: function(jqXHR, textStatus){
                        //enable the button 
                        $('#btnBuscarLetras').attr("disabled", false);
                    }
          
                });        	
               
	               
	        });
	     
	    });
    
    </script>
</head>
<body>


<div class="wrap">
	<div class="header">
		<div class="logo"> <a href="index.jsp"><img src="images/logo4.png" alt="" /></div></a>
			
			<!--menu-->
		<div class="menu-bg">
		<div class="wrap" style="box-shadow: none;">
				<nav>
				  <ul class="sf-menu">
				        <li><a href="main.jsp">Perfil</a></li>
				        <li><a href="AgregarCancion.jsp">Agregar</a></li>
				        <li class="current"><a href="CtrlVerLetra">Letras</a>
				        </li>
				        <li ><a href="Amigos.jsp">Amigos</a></li>
				        <li><a href="faces/Favoritos.xhtml" target="_new">Mias</a></li>
				    </ul>
				    <div class="clear"></div>
				</nav>
				<div class="soc-icons">
				<ul>
					<li><a href="index.jsp">Salir&nbsp;</a></li>
					<li><a href="https://www.facebook.com"><img src="images/facebook.png" alt=""></a></li>
					<li><a href="https://www.twitter.com"><img src="images/twitter.png" alt=""></a></li>
				</ul>
			</div>
			<div class="clear"></div>
		</div>
	</div>
	</div>
	
	<%
             Cancion cans=(Cancion)request.getAttribute("cans");
			Vector<Cancion> listacans = new Vector<Cancion>();
			listacans = cans.listaCanciones;
			String url;
			int sz = 0;
			if(listacans == null)
				url = "null";
			else{
				url = listacans.get(0).m_url;
				sz = listacans.size();
			}

%> 
 		
		    <!--
		    <div class="header_bottom_right_images">
		    <form id="RegisterUserForm"  >	
		    	<fieldset>			    	
				    	<input type="submit" id="btnBuscarLetras" value="LETRAS DE CANCIONES">
				    	 	
				    	 
				</fieldset>
				
				<fieldset>
				<div id="ajaxResultLetras"></div>    	
				</fieldset>			    	
			</form> -->
<div style="position: relative; width: 100%; ">
			<div style="position: absolute; left: 0; width: 65%; ">
					<form id="CancionesForm">	
						<table CELLSPACING="5" Width="700"> 
						<th COLSPAN=4 BGCOLOR="#6D8FFF"> 
							<font color='white' size='5' >Canciones EMUSICoOo</font>
						</th>
						<tr>
					    	<th WIDTH="200">
						    	<font color='black' size='5' > Título de la Canción</font>
						    </th>
						    <th WIDTH="150">
						    	<font color='black' size='5' > Artista</font>
						    </th>
						    <th WIDTH="100">
						    	<font color='black' size='5' > Categoría</font>
						    </th>
						    <th WIDTH="50">
						    	
						    </th>
						</tr>
					    <%  for(int i=0; i< sz; i++) {
					    		Cancion cancion = listacans.get(i);
					    %>
					    <tr>
					    	<td WIDTH="200">
						    	<font color='black' size='4' > <%=cancion.m_nombre%> </font>
						    </td>
					    	<td WIDTH="150">
						    	<font color='black' size='4' > <%=cancion.m_artista %> </font>
						    </td>
						    <td WIDTH="100">
								<font color='black' size='4' ><%=cancion.m_categoria %> </font>
							</td>
							<td WIDTH="50">
							
							
								<form  action = "CtrlDetalleCancion" method="get">
							
									<input type="hidden" id="id_can" name="id_can"  value="<%=cancion.m_identificador%>" >
									<input type="submit" id="btnVerDetalleCancion" value="Detalles">
								</form>
							
							</td>
						</tr>
					    <% } %>
					    </table>
					</form> 
			</div>
	 
	    	<div style="position: absolute; right: 0; width: 35%; height:600px; overflow:auto;margin:auto;">
		    			 
		    			<center>
				        	<iframe width='340' height='250' src="https://www.youtube.com/embed/07G2Fzj3riU" frameborder='0' ></iframe>
				        </center>
					
					
	    	</div>
	    	
</div>
</div>

</body>
</html>