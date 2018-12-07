<%
'***************************************************
'数据库、表操作
'***************************************************
'判断数据表是否存在
Function CheckTable(TableName,Conn)
On Error Resume Next
Err.Clear
Dim c_SQL
c_SQL = "SELECT * FROM [" & TableName & "]"
Conn.ExeCute(c_SQL)
If Err.Number <> 0 Then
Err.Clear
CheckTable = False
Else
CheckTable = True
End If
End Function
'判断数据表字段是否存在
Function CheckFields(FieldsName,TableName)
Flag=False
sql= "SELECT * FROM [" & TableName & "]"
set RSt=server.CreateObject("adodb.recordset")
RSt.open sql,conn,1,1
On Error Resume Next
for i = 0 to RSt.Fields.Count - 1
if RSt.Fields(i).Name=FieldsName then
Flag=True
Exit For
else
Flag=False
end if
Next
CheckFields=Flag
RSt.close
Set RSt = nothing
End Function
'***************************************************
'获得数据表（变量str）的数据条数
'str----可加数据表名和条件
'***************************************************
Public Function CountNums(ByVal Str)
If IsNull(str) Then Exit Function
Dim RsCount
set RsCount=Conn.execute("select count(*) from "&Str&"")
CountNums=RsCount(0)
if IsNull(CountNums) then CountNums=0
End Function
'******************************
'根据ID循环显示数组
'***************************************************
Public Function ArrayName(Byval Table_Name,Byval Fields_Name,Byval ID_Name)
If IsNull(Table_Name) Or IsNull(Fields_Name) Or IsNull(ID_Name) Then Exit Function
Dim Str_Name,T_Sel_ID
'判断数据表和字段是否存在
If CheckTable("LQ_"&Table_Name,Conn) = False Or CheckFields(Fields_Name,"LQ_"&Table_Name) = False Then
Exit Function
Else
For i=1 To ID_Name.Count
If ID_Name.Count=1 Then
T_Sel_ID=ID_Name
Else
T_Sel_ID=Replace(ID_Name(i),"'","")
End If
Str_Name=Conn.ExeCute("select "&Fields_Name&" from LQ_"&Table_Name&" where ID="&T_Sel_ID&"")(0)
ArrayName=ArrayName&"<li>"&Str_Name&"</li>"
Next
End If
End Function
'***************************************************
'拆分数组
'***************************************************
Public Function SplitArray(ByVal RuleStr,ByVal Str)
If IsNull(str) Then Exit Function
Dim sRuleStr,i
sRuleStr = Split(RuleStr,Str)
On Error Resume Next
For i = 0 To UBound(sRuleStr)
If InStr(1,Str, sRuleStr(i),1) > 0 Then
SplitArray = sRuleStr
End If
Next
SplitArray = sRuleStr
End Function
'*************************************************
'增加提交数据的安全性
'*************************************************
'强制字符串为数值型，以增加安全性及减少出错率
'*************************************************
Public Function ChkNumeric(ByVal CHECK_ID)
If CHECK_ID <> "" And IsNumeric(CHECK_ID) Then
If CHECK_ID < 0 Then CHECK_ID = 0
If CHECK_ID > 2147483647 Then CHECK_ID = 0
CHECK_ID = CLng(CHECK_ID)
Else
CHECK_ID = 0
End If
ChkNumeric = CHECK_ID
End Function
Public Function CheckStr(ByVal str)
If IsNull(str) Then
CheckStr = ""
Exit Function
End If
str = Replace(str, Chr(0), "")
CheckStr = Replace(str, "'", "''")
End Function
'*************************************************
'替换Request的某些字符，增加Request安全性及减少出错率
'*************************************************
Public Function RequestForm(ByVal strRequest,Byval strLen)
Dim m_strRequest
If IsNull(strRequest) Or Len(strRequest) = 0 Then
	RequestForm = ""
	Exit Function
End If
m_strRequest = Trim(strRequest)
m_strRequest = Replace(m_strRequest, Chr(0), "")
m_strRequest = Replace(m_strRequest, Chr(255), "")
m_strRequest = Replace(m_strRequest, "'", "&#39;")
m_strRequest = Replace(m_strRequest, Chr(34), "&quot;")
m_strRequest = Replace(m_strRequest, ">", "&gt;")
m_strRequest = Replace(m_strRequest, "<", "&lt;")
m_strRequest = Replace(m_strRequest, "&#62;", "&gt;")
m_strRequest = Replace(m_strRequest, "&#60;", "&lt;")
m_strRequest = Replace(m_strRequest, "--", "－－")
m_strRequest = Replace(m_strRequest, "'", "''")
If Len(m_strRequest) > 0 And strLen > 0 Then
	RequestForm = Left(m_strRequest,strLen)
Else
	RequestForm = m_strRequest
End If
End Function
'================================================
'函数名：IsValidStr
'作  用：判断字符串中是否含有非法字符
'参  数：str   ----原字符串
'返回值：False,True -----布尔值
'================================================
Public Function IsValidStr(ByVal str)
IsValidStr = False
On Error Resume Next
If IsNull(str) Then Exit Function
If Trim(str) = Empty Then Exit Function
If InStr(str, "|")>0 Then Exit Function
Dim ForbidStr, i
ForbidStr = "and|chr|:|=|%|&|$|#|@|+|-|*|/|\|<|>|;|,|^|" & Chr(32) & "|" & Chr(34) & "|" & Chr(39) & "|" & Chr(9)
ForbidStr = Split(ForbidStr, "|")
For i = 0 To UBound(ForbidStr)
	If InStr(LCase(str), ForbidStr(i))>0 And ForbidStr(i)<>"" Then
		IsValidStr = False
		Exit Function
	End If
Next
IsValidStr = True
End Function
'***************************************************
'禁止字符（类似IsValidStr）
'***************************************************
Public Function ChkForbiddenWords(ByVal RuleStr,ByVal Str)
ChkForbiddenWords = False
On Error Resume Next
If IsNull(str) Then Exit Function
If Trim(str) = Empty Then Exit Function
If InStr(str, "|")>0 Then Exit Function
Dim sRuleStr, i
sRuleStr = Split(RuleStr, "|")
For i = 0 To UBound(sRuleStr)
	If InStr(LCase(str), sRuleStr(i))>0 And sRuleStr(i)<>"" Then
		ChkForbiddenWords = False
		Exit Function
	End If
Next
ChkForbiddenWords = True
End Function
'***************************************************
'列出相同字符
'***************************************************
Public Function ChkSameWords(ByVal RuleStr,ByVal Str)
If IsNull(str) Then Exit Function
Dim SameWords,i
SameWords = Split(RuleStr,"|")
On Error Resume Next
For i = 0 To UBound(SameWords)
If InStr(1,Str, SameWords(i),1) > 0 Then
ChkSameWords = ChkSameWords & SameWords(i)
End If
Next
End Function
'================================================
'函数名：IsValidPassWord
'作  用：判断密码字符串中是否含有非法字符
'参  数：str   ----原字符串
'返回值：False,True -----布尔值
'================================================
Public Function IsValidPassWord(ByVal str)
IsValidPassWord=False
On Error Resume Next
If IsNull(str) Then Exit Function
If Trim(str) = Empty Then Exit Function
If InStr(str, ",")>0 Then Exit Function
Dim ForbidStr, i
ForbidStr = "',"",;,%,=,+,^"
ForbidStr = Split(ForbidStr, "|")
For i = 0 To UBound(ForbidStr)
	If InStr(LCase(str), ForbidStr(i))>0 And ForbidStr(i)<>"" Then
		IsValidPassWord = False
		Exit Function
	End If
Next
IsValidPassWord = True
End Function
'***************************************************
'脏话过滤
'***************************************************
Public Function ChkBadWords(str)
If IsNull(str) Then Exit Function
Dim Badwordlist,i,BadworArry
Badwordlist=Split(Badwords,"|")
For i=0 To UBound(Badwordlist)
	If Badwordlist(i)<>"" Then
		BadworArry=Split(Badwordlist(i), "=")
		If UBound(BadworArry)>0 Then
			If BadworArry(0)<>"" Then
				If BadworArry(1)<>"" Then
					str=Replace(str,BadworArry(0),BadworArry(1))
				Else
					str=Replace(str,BadworArry(0),String(Len(BadworArry(0)), "*"))
				End If
			End If
		Else
			str=Replace(str,BadworArry(0),String(Len(BadworArry(0)), "*"))
		End If
	End If
Next
BadworArry=Null
Badwordlist=Null
ChkBadWords = str
End Function
'***************************************************
'受屏蔽IP地址(段)集合，星号为通配符，通常保存于配置文件中。
'LockIP = "192.168.1.*|202.68.*.*|*.12.55.34|185.*.96.24|127.*.0.1|192.168.0.1"
'参数Str：要屏蔽的IP段,IP地址集合，用|符号分隔多个IP地址(段)
'返回Bool：True用户IP在被屏蔽范围，False 反之
'***************************************************
Function IsForbidIP(ByVal Str ,ByVal CurrentIP)
If IsNull(Str) Then Exit Function
Dim counter, arrIPPart, arrBadIP, arrBadIPPart, i, j
arrBadIP = Split(Str, "|")
arrIPPart = Split(CurrentIP, ".")
On Error Resume Next
For i = 0 To UBound(arrBadIP)
counter = 0
arrBadIPPart = Split(arrBadIP(i), ".")
For j = 0 To UBound(arrIPPart)
If (arrBadIPPart(j)) = "*" or Cstr(arrIPPart(j)) = Cstr(arrBadIPPart(j)) Then
counter = counter + 1
End If
Next
If counter = 4 Then
IsForbidIP = True
Exit Function
End If
Next
IsForbidIP = False
End Function
'******************************
'获取真实IP
'***************************************************
Public Function getIP()
Dim strIPAddr
If Request.ServerVariables("HTTP_X_FORWARDED_FOR") = "" Or InStr(Request.ServerVariables("HTTP_X_FORWARDED_FOR"), "unknown") > 0 Then
	strIPAddr = Request.ServerVariables("REMOTE_ADDR")
ElseIf InStr(Request.ServerVariables("HTTP_X_FORWARDED_FOR"), ",") > 0 Then
	strIPAddr = Mid(Request.ServerVariables("HTTP_X_FORWARDED_FOR"), 1, InStr(Request.ServerVariables("HTTP_X_FORWARDED_FOR"), ",")-1)
	actforip = Request.ServerVariables("REMOTE_ADDR")
ElseIf InStr(Request.ServerVariables("HTTP_X_FORWARDED_FOR"), ";") > 0 Then
	strIPAddr = Mid(Request.ServerVariables("HTTP_X_FORWARDED_FOR"), 1, InStr(Request.ServerVariables("HTTP_X_FORWARDED_FOR"), ";")-1)
	actforip = Request.ServerVariables("REMOTE_ADDR")
Else
	strIPAddr = Request.ServerVariables("HTTP_X_FORWARDED_FOR")
	actforip = Request.ServerVariables("REMOTE_ADDR")
End If
getIP = Replace(Trim(Mid(strIPAddr, 1, 30)), "'", "")
End Function
'*****************************************************************************
'Sql防注入专区****************************************************************
'*****************************************************************************
'防Sql注入
'****************************************************
Public Function ChkSQLInWord()
Call ConnOpen(DataBaseNameLog,0,Str_db)
'定义非法操作的次数
Dim RsLogTotalCount,LogTotalCountNums
set RsLogTotalCount=Str_db.Execute("select Count(*) from LQ_SQLIn")
LogTotalCountNums=RsLogTotalCount(0)
if isNull(LogTotalCountNums) then LogTotalCountNums=0
'定义IP非法操作的次数
Dim RsLogCount,LogCountNums
set RsLogCount=Str_db.Execute("select Count(*) from LQ_SQLIn where SqlIn_IP='"&getIP&"'")
LogCountNums=RsLogCount(0)
if isNull(LogCountNums) then LogCountNums=0
Call ConnClose(Str_db)
'定义函数
Dim SQL_Injdata,SQL_Inj,SQL_Get,SQL_Post,SQL_DATA,Str_db
'定义非法字符
SQL_Injdata = ":|;|--|sp_|xp_|\|dir|cmd|^|(|)|+|$|'|copy|format|and|exec|insert|select|delete|update|count|*|%|chr|mid|master|truncate|char|declare"
'SQL_Injdata = ""&SQLInword&""
SQL_Inj = split(SQL_Injdata,"|")
'Get
If Request.QueryString<>"" Then
	For Each SQL_Get In Request.QueryString
		For SQL_Data=0 To Ubound(SQL_Inj)
			If instr(Request.QueryString(SQL_Get),SQL_Inj(SQL_DATA))>0 Then
				'如果开启了记录，写入数据库s
				If IsSqlLog=1 And LogTotalCountNums<500 Then
					Str_db.Execute("insert into LQ_SQLIn(SQLin_IP,SQLIn_Web,SQLIn_FS,SQLIn_CS,SQLIn_SJ) values('"&getIP&"','"&Request.ServerVariables("URL")&"','GET','"&SQL_Get&"','"&replace(Request.QueryString(SQL_Get),"'","''")&"')")
					Call ConnClose(Str_db)
				End If
				'写入数据库e
				'超过次数则记录IP
				If LogCountNums>5 Then
					If IsForbidIP(LockIP,getIP) = false Then
						If LockIP<>"" Then
						curErrIP="|"&getIP
						Conn.ExeCute("UpDate LQ_Config set LockIP=LockIP+'"&curErrIP&"'")
						Else
						curErrIP=getIP
						Conn.ExeCute("UpDate LQ_Config set LockIP='"&curErrIP&"'")
						End If
					Call ConnClose(Conn)
					End If
				End If
			ErrMsg="<li>您提交了非法参数，操作已被禁止并记录！</li>"
			Call showError(ErrMsg)
			'Response.Write ("您提交了非法参数，操作已被禁止并记录！")
			Response.End
			End If
		Next
	Next
End If
'Post
If Request.Form<>"" Then
	For Each SQL_Post In Request.Form
		For SQL_Data=0 To Ubound(SQL_Inj)
			If instr(Request.Form(SQL_Post),SQL_Inj(SQL_DATA))>0 Then
				'如果开启了记录，写入数据库s
				If IsSqlLog=1 And LogTotalCountNums<500 Then
					Str_db.Execute("insert into LQ_SQLIn(SQLin_IP,SQLIn_Web,SQLIn_FS,SQLIn_CS,SQLIn_SJ) values('"&getIP&"','"&Request.ServerVariables("URL")&"','Post','"&SQL_Post&"','"&replace(Request.Form(SQL_Post),"'","''")&"')")
					Call ConnClose(Str_db)
				End If
				'写入数据库e
				'超过次数则记录IP
				If LogCountNums>5 Then
					If IsForbidIP(LockIP,getIP) = false Then
						If LockIP<>"" Then
						curErrIP="|"&getIP
						Conn.ExeCute("UpDate LQ_Config set LockIP=LockIP+'"&curErrIP&"'")
						Else
						curErrIP=getIP
						Conn.ExeCute("UpDate LQ_Config set LockIP='"&curErrIP&"'")
						End If
					Call ConnClose(Conn)
					End If
				End If
			ErrMsg="<li>您提交了非法参数，操作已被禁止并记录！</li>"
			Call showError(ErrMsg)
			'Response.Write ("您提交了非法参数，操作已被禁止并记录！")
			Response.End
			End If
		Next
	Next
End If
End Function
'=============================================================
'函数作用：判断来源URL是否来自外部
'=============================================================
Public Function CheckOutLinks()
On Error Resume Next
Dim server_v1,server_v2,i,Allowlists
CheckOutLinks=False
If Trim(MainSetting(49))="*" Then
	CheckOutLinks=True
	Exit Function
End If
server_v1 = LCase(Request.ServerVariables("HTTP_REFERER"))
server_v2 = LCase(Request.ServerVariables("SERVER_NAME"))
Allowlists = server_v2&","&MainSetting(49)
Allowlists=Split(LCase(Allowlists),",")
If Len(server_v1)>1 Then
	If InStr(9,server_v1,"/")>0 Then server_v1=Mid(server_v1,1,InStr(9,server_v1,"/"))
	For i=0 to Ubound(Allowlists)
		If InStr(server_v1,Allowlists(i))>0 And Len(Allowlists(i))>1 Then
			CheckOutLinks=True
			Exit For
		End If
	Next
Else
	CheckOutLinks=False
End If
End Function
'=============================================================
'函数作用：判断Post
'=============================================================
Public Function ChkPost()
Dim server_v1,server_v2
Chkpost=False
server_v1=Cstr(Request.ServerVariables("HTTP_REFERER"))
server_v2=Cstr(Request.ServerVariables("SERVER_NAME"))
If Mid(server_v1,8,len(server_v2))=server_v2 Then Chkpost=True
End Function
'****************************************************************************
'功能说明: 计算源字符串Str的长度(一个中文字符为2个字节长)
'参数说明: - str [string]: 源字符串
'返回值: - [Int] 源字符串的长度
''****************************************************************************
Public Function strLen(Str)
If IsNull(str) Then
strlen=0
else
Dim P_len,x
P_len=0
StrLen=0
P_len=Len(Trim(Str))
For x=1 To P_len
If Asc(Mid(Str,x,1))<0 Then
StrLen=Int(StrLen) + 2
Else
StrLen=Int(StrLen) + 1
End If
Next
end if
End Function
'****************************************************************************
'功能说明: 截取源字符串Str的前LenNum个字符(一个中文字符为2个字节长)
'参数说明: - str [string]: 源字符串
'参数说明: - LenNum [int]: 截取的长度
'返回值: - [string]: 转换后的字符串
'****************************************************************************
Public Function CutStr(ByVal str,ByVal strlen)
Dim i,l,t,c
l=len(str)
strlen=CLng(strlen)
If strlen<1 Then
	CutStr=str
Else
	t=0
	For i=1 To l
		c=Asc(Mid(str,i,1))
		If c<2 Then
			t=t+2
		Else
			t=t+1
		End If
		If t>=strlen Then
			'CutStr=left(str,i)&Ellipsis
			CutStr=left(str,i)
			Exit for
		Else
			CutStr=str
		End If
	Next
End If
CutStr=Replace(CutStr,Chr(10),"")
End Function
'***************************************************
'字符串HTML过滤
'***************************************************
'功能说明: 将字符串中的str中的HTML代码进行过滤
'参数说明: - Str 源字符串
'返回值: - string 转换后的字符串
'***************************************************
Public Function HTMLEncodes(ByVal fString)
If Not IsNull(fString) Then
	'fString = Replace(fString, "&", "&amp;")
	fString = Replace(fString, "'", "&#39;")
	fString = Replace(fString, ">", "&gt;")
	fString = Replace(fString, "<", "&lt;")
	fString = Replace(fString, Chr(32), " ")
	fString = Replace(fString, Chr(9), " ")
	fString = Replace(fString, Chr(34), "&quot;")
	fString = Replace(fString, Chr(39), "&#39;")
	fString = Replace(fString, Chr(13), "")
	fString = Replace(fString, " ", "&nbsp;")
	fString = Replace(fString, Chr(10), "<br />")
	HTMLEncodes = ChkBadWords(fString)
End If
End Function
'***************************************************
'清除HTML代码
'***************************************************
Public Function HTMLClear(Byval Str)
If Trim(Str)="" Or IsNull(Str) then
HTMLClear=""
else
dim re
Set re=new RegExp
re.IgnoreCase =true
re.Global=True
re.Pattern="(\<.[^\<]*\>)"
Str=re.Replace(Str,"")
re.Pattern="(\<\/[^\<]*\>)"
Str=re.Replace(Str,"")
re.Pattern=Chr(13)&Chr(10)
Str=re.Replace(Str,"")
re.Pattern=chr(32)&" "
Str=re.Replace(Str,"")
'临时空格
re.Pattern="&emsp;"
Str=re.Replace(Str,"")
re.Pattern="	"
Str=re.Replace(Str,"")
re.Pattern="　"
Str=re.Replace(Str,"")
re.Pattern="&nbsp;"
Str=re.Replace(Str,"")
HTMLClear=Str
Set re=Nothing
End If
End Function
'***************************************************
'格式化字符串等
'***************************************************
'精确到毫秒的脚本执行时间
'***************************************************
Public Function GetScriptTime(StartTimer)
GetScriptTime = FormatNumber((Timer()-StartTimer)*1000, 2, -1)
End Function
'=================================================
'函数名：GetFileSize
'作  用：格式化文件的大小
'=================================================
Public Function BytesToString(ByVal iSize)
Dim sRet,KB,MB,S
KB = 1024 : MB = KB * KB
If Not IsNumeric(iSize) Then
	BytesToString = "未知"
	Exit Function
End If
If iSize < KB Then
	sRet = iSize & " Byte"
Else
	S = iSize / KB
	If S < 10 Then
		sRet = FormatNumber(iSize / KB, 2, -1) & " KB"
	ElseIf S < 100 Then
		sRet = FormatNumber(iSize / KB, 1, -1) & " KB"
	ElseIf S < 1000 Then
		sRet = FormatNumber(iSize / KB, 0, -1) & " KB"
	ElseIf S < 10000 Then
		sRet = FormatNumber(iSize / MB, 2, -1) & " MB"
	ElseIf S < 100000 Then
		sRet = FormatNumber(iSize / MB, 1, -1) & " MB"
	ElseIf S < 1000000 Then
		sRet = FormatNumber(iSize / MB, 0, -1) & " MB"
	ElseIf S < 10000000 Then
		sRet = FormatNumber(iSize / MB / KB, 2, -1) & " GB"
	Else
		sRet = FormatNumber(iSize / MB / KB, 1, -1) & " GB"
	End If
End If
BytesToString = sRet
End Function
'***************************************************
'格式化数字，结果例子：1,000,000.00
'***************************************************
Public Function FormatNum(Byval num,Byval n)
If Not IsNumeric(num) or num="" Then num=0
If num<1 and num>0 Then
FormatNum = "0" & FormatNumber(num,n)
Else
FormatNum = FormatNumber(num,n)
End If
End Function
'***************************************************
'将数字转换为货币格式，结果例子：￥1,000,000.00
'***************************************************
Public Function ToPrice(num)
If Not IsNumeric(num) or num="" Then num=0
ToPrice = FormatCurrency(num,2,-1,0,-1)
End Function
'***************************************************
'格式化日期，结果例子：2012-08-31
'***************************************************
Public Function FormatDate(DateAndTime,para)
On Error Resume Next
Dim y, m, d, h, mi, s, strDateTime
FormatDate = DateAndTime
If Not IsNumeric(para) Then Exit Function
If Not IsDate(DateAndTime) Then Exit Function
y = CStr(Year(DateAndTime))
m = CStr(Month(DateAndTime))
If Len(m) = 1 Then m = "0" & m
d = CStr(Day(DateAndTime))
If Len(d) = 1 Then d = "0" & d
h = CStr(Hour(DateAndTime))
If Len(h) = 1 Then h = "0" & h
mi = CStr(Minute(DateAndTime))
If Len(mi) = 1 Then mi = "0" & mi
s = CStr(Second(DateAndTime))
If Len(s) = 1 Then s = "0" & s
Select Case para
Case "1"
strDateTime = y & "-" & m & "-" & d & " " & h & ":" & mi & ":" & s
Case "2"
strDateTime = y & "-" & m & "-" & d
Case "3"
strDateTime = y & "/" & m & "/" & d
Case "4"
strDateTime = y & "年" & m & "月" & d & "日"
Case "5"
strDateTime = m & "-" & d
Case "6"
strDateTime = m & "/" & d
Case "7"
strDateTime = m & "月" & d & "日"
Case "8"
strDateTime = y & "年" & m & "月"
Case "9"
strDateTime = y & "-" & m
Case "10"
strDateTime = y & "/" & m
Case "11"
y = CStr(Year(DateAndTime))
strDateTime = y & "-" & m & "-" & d
Case "12"
y = CStr(Year(DateAndTime))
strDateTime = y & m & d & "_" & h & mi & s
Case Else
strDateTime = DateAndTime
End Select
'FormatDate = strDateTime
If datediff("d",DateAndTime,Now())=0 then
'当天
FormatDate = ""&strDateTime&""
'FormatDate = "<font color='#ff0000'>"&strDateTime&"</font>"
else
FormatDate = ""&strDateTime&""
End if
End Function
'***************************************************
'函数名：IsObjInstalled
'作用：检查组件是否已经安装
'参数：str ----组件名
'返回值：True----已经安装
' False ----没有安装
'***************************************************
Public Function IsObjInstalled(ByVal Str)
On Error Resume Next
IsObjInstalled = False
Err = 0
Dim xTestObj
Set xTestObj = Server.CreateObject(Str)
If Err = 0 Then IsObjInstalled = True
If Err = -2147352567 Then IsObjInstalled = True
Set xTestObj = Nothing
Err = 0
End Function
'================================================
' 函数名：ChkMapPath
' 作  用：相对路径转换为绝对路径
' 参  数：strPath ----原路径
' 返回值：绝对路径
'================================================
Function ChkMapPath(ByVal strPath)
	Dim fullPath
	strPath = Replace(Replace(Trim(strPath), "/", "\"), "\\", "\")

	If strPath = "" Then strPath = "."
	If InStr(strPath,":\") = 0 Then
		fullPath = Server.MapPath(strPath)
	Else
		strPath = Replace(strPath,"..\","")
		fullPath = Trim(strPath)
		If Right(fullPath, 1) = "\" Then
			fullPath = Left(fullPath, Len(fullPath) - 1)
		End If
	End If
	ChkMapPath = fullPath
End Function
'修正文件路径2
Public Function CheckPath(ByVal sPath)
sPath = Trim(sPath)
If Right(sPath, 1) <> "\" And sPath <> "" Then
	sPath = sPath & "\"
End If
CheckPath = sPath
End Function
'================================================
'文件及文件夹增删改
'================================================
'函数名：FilesDelete
'作  用：FSO删除文件
'参  数：FilePath   ----文件路径
'返回值：False  ----  True
'================================================
Public Function FileDelete(ByVal FilePath)
On Error Resume Next
FileDelete = False
If FilePath = "" Then Exit Function
Set fso = CreateObject("Scripting.FileSystemObject")
If InStr(FilePath, ":") = 0 Then FilePath = Server.MapPath(FilePath)
If fso.FileExists(FilePath) Then
fso.DeleteFile FilePath, True
FileDelete = True
End If
Set fso=Nothing
If Err.Number <> 0 Then Err.Clear
End Function
'================================================
'函数名：FolderDelete
'作  用：FSO删除目录
'参  数：folderpath   ----目录路径
'返回值：False  ----  True
'================================================
Public Function FolderDelete(ByVal FolderPath)
FolderDelete = False
On Error Resume Next
If FolderPath = "" Then Exit Function
Set fso = CreateObject("Scripting.FileSystemObject")
If InStr(FolderPath, ":") = 0 Then FolderPath = Server.MapPath(FolderPath)
If fso.FolderExists(FolderPath) Then
	fso.DeleteFolder FolderPath, True
	FolderDelete = True
End If
Set fso=Nothing
If Err.Number <> 0 Then Err.Clear
End Function
'================================================
'函数名：CopyToFile
'作  用：复制文件
'参  数：SoureFile   ----原文件路径
'        NewFile  ----目标文件路径
'================================================
Public Function CopyToFile(ByVal SoureFile, ByVal NewFile)
On Error Resume Next
If SoureFile = "" Then Exit Function
If NewFile = "" Then Exit Function
Set fso = CreateObject("Scripting.FileSystemObject")
If InStr(SoureFile, ":") = 0 Then SoureFile = Server.MapPath(SoureFile)
If InStr(NewFile, ":") = 0 Then NewFile = Server.MapPath(NewFile)
If fso.FileExists(SoureFile) Then
	fso.CopyFile SoureFile, NewFile
End If
Set fso=Nothing
If Err.Number <> 0 Then Err.Clear
End Function
'================================================
'函数名：CopyToFolder
'作  用：复制文件夹
'参  数：SoureFolder   ----原路径
'        NewFolder  ----目标路径
'================================================
Public Function CopyToFolder(ByVal SoureFolder, ByVal NewFolder)
On Error Resume Next
If SoureFolder = "" Then Exit Function
If NewFolder = "" Then Exit Function
Set fso = CreateObject("Scripting.FileSystemObject")
If InStr(SoureFolder, ":") = 0 Then SoureFolder = Server.MapPath(SoureFolder)
If InStr(NewFolder, ":") = 0 Then NewFolder = Server.MapPath(NewFolder)
If fso.FolderExists(SoureFolder) Then
	fso.CopyFolder SoureFolder, NewFolder
End If
Set fso=Nothing
If Err.Number <> 0 Then Err.Clear
End Function
'================================================
'函数名：ReadAlpha
'作  用：读取字符串的第一个字母
'参  数：str   ----字符
'返回值：返回第一个字母
'================================================
Public Function ReadAlpha(ByVal str)
Dim strTemp
If IsNull(str) Or Trim(str) = "" Then
	ReadAlpha = "A-9"
	Exit Function
End If
str = Trim(str)
strTemp = 65536 + Asc(str)
If (strTemp >= 45217 And strTemp <= 45252) Or (strTemp = 65601) Or (strTemp = 65633) Or (strTemp = 37083) Then
	ReadAlpha = "A-Z"
ElseIf (strTemp >= 45253 And strTemp <= 45760) Or (strTemp = 65602) Or (strTemp = 65634) Or (strTemp = 39658) Then
	ReadAlpha = "B-Z"
ElseIf (strTemp >= 45761 And strTemp <= 46317) Or (strTemp = 65603) Or (strTemp = 65635) Or (strTemp = 33405) Then
	ReadAlpha = "C-Z"
ElseIf (strTemp >= 46318 And strTemp <= 46836) Or (strTemp >= 46847 And strTemp <= 46930) Or (strTemp >= 61884 And strTemp <= 61884) Or (strTemp = 65604) Or (strTemp >= 36820 And strTemp <= 38524) Or (strTemp = 65636) Then
	ReadAlpha = "D-Z"
ElseIf (strTemp >= 46837 And strTemp <= 46846) Or (strTemp >= 46931 And strTemp <= 47009) Or (strTemp = 65605) Or (strTemp = 65637) Or (strTemp = 61513) Then
	ReadAlpha = "E-Z"
ElseIf (strTemp >= 47010 And strTemp <= 47296) Or (strTemp = 65606) Or (strTemp = 65638) Or (strTemp = 61320) Or (strTemp = 63568) Or (strTemp = 36281) Then
	ReadAlpha = "F-Z"
ElseIf (strTemp >= 47297 And strTemp <= 47613) Or (strTemp = 65607) Or (strTemp = 65639) Or (strTemp = 35949) Or (strTemp = 36089) Or (strTemp = 36694) Or (strTemp = 34808) Then
	ReadAlpha = "G-Z"
ElseIf (strTemp >= 47614 And strTemp <= 48118) Or (strTemp >= 59112 And strTemp <= 59112) Or (strTemp = 65608) Or (strTemp = 65640) Then
	ReadAlpha = "H-Z"
ElseIf (strTemp = 65641) Or (strTemp = 65609) Or (strTemp = 65641) Then
	ReadAlpha = "I-Z"
ElseIf (strTemp >= 48119 And strTemp <= 49061 And strTemp <> 48739) Or (strTemp >= 62430 And strTemp <= 62430) Or (strTemp = 65610) Or (strTemp = 65642) Or (strTemp = 39048) Then
	ReadAlpha = "J-Z"
ElseIf (strTemp >= 49062 And strTemp <= 49323) Or (strTemp = 65611) Or (strTemp = 65643) Then
	ReadAlpha = "K-Z"
ElseIf (strTemp >= 49324 And strTemp <= 49895) Or (strTemp >= 58838 And strTemp <= 58838) Or (strTemp = 65612) Or (strTemp = 65644) Or (strTemp = 62418) Or (strTemp = 48739) Then
	ReadAlpha = "L-Z"
ElseIf (strTemp >= 49896 And strTemp <= 50370) Or (strTemp = 65613) Or (strTemp = 65645) Then
	ReadAlpha = "M-Z"
ElseIf (strTemp >= 50371 And strTemp <= 50613) Or (strTemp = 65614) Or (strTemp = 65646) Then
	ReadAlpha = "N-Z"
ElseIf (strTemp >= 50614 And strTemp <= 50621) Or (strTemp = 65615) Or (strTemp = 65647) Then
	ReadAlpha = "O-Z"
ElseIf (strTemp >= 50622 And strTemp <= 50905) Or (strTemp = 65616) Or (strTemp = 65648) Then
	ReadAlpha = "P-Z"
ElseIf (strTemp >= 50906 And strTemp <= 51386) Or (strTemp >= 62659 And strTemp <= 63172) Or (strTemp = 65617) Or (strTemp = 65649) Then
	ReadAlpha = "Q-Z"
ElseIf (strTemp >= 51387 And strTemp <= 51445) Or (strTemp = 65618) Or (strTemp = 65650) Then
	ReadAlpha = "R-Z"
ElseIf (strTemp >= 51446 And strTemp <= 52217) Or (strTemp = 65619) Or (strTemp = 65651) Or (strTemp = 34009) Then
	ReadAlpha = "S-Z"
ElseIf (strTemp >= 52218 And strTemp <= 52697) Or (strTemp = 65620) Or (strTemp = 65652) Then
	ReadAlpha = "T-Z"
ElseIf (strTemp = 65621) Or (strTemp = 65653) Then
	ReadAlpha = "U-Z"
ElseIf (strTemp = 65622) Or (strTemp = 65654) Then
	ReadAlpha = "V-Z"
ElseIf (strTemp >= 52698 And strTemp <= 52979) Or (strTemp = 65623) Or (strTemp = 65655) Then
	ReadAlpha = "W-Z"
ElseIf (strTemp >= 52980 And strTemp <= 53688) Or (strTemp = 65624) Or (strTemp = 65656) Then
	ReadAlpha = "X-Z"
ElseIf (strTemp >= 53689 And strTemp <= 54480) Or (strTemp = 65625) Or (strTemp = 65657) Then
	ReadAlpha = "Y-Z"
ElseIf (strTemp >= 54481 And strTemp <= 62383 And strTemp <> 59112 And strTemp <> 58838) Or (strTemp = 65626) Or (strTemp = 65658) Or (strTemp = 38395) Or (strTemp = 39783) Then
	ReadAlpha = "Z-Z"
Else
	ReadAlpha = "A-9"
End If
If (strTemp >= 65633 And strTemp <= 65658) Or (strTemp >= 65601 And strTemp <= 65626) Then ReadAlpha = UCase(Left(str, 1))
If (strTemp >= 65584 And strTemp <= 65593) Then ReadAlpha = "0-9"
End Function
'**************************************************
'函数名：ReplaceLableFlag
'作  用：去除标签{$},并分组以将标签参数用","隔开
'        示例: km=ReplaceLableFlag("{$Test("par1","par2","par3")}")
'        结果     km=Test,Par1,Par2,Par3
'参  数：Content  ----待替换内容
'返回值：返回用","隔开的字符串
'**************************************************
Function ReplaceLableFlag(Content)
Dim regEx, Matches, Match, TempStr
Set regEx = New RegExp
regEx.Pattern = "{\$[^{\$}]*}"
regEx.IgnoreCase = True
regEx.Global = True
Set Matches = regEx.Execute(Content)
ReplaceLableFlag = Content
For Each Match In Matches
On Error Resume Next
TempStr = Match.Value
TempStr = Replace(TempStr, Chr(13) & Chr(10), "")
TempStr = Replace(TempStr, "{$", "")
TempStr = Replace(TempStr, "}", "")
TempStr = Left(TempStr, InStr(TempStr, "(") - 1) & "," & Mid(TempStr, InStr(TempStr, "(") + 1)
TempStr = Left(TempStr, InStrRev(TempStr, ")") - 1)
TempStr = Replace(TempStr, """", "")
If Err.Number = 0 Then
ReplaceLableFlag = Replace(ReplaceLableFlag, Match.Value, KSLabel.ChangeLableToFunction(TempStr))
End If
Next
End Function
'**************************************************
'函数名：IIF
'作  用：条件语句，等于If...Then...Else...
'        示例: IIF(如果,那么,否则)
'返回值：返回B,C
'**************************************************
Function IIF(A,B,C)
	If A Then IIF = B Else IIF = C
End Function
'**************************************************
'获取浏览器类型(可以判断:47种浏览器;GoogLe,Grub,MSN,Yahoo!蜘蛛;十种常见IE插件)
'**************************************************
Function GetBrowserType(isStrType)
Dim GetBrType, StrType, TheInfo, Tmp1, Sysver
GetBrType = "Other Unknown"
TheInfo = UCase(Request.ServerVariables("HTTP_USER_AGENT"))
if Instr(TheInfo,UCase("mozilla"))>0 then GetBrType = "Mozilla"
if Instr(TheInfo,UCase("icab"))>0 then GetBrType = "iCab"
if Instr(TheInfo,UCase("lynx"))>0 then GetBrType = "Lynx"
if Instr(TheInfo,UCase("links"))>0 then GetBrType = "Links"
if Instr(TheInfo,UCase("elinks"))>0 then GetBrType = "ELinks"
if Instr(TheInfo,UCase("jbrowser"))>0 then GetBrType = "JBrowser"
if Instr(TheInfo,UCase("konqueror"))>0 then GetBrType = "konqueror"
if Instr(TheInfo,UCase("wget"))>0 then GetBrType = "wget"
if Instr(TheInfo,UCase("ask jeeves"))>0 or Instr(TheInfo,UCase("teoma"))>0 then GetBrType = "Ask Jeeves/Teoma"
if Instr(TheInfo,UCase("wget"))>0 then GetBrType = "wget"
if Instr(TheInfo,UCase("opera"))>0 then GetBrType = "opera"
if Instr(TheInfo,UCase("NOKIAN"))>0 then GetBrType = "NOKIAN(诺基亚手机)"
if Instr(TheInfo,UCase("SPV"))>0 then GetBrType = "SPV(多普达手机)"
if Instr(TheInfo,UCase("Jakarta Commons"))>0 then GetBrType = "Jakarta Commons-HttpClient"
if Instr(TheInfo,UCase("Gecko"))>0 then
StrType = "[Gecko] "
GetBrType = "Mozilla Series"
if Instr(TheInfo,UCase("aol"))>0 then GetBrType = "AOL"
if Instr(TheInfo,UCase("netscape"))>0 then GetBrType = "Netscape"
if Instr(TheInfo,UCase("firefox"))>0 then GetBrType = "FireFox"
if Instr(TheInfo,UCase("chimera"))>0 then GetBrType = "Chimera"
if Instr(TheInfo,UCase("camino"))>0 then GetBrType = "Camino"
if Instr(TheInfo,UCase("galeon"))>0 then GetBrType = "Galeon"
if Instr(TheInfo,UCase("k-meleon"))>0 then GetBrType = "K-Meleon"
'GetBrType = StrType & GetBrType
end if
if Instr(TheInfo,UCase("bot"))>0 or Instr(TheInfo,UCase("crawl"))>0 then
StrType = "[Bot/Crawler]"
if Instr(TheInfo,UCase("grub"))>0 then GetBrType = "Grub"
if Instr(TheInfo,UCase("googlebot"))>0 then GetBrType = "GoogleBot"
if Instr(TheInfo,UCase("msnbot"))>0 then GetBrType = "MSN Bot"
if Instr(TheInfo,UCase("slurp"))>0 then GetBrType = "Yahoo! Slurp"
'GetBrType = StrType & GetBrType
end if
if Instr(TheInfo,UCase("applewebkit"))>0 then
StrType = "[AppleWebKit]"
GetBrType = ""
if Instr(TheInfo,UCase("omniweb"))>0 then GetBrType = "OmniWeb"
if Instr(TheInfo,UCase("safari"))>0 then GetBrType = "Safari"
if Instr(TheInfo,UCase("chrome"))>0 then GetBrType = "Chrome"
'GetBrType = StrType & GetBrType
end if
if Instr(TheInfo,UCase("msie"))>0 then
StrType = "[MSIE"
Tmp1 = mid(TheInfo,(Instr(TheInfo,UCase("MSIE"))+4),6)
Tmp1 = left(Tmp1,Instr(Tmp1,";")-1)
StrType = StrType & Tmp1 & "]"
GetBrType = "Internet Explorer"
'GetBrType = StrType & GetBrType
end if
if Instr(TheInfo,UCase("msn"))>0 then GetBrType = "MSN"
if Instr(TheInfo,UCase("aol"))>0 then GetBrType = "AOL"
if Instr(TheInfo,UCase("webtv"))>0 then GetBrType = "WebTV"
if Instr(TheInfo,UCase("myie2"))>0 then GetBrType = "MyIE2"
if Instr(TheInfo,UCase("maxthon"))>0 then GetBrType = "Maxthon(傲游浏览器)"
if Instr(TheInfo,UCase("gosurf"))>0 then GetBrType = "GoSurf(冲浪高手浏览器)"
if Instr(TheInfo,UCase("netcaptor"))>0 then GetBrType = "NetCaptor"
if Instr(TheInfo,UCase("sleipnir"))>0 then GetBrType = "Sleipnir"
if Instr(TheInfo,UCase("avant browser"))>0 then GetBrType = "AvantBrowser"
if Instr(TheInfo,UCase("greenbrowser"))>0 then GetBrType = "GreenBrowser"
if Instr(TheInfo,UCase("slimbrowser"))>0 then GetBrType = "SlimBrowser"
if Instr(TheInfo,UCase("360SE"))>0 then GetBrType = GetBrType & "-360SE(360安全浏览器)"
if Instr(TheInfo,UCase("QQDownload"))>0 then GetBrType = GetBrType & "-QQDownload(QQ下载器)"
if Instr(TheInfo,UCase("TheWorld"))>0 then GetBrType = GetBrType & "-TheWorld(世界之窗浏览器)"
if Instr(TheInfo,UCase("icafe8"))>0 then GetBrType = GetBrType & "-icafe8(网维大师网吧管理插件)"
if Instr(TheInfo,UCase("TencentTraveler"))>0 then GetBrType = GetBrType & "-TencentTraveler(腾讯TT浏览器)"
if Instr(TheInfo,UCase("baiduie8"))>0 then GetBrType = GetBrType & "-baiduie8(百度IE8.0)"
if Instr(TheInfo,UCase("iCafeMedia"))>0 then GetBrType = GetBrType & "-iCafeMedia(网吧网媒趋势插件)"
if Instr(TheInfo,UCase("DigExt"))>0 then GetBrType = GetBrType & "-DigExt(IE5允许脱机阅读模式特殊标记)"
if Instr(TheInfo,UCase("baiduds"))>0 then GetBrType = GetBrType & "-baiduds(百度硬盘搜索)"
if Instr(TheInfo,UCase("CNCDialer"))>0 then GetBrType = GetBrType & "-CNCDialer(数控拨号)"
if Instr(TheInfo,UCase("NOKIAN85"))>0 then GetBrType = GetBrType & "-NOKIAN85(诺基亚手机)"
if Instr(TheInfo,UCase("SPV_C600"))>0 then GetBrType = GetBrType & "-SPV_C600(多普达C600)"
if Instr(TheInfo,UCase("Smartphone"))>0 then GetBrType = GetBrType & "-Smartphone(Windows Mobile for Smartphone Edition 操作系统的智能手机)"
If isStrType=1 Then
GetBrowserType = StrType & GetBrType
Else
GetBrowserType = GetBrType
End If
End Function
%>