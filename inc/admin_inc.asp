<!--#include file="conn.asp"-->
<!--#include file="config.asp"-->
<!--#include file="admin_check.asp" -->
<!--#include file="function.asp"-->
<!--#include file="sub_inc.asp" -->
<!--#include file="power.asp"-->
<%
'屏蔽IP
If IsForbidIP(LockIP,getIP) = True Then
Response.Write "<div class='center'>您的IP：<span class='red'>"&getIP&" </span>已被限制登陆！<br />请联系管理员：<a href=""mailto:"&WebSiteAdminEmail&""">"&WebSiteAdminEmail&"</a>！"
Response.Write "<br /><br />网站名称："&WebSiteName&"<br />网站地址："&WebSiteUrl&""
Response.Write "<br /><br /><a href=""#"" onclick=""window.close();"">[关闭窗口]</a></div>"
Response.End
End If
'防注入，针对个别
If MyV_UsersID<>1 Or MyV_UsersName<>"lonq" Then
Call ChkSQLInWord()
End If
'删除7天前的非法事件纪录
Call DelDimDayData()
%>