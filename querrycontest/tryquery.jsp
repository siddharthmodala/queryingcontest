<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="dbpackage.*,java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Try Query</title>
</head>
<body>
<center>
<%
String query=request.getParameter("query");
String qno=request.getParameter("qno");
String tempquery="";
Database db1=null;
Database db2=null;
Database db3=null; 
boolean flag=false;
try{
	db1=new Database();
	db2=new Database();
	db3=new Database();
	ResultSet rs1=db1.executeDBQuery("select ans1,ans2,ans3 from quiz where qno='"+qno+"'");
	if(rs1.next())
	{
		for(int i=1;i<4 & flag==false;i++)
		{
			tempquery=rs1.getString(i);
		
				if(tempquery!=null && !tempquery.equals(""))
			{
				ResultSet rs2=db2.executeDBQuery(query);
				ResultSet rs3=db3.executeDBQuery(tempquery);
				ResultSetMetaData rsmd2=rs2.getMetaData();
				ResultSetMetaData rsmd3=rs3.getMetaData();
				if(rsmd2.getColumnCount()==rsmd3.getColumnCount())
				{
					while(true)
					{
						boolean t1=rs2.next();
						boolean t2=rs3.next();
						 if(t1 ^ t2)
						 {
							 flag=false;
							 break;
						 }
						 else if(t1==false & t2==false )
						 {
							 flag=true;
							 break;
						 }
						 boolean tempflag=false;
						for(int j=1;j<=rsmd2.getColumnCount();j++)
						{
							if(rs2.getString(j).equals(rs3.getString(j)))
							tempflag=true;
							else
							{
								tempflag=false;
								break;
							}
						}
						if(tempflag==false)
						{	flag=false;
						  break;
						}
						else
							flag=true;
					}
				}
			}
			else
				flag=false;	
		}
	}
	else
		out.println("Question "+qno+" doesnot exists");
	if(flag==true)
		out.println("<b>Congrats!!!!<br>Your query is Correct submit it</b>");
	else
		out.println("<b>Sorry!!!<br>Your query is wrong</b>");
	
	ResultSet rs2=db2.executeDBQuery(query);
	out.println("<table border=1> <caption><br><br>OUTPUT</caption>");
	while(rs2.next())
	{
		out.println("<tr>");
		ResultSetMetaData rsmd2=rs2.getMetaData();
		for(int j=1;j<=rsmd2.getColumnCount();j++)
		{
			out.println("<td>"+rs2.getString(j)+"</td>");
		}
		out.println("</tr>");
	}
	out.println("</table>");
	out.println("<a href='javascript:history.go(-1)'>BACK</a>");
}
catch(SQLException e)
{
	out.println("database connection error"+e);
}
finally{
	db1.closeConnections();
	db2.closeConnections();
	db3.closeConnections();
}
%>
</center>
</body>
</html>