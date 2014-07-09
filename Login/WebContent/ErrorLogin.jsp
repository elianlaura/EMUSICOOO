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
</head>
<body>

<center><br><br>	

<%
             Cancion cancion=(Cancion)request.getAttribute("Cancion");

%>       

<div style="position: relative; width: 100%; ">
	    
	        <center>
	        	<img src="images/oops.png" alt="oops">
	        
	      		<br><br>
	      		<font color='red' size='6' >Datos incorrectos</font>
	        </center>
	    
	    
</div>    


	
			

		
		
</body>
</html>