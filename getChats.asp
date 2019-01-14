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

'翻页
Dim page, PageN, CurrPage, pageCount
PageN = 6

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
Case "updatelists"
    Call updatelists()
Case Else
    Call lists()
End Select

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

'更新记录
Public Function updatelists()
Set Rs = server.CreateObject("adodb.recordset")
Sql = "Select * from LQ_Chats where ID > " & GetChatsMaxID & " and BuddyID = " & ID & " and IsShow = 1 order by ID Asc"
Rs.Open Sql,Conn,1,1
If Rs.eof And Rs.bof Then
    Response.Write (0)
    Response.End
Else
    ReturnStr = "{" & vbCrLf
    ReturnStr = ReturnStr & """total"": " & Rs.RecordCount & "," & vbCrLf
    ReturnStr = ReturnStr & """maxid"": " & MaxID("LQ_Chats where") & "," & vbCrLf
    ReturnStr = ReturnStr & """rows"": ["
    Do While Not Rs.eof
        OneRecord = "{" & vbCrLf
        OneRecord = OneRecord & """nickname"": """ & Rs("Nickname") & """," & vbCrLf
        OneRecord = OneRecord & """avatar"": """ & Rs("Avatar") & """," & vbCrLf
        OneRecord = OneRecord & """comment"": """ & Rs("Comment") & """," & vbCrLf
        OneRecord = OneRecord & """addtime"": """ & Rs("AddTime") & """," & vbCrLf
        OneRecord = OneRecord & """isshow"": " & Rs("IsShow") & "" & vbCrLf
        OneRecord = OneRecord & "}"
        OneRecord = OneRecord & "," & vbCrLf
        ReturnStr = ReturnStr & OneRecord
        Rs.MoveNext
    Loop
    ReturnStr = left(ReturnStr, InStrRev(ReturnStr, ",") - 1)
    ReturnStr = ReturnStr & "]"
    ReturnStr = ReturnStr & "}"
End If
Call RsClose(Rs)
updatelists = ReturnStr
Response.Write (updatelists)
End Function
%>
