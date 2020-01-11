$(function(){
  var NumVehicles = 0;
	window.onload = (e) => {
    /* 'links' the js with the Nui message from main.lua */
		window.addEventListener('message', (event) => {
      var item = event.data;
			if (item !== undefined && item.type === "ui") {
        /* if the display is true, it will show */
    		if (item.display === true) {
          $("body").css("opacity", 1);
        /* if the display is false, it will hide */
				} else {
          $("body").css("opacity", 0);
        } 
      } else if (item !== undefined && item.type === "list") {
        var data = item.list;
        var v = data.data;
        $("#location").html(item.street)
        $("#zone").html("in " + item.zone)
        var tab = '<table>';
        for( var key in data) {
          tab += "<tr><td>" + data[key].description + "</td>";
          if(data[key].isout === 1) {
            tab += "<td>Out</td>";
          } else {
            tab += "<td>" + data[key].street + "</td>";
          }
          if (data[key].isout == 1) {
            tab += "<td><div class='find' onclick='FindVehicle(" + JSON.stringify(data[key]) + ")'></div></td>";
          } else if (data[key].garage == data[key].current_garage) {
            tab += "<td><div class='drive' onclick='DriveVehicle(" + JSON.stringify(data[key]) + ")'></div></td>";
          } else {
            tab += "<td><div class='find' onclick='FindVehicle(" + JSON.stringify(data[key]) + ")'></div></td>";
          }
          tab += "<td>  </td>"; 
          tab += "</tr>";
          NumVehicles++;
        }
        tab += "</table>";
        $("#list").append(tab);
      }
		});
  };
  
  document.onkeyup = function(data) {
    if (data.which == 27) { // ESC
      $.post('http://lrp_garages/garage_off', JSON.stringify({}))
      $("#list").html("") // Remove list
      return;
    }
  }
  
});