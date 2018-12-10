<!--#include file="inc/conn.asp"-->
<!--#include file="inc/config.asp"-->
<!--#include file="inc/function.asp"-->
<!--#include file="inc/md5.asp"-->
<!--#include file="inc/power.asp"--><%
'判断条件是否符合
If MyV_AdminID<>"" and MyV_AdminName<>"" and MyV_Password<>"" Then
	'从数据库中取值
	Dim Rs_Check,D_AdminID,D_AdminName,D_Password,D_LoginIP
	Set Rs_Check=server.CreateObject("adodb.recordset")
	Sql="select * from [LQ_Admin] where AdminID="&MyV_AdminID&" and AdminName='"&MyV_AdminName&"' and Password='"&MyV_Password&"'"
	Rs_Check.Open Sql,Conn,1,1
	D_AdminID=Rs_Check("AdminID")
	D_AdminName=Rs_Check("AdminName")
	D_Password=Rs_Check("Password")
	D_LoginIP=Rs_Check("LoginIP")
	Rs_Check.close
	set Rs_Check=Nothing
	'判断是否符合后，设置条件变量
    If D_AdminID=Int(MyV_AdminID) Or D_AdminName=MyV_AdminName Or D_Password=MyV_Password Then
		MyAdmin=1
	End If
    Response.Write (MyAdmin)
'	'测试下
''	Response.write "用户ID："&D_AdminID&"<br />"
''	Response.write "用户名："&D_AdminName&"<br />"
''	Response.write "密码："&D_Password&"<br />"
''	Response.write "IP："&D_LoginIP&"<br />"
End If
'cookie或session不符则返回
If MyAdmin<>1 Then
	Response.Write (0)
	Response.End
	'Response.Redirect("logout.asp")
End If
%>