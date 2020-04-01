//////////////////////////////////
//File:...WWWRoot\js\custom\client_functions.js
//Created By: crmtogether.com
//Used in WWWRoot\CustomPages\company\ctsage300.asp
//////////////////////////////////

function _getPeriod(val){
	switch(val) {
	  case "1":
		return "Jan";
		break;
	  case "2":
		return "Feb";
		break;
	  case "3":
		return "Mar";
		break;
	  case "4":
		return "Apr";
		break;		
	  case "5":
		return "May";
		break;
	  case "6":
		return "Jun";
		break;
	  case "7":
		return "Jul";
		break;
	  case "8":
		return "Aug";
		break;		
	  case "9":
		return "Sep";
		break;
	  case "10":
		return "Oct";
		break;
	  case "11":
		return "Nov";
		break;
	  case "12":
		return "Dec";
		break;		
	  default:
		return val;
	}
}

window.chartColors = {
	red: 'rgb(255, 99, 132)',
	orange: 'rgb(255, 159, 64)',
	yellow: 'rgb(255, 205, 86)',
	green: 'rgb(75, 192, 192)',
	blue: 'rgb(54, 162, 235)',
	purple: 'rgb(153, 102, 255)',
	grey: 'rgb(201, 203, 207)'
};