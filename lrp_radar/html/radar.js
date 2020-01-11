$(function(){
	window.onload = (e) => {
    var ModNames
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
      } else if (item !== undefined && item.type === "forward") {
        var FwdCar = JSON.parse(item.data);
        $("#fwd-speed-data").html(FwdCar.speed);
        $("#fwd-set-data").html(FwdCar.high);
        $("#plate-top").html(FwdCar.plate.toLowerCase());
      } else if (item !== undefined && item.type === "backward") {
        var BwdCar = JSON.parse(item.data);
        $("#bwd-speed-data").html(BwdCar.speed);
        $("#bwd-set-data").html(BwdCar.high);
        $("#plate-bottom").html(BwdCar.plate.toLowerCase());
      } else if (item !== undefined && item.type === "location") {
        $("#location").html(item.name);
      }
		});
  };
  
  document.onkeyup = function(data) {
    if (data.which == 27) { // ESC
      $.post('http://lrp_customs/ExitRadar', JSON.stringify({}))
      $("#list").html("") // Remove list
      return;
    }
  }
  
});