<!--#include file="inc/conn.asp"-->
<!--#include file="inc/config.asp"-->
<!--#include file="inc/function.asp"--><%
'常用变量
Dim Sql, Rs, RsFriendsID, RsMaxs, Action, searchKey, UsersID, ReturnStr, OneRecord

Action = Trim(Request("Action"))
searchkey = Trim(Request("searchkey"))
'If searchkey = "" Then searchkey = "undefined"
UsersID = ChkNumeric(Request("UsersID"))

'翻页
Dim page, PageN, CurrPage, pageCount
PageN = 10


'执行
Select Case Action
Case "lists"
    Call lists()
Case Else
    Call getFriendsIDArr()
End Select

'获取好友ID组
Public Function getFriendsIDArr()
Set RsFriendsID = server.CreateObject("adodb.recordset")
Sql = "Select * from LQ_Friends where OwnerID = " & UsersID & " and IsShow = 1 order by ID Asc"
RsFriendsID.Open Sql,Conn,1,1
If Not(RsFriendsID.eof And RsFriendsID.bof) Then
Do While Not RsFriendsID.eof
    ReturnStr = ReturnStr & RsFriendsID("BuddyID") & "," & vbCrLf
    RsFriendsID.MoveNext
    Loop
End If
ReturnStr = left(ReturnStr, InStrRev(ReturnStr, ",") - 1)
Call RsClose(RsFriendsID)
getFriendsIDArr = ReturnStr
Response.Write (getFriendsIDArr)
End Function

'好友列表
Public Function lists()
Set Rs = server.CreateObject("adodb.recordset")
Sql = "Select * from LQ_Friends where OwnerID = " & UsersID & " and IsShow = 1 order by ID Asc"
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
        ReturnStr = ReturnStr & """rows"": ["
        For i = 1 To x

            Set RsFriendsID = server.CreateObject("adodb.recordset")
            Sql = "Select * from [LQ_Users] where UsersID = " & Rs("BuddyID") & " and IsActive = 1 order by UsersID Asc"
            RsFriendsID.Open Sql,Conn,1,1
            If Not(RsFriendsID.eof And RsFriendsID.bof) Then
                
                OneRecord = "{" & vbCrLf
                OneRecord = OneRecord & """usersid"": " & RsFriendsID("UsersID") & "," & vbCrLf
                OneRecord = OneRecord & """userspetName"": """ & RsFriendsID("UsersPetName") & """," & vbCrLf
                OneRecord = OneRecord & """usersface"": """ & RsFriendsID("UsersFace") & """," & vbCrLf
                OneRecord = OneRecord & """userssignature"": """ & RsFriendsID("UsersSignature") & """," & vbCrLf
                OneRecord = OneRecord & """id"": " & Rs("ID") & "," & vbCrLf
                OneRecord = OneRecord & """ownerid"": " & Rs("OwnerID") & "," & vbCrLf
                OneRecord = OneRecord & """buddyid"": " & Rs("BuddyID") & "," & vbCrLf
                OneRecord = OneRecord & """buddygroup"": " & Rs("BuddyGroup") & "," & vbCrLf
                OneRecord = OneRecord & """description"": """ & Rs("Description") & """," & vbCrLf
                OneRecord = OneRecord & """addtime"": """ & Rs("AddTime") & """," & vbCrLf
                OneRecord = OneRecord & """isshow"": " & Rs("IsShow") & "" & vbCrLf
                OneRecord = OneRecord & "}"
                OneRecord = OneRecord & "," & vbCrLf
                returnStr = returnStr & OneRecord
            End If
            Call RsClose(RsFriendsID)
            Rs.Movenext
        Next
        ReturnStr = left(ReturnStr, InStrRev(ReturnStr, ",") - 1)
        ReturnStr = ReturnStr & "]"
        ReturnStr = ReturnStr & "}"
End If
Call RsClose(Rs)
lists = ReturnStr
Response.Write (lists)
End Function
%>
