<!--#include file="inc/conn.asp"-->
<!--#include file="inc/config.asp"-->
<!--#include file="inc/function.asp"--><%
'常用变量
Dim Sql, Rs, RsMaxs, RsArrID, RsUsers, RsChats, Action, searchKey, UsersID, ReturnStr, OneRecord

Action = Trim(Request("Action"))
searchkey = Trim(Request("searchkey"))
'If searchkey = "" Then searchkey = "undefined"
UsersID = ChkNumeric(Request("UsersID"))

<% 
Function SaveRemoteFile(LocalFileName,RemoteFileUrl) 
SaveRemoteFile=True 
dim Ads,Retrieval,GetRemoteData 
Set Retrieval = Server.CreateObject("Microsoft.XMLHTTP") 
With Retrieval 
.Open "Get", RemoteFileUrl, False, "", ""
.Send 
If .Readystate<>4 then 
SaveRemoteFile=False 
Exit Function 
End If 
GetRemoteData = .ResponseBody 
End With 
Set Retrieval = Nothing 
Set Ads = Server.CreateObject("Adodb.Stream") 
With Ads 
.Type = 1 
.Open 
.Write GetRemoteData 
.SaveToFile server.MapPath(LocalFileName),2 
.Cancel() 
.Close() 
End With 
Set Ads=nothing 
End Function 
%> 

<% 
'以下为调用示例： 
remoteurl="http://192.168.2.214:8080/ajax/uploadfiles/avatars/avatar-01.jpg"'远程文件名（绝对全路径） 
localfile="images/"&Replace(Replace(Replace(Now(),"-","")," ",""),":","")&Right(remoteurl,4)'本机文件名（可自定义） 
If SaveRemoteFile(localfile,remoteurl)=True Then 
Response.Write("成功保存："&localfile) 
End If 
%> 