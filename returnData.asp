<!--#include file="inc/conn.asp"-->
<!--#include file="inc/config.asp"--><%
Dim Sql,Rs,AjaxAction,Title
AjaxAction			= Trim(Request("AjaxAction"))
Title				= Trim(Request("Title"))

'Title
If AjaxAction="CheckFormTitle" Then
    Set Rs=server.CreateObject("adodb.recordset")
    Sql="Select Title from LQ_Requirement where Title='"&Title&"'"
    Rs.Open Sql,Conn,1,1
    If Not(Rs.eof And Rs.bof) Then
        Response.Write ("项目名称已存在")
    Else 
        Response.Write ("true")
    End If
    Call RsClose(Rs)
    Call ConnClose(Conn)
End If
%>