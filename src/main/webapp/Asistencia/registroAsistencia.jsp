<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "com.unu.WebApplication.beans.*" %>
<%@ page import = "java.util.*"%>

<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style >

	.class_li{
	border:1px solid rgb(0,0,0);display: inline-block;margin-right: 20px;
	}

</style>
</head>

<body>

<%
String url = "http://localhost:8080/WebProjectTrabajadores/";
List<Object[]> listaTrabajador= (List<Object[]>) request.getAttribute("listaTrabajador");
//String listaTrabajadorJson = new Gson().toJson(listaTrabajador);
//List<Object[]> listaTrabajador= (List<Object[]>) request.getAttribute("listaTrabajador");
%>

<div class = "menu">
		<a type = "button" href = "#">RREGISTRO TRABAJADOR</a>
		<a type = "button" href = "#">ASISTENCIA</a>
</div>



<div class = "content">
	<form action="<%=url%>AsistenciaController">
		
			<input type = "hidden" id = "op" name = "op" value = "insertar">
			
			<label for = "condicion">Condicion laboral</label>
			<select id="condicion" name="condicion">
  				<option value="" disabled selected>Seleccionar una opción</option>
    			<option value="contratado">Contratado</option>
    			<option value="nombrado">Nombrado</option>
			</select>
			
			<label for = "fecha">Fecha</label>
			<input type = "date" id = "fecha" name = "fecha" required>
			
			<label for = "justificacion">Justificacion</label>
			<input type = "text" id = "justificacion" name = "justificacion" required>
		
		<div class = "agregarTrabajador">
		
			<select id="idtrabajador" name="idtrabajador">
  				<option value="" disabled selected>Seleccionar una opción</option>
  <% 
    		if (listaTrabajador != null) {
      			for (Object[] t : listaTrabajador) { 
  %>
    			<option value="<%=t[0]%>" ><%=String.valueOf( "" + t[1] + "-" + t[3])%></option>
  <%
      			}
   		 	} 
  %>
			</select>

			<a type = "button" href = "#" onclick='InsertarTrabajador()'>Agregar</a>
	
		</div>
	
		
			<div>
			
				<table>
				<thead>
					<tr>
						<th>ITEM</th>
						<th>TRABAJADOR</th>
						<th>SUELDO</th>
						<th>ELIMNAR</th>
					</tr>
				</thead>
				<tbody id = "listaTrabajdores">
					
				</tbody>
			</table>
				
				
			
			</div>
					
						
		<input type = "submit" value = "Guardar asistencia"> <br>
		<a type = "button" href = "<%=url%>">Cancelar</a>
		
	</form>
		


</div>
<script>
let countItems = 0;

	function InsertarTrabajador() {
		const comboTrabajador = document.getElementById('idtrabajador');
		const indexSelected = comboTrabajador.selectedIndex;
	 	if (indexSelected !== 0) {
	 		
	 		let trabajador = comboTrabajador.options[indexSelected].innerText;
	 		let [nombres, sueldo] = trabajador.split("-");
	 		
	 		 // Crear los elementos <tr> para la fila
		 	const lista = document.createElement('tr');
		 	countItems++;

		 	// Crear celdas <td> para los valores
		 	const li_item = document.createElement('td');
		 	li_item.innerText = countItems;

		 	const li_nombre = document.createElement('td');
		 	li_nombre.innerText = nombres;  // Aquí puedes reemplazar por el nombre real

		 	const li_sueldo = document.createElement('td');
		 	li_sueldo.innerText = sueldo;  // Aquí puedes reemplazar por el sueldo real

		 	// Crear la celda para el botón de eliminar
		 	const li_eliminar = document.createElement('td');
		 	const button_eliminar = document.createElement('a');
		 	button_eliminar.type = "button";  // Especifica el tipo de botón
		 	button_eliminar.href = "#";
		 	button_eliminar.innerText = "Eliminar";
		 	button_eliminar.onclick = function() {
		 	// Obtener los valores de los td
				const nombreEliminar = li_nombre.innerText;
				const sueldoEliminar = li_sueldo.innerText;

				// Crear un nuevo option en el combo (select) con los valores de "nombres-sueldo"
				const option = document.createElement('option');
				option.innerText = `${nombreEliminar}-${sueldoEliminar}`;  // Formato "nombres-sueldo"
				comboTrabajador.appendChild(option);  // Añadir la opción al final del combo

				// Eliminar la fila de la tabla
				lista.remove();
		 		};
		 	li_eliminar.appendChild(button_eliminar);

		 	// Añadir las celdas <td> a la fila <tr>
		 	lista.appendChild(li_item);
		 	lista.appendChild(li_nombre);
		 	lista.appendChild(li_sueldo);
		 	lista.appendChild(li_eliminar);

		 	// Añadir la fila a la tabla
		 	const ContentList = document.getElementById('listaTrabajdores');
		 	ContentList.appendChild(lista);
	 		
	 		
	 		
			 comboTrabajador.options[indexSelected].remove();
			 comboTrabajador.selectedIndex = 0;
			 
			 
			 
			 
		 }
	}

</script>
</body>
</html>