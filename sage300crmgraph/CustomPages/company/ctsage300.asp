<!-- #include file ="sagecrm.js" -->
<!-- #include file ="server_functions.js" -->
<script type="text/javascript" src="js/lib/jquery-1.8.2.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.9.3/dist/Chart.min.js" integrity="sha256-R4pqcOYV8lt7snxMQO/HSbVCFRPMdrhAFMH+vr9giYI=" crossorigin="anonymous"></script>
<script type="text/javascript" src="../custompages/company/client_functions.js"></script>
<%

//////////////////////////////////
//File:...WWWRoot\js\custom\ctsage300.asp
//Created By: crmtogether.com
//Called by WWWRoot\js\custom\ctsage300.js
//////////////////////////////////

CurrentUser=CRM.GetContextInfo("selecteduser", "User_UserId");

container = CRM.GetBlock('container');
container.DisplayButton(Button_Default) = false;
container.DisplayForm = false;

customcontent = CRM.GetBlock("content");
customcontent.NewLine = false;
customcontent.contents="";

container.AddBlock( customcontent );

var comp_companyid=CRM.GetContextInfo("company","comp_companyid");
var comprec=CRM.FindRecord("company","comp_companyid="+comp_companyid);
var comp_database=comprec("comp_database");
var comp_custid=comprec("comp_custid");
if ((comp_custid==null)||(comp_custid==""))
{
  Response.End();
}

//add in our chart
customcontent.contents+='<canvas id="yearchart" width="1242" height="421" style="display: block; height: 207px; width: 414px;" class="chartjs-render-monitor"></canvas>';

//our sql...we replace #YEARNUMBER#
var csql="select sum(TERMTTLDUE) as amt, DATEPART(m, convert(datetime,convert(varchar(10),INVDATE,120))) as mth, "+
         "DATEPART(yyyy, convert(datetime,convert(varchar(10),INVDATE,120))) as yr  "+
         "from "+comp_database+".dbo.OEINVH where CUSTOMER='"+comp_custid+"' and  "+
         "(DATEPART(yyyy, convert(datetime,convert(varchar(10),INVDATE,120) )) =  "+
         "DATEPART(yyyy, DATEADD(yyyy, #YEARNUMBER#, getdate())) )  "+
         "group by DATEPART(m, convert(datetime,convert(varchar(10),INVDATE,120))),  "+
         "DATEPART(yyyy, convert(datetime,convert(varchar(10),INVDATE,120))) "+
         "order by yr, mth";

//init our data
var yeardatatemplate=[0,0,0,0,0,0,0,0,0,0,0,0];
var yearsback=1;//the number of years to query back
var yearsbackLabels=[];
var dataarray=new Array();//holds list of arrays
var backgroundColors=new Array();
var borderColor=new Array();
//chart colours are defined in client_functions.js
var chartColors=["window.chartColors.red",
				"window.chartColors.orange",
				"window.chartColors.yellow",
				"window.chartColors.green",
				"window.chartColors.blue",
				"window.chartColors.purple",
				"window.chartColors.gray",
				];


for(var i=0;i<=yearsback;i++)
{
	var csqlX=csql;
	var diff=i;
	if (diff!=0)
	  diff=(i*-1);
	csqlX=csqlX.replace("#YEARNUMBER#",diff);
	var csqlq=CRM.CreateQueryObj(csqlX);
	//_dbg(csqlX);
	csqlq.SelectSQL();
	var yeardata=new Array();
	var _backgroundColors=new Array();
	var _borderColor=new Array();
	for(var j=0;j<yeardatatemplate.length;j++)
	{
		yeardata[j] = yeardatatemplate[j];
		_backgroundColors.push(chartColors[i]);
		_borderColor.push(chartColors[i]);
	}
	//_dbg(yeardata);
	while(!csqlq.eof)
	{
		var mth=new Number(csqlq("mth"));
		yeardata[mth-1]=csqlq("amt");
		csqlq.NextRecord();
	}
	dataarray.push(yeardata);
	backgroundColors.push(_backgroundColors);
	borderColor.push(_borderColor);
	var _now=new Date();
	var _yr=new Number(_now.getFullYear());
	yearsbackLabels.push(_yr+diff);
}


function getArrayAsString(arrayStd)
{
	var res="";
	for(var j=0;j<arrayStd.length;j++)
	{
		if (res!="")
		  res+=",";
		res+="[";
		res +=arrayStd[j];
		res+="]";
	}
	
	return res;
}
%>


<script>

//init our data
var dataarray=[<%=getArrayAsString(dataarray)%>];
var backgroundColors=[<%=getArrayAsString(backgroundColors)%>];
var borderColor=[<%=getArrayAsString(borderColor)%>];
var yearsbackLabels=[<%=getArrayAsString(yearsbackLabels)%>];

var chartperiods=[1,2,3,4,5,6,7,8,9,10,11,12];
var chartlabels=[];
//months
for (var i = 0; i < chartperiods.length; i++) {
	chartlabels[i]=_getPeriod((i+1)+"");
}	

var _chartjsurl="https://cdn.jsdelivr.net/npm/chart.js@2.9.3/dist/Chart.min.js";
			$.getScript(_chartjsurl, function(){
				console.log('chartjs loaded');
				var ctx = document.getElementById('yearchart').getContext('2d');
				var myChart = new Chart(ctx, {
					type: 'bar',
					data: {
						labels: chartlabels,
						datasets: [
						{
							label: yearsbackLabels[0],
							data: dataarray[0],
							backgroundColor: backgroundColors[0],
							borderColor: borderColor[0],
							borderWidth: 1
						}
						]
					},
					options: {
						title: {
							display: true,
							text: 'Sage 300 Invoice Amounts'
						},
						scales: {
							yAxes: [{
								ticks: {
									beginAtZero: true,
									callback: function(value, index, values) {
										return '$' + value;
									}
								}
							}]
						}
					}
				});	
				//add in any other datasets
				for(j=1;j<dataarray.length;j++)
				{
					//build our dataset
					var newDataset = {
						label: yearsbackLabels[j],
							data: dataarray[j],
							backgroundColor: backgroundColors[j],
							borderColor: borderColor[j],
							borderWidth: 1
					}
					myChart.data.datasets.push(newDataset);
					myChart.update();
				}
				
			});	
		
	

</script>
<%
Response.Write(container.Execute());
%>