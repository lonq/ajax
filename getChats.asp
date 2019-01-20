<!--#include file="inc/conn.asp"-->
<!--#include file="inc/config.asp"-->
<!--#include file="inc/function.asp"--><%
'常用变量
Dim Sql, Rs, RsMax, Action, ID, FromID, GetMaxChatsID, ReturnStr, OneRecord
Dim Picture, arrPicture, P
Action = Trim(Request("Action"))
searchkey = Trim(Request("searchkey"))
FromID = ChkNumeric(Request("FromID"))
GetChatsMaxID = ChkNumeric(Request("maxChatsid"))

Dim OwnerID, BuddyID, Types, ChatsContent
OwnerID = ChkNumeric(Request("OwnerID"))
BuddyID = ChkNumeric(Request("BuddyID"))
Types = ChkNumeric(Request("Types"))
ChatsContent = Trim(Request("ChatsContent"))

'获取Buddy
Dim RsFrom, FromUsersName, FromUsersPetName, FromUsersFace
Set RsFrom = server.CreateObject("adodb.recordset")
Sql = "Select * from LQ_Users where UsersID = " & FromID & ""
RsFrom.Open Sql,Conn,1,1
If Not(RsFrom.eof And RsFrom.bof) Then
    FromUsersName = RsFrom("UsersName")
    FromUsersPetName = RsFrom("UsersPetName")
    If FromUsersPetName = "" Then FromUsersPetName = FromUsersName
    FromUsersFace = RsFrom("UsersFace")
End If
Call RsClose(RsFrom)

'获取Owner
Dim RsTo, ToUsersName, ToUsersPetName, ToUsersFace
Set RsTo = server.CreateObject("adodb.recordset")
Sql = "Select * from LQ_Users where UsersID = " & MyV_UsersID & ""
RsTo.Open Sql,Conn,1,1
If Not(RsTo.eof And RsTo.bof) Then
    ToUsersName = RsTo("UsersName")
    ToUsersPetName = RsTo("UsersPetName")
    If ToUsersPetName = "" Then ToUsersPetName = ToUsersName
    ToUsersFace = RsTo("UsersFace")
End If
Call RsClose(RsTo)

'翻页
Dim page, PageN, CurrPage, pageCount
PageN = 5

'获取最大ID
Public Function MaxID(Datasheet)
Set RsMax = server.CreateObject("adodb.recordset")
Sql = "Select top 1 ID from " & Datasheet & " IsShow = 1 order by ID Desc"
RsMax.Open Sql,Conn,1,1
If Not(RsMax.eof And RsMax.bof) Then
    MaxID = ChkNumeric(RsMax("ID"))
End If
Call RsClose(RsMax)
End Function

'执行
Select Case Action
Case "lists"
    Call lists()
Case "addData"
    Call addData()
Case "insertData"
    Call insertData()
Case "delData"
    Call delData()
Case "content"
    Call content()
Case Else
    Call lists()
End Select

'正文
Public Function content()
Set Rs = server.CreateObject("adodb.recordset")
Sql = "Select * from [LQ_Users] where UsersID = " & FromID & ""
Rs.Open Sql,Conn,1,1
If Rs.eof And Rs.bof Then
    Response.Write (0)
    Response.End
Else
    ReturnStr = ReturnStr & "{" & vbCrLf
    ReturnStr = ReturnStr & """fromusersname"": """& Rs("UsersName") & """," & vbCrLf
    ReturnStr = ReturnStr & """fromuserspetname"": """& Rs("UsersPetName") & """," & vbCrLf
    ReturnStr = ReturnStr & """fromusersface"": """& Rs("UsersFace") & """" & vbCrLf
    ReturnStr = ReturnStr & "}"
End If
Call RsClose(Rs)
content = ReturnStr
Response.Write (content)
End Function

'记录
Public Function lists()
Set Rs = server.CreateObject("adodb.recordset")
Sql = "Select * from LQ_Chats where (OwnerID = " & FromID & " and BuddyID = " & MyV_UsersID & ") or (OwnerID = " & MyV_UsersID & " and BuddyID = " & FromID & ") and IsShow = 1 order by ID Asc"
Rs.Open Sql,Conn,1,1
If Rs.eof And Rs.bof Then
    Response.Write (0)
    Response.End
Else
    Rs.PageSize = PageN '每页记录条数
    iCount = Rs.RecordCount '记录总数
    iPageSize = Rs.PageSize
    maxPage = Rs.PageCount
    page = Int(Request("page"))
    If Not IsNumeric(page) Or page = "" then
        page = 1
    Else
        page = CInt(page)
    End If
    If page < 1 Then
        page = 1
    ElseIf page > maxPage Then
        page = maxPage
    End If
    Rs.AbsolutePage = Page
    If page = maxPage Then
        x = iCount - (maxPage - 1) * iPageSize
    Else
        x = iPageSize
    End If
    ReturnStr = "{" & vbCrLf
    ReturnStr = ReturnStr & """total"": " & Rs.RecordCount & "," & vbCrLf
    ReturnStr = ReturnStr & """pagecount"": " & Rs.PageCount & "," & vbCrLf
    ReturnStr = ReturnStr & """maxchatsid"": " & MaxID("LQ_Chats where") & "," & vbCrLf
    ReturnStr = ReturnStr & """fromusersface"": """ & FromUsersFace & """," & vbCrLf
    ReturnStr = ReturnStr & """fromuserspetname"": """ & FromUsersPetName & """," & vbCrLf
    ReturnStr = ReturnStr & """tousersface"": """ & ToUsersFace & """," & vbCrLf
    ReturnStr = ReturnStr & """touserspetname"": """ & ToUsersPetName & """," & vbCrLf
    ReturnStr = ReturnStr & """rows"": ["
    For i = 1 To x
        OneRecord = "{" & vbCrLf
        OneRecord = OneRecord & """id"": " & Rs("ID") & "," & vbCrLf
        OneRecord = OneRecord & """toid"": " & Rs("OwnerID") & "," & vbCrLf
        OneRecord = OneRecord & """fromid"": " & Rs("BuddyID") & "," & vbCrLf
        OneRecord = OneRecord & """types"": " & Rs("Types") & "," & vbCrLf
        OneRecord = OneRecord & """chatscontent"": """ & Rs("ChatsContent") & """," & vbCrLf
        OneRecord = OneRecord & """addtime"": """ & Rs("AddTime") & """," & vbCrLf
        OneRecord = OneRecord & """isshow"": " & Rs("IsShow") & "" & vbCrLf
        OneRecord = OneRecord & "}"
        OneRecord = OneRecord & "," & vbCrLf
        ReturnStr = ReturnStr & OneRecord
        Rs.MoveNext
    Next
    ReturnStr = left(ReturnStr, InStrRev(ReturnStr, ",") - 1)
    ReturnStr = ReturnStr & "]"
    ReturnStr = ReturnStr & "}"
End If
Call RsClose(Rs)
lists = ReturnStr
Response.Write (lists)
End Function

'添加记录
Public Function addData()
Set Rs = server.CreateObject("adodb.recordset")
Sql = "Select * from LQ_Chats"
Rs.Open Sql,Conn,1,3
Rs.AddNew

Rs("OwnerID") = OwnerID
Rs("BuddyID") = BuddyID
Rs("Types") = Types
Rs("ChatsContent") = ChatsContent
Rs("ViewTime") = Now()
Rs("AddTime") = Now()
Rs("IsShow") = 1

Rs.Update
Call RsClose(Rs)
Call ConnClose(Conn)
End Function

'立即显示添加的记录
Public Function insertData()
Set Rs = server.CreateObject("adodb.recordset")
Sql = "Select * from LQ_Chats where (OwnerID = " & FromID & " and BuddyID = " & MyV_UsersID & ") or (OwnerID = " & MyV_UsersID & " and BuddyID = " & FromID & ") and IsShow = 1 order by ID Desc"
Rs.Open Sql,Conn,1,1
If Rs.eof And Rs.bof Then
    Response.Write (0)
    Response.End
Else
    ReturnStr = "{" & vbCrLf
    ReturnStr = ReturnStr & """id"": " & Rs("ID") & "," & vbCrLf
    ReturnStr = ReturnStr & """toid"": " & Rs("OwnerID") & "," & vbCrLf
    ReturnStr = ReturnStr & """fromid"": " & Rs("BuddyID") & "," & vbCrLf
    ReturnStr = ReturnStr & """types"": " & Rs("Types") & "," & vbCrLf
    ReturnStr = ReturnStr & """chatscontent"": """ & Rs("ChatsContent") & """," & vbCrLf
    ReturnStr = ReturnStr & """viewtime"": """ & Rs("ViewTime") & """," & vbCrLf
    ReturnStr = ReturnStr & """addtime"": """ & Rs("AddTime") & """," & vbCrLf
    ReturnStr = ReturnStr & """isshow"": " & Rs("IsShow") & "" & vbCrLf
    ReturnStr = ReturnStr & "}"
End If
Call RsClose(Rs)
Call ConnClose(Conn)
insertData = ReturnStr
Response.Write (insertData)
End Function
%>
