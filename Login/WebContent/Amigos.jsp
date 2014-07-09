<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
 <head>
        <title>EMusicoOo</title>
    
    
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="keywords" content="music, audio, html5, player, playlist, template, portfolio, artist, band, albums, discography, jquery"/>
		<link rel="shortcut icon" href="../favicon.ico" type="image/x-icon"/>
		
        <link rel="stylesheet" href="css/style.css" type="text/css" media="screen"/>
    	<link rel="stylesheet" href="css/skin.css" type="text/css" media="screen"/>
    	<link rel="stylesheet" href="css/style2.css" type="text/css" media="screen"/>
    	
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
                    url: "CtrlListarAmigo",
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
                          $("#ajaxResultAmigos").html(jqXHR.responseText);
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
    
    <script type="text/javascript">
    
	    $(document).ready(function() {
	    	 
	        //Stops the submit request
	        $("#frmSearch").submit(function(e){
	               e.preventDefault();
	        });
	        
	        //checks for the button click event
	        $("#btnSearch").click(function(e){
	        	//alert("buscando");
	        	
	        	//get the form data and then serialize that
                dataString = $("#frmSearch").serialize();
                
                //get the form data using another method 
                //var name = $("input#name").val(); 
                //var email = $("input#email").val(); 
                //var pass = $("input#password").val();     
                //dataString = "name=" + name;
                
				//make the AJAX request, dataType is set to json
                //meaning we are expecting JSON data in response from the server
                $.ajax({
                    type: "POST",
                    url: "CtrlBuscarAmigo",
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
                          $("#ajaxResultBuscarAmigos").html(jqXHR.responseText);
                    },
                    
                    //capture the request before it was sent to server
                    beforeSend: function(jqXHR, settings){
                        //adding some Dummy data to the request
                        settings.data += "&dummyData=whatever";
                        //disable the button until we get the response
                        $('#btnSearch').attr("disabled", true);
                    },
                    
                    //this is called after the response or error functions are finsihed
                    //so that we can take some action
                    complete: function(jqXHR, textStatus){
                        //enable the button 
                        $('#btnSearch').attr("disabled", false);
                    }
          
                });        	
               
	               
	        });
	     
	    });
    
    </script>
			<script type="text/javascript">
			$(function() {
				/**
				* build the carousel for the Albums
				*/
				$('#mp_albums').jcarousel({
					scroll : 3
				}).children('li')
				  .bind('click',function(){
					//when clicking on an album, display its info, and hide the current one
					var $this = $(this);
					$('#mp_content_wrapper').find('.mp_content:visible')
											.hide();
											
												$('#mp_content_wrapper')
												.find('.mp_content:nth-child('+ parseInt($this.index()+1) +')')
											    .fadeIn(1000);
											
			});

				/****  The Player  ****/
				// Local copy of jQuery selectors, for performance.
				var jpPlayTime = $("#jplayer_play_time");
				var jpTotalTime = $("#jplayer_total_time");
				var $list 		= $("#jplayer_playlist ul");

				/**
				* Innitialize the Player 
				* (see jPlayer documentation for other options)
				*/
				$("#jquery_jplayer").jPlayer({
					oggSupport	: true,
					preload		:"auto"
				})
				.jPlayer("onProgressChange", 
					function(loadPercent, playedPercentRelative, playedPercentAbsolute, playedTime, totalTime) {
					jpPlayTime.text($.jPlayer.convertTime(playedTime));
					jpTotalTime.text($.jPlayer.convertTime(totalTime));
				})
				.jPlayer("onSoundComplete", function() {
					playListNext();
				});

				/**
				* click previous button, plays previous song
				*/
				$("#jplayer_previous").bind('click', function(){
					playListPrev();
					$(this).blur();
					return false;
				});

				/**
				* click next button, plays next song
				*/
				$("#jplayer_next").bind('click', function() {
					playListNext();
					$(this).blur();
					return false;
				});

				/**
				* plays song in position i of the list of songs (playlist)
				*/
				function playSong(i){
					var $next_song 		= $list.find('li:nth-child('+ i +')');
					var mp3				= $next_song.find('.mp_mp3').html();
					var ogg				= $next_song.find('.mp_ogg').html();
					$list.find('.jplayer_playlist_current').removeClass("jplayer_playlist_current");
					$next_song.find('a').addClass("jplayer_playlist_current");
					$("#jquery_jplayer").jPlayer("setFile", mp3, ogg).jPlayer("play");
				}

				/**
				* plays the next song in the playlist
				*/
				function playListNext() {
					var $list_nmb_elems = $list.children().length;
					var $curr 			= $list.find('.jplayer_playlist_current');
					var idx				= $curr.parent().index();
					var index 			= (idx < $list_nmb_elems-1) ? idx+1 : 0;
					playSong(index+1);
				}

				/**
				* plays the previous song in the playlist
				*/
				function playListPrev() {
					var $list_nmb_elems = $list.children().length;
					var $curr 			= $list.find('.jplayer_playlist_current');
					var idx				= $curr.parent().index();
					var index 			= (idx-1 >= 0) ? idx-1 : $list_nmb_elems-1;
					playSong(index+1);
				}
				
				/**
				* User clicks the play icon on one of the songs listed for an Album.
				* Adds it to the Playlist, and plays it
				*/
				function addFirst(song_idx,name,mp3,ogg) {
					$list.empty();
					/**
					* each song element in the playlist has:
					* - span for the close / remove action
					* - the mp3 path
					* - the ogg path
					*/
					var song_html = "<a href='#' class='jplayer_playlist_current' tabindex='1'>" + name + "</a>";
					song_html 	 += "<span></span>";
					song_html 	 += "<div class='mp_mp3' style='display:none;'>"+mp3+"</div>";
					song_html 	 += "<div class='mp_ogg' style='display:none;'>"+ogg+"</div>";
					var $listItem = $("<li/>",{
						id			: song_idx,	
						className	: 'jplayer_playlist_current',
						html 		: song_html
					});
					$list.append($listItem);
					//event to play the song when User clicks on it
					$listItem.find('a').bind('click',clickSong);
					//event to remove the song from the playlist when User clicks the remove button
					$listItem.find('span').bind('click',removeSong);
					//start playing it
					$("#jquery_jplayer").jPlayer("setFile", mp3, ogg).jPlayer("play");
					jpTotalTime.show();
					jpPlayTime.show();
				}
				
				/**
				* adds a song to the playlist, if not there already.
				* if it is the only one, start playing it
				*/
				function addToPlayList(song_idx,name,mp3,ogg) {
					var $list_nmb_elems = $list.children().length;
					//if already in the list return
					if($list.find('#'+song_idx).length)
						return;
					//class for the current song being played
					var c = '';
					if($list_nmb_elems == 0)
						c = 'jplayer_playlist_current';
					var song_html = "<a href='#' class="+c+" tabindex='1'>" + name + "</a>";
					song_html 	 += "<span></span>";
					song_html 	 += "<div class='mp_mp3' style='display:none;'>"+mp3+"</div>";
					song_html 	 += "<div class='mp_ogg' style='display:none;'>"+ogg+"</div>";
					var $listItem = $("<li/>",{
						id			: song_idx,	
						html 		: song_html
					});
					$list.append($listItem);
					//if its the only song play it
					if($list_nmb_elems == 0){
						$("#jquery_jplayer").jPlayer("setFile", mp3, ogg).jPlayer("play");
						jpTotalTime.show();
						jpPlayTime.show();
					}
					$listItem.find('a').bind('click',clickSong);
					$listItem.find('span').bind('click',removeSong);
				}
				
				/**
				* removes a song from the playlist.
				* if the song was the current one, and there are more songs 
				* in the playlist, then plays the next one.
				* if there are no more, stops the player, and removes the status bar
				* otherwise keeps playing whatever song was being played
				*/
				function removeSong() {
					var $this 	= $(this); 
					var current = $this.parent().find('a.jplayer_playlist_current').length;
					$this.parent().remove();
					var $list_nmb_elems = $list.children().length;
					if($list_nmb_elems > 0 && current)
						playListNext();
					else if($list_nmb_elems == 0){
						$("#jquery_jplayer").jPlayer("clearFile");
						jpTotalTime.hide();
						jpPlayTime.hide();
					}	
					return false;
				}
				
				/**
				* User clicks on a song in the playlist. Plays it
				*/
				function clickSong() {
						var index = $(this).parent().index();
						playSong(index+1);
						return false;
				}
				
				/**
				* The next are the events for clicking on both "play" and "add to playlist" icons
				*/
				$('#mp_content_wrapper').find('.mp_play').bind('click',function(){
					var $this 		= $(this);
					var $paths		= $this.parent().siblings('.mp_song_info');
					var title   	= $paths.find('.mp_song_title').html();
					var mp3			= $paths.find('.mp_mp3').html();
					var ogg			= $paths.find('.mp_ogg').html();
					var album_id 	= $this.closest('.mp_content').attr('id');
					var song_index	= $this.parent().parent().index();
					var song_idx	= album_id + '_' + song_index;
					//add to playlist and play the song
					addFirst(song_idx,title,mp3,ogg);
				});
				$('#mp_content_wrapper').find('.mp_addpl').bind('click',function(){
					var $this 		= $(this);
					var $paths		= $this.parent().siblings('.mp_song_info');
					var title   	= $paths.find('.mp_song_title').html();
					var mp3			= $paths.find('.mp_mp3').html();
					var ogg			= $paths.find('.mp_ogg').html();
					var album_id 	= $this.closest('.mp_content').attr('id');
					var song_index	= $this.parent().parent().index();
					var song_idx	= album_id + '_' + song_index;
					//add to playlist and play the song if none is there
					addToPlayList(song_idx,title,mp3,ogg);
				});
				
				/**
				* we want to show on the album image, the play button for playing the whole album
				*/
				$('#mp_content_wrapper').find('.mp_content').bind('mouseenter',function(){
					var $this 		= $(this);
					$this.find('.mp_playall').show();
				}).bind('mouseleave',function(){
					var $this 		= $(this);
					$this.find('.mp_playall').hide();
				});
				
				/**
				* to play the whole album, we play the first song and add all the others to the playlist.
				* playing the first one, guarantees us that the playlist is set to empty before
				*/
				$('#mp_content_wrapper').find('.mp_playall').bind('click',function(){
					var $this 		= $(this);
					var $album		= $this.parent();
					$album.find('.mp_play:first').trigger('click');
					$album.find('.mp_addpl').trigger('click');
				})
				
				/**
				* playlist songs can be reordered
				*/
				$list.sortable();
				$list.disableSelection();
				
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
				        <li class="sub-menu"><a href="CtrlVerLetra">Letras</a>
				        	<ul>
				                <li><a href="faces/Favoritos.xhtml"  target="_new" >Favoritas</a></li>
				                </li>
				                 <li><a href="faces/Coleccion.xhtml"  target="_new" >Coleccion</a></li>
				                </li>
				            </ul>
				        </li>
				        <li class="current"><a href="Amigos.jsp">Amigos</a></li>
				        
				    </ul>
				    <div class="clear"></div>
				</nav>
				<div class="soc-icons">
				<ul>
					<li><a href="index.jsp">Salir&nbsp;</a></li>
					<li><a href="https://www.facebook.com"><img src="images/facebook.png" alt=""></a></li>
					<li><a href="https://www.twitter.com"><img src="images/twitter.png" alt=""></a></li>
				</ul>
				</ul>
			</div>
			<div class="clear"></div>
		</div>
	</div>
	
	
	
		<div class="header_top">
		 	<div class="header_top_right">
			 	<div class="search_box">
				    <form id="frmSearch" >
				    	<input type="text" name="buscar" value="Buscar Amigos" onfocus="this.value = '';" onblur="if (this.value == '') {this.value = 'Search Lyrics';}">
				    	<!-- <input type="submit" value="SEARCH"> -->
				    	<input type="submit" id="btnSearch" value="SEARCH"> 
				    	
				    </form>
			    </div>
			    
			</div>		
		</div>
	
	<div class = "header_bottom_left">
		<div id="resultCanciones">
			<div class="content">
				<h2>Resultados:</h2>
	    		<fieldset> <div id="ajaxResultBuscarAmigos"></div> </fieldset>
	    	</div>				
	   	</div>
   </div>
		
		    
	 <div class="header_bottom_right_images">
		    <form id="RegisterUserForm"  >	
		    	<fieldset>			    	
				    	<input type="submit" id="btnRegistrarUsuario" value="AMIGOS">
				    	 	
				    	 
				</fieldset>
				
				<fieldset>
				<div id="ajaxResultAmigos"></div>    	
				</fieldset>			    	
			</form>
	  </div>
	     <div class="clear"></div>    

	
</div>

</body>
</html>