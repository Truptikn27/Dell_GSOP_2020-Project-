<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login</title>
</head>
<body>
<%! String userdbName;
String userdbPsw;
String dbUsertype;
%>
<form action="question.jsp" method="post">
<%
 Connection con= null;
 PreparedStatement ps = null;
 ResultSet rs = null;
 String driverName = "com.mysql.jdbc.Driver";
 String url = "jdbc:mysql://localhost:3306/dell";
 String user = "root";
 String dbpsw = "root";
 String sql = "select * from register where uname=? and pswd=?";
 String name = request.getParameter("name");
 String password = request.getParameter("password");


if((!(name.equals(null) || name.equals("")) && !(password.equals(null) || password.equals(""))))
{
try{
Class.forName(driverName);
con = DriverManager.getConnection(url, user, dbpsw);
ps = con.prepareStatement(sql);
ps.setString(1, name);
ps.setString(2, password);
rs = ps.executeQuery();
if(rs.next())
{ 
userdbName = rs.getString("uname");
userdbPsw = rs.getString("pswd");
String id = rs.getString("ID");
String iname = rs.getString("uname");
if(name.equals(userdbName) && password.equals(userdbPsw))
{
session.setAttribute("name",userdbName);
session.setAttribute("id",id);
session.setAttribute("iname",iname);
%>
<script type="text/javascript">
		alert ( "Welcome User" );
		</script>
<%
getServletContext().getRequestDispatcher("/sidebar.jsp").include(request,response);
} 
}

else
{%>
<script type="text/javascript">
		alert ( "Error in login" );
		</script>  
<%
getServletContext().getRequestDispatcher("/login.jsp").include(request,response);
}
rs.close();
ps.close(); 
}
catch(SQLException sqe)
{
out.println(sqe);
} 
}
else
{
%>
<p style="color:red align:center">Error In Login</p>
<% 
getServletContext().getRequestDispatcher("/login.jsp").include(request,response);
}
%>
</form>

</body>
</html>