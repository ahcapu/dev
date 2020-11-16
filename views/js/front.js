/**
 * 2007-2020 PrestaShop
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License (AFL 3.0)
 * that is bundled with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * http://opensource.org/licenses/afl-3.0.php
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 * versions in the future. If you wish to customize PrestaShop for your
 * needs please refer to http://www.prestashop.com for more information.
 *
 *  @author    PrestaShop SA <contact@prestashop.com>
 *  @copyright 2007-2020 PrestaShop SA
 *  @license   http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
 *  International Registered Trademark & Property of PrestaShop SA
 *
 * Don't forget to prefix your containers with your own identifier
 * to avoid any conflicts with others containers.
 */
//alert("test");
const deliveryAddress = document.getElementById('delivery-address').childNodes[1].childNodes[1].childNodes[23].childNodes[3].childNodes[1];
// console.log("name", deliveryAddress);

deliveryAddress.setAttribute("required", true);

document.body.innerHTML += `<style>
      /* Always set the map height explicitly to define the size of the div
       * element that contains the map. */
      #map {
        height: 100%;
      }
      /* Optional: Makes the sample page fill the window. */
      html, body {
        height: 100%;
        margin: 0;
        padding: 0;
      }
      #description {
        font-family: Roboto;
        font-size: 15px;
        font-weight: 300;
      }

      #infowindow-content .title {
        font-weight: bold;
      }

      #infowindow-content {
        display: none;
      }

      #map #infowindow-content {
        display: inline;
      }

      .pac-card {
        margin: 10px 10px 0 0;
        border-radius: 2px 0 0 2px;
        box-sizing: border-box;
        -moz-box-sizing: border-box;
        outline: none;
        box-shadow: 0 2px 6px rgba(0, 0, 0, 0.3);
        background-color: #fff;
        font-family: Roboto;
      }

      #pac-container {
        padding-bottom: 12px;
        margin-right: 12px;
      }

      .pac-controls {
        display: inline-block;
        padding: 5px 11px;
      }

      .pac-controls label {
        font-family: Roboto;
        font-size: 13px;
        font-weight: 300;
      }

      #pac-input {
        background-color: #fff;
        font-family: Roboto;
        font-size: 15px;
        font-weight: 300;
        margin-left: 12px;
        padding: 0 11px 0 13px;
        text-overflow: ellipsis;
        width: 350px;
      }
      
      #map-address {
        background-color: #fff;
        font-family: Roboto;
        font-size: 15px;
        font-weight: 300;
        margin-left: 12px;
        padding: 0 11px 0 13px;
        text-overflow: ellipsis;
        width: 350px;
      }

      #pac-input:focus {
        border-color: #4d90fe;
      }

      #title {
        color: #fff;
        background-color: #4d90fe;
        font-size: 25px;
        font-weight: 500;
        padding: 6px 12px;
      }
      .pac-container{
      	z-index: 9999;
      }
      .modal-body{
      height: 400px;
      }
    </style>

<!-- Modal for map -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        
      </div>
      <div class="modal-body">
        <div class="pac-card" id="pac-card">
      <div>
        <div id="title">
          Select Pickup Location
        </div>
        <div id="type-selector" class="pac-controls">
          <input type="radio" name="type" id="changetype-all" checked="checked">
          <label for="changetype-all">All</label>
        </div>
        <div id="strict-bounds-selector" class="pac-controls">
          <input type="checkbox" id="use-strict-bounds" value="">
          <label for="use-strict-bounds">Strict Bounds</label>
        </div>
      </div>
      <div id="pac-container">
        <input id="pac-input" type="text"
            placeholder="Enter a location">
      </div>
    </div>
    <div id="map"></div>
    <div id="infowindow-content">
      <img src="" width="16" height="16" id="place-icon">
      <span id="place-name"  class="title"></span><br>
      <span id="place-address"></span>
    </div>
      </div>
      <div class="modal-footer">
        <button type="button" id="dismiss-button" class="btn btn-default" data-dismiss="modal">Select</button>
      </div>
    </div>
  </div>
</div>>
<!--Modal for Timeslot-->

<div class="modal fade" id="time-slot-modal" tabindex="-1" role="dialog" aria-labelledby="time-slot-modal-label" aria-hidden="true">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="time-slot-modal-label">Information for your delivery </h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
           <div id="pac-container">
                <input id="map-address" type="text">
           </div>
           <div class="row">
               <div class="col-lg-4">
                    <ul class="pagination pagination-lg">
                        <li id="minus-disabled" class="page-item">
                            <a class="page-link" id="minus" href="#">&laquo;</a>
                        </li>
                        <li id="plus-disabled" class="page-item">
                            <a class="page-link" id="plus" href="#">&raquo;</a>
                        </li>
                    </ul>
               </div>
               <div class="col-lg-4">
                   <h4 id="date-increment"></h4>
               </div>
               <div class="col-md-4">
                <label for="">Jump to</label>
                <select name="time_slot_months" id="time-slot-months">
                    <option value="1">Jan</option>
                    <option value="2">Feb</option>
                    <option value="3">Mar</option>
                    <option value="4">Apr</option>
                    <option value="5">May</option>
                    <option value="6">Jun</option>
                    <option value="7">Jul</option>
                    <option value="8">Aug</option>
                    <option value="9">Sep</option>
                    <option value="10">Oct</option>
                    <option value="11">Nov</option>
                    <option value="12">Dec</option>
                </select>
           </div>
           </div>
           <div class="row" id="dates-time-slot"></div>
<!--           <br>-->
<!--           <div class="row" id="slot-row-1"></div>-->
<!--           <br>-->
<!--           <div class="row" id="slot-row-2"></div>-->
<!--           <br>-->
<!--           <div class="row" id="slot-row-3"></div>-->
<!--           <br>-->
<!--           <div class="row" id="slot-row-4"></div>-->
<!--           <br>-->
<!--           <div class="row" id="slot-row-5"></div>-->
<!--           <br>-->
<!--           <div class="row" id="slot-row-6"></div>-->
<!--      </div>-->
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Save changes</button>
      </div>
    </div>
  </div>
</div>
`;

let mapApiScriptTag = document.createElement("script");
mapApiScriptTag.src = "https://maps.googleapis.com/maps/api/js?key=AIzaSyBXXUe1UPwcYKHx8L3drP_vJks8zl9kla4&libraries=places&callback=initMap";
document.body.appendChild(mapApiScriptTag);

let addressArr = [];
let lat;
let lng;
function initMap() {
    const componentForm = {
        street_number: 'short_name',
        route: 'long_name',
        locality: 'long_name',
        administrative_area_level_1: 'short_name',
        country: 'long_name',
        postal_code: 'short_name'
    };
    let map = new google.maps.Map(document.getElementById('map'), {
        center: {lat: -33.8688, lng: 151.2195},
        zoom: 13
    });
    let card = document.getElementById('pac-card');
    let input = document.getElementById('pac-input');

    let types = document.getElementById('type-selector');
    let strictBounds = document.getElementById('strict-bounds-selector');

    map.controls[google.maps.ControlPosition.TOP_RIGHT].push(card);

    let autocomplete = new google.maps.places.Autocomplete(input);

    // Bind the map's bounds (viewport) property to the autocomplete object,
    // so that the autocomplete requests use the current map bounds for the
    // bounds option in the request.
    autocomplete.bindTo('bounds', map);

    // Set the data fields to return when the user selects a place.
    autocomplete.setFields(
        ['address_components', 'geometry', 'icon', 'name']);

    let infowindow = new google.maps.InfoWindow();
    let infowindowContent = document.getElementById('infowindow-content');
    infowindow.setContent(infowindowContent);
    let marker = new google.maps.Marker({
        map: map,
        anchorPoint: new google.maps.Point(0, -29)
    });

    autocomplete.addListener('place_changed', function() {
        infowindow.close();
        marker.setVisible(false);
        let place = autocomplete.getPlace();
        if (!place.geometry) {
            // User entered the name of a Place that was not suggested and
            // pressed the Enter key, or the Place Details request failed.
            window.alert("No details available for input: '" + place.name + "'");
            return;
        }

        // If the place has a geometry, then present it on a map.
        if (place.geometry.viewport) {
            map.fitBounds(place.geometry.viewport);
        } else {
            map.setCenter(place.geometry.location);
            map.setZoom(17);  // Why 17? Because it looks good.
        }
        marker.setPosition(place.geometry.location);
        marker.setVisible(true);

        let address = '';
        if (place.address_components) {
            address = [
                (place.address_components[0] && place.address_components[0].short_name || ''),
                (place.address_components[1] && place.address_components[1].short_name || ''),
                (place.address_components[2] && place.address_components[2].short_name || '')
            ].join(' ');
        }

        infowindowContent.children['place-icon'].src = place.icon;
        infowindowContent.children['place-name'].textContent = place.name;
        infowindowContent.children['place-address'].textContent = address;
        // console.log("place address " + place.address_components);
        // console.log(place.address_components[2].types[0]);
        for (let i = 0; i < place.address_components.length; i++) {
            let addressType = place.address_components[i].types[0];
            if (componentForm[addressType]) {
                let val = place.address_components[i][componentForm[addressType]];
                // document.getElementById(addressType).value = val;
                // console.log(i);
                addressArr[i] = val;
                // console.log(val);
            }
        }
        // place.address_components[i][componentForm[addressType]];
        // console.log('latitude ',marker.position.lat());
        //console.log('longitude ',marker.position.lng());
        // console.log(addressArr[0])
        lat = marker.position.lat();
        lng = marker.position.lng();

        infowindow.open(map, marker);
    });

    // Sets a listener on a radio button to change the filter type on Places
    // Autocomplete.
    function setupClickListener(id, types) {
        let radioButton = document.getElementById(id);
        radioButton.addEventListener('click', function() {
            autocomplete.setTypes(types);
        });
    }

    setupClickListener('changetype-all', []);
    // setupClickListener('changetype-address', ['address']);
    // setupClickListener('changetype-establishment', ['establishment']);
    // setupClickListener('changetype-geocode', ['geocode']);

    document.getElementById('use-strict-bounds')
        .addEventListener('click', function() {
            // console.log('Checkbox clicked! New state=' + this.checked);
            autocomplete.setOptions({strictBounds: this.checked});
        });
}
$(document).ready(function(){
    let add_six_Days = 5;
    let year = new Date().getFullYear();
    const monthNames = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
    const dayName = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    console.log(dayName[1]);

    datesTimeSlot(new Date().getMonth() + 1, new Date().getDate());

    function datesTimeSlot(selectedMonth, selectedDate) {


        let monthName = monthNames[selectedMonth - 1];

        let remaining_days = (daysInMonth(selectedMonth, year)) - selectedDate;
        let getDaysInMonth = daysInMonth(selectedMonth, year);

        if (remaining_days >= 6) {

            // Click to increase dates
            let clickCount = 0;
            let totalClicked = 0;
            $("#plus").click(function() {

                $('#dates-time-slot').empty();
                document.getElementById('minus-disabled').classList.remove('disabled');
                clickCount +=5;
                totalClicked +=1;
                let remainingDaysCounter = getDaysInMonth - clickCount;
                if (remainingDaysCounter > add_six_Days) {
                    let increaseDate = selectedDate + clickCount;
                    $('#date-increment').text(increaseDate + '-' + (increaseDate + add_six_Days) + ' ' + monthName + ' ' + year);
                    for (let i = 0; i <= add_six_Days; i++) {
                        $("#dates-time-slot").append('<div class= "col-md-2">' + parseInt(increaseDate + i) + '</div>');
                    }
                } else {

                    let increaseDate = selectedDate + clickCount;

                    let add_remaining_days = getDaysInMonth - selectedDate - clickCount;
                    $('#date-increment').text(increaseDate + '-' + daysInMonth(selectedMonth, year) + ' ' + monthName + ' ' + year);

                    for (let i = 0; i <= add_remaining_days; i++) {
                        $("#dates-time-slot").append('<div class= "col-md-2">' + parseInt(increaseDate + i) + '</div>');
                    }
                    document.getElementById('plus-disabled').classList.add('disabled');
                }

                // console.log(totalClicked);
            });


            // By default
            $('#date-increment').text(selectedDate + '-' + (selectedDate + add_six_Days) + ' ' + monthName + ' ' + year);

            for (let i = 0; i <= add_six_Days; i++) {
                $("#dates-time-slot").append('<div class= "col-md-2">' + parseInt(selectedDate + i) + '</div>');
                for (let j = 0; j < 6; j++) {
                    $("#slot-row-1").append('<div class= "col-md-2"> Slot-' + (j + 1) + '</div>');
                }
                // $("#slot-row-1").append('<div class= "col-md-2"> Slot-' + (i + 1) + '</div>');
                // $("#slot-row-2").append('<div class= "col-md-2"> Slot-' + (1 + i) + '</div>');
                // $("#slot-row-3").append('<div class= "col-md-2"> Slot-' + (1 + i) + '</div>');
                // $("#slot-row-4").append('<div class= "col-md-2"> Slot-' + (1 + i) + '</div>');
                // $("#slot-row-5").append('<div class= "col-md-2"> Slot-' + (1 + i) + '</div>');
                // $("#slot-row-6").append('<div class= "col-md-2"> Slot-' + (1 + i) + '</div>');
            }

        } else {
            $('#date-increment').text(selectedDate + '-' + remaining_days + ' ' + monthName + ' ' + year);

            for (let i = 1; i < remaining_days; i++) {
                $("#dates-time-slot").append('<div class= "col-md-2">' + parseInt(selectedDate + i) + '</div>');
            }
        }
    }

    if (window.location.href.includes("/order")) {

        $('#myModal').ready(function(){
            $('[name="address1"]').keyup(function(){
                $('#myModal').modal('show');
                // $('#time-slot-modal').modal('show');
            })
            $('#dismiss-button').click(function(){
                // $('#time-slot-modal').modal('show');
                document.getElementById('map-address').value = document.getElementById('pac-input').value;
                // console.log(input_address);
                let latLng = lat+","+lng;
                let address = addressArr[1] ? addressArr[0] + ' '+ addressArr[1] : addressArr[0];
                $('[name="address1"]').val(address);
                $('[name="city"]').val(addressArr[2] ? addressArr[2] : '');
                $('[name="id_state"]').val(addressArr[4] ? addressArr[4] : 0);
                $('[name="postcode"]').val(addressArr[6] ? addressArr[6] : '');
                $('[name="id_country"]').val(addressArr[5] ? addressArr[5] : 0);
                $('[name="address2"]').val(latLng);

            });
        });
    }
    // Time slot section with Ajax
    let frank_id;
    let frank_token;
    let time_slot_get_res;

    $.ajax({
        async: false,
        url: '../modules/frank/ajax/variableAjax.php',
        method: 'get',
        success: function(response){
            response = JSON.parse(response);
            frank_id = response.frank_id;
            frank_token = response.frank_token;
            // console.log(response);
        }
    });

    // $.ajax({
    //     async: false,
    //     url: 'https://p-post.herokuapp.com/api/v1/timeslots/all',
    //     method: 'get',
    //     timeout: 0,
    //     headers: {
    //         Authorization: 'Bearer ' + frank_token
    //     },
    //     success: function (response) {
    //         if (response.status === 200) {
    //             time_slot_get_res = response.data;
    //         } else {
    //             time_slot_get_res = 'Something went wrong';
    //         }
    //     }
    // });
    // console.log(time_slot_get_res);

    let settings = {
        "url": "https://p-post.herokuapp.com/api/v1/timeslots/find",
        "method": "POST",
        "timeout": 0,
        "headers": {
            "Content-Type": "application/json"
        },
        "data": JSON.stringify({"startDate":"07-10-2020","endDate":"07-30-2020","location":[0,0]}),
    };

    $.ajax(settings).done(function (response) {
        console.log(response.data);
        response = response.data['15-7-2020'];
        response.map(function (value) {
            console.log(value);
        });
        // console.log(response);

    });
});

function daysInMonth (month, year) {
    return new Date(year, month, 0).getDate();
}