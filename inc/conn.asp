<%@ LANGUAGE = "VBScript" CODEPAGE ="65001" %>
<%
'Option Explicit
Session.CodePage						= 65001
Response.Charset						= "UTF-8"
%>

<%
Response.Buffer						= True
Server.ScriptTimeout					= 90												'脚本超时时间(单位:秒)
Session.Timeout						= 20													'Session过期时间(单位:分钟)
Response.Expires						= -1

Dim MyAppPath,SetDataBasePath,DataBaseName,DataBaseNameLog
const LQ_DataBaseVersion		= "5.0"
const LQ_DataBaseType			= "Microsoft Access"										'值为Access，SQL
MyAppPath								=""													'路径设置
SetDataBasePath						= "database"											'文件夹设置
'主数据库
DataBaseName							= CheckCorrectPath(SetDataBasePath)&"/#LQ_DATA.MDB"
'日志数据库
DataBaseNameLog					= CheckCorrectPath(SetDataBasePath)&"/#LQ_SqlLog.MDB"
'Response.Write(DataBaseName)
'Response.End
On Error Resume Next
'连接数据库
Dim Conn
Set Conn = Server.CreateObject("ADODB.Connection")
Conn.Open "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & Server.MapPath(DataBaseName)
If Err Then
Err.Clear
Call ConnClose(Conn)
Response.Write("数据库连接错误！")
Response.End
End If
'*************************************************
'函数名：ConnOpen
'作 用：连接数据库
'Call ConnOpen(DataBaseName,0,Conn)
'*************************************************
Sub ConnOpen(DataBaseName,DBType,Conn_object)
	On Error Resume Next
	Dim strConn
	If DBType=0  Then	'ACCESS数据库
			Set Conn_object = Server.Createobject("Adodb.Connection")
			strConn="Provider=Microsoft.Jet.Oledb.4.0;Data Source=" & Server.Mappath(DataBaseName)
			Conn_object.Open strConn
	ElseIf DBType=1 Then 	'SQL数据库
		Set Conn_object = Server.Createobject("Adodb.Connection")
		strConn = "Provider=SQLOLEDB.1;Persist Security Info=False;Server="&SQLServer&";User ID="&SqlLoginUser&" ;Password="&SqlLoginPass&";Database="&DataBaseName&";"
		Conn_object.Open strConn
	Else
	Response.Write ("数据库类型错误！")
	Response.End
	End If
	If Err Then
		Err.Clear
		Set Conn_object=Nothing
		Response.Write ("数据库连接错误！")
		Response.End
	End If
End Sub
'修正路径，省略盘符
Function CheckCorrectPath(ByVal strURL)
Dim m_strURL
If Not IsNull(strURL) And Trim(strURL) <> "" And LCase(strURL) <> "http://" Then
	If InStr(strURL,"://") = 0 Then
		If Left(strURL,1) = "/" Then
			m_strURL = strURL
		Else
			m_strURL = Replace(strURL, "../", "")
			m_strURL = MyAppPath & m_strURL
		End If
	Else
		m_strURL = strURL
	End If
Else
	m_strURL=""
End If
CheckCorrectPath=m_strURL
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
'=====================================
'关闭Rs
'=====================================
Sub RsClose(Rs_object)
	Rs_object.Close
	set Rs_object=Nothing
End Sub
'==============================
'断开数据库的连接
'==============================
Sub ConnClose(Conn_object)
	Conn_object.Close
	set Conn_object = nothing
End Sub
%>