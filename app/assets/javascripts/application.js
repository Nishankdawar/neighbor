// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.noty.packaged.min
//= require underscore
//= require gmaps/google
//= require turbolinks
//= require_tree .

var map;
var infoWindow;


var citymap = {
	nsit: {
		center: {lat: 28.609884729694669, lng: 77.03890307044993},
		population: 1500
	}
}

function initMap() {
   var myLatlng = {lat: 28.609684729694669, lng: 77.03590307044993};

  // var map = new google.maps.Map(document.getElementById('map'), {
  //   zoom: 13,
  //   center: myLatlng
  // });

    map = new google.maps.Map(document.getElementById('map'), {
  	zoom: 15,
  	center: myLatlng,
  	mapTypeId: 'terrain'
  });

  var marker = new google.maps.Marker({
    position: myLatlng,
    map: map,
    title: 'Click to zoom'
  });

  // map.addListener('center_changed', function() {
  //   // 3 seconds after the center of the map has changed, pan back to the
  //   // marker.
  //   window.setTimeout(function() {
  //     map.panTo(marker.getPosition());
  //   }, 3000);
  // });

  marker.addListener('click', function() {
    map.setZoom(15);
    map.setCenter(marker.getPosition());
  });


    for (var city in citymap) {
    // Add the circle for this city to the map.
    var cityCircle = new google.maps.Circle({
      strokeColor: '#FF0000',
      strokeOpacity: 0.8,
      strokeWeight: 2,
      fillColor: '#FF0000',
      fillOpacity: 0.35,
      map: map,
      center: citymap[city].center,
      radius: Math.sqrt(citymap[city].population) * 14
 
    });
  }


//   var triangleCoords = [
// 	  {lat: 28.6091, lng: 77.0351},
// 	  {lat: 28.6094, lng: 77.0398},
// 	  {lat: 28.6097, lng: 77.0342}
//   ];
// 	var bermudaTriangle = new google.maps.Polygon({
// 	paths: triangleCoords,
// 	strokeColor: '#FF0000',
// 	strokeOpacity: 0.8,
// 	strokeWeight: 2,
// 	fillColor: '#FF0000',
// 	fillOpacity: 0.35
// 	 // draggable: true,
//   //    geodesic: true
//   });
//   bermudaTriangle.setMap(map);


//   // Add a listener for the click event.
//   bermudaTriangle.addListener('click', showArrays);

//   infoWindow = new google.maps.InfoWindow;
// }

// //  @this {google.maps.Polygon} 
// function showArrays(event) {
//   // Since this polygon has only one path, we can call getPath() to return the
//   // MVCArray of LatLngs.
//   var vertices = this.getPath();

//   var contentString = '<b>Bermuda Triangle polygon</b><br>' +
//       'Clicked location: <br>' + event.latLng.lat() + ',' + event.latLng.lng() +
//       '<br>';

//   // Iterate over the vertices.
//   for (var i =0; i < vertices.getLength(); i++) {
//     var xy = vertices.getAt(i);
//     contentString += '<br>' + 'Coordinate ' + i + ':<br>' + xy.lat() + ',' +
//         xy.lng();
//   }

//   // Replace the info window's content and position.
//   infoWindow.setContent(contentString);
//   infoWindow.setPosition(event.latLng);

//   infoWindow.open(map);


}

function onBodyLoad() {

    var toTop = document.getElementById('toTop');
    var id = null;
    var delta;
    var height;

    function scrollToTop() {
        var y = window.scrollY;
        if (y > height / 2) {
            delta = delta + 10;
        } else {
            delta = delta - 10;
            delta = delta < 0 ? 10 : delta;
        }
        y = y - delta;
        y = y > 0 ? y : 0;
        window.scrollTo(0, y);
        if (y === 0) {
            clearInterval(id);
        }
    }

    toTop.addEventListener('click', function(event) {
        delta = 5;
        height = window.scrollY;
        event.preventDefault();
        id = setInterval(scrollToTop, 10);
    });



    var content = document.getElementById("content");
    if (content) {
        content.addEventListener('keyup', function() {
            var length = content.value.length;
            var letters = document.getElementById("letters");
            letters.innerHTML = length;

            if (length > 140) {
                letters.style.color = "red";
            } else {
                letters.style.color = "green";
            }
        });
    }


    var createClack = document.getElementById("create_clack");
    if (createClack) {
        createClack.addEventListener('submit', function(event) {
            event.preventDefault();
            console.log("tried submitting");
            var url = "/create_clack_json";
            var content = document.getElementById("content");
            data = {
                content: content.value,
                random: 12345,
            }

            if (!content.value || (content.value && content.value.length < 1)) {

                noty({ text: "Cannot Create Empty Clack", theme: "relax", type: 'error', layout: 'topRight' });

                return;
            }


            $.ajax({
                url: url,
                method: "POST",
                data: data,
                success: function(result) {
                    console.log(result);
                    var list = document.getElementById("clacks");
                    next_elem = list.firstElementChild;
                    var new_elem = document.createElement('div');
                    new_elem.innerHTML = result.content;
                    list.insertBefore(new_elem, next_elem);
                },
                error: function(error) {
                    console.log(error);
                    noty({ text: "Error", theme: "relax", type: 'error', layout: 'topRight' });

                }
            });

        });
    }


    var like_links = document.querySelectorAll('div.clack a.clack_like_link');
    if (like_links) {
        for (var i = 0; i < like_links.length; i++) {
            var link = like_links[i];
            var click_function = function(event) {
                event.preventDefault();
                event.stopPropagation();
                var clack_id = this.id.slice(6);
                $.ajax({
                    url: '/like_clack_json',
                    method: "POST",
                    data: { clack_id: clack_id },
                    success: function(data) {
                        console.log("clack_" + data.clack_id);
                        var element = document.getElementById("clack_" + data.like.clack_id);
                        console.log(element);

                        if (data.like_state) {
                            element.innerHTML = "Unlike";
                        } else {
                            element.innerHTML = "Like";
                        }

                    },
                    error: function(error) {

                        noty({ text: "Error", theme: "relax", type: 'error', layout: 'topRight' });

                    }
                });

            };

            link.addEventListener('click', click_function.bind(link));
        }
    }

}

window.addEventListener("load", function(event) {
    onBodyLoad();
});

















