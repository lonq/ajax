<!--#include file="inc/conn.asp"-->
<!--#include file="inc/config.asp"-->
<!--#include file="inc/function.asp"-->
<!--#include file="inc/md5.asp"-->
<!--#include file="inc/power.asp"--><%
'判断条件是否符合
If MyV_UsersID<>"" and MyV_UsersName<>"" and MyV_Password<>"" Then
	'从数据库中取值
	Dim Rs_Check,D_UsersID,D_UsersName,D_Password,D_LoginIP
	Set Rs_Check=server.CreateObject("adodb.recordset")
	Sql="select * from [LQ_Users] where UsersID="&MyV_UsersID&" and UsersName='"&MyV_UsersName&"' and Password='"&MyV_Password&"'"
	Rs_Check.Open Sql,Conn,1,1
	D_UsersID=Rs_Check("UsersID")
	D_UsersName=Rs_Check("UsersName")
	D_Password=Rs_Check("Password")
	D_LoginIP=Rs_Check("LoginIP")
	Rs_Check.close
	set Rs_Check=Nothing
	'判断是否符合后，设置条件变量
    If D_UsersID=Int(MyV_UsersID) Or D_UsersName=MyV_UsersName Or D_Password=MyV_Password Then
		MyUsers=1
	End If
    Response.Write (MyUsers)
'	'测试下
''	Response.write "用户ID："&D_UsersID&"<br />"
''	Response.write "用户名："&D_UsersName&"<br />"
''	Response.write "密码："&D_Password&"<br />"
''	Response.write "IP："&D_LoginIP&"<br />"
End If
'cookie或session不符则返回
If MyUsers<>1 Then
	Response.Write (0)
	Response.End
	'Response.Redirect("logout.asp")
End If
%>