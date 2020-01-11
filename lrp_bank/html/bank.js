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
      } else if (item !== undefined && item.type === "accounts") {
        var accounts = JSON.parse(item.accounts);
        var select = "<select class='classoption' onchange='GetBalanceByAccount(this)'>\n<option value=''>Select Class</option>\n";
        for( var key in accounts) {
           select += "  <option value='" + accounts[key].account + "'>" + accounts[key].description + "</option>\n";
        }
        select += "</select>\n";
        $("#accounts").html(select);
      } else if (item !== undefined && item.type === "hud") {
        $("#cash-balance").html(item.cash);
      } else if (item !== undefined && item.type === "location") {
        $("#location").html(item.name);
      } else if (item !== undefined && item.type === "balances") {
        var data = JSON.parse(item.accounts);
        var tab = '<table>';
        for( var key in data) {
          if (data[key].account == 'cash') {
            var cost = data[key].balance;
            $("#accounts").html("Cash $" + cost.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
          } else {
            var cost = data[key].balance;
            tab += "<tr><td>" + data[key].description + "</td>";
            tab += "<td align=right> $" + cost.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "</td>";
            tab += "<td align=right><input placeholder='amount' id='" + data[key].account + "'></td><td />";
            if($("#location").first().text() == "Teller" ) {
              tab += "<td style='width: 28px'><div class='deposit' onclick='DepositCash(" + JSON.stringify(data[key]) + ")'></div></td>";
            }
            tab += "<td style='width: 28px'><div class='withdrawal' onclick='WithdrawalCash(" + JSON.stringify(data[key]) + ")'></div></td>";
            tab += "</tr>";
          }
        }
        tab += "</table>";
        $("#list").html(tab);
      }
		});
  };
  
  document.onkeyup = function(data) {
    if (data.which == 27) { // ESC
      $.post('http://lrp_bank/ExitBank', JSON.stringify({}))
      $("#list").html("") // Remove list
      return;
    }
  }
  
});