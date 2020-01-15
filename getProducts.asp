<!--#include file="token.asp"--><%
'常用变量
Dim Sql, Rs, RsMax, Action, ID, GetMaxProductsListsID, GetMaxCommentsID, GetRecommendationsMaxID, ReturnStr, OneRecord
Dim Picture, arrPicture, P
Action = Trim(Request("Action"))
searchkey = Trim(Request("searchkey"))
'If searchkey = "" Then searchkey = "undefined"
ID = ChkNumeric(Request("ID"))
GetMaxProductsListsID = ChkNumeric(Request("maxlistsid"))
GetCommentsMaxID = ChkNumeric(Request("maxcommentsid"))
GetRecommendationsMaxID = ChkNumeric(Request("maxrecommendationsid"))

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
Case "slides"
    Call slides()
Case "lists"
    Call lists()
Case "updatelists"
    Call updatelists()
Case "details"
    Call details()
Case "comments"
    Call comments()
Case "updatecomments"
    Call updatecomments()
Case "recommendations"
    Call recommendations()
Case "updaterecommendations"
    Call updaterecommendations()
Case Else
    Call lists()
End Select

'幻灯
Public Function slides()
Set Rs = server.CreateObject("adodb.recordset")
Sql = "Select * from LQ_Slides where IsShow = 1 order by Orders Desc, IsTop Desc"
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
slides = ReturnStr
Response.Write (slides)
End Function

'产品详情
Public Function details()
Set Rs = server.CreateObject("adodb.recordset")
Sql = "Select * from LQ_Products where ID = " & ID & " and IsShow = 1 order by ID Desc"
Rs.Open Sql,Conn,1,1
If Rs.eof And Rs.bof Then
    Response.Write (0)
    Response.End
Else
    ReturnStr = "{" & vbCrLf
    ReturnStr = ReturnStr & """title"": """& Rs("Title") & """," & vbCrLf
    If Len(trim(Rs("Picture"))) > 0 Then
        Picture = split(Rs("Picture"), ",")
        arrPicture = ""
        ReturnStr = ReturnStr & """pictures"": ["
        For P = 0 to ubound(Picture)
            arrPicture = arrPicture & """" & picture(P)& ""","
        Next
        ReturnStr = ReturnStr & left(arrPicture, InStrRev(arrPicture, ",") - 1)
        ReturnStr = ReturnStr & "]," & vbCrLf
    Else
        ReturnStr = ReturnStr & """pictures"": ""," & vbCrLf
    End If
    ReturnStr = ReturnStr & """description"": """& Rs("Description") & """," & vbCrLf
    ReturnStr = ReturnStr & """content"": """ & HTMLEncodes(Rs("Content")) & """," & vbCrLf
    ReturnStr = ReturnStr & """price"": """ & FormatNumber(Rs("Price"), 2, -1) & """," & vbCrLf
    ReturnStr = ReturnStr & """sharing"": " & Rs("Sharing") & "," & vbCrLf
    ReturnStr = ReturnStr & """comments"": " & Rs("Comments") & "" & vbCrLf
    ReturnStr = ReturnStr & "}"
End If
Call RsClose(Rs)
details = ReturnStr
Response.Write (details)
End Function

'产品列表
Public Function lists()
Set Rs = server.CreateObject("adodb.recordset")
Sql = "Select * from LQ_Products where IsShow = 1 order by ID Desc"
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
    ReturnStr = ReturnStr & """maxid"": " & MaxID("LQ_Products where") & "," & vbCrLf
    ReturnStr = ReturnStr & """rows"": ["
    For i = 1 To x
        OneRecord = "{" & vbCrLf
        If Len(trim(Rs("Picture"))) > 0 Then
            Picture = split(Rs("Picture"), ",")
            arrPicture = ""
            OneRecord = OneRecord & """pictures"": ["
            For P = 0 to ubound(Picture)
                arrPicture = arrPicture & """" & picture(P)& ""","
            Next
            OneRecord = OneRecord & left(arrPicture, InStrRev(arrPicture, ",") - 1)
            OneRecord = OneRecord & "]," & vbCrLf
        Else
            OneRecord = OneRecord & """pictures"": ""," & vbCrLf
        End If
        OneRecord = OneRecord & """id"": """ & Rs("ID") & """," & vbCrLf
        OneRecord = OneRecord & """title"": """& i & Rs("Title") & """," & vbCrLf
        OneRecord = OneRecord & """linkurl"": """ & Rs("LinkUrl") & """," & vbCrLf
        OneRecord = OneRecord & """description"": """ & Rs("Description") & """," & vbCrLf
        OneRecord = OneRecord & """price"": """ & FormatNumber(Rs("Price"), 2, -1) & """," & vbCrLf
        OneRecord = OneRecord & """sharing"": " & Rs("Sharing") & "," & vbCrLf
        OneRecord = OneRecord & """comments"": " & Rs("Comments") & "," & vbCrLf
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

'更新产品
Public Function updatelists()
Set Rs = server.CreateObject("adodb.recordset")
Sql = "Select * from LQ_Products where ID > " & GetMaxProductsListsID & " and IsShow = 1 order by ID Desc"
Rs.Open Sql,Conn,1,1
If Rs.eof And Rs.bof Then
    Response.Write (0)
    Response.End
Else
    ReturnStr = "{" & vbCrLf
    ReturnStr = ReturnStr & """total"": " & Rs.RecordCount & "," & vbCrLf
    ReturnStr = ReturnStr & """maxid"": " & MaxID("LQ_Products where ID > " & GetMaxProductsListsID & " and") & "," & vbCrLf
    ReturnStr = ReturnStr & """rows"": ["
    Do While Not Rs.eof
        OneRecord = "{" & vbCrLf
        If Len(trim(Rs("Picture"))) > 0 Then
            Picture = split(Rs("Picture"), ",")
            arrPicture = ""
            OneRecord = OneRecord & """pictures"": ["
            For P = 0 to ubound(Picture)
                arrPicture = arrPicture & """" & picture(P)& ""","
            Next
            OneRecord = OneRecord & left(arrPicture, InStrRev(arrPicture, ",") - 1)
            OneRecord = OneRecord & "]," & vbCrLf
        Else
            OneRecord = OneRecord & """pictures"": ""," & vbCrLf
        End If
        OneRecord = OneRecord & """id"": " & Rs("ID") & "," & vbCrLf
        OneRecord = OneRecord & """title"": """& Rs("Title") & """," & vbCrLf
        OneRecord = OneRecord & """linkurl"": """ & Rs("LinkUrl") & """," & vbCrLf
        OneRecord = OneRecord & """description"": """ & Rs("Description") & """," & vbCrLf
        OneRecord = OneRecord & """price"": """ & FormatNumber(Rs("Price"), 2, -1) & """," & vbCrLf
        OneRecord = OneRecord & """sharing"": " & Rs("Sharing") & "," & vbCrLf
        OneRecord = OneRecord & """comments"": " & Rs("Comments") & "," & vbCrLf
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

'评论
Public Function comments()
Set Rs = server.CreateObject("adodb.recordset")
Sql = "Select * from LQ_Comments where ProductID = " & ID & " and IsShow = 1 order by ID Desc"
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
    ReturnStr = ReturnStr & """maxcommentsid"": " & MaxID("LQ_Comments where") & "," & vbCrLf
    ReturnStr = ReturnStr & """rows"": ["
    For i = 1 To x
        OneRecord = "{" & vbCrLf
        OneRecord = OneRecord & """nickname"": """ & Rs("Nickname") & """," & vbCrLf
        OneRecord = OneRecord & """avatar"": """ & Rs("Avatar") & """," & vbCrLf
        OneRecord = OneRecord & """id"": """ & ID & """," & vbCrLf
        OneRecord = OneRecord & """comment"": """ & Rs("Comment") & """," & vbCrLf
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
comments = ReturnStr
Response.Write (comments)
End Function

'更新评论
Public Function updatecomments()
Set Rs = server.CreateObject("adodb.recordset")
Sql = "Select * from LQ_Comments where ID > " & GetCommentsMaxID & " and ProductID = " & ID & " and IsShow = 1 order by ID Desc"
Rs.Open Sql,Conn,1,1
If Rs.eof And Rs.bof Then
    Response.Write (0)
    Response.End
Else
    ReturnStr = "{" & vbCrLf
    ReturnStr = ReturnStr & """total"": " & Rs.RecordCount & "," & vbCrLf
    ReturnStr = ReturnStr & """maxid"": " & MaxID("LQ_Comments where") & "," & vbCrLf
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
updatecomments = ReturnStr
Response.Write (updatecomments)
End Function

'产品推荐列表
Public Function recommendations()
Set Rs = server.CreateObject("adodb.recordset")
Sql = "Select * from LQ_Products where IsRecommendation = 1 and IsShow = 1 order by ID Desc"
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
    ReturnStr = ReturnStr & """maxid"": " & MaxID("LQ_Products where IsRecommendation = 1 and") & "," & vbCrLf
    ReturnStr = ReturnStr & """rows"": ["
    For i = 1 To x
        OneRecord = "{" & vbCrLf
        OneRecord = OneRecord & """title"": """& Rs("Title") & """," & vbCrLf
        If Len(trim(Rs("Picture"))) > 0 Then
            Picture = split(Rs("Picture"), ",")
            arrPicture = ""
            OneRecord = OneRecord & """pictures"": ["
            For P = 0 to ubound(Picture)
                arrPicture = arrPicture & """" & picture(P)& ""","
            Next
            OneRecord = OneRecord & left(arrPicture, InStrRev(arrPicture, ",") - 1)
            OneRecord = OneRecord & "]," & vbCrLf
        Else
            OneRecord = OneRecord & """pictures"": ""," & vbCrLf
        End If
        OneRecord = OneRecord & """id"": """ & Rs("ID") & """," & vbCrLf
        OneRecord = OneRecord & """linkurl"": """ & Rs("LinkUrl") & """," & vbCrLf
        OneRecord = OneRecord & """description"": """ & Rs("Description") & """," & vbCrLf
        OneRecord = OneRecord & """price"": """ & FormatNumber(Rs("Price"), 2, -1) & """," & vbCrLf
        OneRecord = OneRecord & """sharing"": " & Rs("Sharing") & "," & vbCrLf
        OneRecord = OneRecord & """comments"": " & Rs("Comments") & "," & vbCrLf
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
recommendations = ReturnStr
Response.Write (recommendations)
End Function

'更新推荐
Public Function updaterecommendations()
Set Rs = server.CreateObject("adodb.recordset")
Sql = "Select * from LQ_Products where ID > " & GetRecommendationsMaxID & " and IsRecommendation = 1 and IsShow = 1 order by ID Desc"
Rs.Open Sql,Conn,1,1
If Rs.eof And Rs.bof Then
    Response.Write (0)
    Response.End
Else
    ReturnStr = "{" & vbCrLf
    ReturnStr = ReturnStr & """total"": " & Rs.RecordCount & "," & vbCrLf
    ReturnStr = ReturnStr & """maxid"": " & MaxID("LQ_Products where ID > " & GetRecommendationsMaxID & " and IsRecommendation = 1 and") & "," & vbCrLf
    ReturnStr = ReturnStr & """rows"": ["
    Do While Not Rs.eof
        OneRecord = "{" & vbCrLf
        If Len(trim(Rs("Picture"))) > 0 Then
            Picture = split(Rs("Picture"), ",")
            arrPicture = ""
            OneRecord = OneRecord & """pictures"": ["
            For P = 0 to ubound(Picture)
                arrPicture = arrPicture & """" & picture(P)& ""","
            Next
            OneRecord = OneRecord & left(arrPicture, InStrRev(arrPicture, ",") - 1)
            OneRecord = OneRecord & "]," & vbCrLf
        Else
            OneRecord = OneRecord & """pictures"": ""," & vbCrLf
        End If
        OneRecord = OneRecord & """id"": """ & Rs("ID") & """," & vbCrLf
        OneRecord = OneRecord & """title"": """& Rs("Title") & """," & vbCrLf
        OneRecord = OneRecord & """linkurl"": """ & Rs("LinkUrl") & """," & vbCrLf
        OneRecord = OneRecord & """description"": """ & Rs("Description") & """," & vbCrLf
        OneRecord = OneRecord & """price"": """ & FormatNumber(Rs("Price"), 2, -1) & """," & vbCrLf
        OneRecord = OneRecord & """sharing"": " & Rs("Sharing") & "," & vbCrLf
        OneRecord = OneRecord & """comments"": " & Rs("Comments") & "," & vbCrLf
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
updaterecommendations = ReturnStr
Response.Write (updaterecommendations)
End Function
%>
