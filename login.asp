<!--#include file="inc/conn.asp"-->
<!--#include file="inc/config.asp"-->
<!--#include file="inc/function.asp"-->
<!--#include file="inc/md5.asp"-->
<%
Response.CacheControl = "no-cache"
Dim Rs,ErrMsg,Action,AdminName,Password,IsCookie,verifycode,GetCode
Action			=Trim(Request("Action"))
AdminName		=Replace(Trim(Request.form("AdminName")),"'","")
Password		=md5(Replace(Trim(Request.form("Password")),"'",""))
IsCookie		=ChkNumeric(Request.form("IsCookie"))

Select Case Action
    Case "chkLoginAdminName"
    Call chkLoginAdminName()
    Case "chkAdminName"
    Call chkAdminName()
    Case "chkLogin"
    Call chkLogin()
    Case "chkRegister"
    Call chkRegister()
End Select

'检查登录用户名
Sub chkLoginAdminName()
Set Rs=server.CreateObject("adodb.recordset")
Sql="Select * from [LQ_Admin] where AdminName='"&Replace(Trim(Request.form("LoginAdminName")),"'","")&"'"
Rs.Open Sql,conn,1,3
If Rs.Eof and Rs.Bof Then
    Response.Write "false"
    Exit Sub
Else
    response.write "true"
    Exit Sub
End If
RsClose(Rs)
Call ConnClose(Conn)
End Sub

'检查注册用户名
Sub chkAdminName()
Set Rs=server.CreateObject("adodb.recordset")
Sql="Select * from [LQ_Admin] where AdminName='"&AdminName&"'"
Rs.Open Sql,conn,1,3
If Rs.Eof and Rs.Bof Then
    Response.Write "true"
    Exit Sub
Else
    response.write "false"
    Exit Sub
End If
RsClose(Rs)
Call ConnClose(Conn)
End Sub

'检查登录
Sub chkLogin()
Set Rs=server.CreateObject("adodb.recordset")
Sql="Select * from [LQ_Admin] where AdminName='"&Replace(Trim(Request.form("LoginAdminName")),"'","")&"'"
Rs.Open Sql,conn,1,3
If Rs.Eof and Rs.Bof Then
    Response.Write 0
    Exit Sub
Else
    If md5(Replace(Trim(Request.form("LoginPassword")),"'",""))<>Trim(Rs("Password")) Then
        Conn.ExeCute("UpDate [LQ_Admin] set LoginDate=Now(),LoginIP='"&getIP&"',ErrLoginTimes=ErrLoginTimes+1 where AdminName='"&Replace(Trim(Request.form("LoginAdminName")),"'","")&"'")
        response.write 2
        Exit Sub
    Else
        If IsAdminVariable=1 Then
            '设置cookie
            Response.Cookies("LQCookies")("AdminID")=Int(Rs("AdminID"))
            Response.Cookies("LQCookies")("AdminName")=Trim(Rs("AdminName"))
            Response.Cookies("LQCookies")("Password")=Trim(Rs("Password"))
            Response.Cookies("LQCookies")("AdminSignature")=Trim(Rs("AdminSignature"))
            Response.Cookies("LQCookies")("IsSuperAdmin")=Int(Rs("IsSuperAdmin"))
            Response.Cookies("LQCookies")("ListFlag")=Trim(Rs("ListFlag"))
            Response.Cookies("LQCookies")("AdminFlag")=Trim(Rs("AdminFlag"))
            If IsCookie>0 Then
                Response.Cookies("LQCookies").Expires=Date+IsCookie
            End If
        Else
            '设置session
            Session("AdminID")=Int(Rs("AdminID"))
            Session("AdminName")=Trim(Rs("AdminName"))
            Session("Password")=Trim(Rs("Password"))
            Session("AdminSignature")=Trim(Rs("AdminSignature"))
            Session("IsSuperAdmin")=Int(Rs("IsSuperAdmin"))
            Session("ListFlag")=Trim(Rs("ListFlag"))
            Session("AdminFlag")=Trim(Rs("AdminFlag"))
        End If
        '更新管理员信息
        Conn.ExeCute("UpDate [LQ_Admin] set LoginDate=Now(),LoginTimes=LoginTimes+1,ErrLoginTimes=0,LoginIP='"&getIP&"' where AdminName='"&Replace(Trim(Request.form("LoginAdminName")),"'","")&"'")
        response.write 1
        Exit Sub
    End If
End If
RsClose(Rs)
Call ConnClose(Conn)
End Sub

'检查注册
Sub chkRegister()
Set Rs=server.CreateObject("adodb.recordset")
Sql="Select * from [LQ_Admin] where AdminName='"&AdminName&"'"
Rs.Open Sql,conn,1,3
If Not(Rs.Eof and Rs.Bof) Then
    response.write 0
    Exit Sub
Else
    Rs.AddNew
    Rs("AdminName")=Trim(Request.Form("AdminName"))
    Rs("AdminSignature")=Trim(Request.Form("AdminSignature"))
    Rs("Password")=md5(trim(Request.form("Password")))
    Rs("IsActive")=0
    Rs("AddName")="lonq"
    Rs("LoginIP")="没有登陆过后台"
    Rs("LoginDate")=Now()
    Rs("ErrLoginTimes")=0
    '权限
    Rs("IsSuperAdmin")=1
    Rs("ListFlag")="1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1"
    Rs("AdminFlag")="1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1"
    Rs.Update
    response.write 1
    Exit Sub
End If
RsClose(Rs)
ConnClose(Conn)
End Sub
%>