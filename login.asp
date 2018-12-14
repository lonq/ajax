<!--#include file="inc/conn.asp"-->
<!--#include file="inc/config.asp"-->
<!--#include file="inc/function.asp"-->
<!--#include file="inc/md5.asp"-->
<%
Response.CacheControl = "no-cache"
Dim Rs,ErrMsg,Action,UsersName,Password,IsCookie,verifycode,GetCode
Action			=Trim(Request("Action"))
UsersName		=Replace(Trim(Request.form("UsersName")),"'","")
Password		=md5(Replace(Trim(Request.form("Password")),"'",""))
IsCookie		=ChkNumeric(Request.form("IsCookie"))

Select Case Action
    Case "chkLoginUsersName"
    Call chkLoginUsersName()
    Case "chkUsersName"
    Call chkUsersName()
    Case "chkLogin"
    Call chkLogin()
    Case "chkRegister"
    Call chkRegister()
End Select

'检查登录用户名
Sub chkLoginUsersName()
Set Rs=server.CreateObject("adodb.recordset")
Sql="Select * from [LQ_Users] where UsersName='"&Replace(Trim(Request.form("LoginUsersName")),"'","")&"'"
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
Sub chkUsersName()
Set Rs=server.CreateObject("adodb.recordset")
Sql="Select * from [LQ_Users] where UsersName='"&UsersName&"'"
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
Sql="Select * from [LQ_Users] where UsersName='"&Replace(Trim(Request.form("LoginUsersName")),"'","")&"'"
Rs.Open Sql,conn,1,3
If Rs.Eof and Rs.Bof Then
    Response.Write 0
    Exit Sub
Else
    If md5(Replace(Trim(Request.form("LoginPassword")),"'",""))<>Trim(Rs("Password")) Then
        Conn.ExeCute("UpDate [LQ_Users] set LoginDate=Now(),LoginIP='"&getIP&"',ErrLoginTimes=ErrLoginTimes+1 where UsersName='"&Replace(Trim(Request.form("LoginUsersName")),"'","")&"'")
        response.write 2
        Exit Sub
    Else
        If IsUsersVariable=1 Then
            '设置cookie
            Response.Cookies("LQCookies")("UsersID")=Int(Rs("UsersID"))
            Response.Cookies("LQCookies")("UsersName")=Trim(Rs("UsersName"))
            Response.Cookies("LQCookies")("Password")=Trim(Rs("Password"))
            Response.Cookies("LQCookies")("UsersSignature")=Trim(Rs("UsersSignature"))
            Response.Cookies("LQCookies")("IsSuperUsers")=Int(Rs("IsSuperUsers"))
            Response.Cookies("LQCookies")("ListFlag")=Trim(Rs("ListFlag"))
            Response.Cookies("LQCookies")("UsersFlag")=Trim(Rs("UsersFlag"))
            If IsCookie>0 Then
                Response.Cookies("LQCookies").Expires=Date+IsCookie
            End If
        Else
            '设置session
            Session("UsersID")=Int(Rs("UsersID"))
            Session("UsersName")=Trim(Rs("UsersName"))
            Session("Password")=Trim(Rs("Password"))
            Session("UsersSignature")=Trim(Rs("UsersSignature"))
            Session("IsSuperUsers")=Int(Rs("IsSuperUsers"))
            Session("ListFlag")=Trim(Rs("ListFlag"))
            Session("UsersFlag")=Trim(Rs("UsersFlag"))
        End If
        '更新管理员信息
        Conn.ExeCute("UpDate [LQ_Users] set LoginDate=Now(),LoginTimes=LoginTimes+1,ErrLoginTimes=0,LoginIP='"&getIP&"' where UsersName='"&Replace(Trim(Request.form("LoginUsersName")),"'","")&"'")
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
Sql="Select * from [LQ_Users] where UsersName='"&UsersName&"'"
Rs.Open Sql,conn,1,3
If Not(Rs.Eof and Rs.Bof) Then
    response.write 0
    Exit Sub
Else
    Rs.AddNew
    Rs("UsersName")=Trim(Request.Form("UsersName"))
    Rs("UsersSignature")=Trim(Request.Form("UsersSignature"))
    Rs("Password")=md5(trim(Request.form("Password")))
    Rs("IsActive")=0
    Rs("AddName")="lonq"
    Rs("LoginIP")="没有登陆过后台"
    Rs("LoginDate")=Now()
    Rs("ErrLoginTimes")=0
    '权限
    Rs("IsSuperUsers")=1
    Rs("ListFlag")="1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1"
    Rs("UsersFlag")="1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1"
    Rs.Update
    response.write 1
    Exit Sub
End If
RsClose(Rs)
ConnClose(Conn)
End Sub
%>