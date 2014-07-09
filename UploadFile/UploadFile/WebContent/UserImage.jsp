<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head>

<link rel="stylesheet" href="../css/style.css" type="text/css" media="screen"/>
    	<link rel="stylesheet" href="../css/skin.css" type="text/css" media="screen"/>
    	<link rel="stylesheet" href="../css/style2.css" type="text/css" media="screen"/>


<title>eMusicoOo</title>
</head>
 
<body background='images/fondobody3.jpeg'>
<div style="width:100%;font-size:36px;line-height:48px;background-color:navy;color:white">eMusicoOo</div>

<h2>Nueva canción</h2>
<s:actionerror />
<s:form action="userImage" method="post" enctype="multipart/form-data">
    
   
    
    <s:textfield name="url" label="URL" />
    <s:textfield name="name" label="Nombre" />   
    <s:textarea name="lyric" label="Letra" rows="8" cols="50" />
      
    <s:combobox label="Artista" 
		headerKey="-1" headerValue="--- Select ---"
		list="#{'1':'Stratovarius', '2':'Sirenia', '3':'Loquillo y los trogloditas', '4':'Paramore', 
			'5':'Adele', '6':'Plan B', '7':'Dolores delirio', '8':'Glut',
			'9':'Rio roma', '10':'Balvin', '11':'X-Dinero'}" 
		name="artist" />
		
		
	<s:combobox label="Categoria" 
		headerKey="-1" headerValue="--- Select ---"
		list="#{'1':'Rock', '2':'Metal', '3':'Power Metal', '4':'Salsa', 
			'5':'Alternativo', '6':'Balada', '7':'Regueton'}" 
		name="category" />	
		
    
    <s:file name="userImage" label="Foto" />
    
    <s:submit value="Registrar" align="left" />
    

    
</s:form>
</body>
</html>