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
      } else if (item !== undefined && item.type === "hud") {
        $("#cash-balance").html(item.cash);
      }
		});
  };
  
  document.onkeyup = function(data) {
    if (data.which == 27) { // ESC
      $.post('http://lrp_job/ExitJob', JSON.stringify({}))
      $("#list").html("") // Remove list
      return;
    }
  }
  
});