$(function(){
	window.onload = (e) => {
    /* 'links' the js with the Nui message from main.lua */
		window.addEventListener('message', (event) => {
      var item = event.data;
      $("tester").html(item.street);
			if (item !== undefined && item.type === "ui") {
        /* if the display is true, it will show */
    		if (item.display === true) {
          $("body").css("opacity", 1);
        /*  $("#container").show();
          $("#speed-shadow").show();
          $("#rpm-shadow").show();
          $("#speed").show();
          $("#rpm").show();
          $("#fuel").show();
          $("#fuel-shadow").show();
          $("#time").show();
          $("#time-shadow").show();
          $("#heading").show();
          $("#street").show();
          $("#cross").show();
          $("#zone").show();
          $("#cruise").show();
          $("#cruise-speed").show();
          $("#cruise-speed-shadow").show();
          $("#low-beam").show();
          $("#engine").show();
          $("#high-beam").show();
          $("#seatbelt").show(); */
        /* if the display is false, it will hide */
				} else {
          $("body").css("opacity", 0);
          /*$("#container").hide();
          $("#speed-shadow").hide();
          $("#rpm-shadow").hide();
          $("#speed").hide();
          $("#rpm").hide();
          $("#fuel").hide();
          $("#fuel-shadow").hide();
          $("#time").hide();
          $("#time-shadow").hide();
          $("#heading").hide();
          $("#street").hide();
          $("#cross").hide();
          $("#zone").hide();
          $("#cruise").hide();
          $("#cruise-speed").hide();
          $("#cruise-speed-shadow").hide();
          $("#low-beam").hide();
          $("#engine").hide();
          $("#high-beam").hide();
          $("#seatbelt").hide();*/
        } 
      } else if (item !== undefined && item.type === "time") {
        $("#time").html(item.time);
      } else if (item !== undefined && item.type === "gps") {
        $("#heading").html(item.heading);
        $("#zone").html(item.zone);
        $("#street").html(item.street);
        $("#cross").html(item.cross);
      } else if (item !== undefined && item.type === "stats") {
        $("#speed").html(item.speed);
        var revsp = item.revs / 10000;
        $("#rpm").css("width", 86 * revsp + "px");
      } else if (item !== undefined && item.type === "tester") {
        $("#tester").html(item.text);
      } else if (item !== undefined && item.type === "low-beam") {
        $("#low-beam").css("background-color", item.color);
      } else if (item !== undefined && item.type === "high-beam") {
        $("#high-beam").css("background-color", item.color);
      } else if (item !== undefined && item.type === "seatbelt") {
        $("#seatbelt").css("background-color", item.color);
      } else if (item !== undefined && item.type === "engine") {
        $("#engine").css("background-color", item.color);
      } else if (item !== undefined && item.type === "cruise") {
        $("#cruise-speed").html(item.limit)
        $("#cruise").css("color", item.color)
      } else if (item !== undefined && item.type === "fuel") {
        $("#fuel").css("background-color", item.color);
        $("#fuel").css("width", 86 * item.fuelP + "px");
      }
		});
	};
});