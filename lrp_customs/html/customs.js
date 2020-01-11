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
      } else if (item !== undefined && item.type === "colors") {
        var ColorList = [];
        ColorList = JSON.parse(item.data);
        var primary = "<table><tr class='pbody panel-body' ><td><div class='pbody panel-body'>\n";
        for(var key in ColorList) {
           for(var id in ColorList[key]) {
             primary += "<div class='" + ColorList[key][id].style + "' style='background-color: " + ColorList[key][id].color + "' onclick='SetPrimaryColor(" + id + ")'></div>\n";
           }
        }
        primary += "</div></td></tr></table>";
        $("#primary").html(primary);

        var secondary = "<table><tr class='pbody panel-body' ><td><div class='pbody panel-body'>\n";
        for(var key in ColorList) {
           for(var id in ColorList[key]) {
             secondary += "<div class='" + ColorList[key][id].style + "' style='background-color: " + ColorList[key][id].color + "' onclick='SetSecondaryColor(" + id + ")'></div>\n";
           }
        }
        secondary += "</div></td></tr></table>";
        $("#secondary").html(secondary);

        var pearlescent = "<table><tr class='pbody panel-body' ><td><div class='pbody panel-body'>\n";
        for(var key in ColorList) {
           for(var id in ColorList[key]) {
            pearlescent += "<div class='" + ColorList[key][id].style + "' style='background-color: " + ColorList[key][id].color + "' onclick='SetPearlescentColor(" + id + ")'></div>\n";
           }
        }
        pearlescent += "</div></td></tr></table>";
        $("#pearlescent").html(pearlescent);

        var wheelcolor = "<table><tr class='pbody panel-body' ><td><div class='pbody panel-body'>\n";
        for(var key in ColorList) {
           for(var id in ColorList[key]) {
             wheelcolor += "<div class='" + ColorList[key][id].style + "' style='background-color: " + ColorList[key][id].color + "' onclick='SetWheelColor(" + id + ")'></div>\n";
           }
        }
        wheelcolor += "</div></td></tr></table>";
        $("#wheelcolor").html(wheelcolor);

      } else if (item !== undefined && item.type === "mods") {
        var ModList = JSON.parse(item.data);
        var mods = "";
        var select = "";
        var names = [];
        mods += "<div class='panel-group' id='bodyworks-accordian'>\n";
        for(var key in ModList) {
          if (ModList[key].max > 0) {
            mods += "  <div class='panel panel-default'>\n";
            mods += "    <div class='pheading panel-heading'>\n";
            mods += "      <div data-toggle='collapse' data-parent='#bodyworks-accordian' href='#body" + ModList[key].id + "'>" + key + "</div>\n";
            mods += "    </div>\n";
            mods += "    <div id='body" + ModList[key].id + "' class='panel-collapse collapse'>\n";
            if (ModList[key].type == 'multiple') {
              modnames = ModList[key].mods
              var option = 1;
              mods += "      <div class='pbody panel-body' onclick='ChangeMod(" + ModList[key].id + ", -1)'>Stock</div>\n";
              for(var m in modnames) {
                if(modnames[m] == 'NULL') { modnames[m] = 'Option ' + option}
                mods += "      <div class='pbody panel-body' onclick='ChangeMod(" + ModList[key].id + ", " + m + ")'>" + modnames[m] + "</div>\n";
                option = option+1;
              }
            } else if (ModList[key].cat.type == 'toggle') {
            } 
            mods += "    </div>\n";
            mods += "  </div>\n";
          }
        }
        mods += "</div>\n";
        $("#bodyworks").html(mods); 
      } else if (item !== undefined && item.type === "perfs") {
        var ModList = JSON.parse(item.data);
        var mods = "";
        var select = "";
        var names = [];
        mods += "<div class='panel-group' id='performance-accordian'>\n";
        for(var key in ModList) {
          if (ModList[key].max > 0) {
            mods += "  <div class='panel panel-default'>\n";
            mods += "    <div class='pheading panel-heading'>\n";
            mods += "      <div data-toggle='collapse' data-parent='#performance-accordian' href='#body" + ModList[key].id + "'>" + key + "</div>\n";
            mods += "    </div>\n";
            mods += "    <div id='body" + ModList[key].id + "' class='panel-collapse collapse'>\n";
            if (ModList[key].type == 'multiple') {
              modnames = ModList[key].mods
              var option = 1;
              mods += "      <div class='pbody panel-body' onclick='ChangeMod(" + ModList[key].id + ", -1)'>Stock</div>\n";
              for(var m in modnames) {
                if(modnames[m] == 'NULL') { modnames[m] = 'Option ' + option}
                mods += "      <div class='pbody panel-body' onclick='ChangeMod(" + ModList[key].id + ", " + m + ")'>" + modnames[m] + "</div>\n";
                option = option+1;
              }
            } else if (ModList[key].cat.type == 'toggle') {
            } 
            mods += "    </div>\n";
            mods += "  </div>\n";
          }
        }
        mods += "</div>\n";
        $("#performance").html(mods); 
      } else if (item !== undefined && item.type === "wheels") {
        var TireList = JSON.parse(item.tires);
        var WheelList = JSON.parse(item.wheels);
        var mods = "";
        var select = "";
        var names = [];
        mods += "<div class='panel-group' id='wheels-accordian'>\n";
        for(var key in TireList) {
          mods += "  <div class='panel panel-default'>\n";
          mods += "    <div class='pheading panel-heading'>\n";
          mods += "      <div data-toggle='collapse' data-parent='#wheels-accordian' href='#wheels" + TireList[key].id + "'>" + key + "</div>\n";
          mods += "    </div>\n";
          mods += "    <div id='wheels" + TireList[key].id + "' class='panel-collapse collapse'>\n";
          for(var wheel in WheelList) {
            mods += "      <div class='pbody panel-body' onclick='ChangeWheel(" + TireList[key].id + ", " + wheel + ")'>" + WheelList[wheel] + "</div>\n";
          }
          mods += "    </div>\n";
          mods += "  </div>\n";
        }
        mods += "</div>\n";
        $("#wheels").html(mods); 
      } else if (item !== undefined && item.type === "location") {
        $("#location").html(item.name);
      }
		});
  };
  
  document.onkeyup = function(data) {
    if (data.which == 27) { // ESC
      $.post('http://lrp_customs/ExitCustoms', JSON.stringify({}))
      $("#list").html("") // Remove list
      return;
    }
  }
  
});