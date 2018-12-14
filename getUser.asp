<!--#include file="inc/conn.asp"-->
<!--#include file="inc/config.asp"-->
<!--#include file="inc/function.asp"--><%
'常用变量
Dim Sql, Rs, Action, UsersID, UsersName, ReturnStr, OneRecord
Dim Picture
Action = Trim(Request("Action"))
UsersID = ChkNumeric(Request("UsersID"))
UsersName = Trim(Request("UsersName"))

'执行
Select Case Action
Case "lists"
    Call lists()
Case "content"
    Call content()
Case "usercapability"
    Call usercapability()
Case Else
    Call lists()
End Select

'正文
Public Function content()
Set Rs = server.CreateObject("adodb.recordset")
Sql = "Select * from [LQ_Admin] where UsersName = '"&UsersName&"'"
Rs.Open Sql,Conn,1,1
If Rs.eof And Rs.bof Then
    Response.Write (0)
    Response.End
Else
    ReturnStr = ReturnStr & "{" & vbCrLf
    ReturnStr = ReturnStr & """adminid"": " & Rs("UsersID") & "," & vbCrLf
    ReturnStr = ReturnStr & """orders"": " & Rs("Orders") & "," & vbCrLf
    ReturnStr = ReturnStr & """adminname"": """& Rs("UsersName") & """," & vbCrLf
    ReturnStr = ReturnStr & """adminemail"": """& Rs("UsersEMail") & """," & vbCrLf
    ReturnStr = ReturnStr & """adminpetname"": """& Rs("UsersPetName") & """," & vbCrLf
    ReturnStr = ReturnStr & """adminface"": """& Rs("UsersFace") & """," & vbCrLf
    ReturnStr = ReturnStr & """iscookie"": " & Rs("IsCookie") & "," & vbCrLf
    ReturnStr = ReturnStr & """adminsignature"": """& Rs("UsersSignature") & """," & vbCrLf
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

'用户功能
Public Function usercapability()
Set Rs = server.CreateObject("adodb.recordset")
Sql = "Select * from LQ_UserCapability where IsShow = 1 order by Orders Asc, IsTop Desc"
Rs.Open Sql,Conn,1,1
If Rs.eof And Rs.bof Then
    Response.Write (0)
    Response.End
Else
ReturnStr = "["
Do While Not Rs.eof
    ReturnStr = ReturnStr & "{" & vbCrLf
    ReturnStr = ReturnStr & """title"": """& Rs("Title") & """," & vbCrLf
    ReturnStr = ReturnStr & """linkurl"": """ & Rs("LinkUrl") & """," & vbCrLf
    ReturnStr = ReturnStr & """pictures"": """& Rs("Picture") & """," & vbCrLf
    ReturnStr = ReturnStr & """description"": """& Rs("Description") & """," & vbCrLf
    ReturnStr = ReturnStr & """orders"": " & Rs("Orders") & "," & vbCrLf
    ReturnStr = ReturnStr & """width"": " & Rs("Width") & "," & vbCrLf
    ReturnStr = ReturnStr & """height"": " & Rs("Height") & "," & vbCrLf
    ReturnStr = ReturnStr & """isrecommendation"": " & Rs("IsRecommendation") & "," & vbCrLf
    ReturnStr = ReturnStr & """istop"": " & Rs("IsTop") & "" & vbCrLf
    ReturnStr = ReturnStr & "},"
    Rs.MoveNext
    Loop
End If
ReturnStr = left(ReturnStr, InStrRev(ReturnStr, ",") - 1)
ReturnStr = ReturnStr & "]"
Call RsClose(Rs)
usercapability = ReturnStr
Response.Write (usercapability)
End Function
%>
