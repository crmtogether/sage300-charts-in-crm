//////////////////////////////////
//File:...WWWRoot\js\custom\ctsage300.js
//Created By: crmtogether.com
//Links to ../custompages/company/ctsage300.asp
//////////////////////////////////
crm.ready(function()
{

	var act = crm.getArg("Act", $("form[name=EntryForm]").attr("action"));

	if (act == "200" || act == "220" || act == "222"|| act == "140"|| act == "141")
	{
		var keyOne = crm.getArg("Key1", $("form[name=EntryForm]").attr("action"));
		var url="../custompages/company/ctsage300.asp?SID="+crm.getArg('sid')+"&Key0=1&Key1="+keyOne;
		//alert(url);
		$.get(url, function(data) {
			if ((data==null)||(data==""))
			{
				return;
			}
			var tables=document.getElementsByTagName('table');
			var tableindex=10;
			var row = tables[tableindex].insertRow(2);
			var row = tables[tableindex].insertRow(2);
			row.id="crmtogether";
			var cell1 = row.insertCell(0);
			cell1.id="crmtogether1";
			cell1.colSpan="3";
			cell1.width="100%";
			$(cell1).html(data);
		});
		
	}
 
  
});