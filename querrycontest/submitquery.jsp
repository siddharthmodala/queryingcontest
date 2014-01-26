<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="dbpackage.*,java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Submit Query</title>
</head>
<body>
<center>
<%
String query=request.getParameter("query");
String qno="",user="";
Cookie c[]=request.getCookies();
for(int i=0;i<c.length;i++)
	{if(c[i].getName().equals("user"))
		user=c[i].getValue();
	if(c[i].getName().equals("qno"))
		qno=c[i].getValue();
	}
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
	{
		String temp="";
		String q="q"+qno;
		int min=Integer.parseInt(request.getParameter("min"));
		int sec=Integer.parseInt(request.getParameter("sec"));
		int score;
		ResultSet rs3=db3.executeDBQuery("select "+q+" from scores where userid='administrator'");
		rs3.next();
		int count=rs3.getInt(1);
		if(rs3.getInt(1)==0)
			score=10;
		else if(rs3.getInt(1)==1)
			score=8;
		else if(rs3.getInt(1)==2)
			score=5;
		else 
			score=3;
		count++;
		db3.executeDBUpdate("update scores set "+q+"='"+count+"' where userid='administrator'");
		
		if(!user.equals(""))
		{
			
			ResultSet rs2=db2.executeDBQuery("select * from scores where userid='"+user+"'");
			if(rs2.next())
				temp="update scores set "+q+"='"+score+"' where userid='"+user+"'";
			else
				temp="insert into scores values('"+user+"',"+score+",0,0,0,0,0,0,0,0,0)";
			out.println("1"+temp+"<br>");
			db2.executeDBUpdate(temp);		
			
		}
			
	}
	
	int question=Integer.parseInt(qno);
	question++;
	response.addCookie(new Cookie("qno",""+question));
	response.sendRedirect("./loadquestion.jsp");

}
catch(SQLException e)
{
	int question=Integer.parseInt(qno);
	question++;
	response.addCookie(new Cookie("qno",""+question));
	response.sendRedirect("./loadquestion.jsp");
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