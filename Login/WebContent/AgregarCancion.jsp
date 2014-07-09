<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    

<%@page import="Model.Cancion" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="css/style.css" type="text/css" media="screen"/>
    	<link rel="stylesheet" href="css/skin.css" type="text/css" media="screen"/>
    	<link rel="stylesheet" href="css/style2.css" type="text/css" media="screen"/>
<title>EMusicoOo-Elian-Enrique</title>

<script src="js/jquery.js"></script>
<script src="js/jquery-ui.min.js"></script>
 <script type="text/javascript">
    
	    $(document).ready(function() {
	    	 
	        //Stops the submit request
	        $("#RegisterUserForm").submit(function(e){
	               e.preventDefault();
	        });
	        
	        //checks for the button click event
	        $("#btnRegistrarUsuario").click(function(e){
	        	
	        	//alert("btn");
	        	
	        	//get the form data and then serialize that
                dataString = $("#RegisterUserForm").serialize();
                
                //get the form data using another method 
                //var name = $("input#name").val(); 
                //var email = $("input#email").val(); 
                //var pass = $("input#password").val();     
                //dataString = "name=" + name;
                
                //alert($("select#cmbArtistas").val());
                
                var nombre = $("input#nom_can").val(); 
                var letra = $("textarea#let_can").val(); 
                var url = $("input#url_can").val(); 
                var art = $("select#cmbArtistas").val(); 
                var cat = $("select#cmbCategorias").val(); 
                
                dataString = "nom_can=" + nombre + "&let_can=" + letra+ "&url_can=" + url+
                			"&cmbArtistas=" + art+ "&cmbCategorias=" + cat;
                
				//make the AJAX request, dataType is set to json
                //meaning we are expecting JSON data in response from the server
                
                
                $.ajax({
                    type: "POST",
                    url: "CtrlAgregarCancion",
                    data: dataString,
                    dataType: "json",
                    
                    //if received a response from the server
                    success: function( data, textStatus, jqXHR) {
                    	 if(data.result){							
                        	$("#ajaxResponse").html("<div><b><font color='black' size='4' >Registro exitoso</font></b></div>");
                         }                         
                         else {
                             $("#ajaxResponse").html("<div><b><font color='red' size='4' >ERROR!</font></b></div>");
                         }	                                               
                    },
                    
                    //If there was no resonse from the server
                    error: function(jqXHR, textStatus, errorThrown){
                         console.log("Something really bad happened " + textStatus);
                          $("#ajaxResponse").html(jqXHR.responseText);
                    },
                    
                    //capture the request before it was sent to server
                    beforeSend: function(jqXHR, settings){
                        //adding some Dummy data to the request
                        settings.data += "&dummyData=whatever";
                        //disable the button until we get the response
                        $('#btnRegistrarUsuario').attr("disabled", true);
                    },
                    
                    //this is called after the response or error functions are finsihed
                    //so that we can take some action
                    complete: function(jqXHR, textStatus){
                        //enable the button 
                        $('#btnRegistrarUsuario').attr("disabled", false);
                    }
          
                });        	
               
	               
	        });
	     
	    });
    
    </script>

</head>
<body>

<center><br><br>	

<%
             Cancion cancion=(Cancion)request.getAttribute("Cancion");

%>       

<div style="position: relative; width: 100%; ">
	    
	        <center>       	
	        
	      		<form id="RegisterUserForm">
	                        <fieldset id="body">
	                            <fieldset>
	                            	
	                            	
	                            	<font color="black" size="5" >NUEVA CANCION</font> 
	                            	<br><br>
	                            	
	                                <input type="text" name="nom_can" id="nom_can" placeholder="Nombre de la canción" />
	                                <br><br>
	                                
	                                
	                               <label for="name">Letra de la canción</label>
	                               
	                               <TEXTAREA name="let_can" id="let_can" rows="8" cols="50" placeholder="Letra de la canción">
	                               </TEXTAREA>
	                                <br><br>
	                               
	                               
	                                <input type="text" name="url_can" id="url_can" placeholder="URL de la canción" />
	                                <br><br>
	                                
	                                <select  id="cmbArtistas">
										<option value="0">Artista</option>
										<option value="1">Stratovarius</option>
										<option value="2">Sirenia</option>
										<option value="3">Loquillo y los trogloditas</option>
										<option value="4">Paramore</option>
										<option value="5">Adele</option>
										<option value="6">Plan B</option>
										<option value="7">Dolores delirio</option>
										<option value="8">Glut</option>
										<option value="9">Rio roma</option>
										<option value="10">Balvin</option>	
										<option value="11">X-Dinero</option>					
									</select>
	                             	<br><br>
	                             	
	                             	<select id="cmbCategorias" >
										<option value="0">Categoria</option>
										<option value="1">Rock</option>
										<option value="2">Metal</option>
										<option value="3">Power Metal</option>
										<option value="4">Salsa</option>
										<option value="5">Alternativo</option>
										<option value="6">Balada</option>
										<option value="7">Regueton</option>					
									</select>
	                            
	                            <fieldset>
	                            
	                            <input  type="submit" id="btnRegistrarUsuario"  value="Registrar" />
	                            
	                            </fieldset>
	                            
	                            <div id="anotherSection">
							        <fieldset>
							                 <div id="ajaxResponse"></div>
							        </fieldset>
							    </div>   
	                            
	                        </fieldset>
	                        </fieldset>
	                        
	                    </form>
                
	        </center>
	    
	    
</div>    


	
			

		
		
</body>
</html>