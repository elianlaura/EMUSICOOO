<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    

<%@page import="Model.Cancion" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="css/style.css" type="text/css" media="screen"/>
    	<link rel="stylesheet" href="css/skin.css" type="text/css" media="screen"/>
    	<link rel="stylesheet" href="css/style.css" type="text/css" media="screen"/>
    	<link rel="stylesheet" href="css/style2.css" type="text/css" media="screen"/>
<title>Insert title here</title>


<script src="js/jquery.js"></script>
<script src="js/jquery-ui.min.js"></script>
 <script type="text/javascript">
    
	    $(document).ready(function() {
	    	 
	        //Stops the submit request
	        $("#formAgregarAColeccion").submit(function(e){
	               e.preventDefault();
	        });
	        
	        //checks for the button click event
	        $("#btnAdd").click(function(e){
	        	
	        	//alert("btn");
	        	
	        	//get the form data and then serialize that
                dataString = $("#formAgregarAColeccion").serialize();
                
                
                
                /*var nombre = $("input#nom_can").val(); 
                var letra = $("textarea#let_can").val(); 
                var url = $("input#url_can").val(); 
                var art = $("select#cmbArtistas").val(); 
                var cat = $("select#cmbCategorias").val(); 
                
                dataString = "nom_can=" + nombre + "&let_can=" + letra+ "&url_can=" + url+
                			"&cmbArtistas=" + art+ "&cmbCategorias=" + cat;
                
				*/
                
                $.ajax({
                    type: "POST",
                    url: "CtrlDetalleCancion",
                    data: dataString,
                    dataType: "json",
                    
                    //if received a response from the server
                    success: function( data, textStatus, jqXHR) {
                    	 if(data.result){							
                        	$("#ajaxResponse").html("<div><b><font color='red' size='4' >Agregado</font></b></div>");
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
                        $('#btnAdd').attr("disabled", true);
                    },
                    
                    //this is called after the response or error functions are finsihed
                    //so that we can take some action
                    complete: function(jqXHR, textStatus){
                        //enable the button 
                        $('#btnAdd').attr("disabled", false);
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
	    <div style="position: absolute; left: 0; width: 50%; ">
	        <center>
	        	<img src="images/logo4.png" alt="EmusicoOo">
	        <br>
	        <iframe width='640' height='390' src="<%=cancion.m_url %>" frameborder='0' ></iframe>
	        </center>
	    </div>
	    <div style="position: absolute; right: 0; width: 50%; height:600px; overflow:auto;
    						margin:auto;">
	    	<font color='black' size='6' ><%=cancion.m_nombre %> - <%=cancion.m_artista %> ( <%=cancion.m_categoria %>)</font><br>
			
			<form id="formAgregarAColeccion" >
		    	<input type='hidden' name='accion' id='accion' value ='2'/> 
		    	<input type='hidden' name='id_can' id='id_can' value =<%=cancion.m_identificador %>> 
		    	<input type="submit" id="btnAdd" value="Agregar a tu coleccion" style = "  font-size:12px;
								        font-family:Verdana,Helvetica;
								        font-weight:bold;
								        color:white;
								        background:#638cb5;
								        border:1px;
								        width:180px;
								        height:29px; " > 
		    	
		    </form>
		    <div id="anotherSection">
							        <fieldset>
							                 <div id="ajaxResponse"></div>
							        </fieldset>
							    </div>   
			
			<br><font color='black' size='4' ><%=cancion.m_letra.replace("\n", "<br>") %>   </font>
	    </div>
</div>    


	
			

		
		
</body>
</html>