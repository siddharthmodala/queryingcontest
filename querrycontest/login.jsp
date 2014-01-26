<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="dbpackage.*,java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login</title>
</head>
<body>
<center>
<%
Database db=null;
try{
	db=new Database();
	String name=request.getParameter("username");
	String password=request.getParameter("password");
	ResultSet rs=db.executeDBQuery("select password from users where userid='"+name+"'");
	if(rs.next())
	{
		if(rs.getString(1).equals(password))
		{
			response.addCookie(new Cookie("user",name));
			response.sendRedirect("./Home.html");
			
		}
		else
			out.println("Password Wrong!!please retry<br><a href='javascript:history.go(-1)'>Back</a>");
	}
	else
	{
		out.println("UserName doesn't exists<br><a href='./Login.html'>Login</a> ");
	}
}
catch(SQLException e)
{
	out.println("Database connection error!!");
}
finally{
	db.closeConnections();
}
%>
</center>
</body>
</html>