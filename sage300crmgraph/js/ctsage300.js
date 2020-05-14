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
		var _field=document.getElementById('_Datacomp_graphfield');
		$(_field).html('');
			_field.parentNode.style.height='300px';
			_field.parentNode.style.width='600px';
			_field.parentNode.setAttribute('colspan','5');
			_field.style.width='100%';
			_field.style.height='400px';
			
		var keyOne = crm.getArg("Key1", $("form[name=EntryForm]").attr("action"));
		var url="../custompages/company/ctsage300.asp?SID="+crm.getArg('sid')+"&Key0=1&Key1="+keyOne;
		//alert(url);
		$.get(url, function(data) {
			if ((data==null)||(data==""))
			{
				return;
			}
			var _field=document.getElementById('_Datacomp_graphfield');
			var mydiv=document.createElement('div');
			_field.appendChild(mydiv);
			$(mydiv).html(data);
		});
		
	}
 
  
});