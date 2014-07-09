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
                
                var nombre = $("input#nom_user").val(); 
                var mensaje = $("textarea#mensaje").val(); 
               
                
                dataString = "nom_user=" + nombre + "&mensaje=" + mensaje + "&accion=2";
                
				//make the AJAX request, dataType is set to json
                //meaning we are expecting JSON data in response from the server
                
                $.ajax({
                    type: "POST",
                    url: "CtrlAgregarAmigo",
                    data: dataString,
                    dataType: "json",
                    
                    //if received a response from the server
                    success: function( data, textStatus, jqXHR) {
                        
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
             String nom_amigo = (String)request.getAttribute("NomAmigo");

%>       

<div style="position: relative; width: 100%; ">
	    
	        <center>       	
	        
	      		<form id="RegisterUserForm">
	                        <fieldset id="body">
	                            <fieldset>
	                            	
	                            	
	                            	<font color="black" size="5" >AGREGAR AMIGO</font> 
	                            	<br><br>
	                            	
	                                <input type="text" name="nom_user" id="nom_user" value="<%=nom_amigo %>" />
	                                <br><br>
	                                
	                                
	                               <label for="name">Mensaje</label>
	                               
	                               <TEXTAREA name="mensaje" id="mensaje" rows="8" cols="50" placeholder="mensaje">
	                               </TEXTAREA>
	                                <br><br>
	                               	                                
	                                	                            
	                            <fieldset>
	                            
	                            <input  type="submit" id="btnRegistrarUsuario"  value="Agregar" />
	                            
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