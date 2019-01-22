<!--#include file="inc/conn.asp"-->
<!--#include file="inc/config.asp"-->
<!--#include file="inc/function.asp"--><%
'常用变量
Dim Sql, Rs, RsMaxs, RsArrID, RsUsers, RsChats, Action, searchKey, UsersID, ReturnStr, OneRecord

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
    Call lists()
End Select

'获取好友ID组
Public Function getFriendsIDArr()
Set RsArrID = server.CreateObject("adodb.recordset")
Sql = "Select * from LQ_Friends where OwnerID = " & UsersID & " and IsShow = 1 order by ID Asc"
RsArrID.Open Sql,Conn,1,1
If Not(RsArrID.eof And RsArrID.bof) Then
Do While Not RsArrID.eof
    ReturnStr = ReturnStr & RsArrID("BuddyID") & "," & vbCrLf
    RsArrID.MoveNext
    Loop
End If
ReturnStr = left(ReturnStr, InStrRev(ReturnStr, ",") - 1)
Call RsClose(RsArrID)
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

            Set RsUsers = server.CreateObject("adodb.recordset")
            Sql = "Select * from [LQ_Users] where UsersID = " & Rs("BuddyID") & " and IsActive = 1 order by UsersID Asc"
            RsUsers.Open Sql,Conn,1,1
            If Not(RsUsers.eof And RsUsers.bof) Then
            
                Set RsChats = server.CreateObject("adodb.recordset")
                Sql = "Select * from LQ_Chats where (OwnerID = " & Rs("BuddyID") & " and BuddyID = " & MyV_UsersID & ") and IsShow = 1 order by ID Desc"
                RsChats.Open Sql,Conn,1,1
                
                    OneRecord = "{" & vbCrLf
                    OneRecord = OneRecord & """usersid"": " & RsUsers("UsersID") & "," & vbCrLf
                    OneRecord = OneRecord & """userspetName"": """ & RsUsers("UsersPetName") & """," & vbCrLf
                    OneRecord = OneRecord & """usersface"": """ & RsUsers("UsersFace") & """," & vbCrLf
                    OneRecord = OneRecord & """userssignature"": """ & RsUsers("UsersSignature") & """," & vbCrLf
                    OneRecord = OneRecord & """chatsid"": " & RsChats("ID") & "," & vbCrLf
                    OneRecord = OneRecord & """chatscontent"": """ & RsChats("ChatsContent") & """," & vbCrLf
                    OneRecord = OneRecord & """chatsaddtime"": """ & RsChats("AddTime") & """," & vbCrLf
                    OneRecord = OneRecord & """chatsrecordcount"": " & RsChats.RecordCount & "," & vbCrLf
                    OneRecord = OneRecord & """chatsisview"": " & RsChats("IsView") & "," & vbCrLf
                    OneRecord = OneRecord & """id"": " & Rs("ID") & "," & vbCrLf
                    OneRecord = OneRecord & """ownerid"": " & Rs("OwnerID") & "," & vbCrLf
                    OneRecord = OneRecord & """buddyid"": " & Rs("BuddyID") & "," & vbCrLf
                    OneRecord = OneRecord & """buddygroup"": " & Rs("BuddyGroup") & "," & vbCrLf
                    OneRecord = OneRecord & """description"": """ & Rs("Description") & """," & vbCrLf
                    OneRecord = OneRecord & """addtime"": """ & Rs("AddTime") & """," & vbCrLf
                    OneRecord = OneRecord & """isshow"": " & Rs("IsShow") & "" & vbCrLf
                    OneRecord = OneRecord & "}"
                    OneRecord = OneRecord & "," & vbCrLf
                    ReturnStr = ReturnStr & OneRecord

                Call RsClose(RsChats)

            End If
            Call RsClose(RsUsers)
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
