<!--#include file="inc/conn.asp"-->
<!--#include file="inc/config.asp"-->
<!--#include file="inc/function.asp"-->
<!--#include file="inc/function_page.asp"-->
<!--#include file="inc/sub_inc.asp" --><%
'常用变量
Dim Sql, Rs, Action, AdminID, AdminName, ReturnStr, OneRecord
Dim Picture
Action = Trim(Request("Action"))
AdminID = ChkNumeric(Request("AdminID"))
AdminName = Trim(Request("AdminName"))

'执行
Select Case Action
Case "lists"
    Call lists()
Case "content"
    Call content()
Case Else
    Call lists()
End Select

'正文
Public Function content()
Set Rs = server.CreateObject("adodb.recordset")
Sql = "Select * from [LQ_Admin] where AdminID = "&AdminID&""
Rs.Open Sql,Conn,1,1
If Rs.eof And Rs.bof Then
    Response.Write (0)
    Response.End
Else
    ReturnStr = ReturnStr & "{" & vbCrLf
    ReturnStr = ReturnStr & """adminid"": " & Rs("AdminID") & "," & vbCrLf
    ReturnStr = ReturnStr & """orders"": " & Rs("Orders") & "," & vbCrLf
    ReturnStr = ReturnStr & """adminname"": """& Rs("AdminName") & """," & vbCrLf
    ReturnStr = ReturnStr & """adminemail"": """& Rs("AdminEMail") & """," & vbCrLf
    ReturnStr = ReturnStr & """adminpetname"": """& Rs("AdminPetName") & """," & vbCrLf
    ReturnStr = ReturnStr & """adminface"": """& Rs("AdminFace") & """," & vbCrLf
    ReturnStr = ReturnStr & """iscookie"": " & Rs("IsCookie") & "," & vbCrLf
    ReturnStr = ReturnStr & """adminsignature"": """& Rs("AdminSignature") & """," & vbCrLf
    ReturnStr = ReturnStr & """isactive"": " & Rs("IsActive") & "," & vbCrLf
    ReturnStr = ReturnStr & """logindate"": """& Rs("LoginDate") & """," & vbCrLf
    ReturnStr = ReturnStr & """loginip"": """& Rs("LoginIP") & """," & vbCrLf
    ReturnStr = ReturnStr & """logintimes"": " & Rs("LoginTimes") & "" & vbCrLf
    ReturnStr = ReturnStr & "}"
End If
Call RsClose(Rs)
content = ReturnStr
Response.Write (content)
End Function
%>
