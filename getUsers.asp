<!--#include file="token.asp"--><%
'常用变量
Dim Sql, Rs, Action, UsersID, UsersName, ReturnStr, OneRecord
Dim UsersFace, UsersPetName, UsersSex, UsersBirthday, UsersPhone, UsersEMail, UsersSignature, SMS, limitTime, expiresTime
Dim Picture
Action = Trim(Request("Action"))
If Trim(Request.Form("UsersID")) = "" Then
    UsersID = ChkNumeric(Request("UsersID"))
Else
    UsersID = ChkNumeric(Request.Form("UsersID"))
End If
UsersName = Trim(Request.Form("UsersName"))
UsersPetName = Trim(Request.Form("UsersPetName"))
UsersSex = Trim(Request.Form("UsersSex"))
UsersBirthday = Trim(Request.Form("UsersBirthday"))
UsersPhone = Trim(Request.Form("UsersPhone"))
UsersEMail = Trim(Request.Form("UsersEMail"))
UsersSignature = HTMLClear(Trim(Request.Form("UsersSignature")))
SMS = Trim(Request.Form("SMS"))
limitTime = ChkNumeric(Request("limitTime"))
expiresTime = ChkNumeric(Request("expiresTime"))

'自定义变量
Dim urlData, upPath, rndNumber, fileName
urlData = Trim(Request("urlData"))
upPath = "uploadfiles/avatars/"
Picture = replace(urlData, "data:image/jpeg;base64,", "")
rndNumber = year(now)&month(now)&day(now)&hour(now)&minute(now)&second(now()) ''生成当天的子文件夹的名称
fileName = MyAppPath & upPath & rndNumber & ".jpg"
UsersFace = fileName

Dim RsData, DataUsersName, DataUsersFace, DataUsersPetName, DataUsersPhone, DataUsersEMail, DataUsersSignature
Set RsData = server.CreateObject("adodb.recordset")
Sql = "Select * from [LQ_Users] where UsersID = "&UsersID&""
RsData.Open Sql,Conn,1,1
If Not(RsData.eof And RsData.bof) Then
DataUsersName = Trim(RsData("UsersName"))
DataUsersFace = Trim(RsData("UsersFace"))
DataUsersPetName = Trim(RsData("UsersPetName"))
DataUsersSex = Trim(RsData("UsersSex"))
DataUsersBirthday = Trim(RsData("UsersBirthday"))
DataUsersPhone = Trim(RsData("UsersPhone"))
DataUsersEMail = Trim(RsData("UsersEMail"))
DataUsersSignature = Trim(RsData("UsersSignature"))
End If
Call RsClose(RsData)

'执行
Select Case Action
Case "lists"
    Call lists()
Case "content"
    Call content()
Case "usercapability"
    Call usercapability()
Case "updateUsersFace"
    Call updateUsersFace()
Case "updateUsersPetName"
    Call updateUsersPetName()
Case "updateUsersSex"
    Call updateUsersSex()
Case "updateUsersBirthday"
    Call updateUsersBirthday()
Case "updateUsersPhone"
    Call updateUsersPhone()
Case "updateUsersEMail"
    Call updateUsersEMail()
Case "updateUsersSignature"
    Call updateUsersSignature()

Case "checkUsersPhone"
    Call checkUsersPhone()
Case "sendSMS"
    Call sendSMS()
Case "checkSMS"
    Call checkSMS()

Case Else
    Call lists()
End Select

'正文
Public Function content()
Set Rs = server.CreateObject("adodb.recordset")
Sql = "Select * from [LQ_Users] where UsersID = "&UsersID&""
Rs.Open Sql,Conn,1,1
If Rs.eof And Rs.bof Then
    Response.Write (0)
    Response.End
Else
    ReturnStr = ReturnStr & "{" & vbCrLf
    ReturnStr = ReturnStr & """usersid"": " & Rs("UsersID") & "," & vbCrLf
    ReturnStr = ReturnStr & """orders"": " & Rs("Orders") & "," & vbCrLf
    ReturnStr = ReturnStr & """usersname"": """& Rs("UsersName") & """," & vbCrLf
    ReturnStr = ReturnStr & """usersemail"": """& Rs("UsersEMail") & """," & vbCrLf
    ReturnStr = ReturnStr & """userspetname"": """& Rs("UsersPetName") & """," & vbCrLf
    ReturnStr = ReturnStr & """userssex"": """& Rs("UsersSex") & """," & vbCrLf
    ReturnStr = ReturnStr & """usersbirthday"": """& Rs("UsersBirthday") & """," & vbCrLf
    ReturnStr = ReturnStr & """usersphone"": """& Rs("UsersPhone") & """," & vbCrLf
    ReturnStr = ReturnStr & """usersface"": """& Rs("UsersFace") & """," & vbCrLf
    ReturnStr = ReturnStr & """iscookie"": " & Rs("IsCookie") & "," & vbCrLf
    ReturnStr = ReturnStr & """userssignature"": """& Rs("UsersSignature") & """," & vbCrLf
    ReturnStr = ReturnStr & """isactive"": " & Rs("IsActive") & "," & vbCrLf
    ReturnStr = ReturnStr & """logindate"": """& Rs("LoginDate") & """," & vbCrLf
    ReturnStr = ReturnStr & """loginip"": """& Rs("LoginIP") & """," & vbCrLf
    ReturnStr = ReturnStr & """addtime"": """& Rs("AddTime") & """," & vbCrLf
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

'用户头像
Public Function updateUsersFace()
'写入头像
xmlstr = "<data>"&Picture&"</data>"
Dim xml : Set xml = Server.CreateObject("MSXML2.DOMDocument")
Dim stm : Set stm = Server.CreateObject("ADODB.Stream")
xml.resolveExternals = False
xml.loadxml(xmlstr)
xml.documentElement.setAttribute "xmlns:dt","urn:schemas-microsoft-com:datatypes"
xml.documentElement.dataType = "bin.base64"
stm.Type = 1 'adTypeBinary
stm.Open
stm.Write xml.documentElement.nodeTypedValue
stm.SaveToFile Server.MapPath(fileName)
stm.Close
Set xml = Nothing
Set stm = Nothing
'更新头像路径
Conn.ExeCute("Update [LQ_Users] set UsersFace='"&UsersFace&"' where UsersID = "&UsersID&"")
Response.Write (1)
Call ConnClose(Conn)
End Function

'用户昵称
Public Function updateUsersPetName()
If UsersPetName <> DataUsersPetName Then
Conn.ExeCute("UpDate [LQ_Users] set UsersPetName='"&UsersPetName&"' where UsersID = "&UsersID&"")
End If
Call ConnClose(Conn)
End Function

'用户性别
Public Function updateUsersSex()
If UsersSex <> DataUsersSex Then
Conn.ExeCute("UpDate [LQ_Users] set UsersSex='"&UsersSex&"' where UsersID = "&UsersID&"")
End If
Call ConnClose(Conn)
End Function

'用户生日
Public Function updateUsersBirthday()
If UsersBirthday <> DataUsersBirthday Then
Conn.ExeCute("UpDate [LQ_Users] set UsersBirthday='"&UsersBirthday&"' where UsersID = "&UsersID&"")
End If
Call ConnClose(Conn)
End Function

'用户手机号
Public Function updateUsersPhone()
If UsersPhone <> DataUsersPhone Then
Conn.ExeCute("UpDate [LQ_Users] set UsersPhone='"&UsersPhone&"' where UsersID = "&UsersID&"")
End If
Call ConnClose(Conn)
End Function

'用户邮箱
Public Function updateUsersEMail()
If UsersEMail <> DataUsersEMail Then
Conn.ExeCute("UpDate [LQ_Users] set UsersEMail='"&UsersEMail&"' where UsersID = "&UsersID&"")
End If
Call ConnClose(Conn)
End Function

'用户签名
Public Function updateUsersSignature()
If UsersSignature <> DataUsersSignature Then
Conn.ExeCute("UpDate [LQ_Users] set UsersSignature='"&UsersSignature&"' where UsersID = "&UsersID&"")
End If
Call ConnClose(Conn)
End Function

'验证电话
Public Function checkUsersPhone()
Set Rs = server.CreateObject("adodb.recordset")
Sql = "Select * from [LQ_Users] where UsersPhone = '"&UsersPhone&"'"
Rs.Open Sql,Conn,1,1
If Rs.eof And Rs.bof Then
    Response.Write ("false")
    Response.End
Else
    Response.Write ("true")
    Response.End
End If
Call RsClose(Rs)
End Function

'发送sms
Public Function sendSMS()
Dim RndNum
Randomize
RndNum = Int((999999 * Rnd) + 000000)
Set Rs = server.CreateObject("adodb.recordset")
Sql = "Select * from LQ_SMS where UsersPhone = '"&UsersPhone&"'"
Rs.Open Sql,Conn,1,3
If Not(Rs.eof And Rs.bof) Then
	If Now() > DateAdd("s", limitTime, Rs("AddTime")) Then
		Conn.ExeCute("Delete from LQ_SMS where UsersPhone = '"&UsersPhone&"'")
		Rs.AddNew
		Rs("UsersPhone") = UsersPhone
		Rs("RndNum") = RndNum
		Rs.Update
		Response.write (1)
		Response.End
	Else
		Response.write (0)
		Response.End
	End If
Else
    Rs.AddNew
    Rs("UsersPhone") = UsersPhone
    Rs("RndNum") = RndNum
    Rs.Update
    Response.write (1)
    Response.End
End If
RsClose(Rs)
ConnClose(Conn)
End Function

'检查sms
Public Function checkSMS()
Set Rs = server.CreateObject("adodb.recordset")
Sql = "Select * from LQ_SMS where RndNum = '"&RndNum&"' and UsersPhone = '"&UsersPhone&"'"
Rs.Open Sql,Conn,1,1
If Not(Rs.eof And Rs.bof) Then
	If Now() <= DateAdd("s", expiresTime, Rs("AddTime")) Then
		Response.Write ("true")
		Response.End
	End If
Else
	Response.Write ("false")
	Response.End
End If
Call RsClose(Rs)
End Function
%>
