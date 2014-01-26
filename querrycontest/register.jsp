<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="dbpackage.*,java.sql.*" %>
   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Registration</title>
</head>
<body>
<center>
<%
Database db=null;
try{
db=new Database();
String name1=request.getParameter("name1");
String name2=request.getParameter("name2");
String username=request.getParameter("username");
String password=request.getParameter("password");
int count=db.executeDBUpdate("insert into users values('"+name1+"','"+name2+"','"+username+"','"+password+"')");
if(count==0)
	out.println("<h2>Username already exists.Use another name</h2><br/><a href='javascript:history.go(-1)'>Back</a>");
else
	out.println("<h2>Successfully registered!!</h2><br><a href='./Login.html'>Login</a>");
}
catch(SQLException e)
{
	out.println("Database connection Error!!!"+e);
}
catch(Exception e)
{
	out.println("An exception occured while processing the data please contact the admin");
}
finally
{
	db.closeConnections();
}
%>
</center>
</body>
</html>