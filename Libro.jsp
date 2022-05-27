<%@ page import="java.io.*"%>
<%--<%@ page import="modelBanco.BancoADjdbc"%>--%>

<jsp:useBean id="libro" class="modelLibro.BiblioADjdbc"/>
<jsp:useBean id="librodp" class="modelLibro.LibroDP"/>
<jsp:setProperty name="librodp" property="*"/>


<%
	if (request.getParameter("bCapturar") == null && request.getParameter("bConsultar") == null && request.getParameter("bConsultarEdit") == null && request.getParameter("bConsultarTitulo") == null){
%>


<html>
  <head>
    <title>Apache y Servlet</title>
    <link rel="stylesheet" type="text/css" href="styles/styles.css">
    <meta charset="utf-8">
    <script type="text/javascript" src="js/funciones.js"></script>
</head>
    <body style="background-image: url('resources/images/cardinal.jpg')">
        <h1>LaBiblio</h1>
        <br>
        <br>
        <br>
        <br>
        <br>
        <br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>

        <form action='../bibliotecaJsp/Libro.jsp' method='get' style="height: 40%; flex-direction: unset; border-radius: 30px;">
            <table>
                <tr>
                    <td>TITULO: </td>
                    <td colspan="3"><input type='text' name='titulo' id='titulo' value=''><br/></td>
                </tr>
                <tr>
                    <td>AUTOR: </td>
                    <td colspan="3"><input type='text' name='autor' id="autor" value=''><br/></td>
                </tr>
                <tr>
                    <td>EDITORIAL: </td>
                    <td colspan="3"><input type='text' name='editorial' id="editorial" value=''><br/></td>
                </tr>
                <tr>
                    <td><input type='submit' name='bCapturar' value='Capturar Datos'></td>
                    <td><input type='submit' name='bConsultar' value='Consultar Libros'></td>
                    <td><input type='submit' name='bConsultarEdit' value='Consultar Editorial'></td>
                    <td><input type='submit' name='bConsultarTitulo' value='Consultar Titulo'></td>
                </tr>
                <tr>
                    <td colspan="2"><input type='button' name='bConsultarJson'     id='bConsultarJson'     value='Consultar Libros JSON'    onclick='consultar()'></td>
                    <td colspan="2"><input type='button' name='bConsultarEditJson' id='bConsultarEditJson' value='Consultar Editorial JSON' onclick='consultarEdit()'></td>
                </tr>
                <tr>
                    <td colspan="4"><input type='button' name='bConsultarTitJson' id='bConsultarTitJson' value='Consultar Título JSON' onclick='consultarTit()'></td>
                </tr>

            </table>  
            <br/><br/>            
        </form>
        <h1>Resultados:</h1>
        <div id='operacion'></div>
    </body>
</html>
<%
	}

	//Atributos
	

	else{
		//BancoADjdbc banco = new BancoADjdbc();
		String datos, respuesta;

		if (request.getParameter("bCapturar") != null){
			//response.sendRedirect("RespuestaServer.jsp?datos=Capturar datos...");

			// 2.1 Obtener datos del URL String
			//datos = obtenerDatos(request);
			datos = librodp.toString();

			// 2.2 Capturar datos en BD
			//respuesta = banco.capturar(datos);
			//respuesta = datos;
			respuesta = libro.capturar(librodp);

			// 2.3 Enviar al server el resultado de la transaccion
			response.sendRedirect("RespuestaServer.jsp?datos="+respuesta);
		}
		if (request.getParameter("bConsultar") != null){
			//response.sendRedirect("RespuestaServer.jsp?datos=Consultar datos...");

			//1 Consultar datos de la BD
			datos=libro.consultarLibros();

			//2 Mostrar los datos
			//response.sendRedirect("RespuestaServer.jsp?datos="+datos);
			respuestaServer(response,datos);
		}
		if (request.getParameter("bConsultarEdit") != null){
			//response.sendRedirect("RespuestaServer.jsp?datos=Consultar no. cuenta...");

			//String nocta = request.getParameter("nocta");
			String edit = librodp.getEditorial();

			datos=libro.consultarEditorial(edit);
			//response.sendRedirect("RespuestaServer.jsp?datos="+datos);
			%>
			<jsp:forward page ="RespuestaServerTabla.jsp">
				<jsp:param name="datos" value="<%=datos%>"/>
			</jsp:forward>

			<%
		}
		if (request.getParameter("bConsultarTitulo") != null){
			//response.sendRedirect("RespuestaServer.jsp?datos=Consultar tipo cuenta...");
			
			//Obtener tipo de cuenta a consultar
			//String tcta = request.getParameter("tipo");
			String titulo = librodp.getTitulo();

			//Consultar cliente con ese tipo de cuenta
			datos=libro.consultarTitulo(titulo);

			//Mostrar datos
			//response.sendRedirect("RespuestaServer.jsp?datos="+datos);
			%>
			<jsp:forward page ="RespuestaServerTabla.jsp">
				<jsp:param name="datos" value="<%=datos%>"/>
			</jsp:forward>

			<%
		}
	}
%>

<%!
	//Metodos
	private String obtenerDatos(HttpServletRequest request){
		String titulo, autor, editorial, datos;

		titulo = request.getParameter("titulo");
		autor = request.getParameter("autor");
		editorial = request.getParameter("editorial");

		datos = titulo+"_"+autor+"_"+editorial;

		return datos;
	}

	private void respuestaServer(HttpServletResponse response, String datosJson) throws IOException{
		PrintWriter salidaServer = response.getWriter();
		response.setContentType("text/plain");

		salidaServer.println(datosJson);
	}
%>