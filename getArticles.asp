<!--#include file="inc/conn.asp"-->
<!--#include file="inc/config.asp"-->
<!--#include file="inc/function.asp"--><%
'常用变量
Dim Sql, Rs, RsMax, Action, searchKey, ID, GetType, GetMaxArticlesListsID, ReturnStr, OneRecord
Dim Picture, arrPicture, P
Action = Trim(Request("Action"))
searchkey = Trim(Request("searchkey"))
'If searchkey = "" Then searchkey = "undefined"
ID = ChkNumeric(Request("ID"))
GetType = ChkNumeric(Request("Type"))
GetMaxArticlesListsID = ChkNumeric(Request("maxlistsid"))

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
Case "search"
    Call search()
Case "lists"
    Call lists()
Case "updatelists"
    Call updatelists()
Case "content"
    Call content()
Case "related"
    Call related()
Case Else
    Call lists()
End Select

'搜索
Public Function search()
Set Rs = server.CreateObject("adodb.recordset")
Sql = "Select * from LQ_Articles where Title like '%"&searchkey&"%' and IsShow = 1 order by ID Desc"
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
    ReturnStr = ReturnStr & """maxid"": " & MaxID("LQ_Articles where") & "," & vbCrLf
    ReturnStr = ReturnStr & """rows"": ["
    For i = 1 To x
        OneRecord = "{" & vbCrLf
        OneRecord = OneRecord & """id"": " & Rs("ID") & "," & vbCrLf
        OneRecord = OneRecord & """type"": " & Rs("Type") & "," & vbCrLf
        OneRecord = OneRecord & """title"": """ & Rs("Title") & """," & vbCrLf
        If Instr(Rs("Picture"), ",") > 0 Then
            Picture = split(Rs("Picture"), ",")
            arrPicture = ""
			OneRecord = OneRecord & """pictures"": ["
            For P = 0 to ubound(Picture)
			    arrPicture = arrPicture & """" & picture(P)& ""","
            Next
			OneRecord = OneRecord & left(arrPicture, InStrRev(arrPicture, ",") - 1)
			OneRecord = OneRecord & "]," & vbCrLf
        Else
            OneRecord = OneRecord & """pictures"": """ & Rs("Picture") & """," & vbCrLf
        End If
        OneRecord = OneRecord & """video"": """ & Rs("video") & """," & vbCrLf
        OneRecord = OneRecord & """duration"": " & Rs("duration") & "," & vbCrLf
        OneRecord = OneRecord & """linkurl"": """ & Rs("LinkUrl") & """," & vbCrLf
        OneRecord = OneRecord & """content"": """ & HTMLEncodes(Rs("Content")) & """," & vbCrLf
        OneRecord = OneRecord & """sharing"": " & Rs("Sharing") & "," & vbCrLf
        OneRecord = OneRecord & """comments"": " & Rs("Comments") & "," & vbCrLf
        OneRecord = OneRecord & """source"": """ & Rs("Source") & """," & vbCrLf
        OneRecord = OneRecord & """addtime"": """ & Rs("AddTime") & """," & vbCrLf
        OneRecord = OneRecord & """isshow"": " & Rs("IsShow") & "" & vbCrLf
        OneRecord = OneRecord & "}"
        OneRecord = OneRecord & "," & vbCrLf
        returnStr = returnStr & OneRecord
        Rs.Movenext
    Next
    ReturnStr = left(ReturnStr, InStrRev(ReturnStr, ",") - 1)
    ReturnStr = ReturnStr & "]"
    ReturnStr = ReturnStr & "}"
End If
Call RsClose(Rs)
search = ReturnStr
Response.Write (search)
End Function

'列表
Public Function lists()
Set Rs = server.CreateObject("adodb.recordset")
Sql = "Select * from LQ_Articles where Title like '%"&searchkey&"%' and IsShow = 1 order by ID Desc"
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
    ReturnStr = ReturnStr & """maxid"": " & MaxID("LQ_Articles where") & "," & vbCrLf
    ReturnStr = ReturnStr & """rows"": ["
    For i = 1 To x
        OneRecord = "{" & vbCrLf
        If Instr(Rs("Picture"), ",") > 0 Then
            Picture = split(Rs("Picture"), ",")
            arrPicture = ""
			OneRecord = OneRecord & """pictures"": ["
            For P = 0 to ubound(Picture)
			    arrPicture = arrPicture & """" & picture(P)& ""","
            Next
			OneRecord = OneRecord & left(arrPicture, InStrRev(arrPicture, ",") - 1)
			OneRecord = OneRecord & "]," & vbCrLf
        Else
            OneRecord = OneRecord & """pictures"": """ & Rs("Picture") & """," & vbCrLf
        End If
        OneRecord = OneRecord & """id"": " & Rs("ID") & "," & vbCrLf
        OneRecord = OneRecord & """type"": " & Rs("Type") & "," & vbCrLf
        OneRecord = OneRecord & """title"": """ & Rs("Title") & """," & vbCrLf
        OneRecord = OneRecord & """video"": """ & Rs("video") & """," & vbCrLf
        OneRecord = OneRecord & """duration"": " & Rs("duration") & "," & vbCrLf
        OneRecord = OneRecord & """linkurl"": """ & Rs("LinkUrl") & """," & vbCrLf
        OneRecord = OneRecord & """content"": """ & HTMLEncodes(Rs("Content")) & """," & vbCrLf
        OneRecord = OneRecord & """sharing"": " & Rs("Sharing") & "," & vbCrLf
        OneRecord = OneRecord & """comments"": " & Rs("Comments") & "," & vbCrLf
        OneRecord = OneRecord & """source"": """ & Rs("Source") & """," & vbCrLf
        OneRecord = OneRecord & """addtime"": """ & Rs("AddTime") & """," & vbCrLf
        OneRecord = OneRecord & """isshow"": " & Rs("IsShow") & "" & vbCrLf
        OneRecord = OneRecord & "}"
        OneRecord = OneRecord & "," & vbCrLf
        returnStr = returnStr & OneRecord
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

'更新
Public Function updatelists()
Set Rs = server.CreateObject("adodb.recordset")
Sql = "Select * from LQ_Articles where ID > " & GetMaxArticlesListsID & " and IsShow = 1 order by ID Desc"
Rs.Open Sql,Conn,1,1
If Rs.eof And Rs.bof Then
    Response.Write (0)
    Response.End
Else
    ReturnStr = "{" & vbCrLf
    ReturnStr = ReturnStr & """total"": " & Rs.RecordCount & "," & vbCrLf
    ReturnStr = ReturnStr & """maxid"": " & MaxID("LQ_Articles where ID > " & GetMaxArticlesListsID & " and") & "," & vbCrLf
    ReturnStr = ReturnStr & """rows"": ["
    Do While Not Rs.eof
        OneRecord = "{" & vbCrLf
        If Instr(Rs("Picture"), ",") > 0 Then
            Picture = split(Rs("Picture"), ",")
            arrPicture = ""
			OneRecord = OneRecord & """pictures"": ["
            For P = 0 to ubound(Picture)
			    arrPicture = arrPicture & """" & picture(P)& ""","
            Next
			OneRecord = OneRecord & left(arrPicture, InStrRev(arrPicture, ",") - 1)
			OneRecord = OneRecord & "]," & vbCrLf
        Else
            OneRecord = OneRecord & """pictures"": """ & Rs("Picture") & """," & vbCrLf
        End If
        OneRecord = OneRecord & """id"": " & Rs("ID") & "," & vbCrLf
        OneRecord = OneRecord & """type"": " & Rs("Type") & "," & vbCrLf
        OneRecord = OneRecord & """title"": """ & Rs("Title") & """," & vbCrLf
        OneRecord = OneRecord & """video"": """ & Rs("video") & """," & vbCrLf
        OneRecord = OneRecord & """duration"": " & Rs("duration") & "," & vbCrLf
        OneRecord = OneRecord & """linkurl"": """ & Rs("LinkUrl") & """," & vbCrLf
        OneRecord = OneRecord & """content"": """ & HTMLEncodes(Rs("Content")) & """," & vbCrLf
        OneRecord = OneRecord & """sharing"": " & Rs("Sharing") & "," & vbCrLf
        OneRecord = OneRecord & """comments"": " & Rs("Comments") & "," & vbCrLf
        OneRecord = OneRecord & """source"": """ & Rs("Source") & """," & vbCrLf
        OneRecord = OneRecord & """addtime"": """ & Rs("AddTime") & """," & vbCrLf
        OneRecord = OneRecord & """isshow"": " & Rs("IsShow") & "" & vbCrLf
        OneRecord = OneRecord & "}"
        OneRecord = OneRecord & "," & vbCrLf
        returnStr = returnStr & OneRecord
        Rs.Movenext
    Loop
    ReturnStr = left(ReturnStr, InStrRev(ReturnStr, ",") - 1)
    ReturnStr = ReturnStr & "]"
    ReturnStr = ReturnStr & "}"
End If
Call RsClose(Rs)
updatelists = ReturnStr
Response.Write (updatelists)
End Function

'正文
Public Function content()
Set Rs = server.CreateObject("adodb.recordset")
Sql = "Select * from LQ_Articles where ID = " & ID & " and IsShow = 1 order by ID Desc"
Rs.Open Sql,Conn,1,1
If Rs.eof And Rs.bof Then
    Response.Write (0)
    Response.End
Else
    OneRecord = "{" & vbCrLf
    OneRecord = OneRecord & """id"": " & Rs("ID") & "," & vbCrLf
    OneRecord = OneRecord & """type"": " & Rs("Type") & "," & vbCrLf
    OneRecord = OneRecord & """title"": """ & Rs("Title") & """," & vbCrLf
    If Instr(Rs("Picture"), ",") > 0 Then
        Picture = split(Rs("Picture"), ",")
        arrPicture = ""
        OneRecord = OneRecord & """pictures"": ["
        For P = 0 to ubound(Picture)
            arrPicture = arrPicture & """" & picture(P)& ""","
        Next
        OneRecord = OneRecord & left(arrPicture, InStrRev(arrPicture, ",") - 1)
        OneRecord = OneRecord & "]," & vbCrLf
    Else
        OneRecord = OneRecord & """pictures"": """ & Rs("Picture") & """," & vbCrLf
    End If
    OneRecord = OneRecord & """video"": """ & Rs("video") & """," & vbCrLf
    OneRecord = OneRecord & """duration"": " & Rs("duration") & "," & vbCrLf
    OneRecord = OneRecord & """linkurl"": """ & Rs("LinkUrl") & """," & vbCrLf
    OneRecord = OneRecord & """content"": """ & HTMLEncodes(Rs("Content")) & """," & vbCrLf
    OneRecord = OneRecord & """sharing"": " & Rs("Sharing") & "," & vbCrLf
    OneRecord = OneRecord & """comments"": " & Rs("Comments") & "," & vbCrLf
    OneRecord = OneRecord & """source"": """ & Rs("Source") & """," & vbCrLf
    OneRecord = OneRecord & """addtime"": """ & Rs("AddTime") & """," & vbCrLf
    OneRecord = OneRecord & """isshow"": " & Rs("IsShow") & "" & vbCrLf
    returnStr = returnStr & OneRecord
    ReturnStr = ReturnStr & "}"
End If
Call RsClose(Rs)
content = ReturnStr
Response.Write (content)
End Function

'相关
Public Function related()
Set Rs = server.CreateObject("adodb.recordset")
If GetType = 4 Then
    Sql = "Select * from LQ_Articles where ID <> " & ID & " and Type = 4 and IsShow = 1 order by ID Desc"
Else
    Sql = "Select * from LQ_Articles where ID <> " & ID & " and Type <> 4 and IsShow = 1 order by ID Desc"
End If
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
    ReturnStr = ReturnStr & """maxid"": " & MaxID("LQ_Articles where") & "," & vbCrLf
    ReturnStr = ReturnStr & """rows"": ["
    For i = 1 To x
        OneRecord = "{" & vbCrLf
        OneRecord = OneRecord & """id"": " & Rs("ID") & "," & vbCrLf
        OneRecord = OneRecord & """type"": " & Rs("Type") & "," & vbCrLf
        OneRecord = OneRecord & """title"": """ & Rs("Title") & """," & vbCrLf
        If Instr(Rs("Picture"), ",") > 0 Then
            Picture = split(Rs("Picture"), ",")
            arrPicture = ""
			OneRecord = OneRecord & """pictures"": ["
            For P = 0 to ubound(Picture)
			    arrPicture = arrPicture & """" & picture(P)& ""","
            Next
			OneRecord = OneRecord & left(arrPicture, InStrRev(arrPicture, ",") - 1)
			OneRecord = OneRecord & "]," & vbCrLf
        Else
            OneRecord = OneRecord & """pictures"": """ & Rs("Picture") & """," & vbCrLf
        End If
        OneRecord = OneRecord & """video"": """ & Rs("video") & """," & vbCrLf
        OneRecord = OneRecord & """duration"": " & Rs("duration") & "," & vbCrLf
        OneRecord = OneRecord & """linkurl"": """ & Rs("LinkUrl") & """," & vbCrLf
        OneRecord = OneRecord & """content"": """ & HTMLEncodes(Rs("Content")) & """," & vbCrLf
        OneRecord = OneRecord & """sharing"": " & Rs("Sharing") & "," & vbCrLf
        OneRecord = OneRecord & """comments"": " & Rs("Comments") & "," & vbCrLf
        OneRecord = OneRecord & """source"": """ & Rs("Source") & """," & vbCrLf
        OneRecord = OneRecord & """addtime"": """ & Rs("AddTime") & """," & vbCrLf
        OneRecord = OneRecord & """isshow"": " & Rs("IsShow") & "" & vbCrLf
        OneRecord = OneRecord & "}"
        OneRecord = OneRecord & "," & vbCrLf
        returnStr = returnStr & OneRecord
        Rs.Movenext
    Next
    ReturnStr = left(ReturnStr, InStrRev(ReturnStr, ",") - 1)
    ReturnStr = ReturnStr & "]"
    ReturnStr = ReturnStr & "}"
End If
Call RsClose(Rs)
related = ReturnStr
Response.Write (related)
End Function

'更新
Public Function updaterelated()
Set Rs = server.CreateObject("adodb.recordset")
If GetType = 4 Then
    Sql = "Select * from LQ_Articles where ID <> " & ID & " and Type = 4 and IsShow = 1 order by ID Desc"
Else
    Sql = "Select * from LQ_Articles where ID <> " & ID & " and Type <> 4 and IsShow = 1 order by ID Desc"
End If
Rs.Open Sql,Conn,1,1
If Rs.eof And Rs.bof Then
    Response.Write (0)
    Response.End
Else
    ReturnStr = "{" & vbCrLf
    ReturnStr = ReturnStr & """total"": " & Rs.RecordCount & "," & vbCrLf
    ReturnStr = ReturnStr & """maxid"": " & MaxID("LQ_Articles where Type = " & GetType & " and ID > " & GetMaxArticlesListsID & " and") & "," & vbCrLf
    ReturnStr = ReturnStr & """rows"": ["
    Do While Not Rs.eof
        OneRecord = "{" & vbCrLf
        OneRecord = OneRecord & """id"": " & Rs("ID") & "," & vbCrLf
        OneRecord = OneRecord & """type"": " & Rs("Type") & "," & vbCrLf
        OneRecord = OneRecord & """title"": """ & Rs("Title") & """," & vbCrLf
        If Instr(Rs("Picture"), ",") > 0 Then
            Picture = split(Rs("Picture"), ",")
            arrPicture = ""
			OneRecord = OneRecord & """pictures"": ["
            For P = 0 to ubound(Picture)
			    arrPicture = arrPicture & """" & picture(P)& ""","
            Next
			OneRecord = OneRecord & left(arrPicture, InStrRev(arrPicture, ",") - 1)
			OneRecord = OneRecord & "]," & vbCrLf
        Else
            OneRecord = OneRecord & """pictures"": """ & Rs("Picture") & """," & vbCrLf
        End If
        OneRecord = OneRecord & """video"": """ & Rs("video") & """," & vbCrLf
        OneRecord = OneRecord & """duration"": " & Rs("duration") & "," & vbCrLf
        OneRecord = OneRecord & """linkurl"": """ & Rs("LinkUrl") & """," & vbCrLf
        OneRecord = OneRecord & """content"": """ & HTMLEncodes(Rs("Content")) & """," & vbCrLf
        OneRecord = OneRecord & """sharing"": " & Rs("Sharing") & "," & vbCrLf
        OneRecord = OneRecord & """comments"": " & Rs("Comments") & "," & vbCrLf
        OneRecord = OneRecord & """source"": """ & Rs("Source") & """," & vbCrLf
        OneRecord = OneRecord & """addtime"": """ & Rs("AddTime") & """," & vbCrLf
        OneRecord = OneRecord & """isshow"": " & Rs("IsShow") & "" & vbCrLf
        OneRecord = OneRecord & "}"
        OneRecord = OneRecord & "," & vbCrLf
        returnStr = returnStr & OneRecord
        Rs.Movenext
    Loop
    ReturnStr = left(ReturnStr, InStrRev(ReturnStr, ",") - 1)
    ReturnStr = ReturnStr & "]"
    ReturnStr = ReturnStr & "}"
End If
Call RsClose(Rs)
updaterelated = ReturnStr
Response.Write (updaterelated)
End Function
%>
