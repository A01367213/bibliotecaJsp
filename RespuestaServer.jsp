<%
    String datos = request.getParameter("datos");
%>

<html>
  <head>
  	<link rel="stylesheet" type="text/css" href="styles/styles.css">
  	<title>WEB Server Tomcat</title>
  </head>
    <body>
        <hr>
        <h2>Datos Capturados: <%= datos %></h2>
        <image align='center' alt='IMAGEN' src='resources/images/pansy.jpg'></image>
    </body>
</html>