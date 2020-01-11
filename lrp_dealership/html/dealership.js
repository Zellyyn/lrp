$(function(){
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
      } else if (item !== undefined && item.type === "classes") {
        var classes = JSON.parse(item.classes);
        var select = "<select class='classoption' onchange='GetVehiclesByClass(this)'>\n<option value=''>Select Class</option>\n";
        for( var key in classes) {
           select += "  <option value='" + classes[key].class + "'>" + classes[key].description + "</option>\n";
        }
        select += "</select>\n";
        $("#classes").html(select);
      } else if (item !== undefined && item.type === "location") {
        $("#location").html(item.name);
        $("#zone").html(item.name2);
      } else if (item !== undefined && item.type === "list") {
        var data = JSON.parse(item.list);
        var tab = '<table>';
        for( var key in data) {
          var cost = data[key].price
          tab += "<tr><td>" + data[key].name + "</td>";
          tab += "<td align=right> $" + cost.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "&nbsp;</td>";
          tab += "<td><div class='view' onclick='ViewVehicle(" + JSON.stringify(data[key]) + ")'></div></td>";
          tab += "<td><div class='purchase' onclick='PurchaseVehicle(" + JSON.stringify(data[key]) + ")'></div></td>";
          tab += "</tr>";
        }
        tab += "</table>";
        $("#list").html(tab);
      }
		});
  };
  
  document.onkeyup = function(data) {
    if (data.which == 27) { // ESC
      $.post('http://lrp_dealership/ExitDealership', JSON.stringify({}))
      $("#list").html("") // Remove list
      return;
    }
  }
  
});