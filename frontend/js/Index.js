// Index.js is the main file, this file load all of the app
import {addPointsToMap, updateBus} from "./Functions.js";

// This is the first action to be secure of the script only load when the DOM is full loaded
/**
 * to jQuery, $(element).action
*/
$(document).ready(function() {

    // Load the map
    const center_point = [4.60971, -74.08175]; // This central point to reference on the map load
    const map = L.map('map').setView(center_point, 9);

    L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', {
        maxZoom: 19,
        attribution: '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>'
    }).addTo(map);

    $("button#info-btn").on("click", () => alert("Para actualizar la información, cierra la ventana y abrela de nuevo"));

    // Get the points of the map og the API, the AJAX request stored in a function
    let parking_points = function () {
        $.ajax({
            type: "GET",
            url: "http://127.0.0.1:3000/api/parqueaderos",
            cache: false,
            // This means that the answer should be in JSON format
            // ? why if the request put the contentType: "application/json", the server response 403?
            async: true,
            success: function (response) { // success function when the request will be completed (OK)
                console.log("Successfull");
                addPointsToMap(response, map);
            },
            error: function(error) {
                alert("Lo sentimos, hubo un error al cargar la aplicación, por favor intente de nuevo después");
                console.log("Error in the request: " + error);
            }
        });
    };

    $("#form-buses-change").on("submit", (event) => {

        event.preventDefault();
        let id_bus_input = $("#bus_id").val();
        let id_paking_select = $("#parking_select").val();
        let departure_time = `input#departure_time_` + `${id_bus_input}`;
        let arrival_time = `input#arrival_time_` + `${id_bus_input}`;
        departure_time = $(departure_time).val();
        arrival_time = $(arrival_time).val();
        
        try {
            id_bus_input = Number(id_bus_input);
            id_paking_select = Number(id_paking_select);
        } catch (error) {
            id_parking = null;
            id_bus_input = null;
        }
        
        if(!isNaN(id_bus_input) && !isNaN(id_paking_select)){
            updateBus(id_bus_input, id_paking_select, departure_time, arrival_time);
        }else{
            const message_alert = $("#alert_request");
            // This remove all of the clases of the element and set news again
            message_alert.attr("class", "alert alert-warning");
            message_alert.text("El campo id del bus debe de ser un número y debes seleccionar un id de parqueadero a desplazar el bus");
        }
        L.markerClusterGroup(); // Delete ALL of the markers on the map
        parking_points(); // Get again the points to have now them

    });
    
    parking_points();

});
