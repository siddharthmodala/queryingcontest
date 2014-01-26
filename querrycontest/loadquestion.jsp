<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import = "java.sql.*" %>
<%@ page import = "java.io.*" %>
<%@ page import = "dbpackage.*" %>
<html>
<head>
<SCRIPT LANGUAGE="JavaScript">
var running = false;
var endTime = null;
var timerID = null;
var start = null;
var theMin = null;
var theSec = null;
			function startTimer() {
				running = true;
				var now = new Date();
				start =now.getTime();
				 var setTime = 1000*60*5;
				endTime = start + setTime;
				showCountDown();
			}

			function showCountDown() {
				var present = new Date();
				moment = present.getTime();
				if (endTime - moment<= 0) {
					stopTimer();
				document.forms[0].min.value = "00";
				document.forms[0].sec.value = "00";
				} else {
						totalsec=(endTime - moment)/1000;
					 theMin = (totalsec/60) |0;
					 theSec  = (totalsec %60) |0;
	document.f.min.value = theMin;
	document.f.sec.value = theSec;
					if (running) {
						timerID = setTimeout("showCountDown()",1000)
					}
				}
			}
			function stopTimer() {
				document.f.min.value = theMin ;
				document.f.sec.value = theSec ;
				clearTimeout(timerID);
				running = false;
				alert("Time Up!! solution auto submitted");
				document.f.action="./submitquery.jsp";
				document.f.submit();
			}
			function checkTry(temp)
			{
			if(running == true )
				{
					document.f.action="./tryquery.jsp";
					document.f.submit();
					
				}
				else
				{
alert("Time up!!. \n You cannot try/submit the query now.\n Wait for further instructions.");
					return false;
				}
			}
			function checkSubmit(temp)
			{
				if(running == true )
				{
					document.f.action="./submitquery.jsp";
					document.f.submit();
				}
				else
				{
alert("Time up!!. \n You cannot try/submit the query now.\n Wait for further instructions.");
				return false;
				}
			}
			
</SCRIPT>

</head>

<%
Database db=null;
String question="";
String qno=null;
String user="";
try{
	db=new Database();
	Cookie c[]=request.getCookies();
	for(int i=0;i<c.length;i++)
		{if(c[i].getName().equals("qno"))
			qno=c[i].getValue();
		if(c[i].getName().equals("user"))
		user=c[i].getValue();
		}
	if(qno==null)
	{	
		ResultSet rs=db.executeDBQuery("select * from scores where userid='"+user+"'" );
		if(rs.next())
		{
		qno=""+100; //some value so that it will show as quiz is completed
		}
		else 
		{
			qno="1";
		}
		response.addCookie(new Cookie("qno",qno));
	}
	ResultSet rs=db.executeDBQuery("select question from quiz where qno='"+qno+"'");
	if(rs.next())
	{
		question=rs.getString(1);
	%>
<body onload="startTimer()">
<center>
<form name="f" method="post">
<table align="right">
<tr> 
<td align="right">
<input type="text" size="2" name="min">:
<input type="text" size="2" name="sec">
</td>
</tr>
</table>
<br></br><br></br><br></br>
<table align="center">
<caption><b><u>Question</u></b></caption>
<tr>
<td align="center"><%=question%></td>
</tr>
<tr>
<td><textarea rows="5" cols="50" name="query"></textarea>
<input type="hidden" name="qno" value=<%=qno%> ></input>
</td>
</tr>
<tr>
<td align="center"><input type="button" value="Try query" onclick="checkTry(this)"></input>
<input type="button" value="Submit query" onclick="checkSubmit(this)"></input>
</td>
</table>
</form>
</center>
</body>
</html>	
<%
	}
else
{	out.println("<h2>Quiz Completed<br>Wait For Results</h2>");

}
}
catch(SQLException e)
{
out.println("Database Error!!");
}
%>

