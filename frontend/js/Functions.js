// Function to add the points of the markers on the map
export function addPointsToMap(points, map){
    points.forEach(point => {
        const parking_point = L.marker([point.ubicacion[0], point.ubicacion[1]], {
            id: point.id,
            id_municipality: point.id_municipio,
            municipality_name: point.nombre,
            latitude: point.ubicacion[0],
            longitude: point.ubicacion[1],
            current_occupation: point.ocupacion_actual,
            current_capacity: point.capacidad_actual,
            maximum_capacity: point.capacidad_maxima
        }).addTo(map);
        /* parking_point.on("mouseover",function () { 
            alert("mmmm");
        }); */

        // With the function on, add a eventlistener and it's function
        parking_point.on('click', () => {
            // Modify the innerText of the element, also, the data of the marker store in the options
            $('#parking_number').text(parking_point.options.id);
            $("#municipality").text("Municipio: " + parking_point.options.municipality_name);
            $("#parking_position").text("Posición: Latitud=" + parking_point.options.latitude + " | Longitud= " + parking_point.options.longitude);
            $("#ocupation_data").text("Ocupación actual: " + parking_point.options.current_occupation + "  | Capacidad actual: " + parking_point.options.current_capacity + "  | Capacidad máxima: " + parking_point.options.maximum_capacity);
            $('#myModal').modal('show');
            getBusesForParking(parking_point.options.id);
        });
    });

    addParkingsList();
}

export function updateBus(id_bus, id_parqueadero, departure_time, arrival_time) {

    let bus_data = {
        id_bus,
        id_parqueadero,
        departure_time,
        arrival_time,
        _method: "PUT"
    }
    let update = () => $.ajax({
        type: "PUT",
        url: "http://127.0.0.1:3000/api/buses/actualizar-bus", 
        contentType: "application/json",
        cache: false,
        data: JSON.stringify(bus_data),
        async: true,
        success: function (response) {
            console.log(response);
            if(response.answer === "Parking bussy"){
                const message_alert = $("#alert_request");
                // This remove all of the clases of the element and set news again
                message_alert.attr("class", "alert alert-danger");
                message_alert.text(`El parqueadero al que hace referencia no tiene suficiente ocupacion actual`);
            }else{
                const message_alert = $("#alert_request");
                // This remove all of the clases of the element and set news again
                message_alert.attr("class", "alert alert-success");
                message_alert.text(`Parquedero del bus ${id_bus} actualizado exitosamente`);
                $("tr#" + id_bus).remove();
                // TODO: VER EL TEMA DE CACHE DE AJAX...
            }
        },
        error: function(error) {
            console.log("Error in the update of the bus to the api of the parkings , the reason: " + error);
            const message_alert = $("#alert_request");
                // This remove all of the clases of the element and set news again
                message_alert.attr("class", "alert alert-danger");
                message_alert.text(`Lo sentimos, hubo un error al intentar actualizar el parqueadero del bus, intente de nuevo después`);
        }
    });
    update();
}

function getBusesForParking(id){
    let getBuses = () => $.ajax({
        type: "GET",
        url: "http://127.0.0.1:3000/api/buses-por-parqueadero/" + id,
        async: true,
        cache: false,
        success: function (response) {
            console.log("Successfull");
            console.log(response);
            const message_alert = $("#alert_request");
            if(response.answer === "false"){
                // This remove all of the clases of the element and set news again
                message_alert.attr("class", "alert alert-danger");
                message_alert.text(`El parqueadero no contiene buses actualmente`);
                $("#table-body").html("");
                return;
            }else{
                message_alert.attr("class", "alert");
                message_alert.text(``);
                addBusesOnTable(response);
            }
            
        },
        error: function(error) {
            console.log("Error in the request to the api of the buses in the parking, the reason: " + error);
        }
    });
    getBuses();
}

function addBusesOnTable(response){

    // Get the tbody to present the data, first reset the html content
    const table_body = $("#table-body").html("");
    console.log("Listas de parqueaderos: ");
    addParkingsList();

    for (let i = 0; i < response.length; i++) {
        // Then, add the new content
        const file = $(`<tr></tr>`);
        const bus = response[i];
        file.attr("id", bus.bus_id);
        let data = $(`<td>${bus.bus_id}</td>`);
        file.append(data);
        data = $(`<td>${bus.tiempo_estadia}</td>`);
        file.append(data);
        data = $(`<td><input id="arrival_time_${bus.bus_id}" name="arrival_time_${bus.bus_id}" type="datetime-local" value="${bus.hora_llegada_destino}"></input></td>`);
        file.append(data);
        data = $(`<td><input id="departure_time_${bus.bus_id}" name="departure_time_${bus.bus_id}" type="datetime-local" value="${bus.hora_salida_origen}"></input></td>`);
        file.append(data);        
        table_body.append(file); 
    
    }

}

function addParkingsList() {

    let getParkings = () => $.ajax({
        type: "GET",
        url: "http://127.0.0.1:3000/api/parqueaderos",
        async: true,
        cache: false,
        success: function (response) {
            console.log("Successful for parkings:");
            console.log(response);
            addParkingsSelect(response);
        },
        error: function(error) {
            console.log("Error in the request to the api of the parkings , the reason: " + error);
        }
    });

    getParkings();
    
}

function addParkingsSelect(response) {

    const select = $("#parking_select");
    select.html("");
    const selected = $("<option selected>Seleccionar parqueadero destino</option>");
    select.append(selected);

    for (let i = 0; i < response.length; i++) {
        const parking = response[i];
        const option = $(`<option value='${parking.id}'>${parking.id} - ${parking.nombre}</option>`);
        select.append(option);
    }
}

