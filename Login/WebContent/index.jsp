<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">


<title>EMusicoOo-Elian-Enrique</title>
    <link rel="stylesheet" href="css/style.css" />
    <link rel="stylesheet" href="css/style2.css" />
    <script src="js/jquery.js"></script>
    <script src="js/jquery-ui.min.js"></script>
    <script src="js/login.js"></script>
    
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
                
               
                $.ajax({
                    type: "POST",
                    url: "CtrlRegisterUser",
                    data: dataString,
                    dataType: "json",
                    
                    //if received a response from the server
                    success: function( data, textStatus, jqXHR) {                                                
                        if(data.result){							
                        	$("#ajaxResponse").html("<div><b><font color='black' size='4' >El usuario se registro correctamente</font></b></div>");
                         }                         
                         else {
                             $("#ajaxResponse").html("<div><b><font color='red' size='4' >No se pudo registrar al usuario!</font></b></div>");
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

	<div id="bar">
        <div id="container">
            <!-- Login Starts Here -->
            <div id="loginContainer">
                <a href="#" id="loginButton"><span>Login</span><em></em></a>
                <div style="clear:both"></div>
                <div id="loginBox">                
                    <form id="loginForm" action = "CtrlLogin" method="post">
                        <fieldset id="body">
                            <fieldset>
                                <label for="email">Email Address</label>
                                <input type="text" name="email" id="email" />
                            </fieldset>
                            <fieldset>
                                <label for="password">Password</label>
                                <input type="password" name="password" id="password" />
                            </fieldset>
                            <input  type="submit" id="login" value="Sign in" />
                            <label for="checkbox"><input type="checkbox" id="checkbox" />Remember me</label>
                        </fieldset>
                        <span><a href="#">Forgot your password?</a></span>
                    </form>
                </div>
            </div>
            <!-- Login Ends Here -->
        </div>
    </div>
    
   
    
    <div style="position: relative; width: 100%; ">
	    <div style="position: absolute; left: 0; width: 60%; ">
	       
			<!--   <div id="imagebg">	</div>-->
			<center>
			 <img src="images/music-life.png" alt="EmusicoOo"/> 
			 </center>
				
	    	
	    
	    </div>
	    <div style="position: absolute; right: 0; width: 40%; ">
	    
	    	<!-- Login Starts Here -->
	                              
	                    <form id="RegisterUserForm">
	                        <fieldset id="body">
	                            <fieldset>
	                            	
	                            	<div id="logoEmusico">	</div>
	                            	<br>
	                            	<font color="black" size="5" >REGISTRATE</font> 
	                            	<br>
	                            	<label for="name">Nombre</label>
	                                <input type="text" name="name" id="name" />
	                                
	                                <label for="email">Email</label>
	                                <input type="text" name="email" id="email" />
	                            
	                                <label for="password">Password</label>
	                                <input type="password" name="password" id="password" />
	                            
	                            
	                            <input  type="submit" id="btnRegistrarUsuario"  value="Registrar" />
	                            
	                            <div id="anotherSection">
							        <fieldset>
							                 <div id="ajaxResponse"></div>
							        </fieldset>
							    </div>   
	                            
	                        </fieldset>
	                        </fieldset>
	                        
	                    </form>
	               
	            
	            <!-- Login Ends Here -->
	    
	    
	    	
	    </div>
	</div>


</body>
</html>