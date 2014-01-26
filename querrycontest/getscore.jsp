<%@page import="dbpackage.*" %>
<%@ page import = "java.sql.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>

 <HEAD>
  <TITLE> GetScores </TITLE>
  </HEAD>
 <BODY>
<%
	String user=request.getParameter("username");
	Database db=null;
	try{
		db=new Database();
		ResultSet rs=db.executeDBQuery("Select * from scores where userid='"+user+"'");
		ResultSetMetaData rsmd=rs.getMetaData();
		if(rs.next())
		{
			out.println("<table border=1 align='center'><caption>Scores of "+user+" </caption><tr><th>question no</th><th>Marks</th></tr>");			
			for(int i=2;i<=rsmd.getColumnCount();i++)
			out.println("<tr><td>"+(i-1)+"</td><td>"+rs.getString(i)+"</td></tr>");
			out.println("</table>");
		}
		else
			out.println("<center><h3>Enter valid username and password</h3></center>"+user);
		}
		catch(Exception e)
		{
			db.closeConnections();
		}
			%>
 </BODY>
</HTML>
