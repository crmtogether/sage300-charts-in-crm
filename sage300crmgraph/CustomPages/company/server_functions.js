<%
//////////////////////////////////
//File:...WWWRoot\js\custom\server_functions.js
//Created By: crmtogether.com
//Used in WWWRoot\CustomPages\company\ctsage300.asp
//////////////////////////////////

function _dbg(val)
{
	Response.Write(val);
	Response.End();
}

function readFile(fname){
	var fso = Server.CreateObject("Scripting.FilesystemObject");
	var txt = fso.OpenTextFile(Server.MapPath(fname));
	return txt.ReadAll();
}

%>