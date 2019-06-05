function S_GET(id){
  var a = new RegExp(id+"=([^&#=]*)");
  var result = "";

  try{
  	result = decodeURIComponent(a.exec(window.location.search)[1]);
  }
  catch(err){
  	result = "";
  }
  return result;
}

function get_today_month(){
	var today = new Date();
	var mm = today.getMonth()+1; //January is 0!
	return mm;
}
function get_today_day(){
	var today = new Date();
	var dd = today.getDate();
	return dd;
}
function get_today_year(){
	var today = new Date();
	var yyyy = today.getFullYear();

	return yyyy;
}
function get_today_date()
{
	var today = new Date();
	var dd = today.getDate();
	var mm = today.getMonth()+1; //January is 0!
	var yyyy = today.getFullYear();

	if(dd < 10) {
    	dd = '0' + dd;
	} 

	if(mm < 10) {
    	mm = '0' + mm;
	} 

	today = yyyy + '/' + mm + '/' + dd;

	return today;
}
function get_current_time(){
	var now = new Date();
	var hh = now.getHours();
	var mm = now.getMinutes();

	if(hh<10) {
    	hh = '0' + hh;
	} 

	if(mm < 10 ) {
    	mm = '0' + mm
	}	

	now = hh + ":" + mm;

	return now;
}
function get_current_full_time(){
	var now = new Date();
	var hh = now.getHours();
	var mm = now.getMinutes();
	var ss = now.getSeconds();

	if(hh<10) {
    	hh = '0' + hh;
	} 
	if(mm < 10 ) {
    	mm = '0' + mm
	}	
	if(ss < 10) {
		ss = '0' + ss
	}

	now = hh + ":" + mm + ":" + ss; 

	return now;	
}