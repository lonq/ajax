<!--#include file="inc/conn.asp"-->
<!--#include file="inc/config.asp"-->
<!--#include file="inc/function.asp"-->
<!--#include file="inc/function_page.asp"-->
<!--#include file="inc/sub_inc.asp" --><%
'常用变量
Dim Sql,Action,ID
Action=Trim(Request("Action"))
ID=ChkNumeric(Request("ID"))

Dim page, PageN, CurrPage, pageCount
PageN = 10

Select Case Action
Case "lists"
    Call lists()
Case "update"
    Call update()
Case Else
    Call lists()
End Select
'列表
Public Function lists()
Dim Rs, Sql, returnStr, oneRecord
Set Rs=server.CreateObject("adodb.recordset")
Sql="Select * from LQ_News order by ID Desc"
Rs.Open Sql,Conn,1,1

Rs.PageSize = PageN '设置页码
pageCount = Rs.PageCount '获取总页码
page = Int(Request("page")) '接收页码
If page <= 0 Then page = 1 '判断
If Int(Request("page")) = "" Then page=1
Rs.AbsolutePage = page '设置本页页码

If Rs.eof And Rs.bof Then
    Response.Write (0)
    Response.End
Else
    returnStr = "{" & vbCrLf
    returnStr = returnStr & """total"": " & Rs.RecordCount & "," & vbCrLf
    returnStr = returnStr & """pagecount"": " & Rs.PageCount & "," & vbCrLf
    returnStr = returnStr & """rows"": ["
    For i=1 To PageN
        oneRecord = "{" & vbCrLf
        oneRecord = oneRecord & """title"": """ & Rs("Orders") & Rs("Title") & """," & vbCrLf
        oneRecord = oneRecord & """picture"": """ & Rs("Picture") & """," & vbCrLf
        oneRecord = oneRecord & """linkurl"": """ & Rs("LinkUrl") & """," & vbCrLf
        oneRecord = oneRecord & """content"": """ & Rs("Content") & """," & vbCrLf
        oneRecord = oneRecord & """sharing"": " & Rs("Sharing") & "," & vbCrLf
        oneRecord = oneRecord & """comments"": " & Rs("Comments") & "," & vbCrLf
        oneRecord = oneRecord & """addtime"": """ & Rs("AddTime") & """," & vbCrLf
        oneRecord = oneRecord & """isshow"": " & Rs("IsShow") & "" & vbCrLf
        oneRecord = oneRecord & "}"
        oneRecord = oneRecord & "," & vbCrLf
        returnStr = returnStr & oneRecord
        Rs.Movenext
    Next
    returnStr = left(returnStr, InStrRev(returnStr, ",") - 1)
    returnStr = returnStr & "]"
    returnStr = returnStr & "}"
End If
Call RsClose(Rs)
lists = returnStr
Response.Write (lists)
End Function

'更新
Public Function update()
Dim Rs, Sql, returnStr, oneRecord
Set Rs=server.CreateObject("adodb.recordset")
Sql="Select * from LQ_News order by ID Desc"
Rs.Open Sql,Conn,1,1

If Rs.eof And Rs.bof Then
    Response.Write (0)
    Response.End
Else
    returnStr = "{" & vbCrLf
    returnStr = returnStr & """total"": " & Rs.RecordCount & "," & vbCrLf
    returnStr = returnStr & """rows"": ["
    For i=1 To Rs.PageSize
        oneRecord = "{" & vbCrLf
        oneRecord = oneRecord & """title"": ""New-" & Rs("Orders") & Rs("Title") & """," & vbCrLf
        oneRecord = oneRecord & """picture"": """ & Rs("Picture") & """," & vbCrLf
        oneRecord = oneRecord & """linkurl"": """ & Rs("LinkUrl") & """," & vbCrLf
        oneRecord = oneRecord & """content"": """ & Rs("Content") & """," & vbCrLf
        oneRecord = oneRecord & """sharing"": " & Rs("Sharing") & "," & vbCrLf
        oneRecord = oneRecord & """comments"": " & Rs("Comments") & "," & vbCrLf
        oneRecord = oneRecord & """addtime"": """ & Rs("AddTime") & """," & vbCrLf
        oneRecord = oneRecord & """isshow"": " & Rs("IsShow") & "" & vbCrLf
        oneRecord = oneRecord & "}"
        oneRecord = oneRecord & "," & vbCrLf
        returnStr = returnStr & oneRecord
        Rs.Movenext
    Next
    returnStr = left(returnStr, InStrRev(returnStr, ",") - 1)
    returnStr = returnStr & "]"
    returnStr = returnStr & "}"
End If
Call RsClose(Rs)
update = returnStr
Response.Write (update)
End Function
%>
