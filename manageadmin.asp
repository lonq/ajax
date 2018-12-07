<!--#include file="Inc/Admin_inc.asp"-->
<!--#include file="Inc/md5.asp"-->
<!--#include file="Inc/Function_Page.asp"--><%
'页面名称
Dim MyFileName,ItemName
MyFileName="Admin"
ItemName="用户"
'权限
Dim FtListFlag,FtAdminFlag
FtListFlag=ListFlag14
FtAdminFlag=AdminFlag14
Call ListFlagMsg()
'常用变量
Dim Sql,Rs,Action,ClassID,ID,searchkey,quicklink,page,movetype,StrAddDate,strVariable,strUrl
Action=Trim(Request("Action"))
ClassID=ChkNumeric(Request("ClassID"))
ID=ChkNumeric(Request("ID"))
searchkey=Trim(Request("searchkey"))
quicklink=Trim(Request("quicklink"))
page=Request("page")
movetype=Request("movetype")
StrAddDate=year(Now())&"-"&right("0"&month(Now()),2)&"-"&right("0"&day(Now()),2)
strVariable = "searchkey="&searchkey&"&page="&page&""
strUrl=Request.ServerVariables("http_referer")
If strUrl="" then strUrl=-1

Dim AdminName
AdminName=Trim(Request.Form("AdminName"))
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML xmlns="http://www.w3.org/1999/xhtml">
<head>
<Title>管理<%=ItemName%></Title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="pragma" CONTENT="no-cache">
<meta http-equiv="Cache-Control" CONTENT="no-cache, must-revalidate">
<meta http-equiv="expires" CONTENT="0">
<!--#include file="inc/css_inc.asp"-->
<style type="text/css">
<!--
.quanxian ul {margin:0;padding:0;}
.quanxian ul {list-style:none;margin:0;padding:0;}
.quanxian ul li {float:left;display:inline;margin:0;padding:0;height:25px;line-height:25px;border-bottom:1px solid #ffffff;}
.quanxian ul li.quanju {margin:0;padding:0;color:#cc3333;width:150px;}
.quanxian ul li.jubu {margin:0;padding:0;width:100px;}
.quanxian ul li.label {margin:0;padding:0;}
-->
</style>
<!--#include file="inc/js_inc.asp"-->
<script type="text/javascript">
<!--
//检查是否超级管理员
$(document).ready(function(){

$("#IsSuperAdmin").click(function(){
if($("#IsSuperAdmin").attr("checked")=="checked"){
$("#DisAdminPower").hide("fast");
}
else{
$("#DisAdminPower").show("fast");
}
});

$(".quanxian").click(function(){
var checked=$("input:checkbox",this).attr("checked");
if(checked!="checked"){
//alert(checked);
$("input:radio",this).eq(0).attr("checked","checked");
}
});

});
//-->
</script>
</head>
<body>
<%
Dim RsListFlag,RsListFlag0,RsListFlag1,RsListFlag2,RsListFlag3,RsListFlag4,RsListFlag5,RsListFlag6,RsListFlag7,RsListFlag8,RsListFlag9,RsListFlag10,RsListFlag11,RsListFlag12,RsListFlag13,RsListFlag14,RsListFlag15,RsListFlag16,RsListFlag17,RsListFlag18,RsListFlag19,RsListFlag20,RsListFlag21,RsListFlag22,RsListFlag23,RsListFlag24,RsAdminFlag,RsAdminFlag0,RsAdminFlag1,RsAdminFlag2,RsAdminFlag3,RsAdminFlag4,RsAdminFlag5,RsAdminFlag6,RsAdminFlag7,RsAdminFlag8,RsAdminFlag9,RsAdminFlag10,RsAdminFlag11,RsAdminFlag12,RsAdminFlag13,RsAdminFlag14,RsAdminFlag15,RsAdminFlag16,RsAdminFlag17,RsAdminFlag18,RsAdminFlag19,RsAdminFlag20,RsAdminFlag21,RsAdminFlag22,RsAdminFlag23,RsAdminFlag24
set Rs=server.CreateObject("adodb.recordset")
Sql="select * From [LQ_"&MyFileName&"] where AdminID="&ID&""
Rs.open Sql,conn,1,1
RsListFlag=Split(Rs("ListFlag"),",")
for RsListFlag_i=0 to UBound(RsListFlag)
RsListFlag0=RsListFlag(0)
RsListFlag1=RsListFlag(1)
RsListFlag2=RsListFlag(2)
RsListFlag3=RsListFlag(3)
RsListFlag4=RsListFlag(4)
RsListFlag5=RsListFlag(5)
RsListFlag6=RsListFlag(6)
RsListFlag7=RsListFlag(7)
RsListFlag8=RsListFlag(8)
RsListFlag9=RsListFlag(9)
RsListFlag10=RsListFlag(10)
RsListFlag11=RsListFlag(11)
RsListFlag12=RsListFlag(12)
RsListFlag13=RsListFlag(13)
RsListFlag14=RsListFlag(14)
RsListFlag15=RsListFlag(15)
RsListFlag16=RsListFlag(16)
RsListFlag17=RsListFlag(17)
RsListFlag18=RsListFlag(18)
RsListFlag19=RsListFlag(19)
RsListFlag20=RsListFlag(20)
RsListFlag21=RsListFlag(21)
RsListFlag22=RsListFlag(22)
RsListFlag23=RsListFlag(23)
RsListFlag24=RsListFlag(24)
Next
'每个栏目下的具体权限
RsAdminFlag=split(Rs("AdminFlag"),",")
for RsAdminFlag_i=0 to UBound(RsAdminFlag)
RsAdminFlag0=RsAdminFlag(0)
RsAdminFlag1=RsAdminFlag(1)
RsAdminFlag2=RsAdminFlag(2)
RsAdminFlag3=RsAdminFlag(3)
RsAdminFlag4=RsAdminFlag(4)
RsAdminFlag5=RsAdminFlag(5)
RsAdminFlag6=RsAdminFlag(6)
RsAdminFlag7=RsAdminFlag(7)
RsAdminFlag8=RsAdminFlag(8)
RsAdminFlag9=RsAdminFlag(9)
RsAdminFlag10=RsAdminFlag(10)
RsAdminFlag11=RsAdminFlag(11)
RsAdminFlag12=RsAdminFlag(12)
RsAdminFlag13=RsAdminFlag(13)
RsAdminFlag14=RsAdminFlag(14)
RsAdminFlag15=RsAdminFlag(15)
RsAdminFlag16=RsAdminFlag(16)
RsAdminFlag17=RsAdminFlag(17)
RsAdminFlag18=RsAdminFlag(18)
RsAdminFlag19=RsAdminFlag(19)
RsAdminFlag20=RsAdminFlag(20)
RsAdminFlag21=RsAdminFlag(21)
RsAdminFlag22=RsAdminFlag(22)
RsAdminFlag23=RsAdminFlag(23)
RsAdminFlag24=RsAdminFlag(24)
Next
Call RsClose(Rs)
'Call AddAdminJurisdiction(0,"用户管理",0,"无权限",3,"添加",2,"修改",1,"删除")
'功能：添加管理员权限
Sub AddAdminJurisdiction(ByVal ClassCode,ByVal ClassTitle,ByVal S_Value0,ByVal S_Title0,ByVal S_Value3,ByVal S_Title3,ByVal S_Value2,ByVal S_Title2,ByVal S_Value1,ByVal S_Title1)
Response.Write ("<div class=""quanxian"">")
Response.Write ("<ul>")
'全局
Response.Write ("<li class=""quanju"">")
Response.Write ("<input style=""border:none;"" type=""checkbox"" Name=""ListFlag"&ClassCode&""" id=""ListFlag"&ClassCode&""" value=""1"" />")
If ClassCode > -1 Then
Response.Write ("("&ClassCode&")&nbsp;")
End If 
Response.Write ("<label for=""ListFlag"&ClassCode&""">")
If ClassTitle <> "NO" Then
Response.Write (ClassTitle)
End If 
Response.Write ("</label>")
Response.Write ("</li>")
'局部
'0
Response.Write ("<li class=""jubu"">")
If S_Value0 > -1 Then  
Response.Write ("<input style=""border:none;"" type=""radio"" Name=""AdminFlag"&ClassCode&""" id=""AdminFlag"&ClassCode&"_a"" value=""0"" Checked=""Checked"" />")
End If 
If S_Title0 <> "NO" Then 
Response.Write ("<label for=""AdminFlag"&ClassCode&"_a"">"&S_Title0&"</label>")
End If 
Response.Write ("</li>")
'3
Response.Write ("<li class=""jubu"">")
If S_Value3 > -1 Then  
Response.Write ("<input style=""border:none;"" type=""radio"" Name=""AdminFlag"&ClassCode&""" id=""AdminFlag"&ClassCode&"_c"" value=""3"" />")
End If 
If S_Title3 <> "NO" Then 
Response.Write ("<label for=""AdminFlag"&ClassCode&"_c"">"&S_Title3&"</label>")
End If 
Response.Write ("</li>")
'2
Response.Write ("<li class=""jubu"">")
If S_Value2 > -1 Then  
Response.Write ("<input style=""border:none;"" type=""radio"" Name=""AdminFlag"&ClassCode&""" id=""AdminFlag"&ClassCode&"_d"" value=""2"" />")
End If 
If S_Title2 <> "NO" Then 
Response.Write ("<label for=""AdminFlag"&ClassCode&"_d"">"&S_Title2&"</label>")
End If 
Response.Write ("</li>")
'1
Response.Write ("<li class=""jubu"">")
If S_Value1 > -1 Then  
Response.Write ("<input style=""border:none;"" type=""radio"" Name=""AdminFlag"&ClassCode&""" id=""AdminFlag"&ClassCode&"_e"" value=""1"" />")
End If 
If S_Title1 <> "NO" Then 
Response.Write ("<label for=""AdminFlag"&ClassCode&"_e"">"&S_Title1&"</label>")
End If 
Response.Write ("</li>")
Response.Write ("</ul>")
Response.Write ("</div>")
Response.Write ("<div style=""font:0px/0px sans-serif;clear:both;""></div>")
End Sub
'******************************
'Call EditAdminJurisdiction(0,"用户管理",0,"无权限",3,"添加",2,"修改",1,"删除")
'功能：修改管理员权限
Sub EditAdminJurisdiction(ByVal ClassCode,ByVal ClassTitle,ByVal S_Value0,ByVal S_Title0,ByVal S_Value3,ByVal S_Title3,ByVal S_Value2,ByVal S_Title2,ByVal S_Value1,ByVal S_Title1)
Response.Write ("<div class=""quanxian"">")
Response.Write ("<ul>")
'全局
Response.Write ("<li class=""quanju"">")
Response.Write ("<input style=""border:none;"" type=""checkbox"" Name=""ListFlag"&ClassCode&""" id=""ListFlag"&ClassCode&""" value=""1""")
If RsListFlag(ClassCode) = 1 Then
Response.Write (" Checked=""Checked""")
End If 
Response.Write (" />")
If ClassCode > -1 Then
Response.Write ("("&ClassCode&")&nbsp;")
End If 
Response.Write ("<label for=""ListFlag"&ClassCode&""">")
If ClassTitle <> "NO" Then
Response.Write (ClassTitle)
End If 
Response.Write ("</label>")
Response.Write ("</li>")
'局部
'0
Response.Write ("<li class=""jubu"">")
If S_Value0 > -1 Then  
Response.Write ("<input style=""border:none;"" type=""radio"" Name=""AdminFlag"&ClassCode&""" id=""AdminFlag"&ClassCode&"_a"" value=""0""")
If RsAdminFlag(ClassCode) = 0 Then
Response.Write (" Checked=""Checked""")
End If 
Response.Write (" />")
End If 
If S_Title0 <> "NO" Then 
Response.Write ("<label for=""AdminFlag"&ClassCode&"_a"">"&S_Title0&"</label>")
End If 
Response.Write ("</li>")
'3
Response.Write ("<li class=""jubu"">")
If S_Value3 > -1 Then  
Response.Write ("<input style=""border:none;"" type=""radio"" Name=""AdminFlag"&ClassCode&""" id=""AdminFlag"&ClassCode&"_c"" value=""3""")
If RsAdminFlag(ClassCode) = 3 Then
Response.Write (" Checked=""Checked""")
End If 
Response.Write (" />")
End If 
If S_Title3 <> "NO" Then 
Response.Write ("<label for=""AdminFlag"&ClassCode&"_c"">"&S_Title3&"</label>")
End If 
Response.Write ("</li>")
'2
Response.Write ("<li class=""jubu"">")
If S_Value2 > -1 Then  
Response.Write ("<input style=""border:none;"" type=""radio"" Name=""AdminFlag"&ClassCode&""" id=""AdminFlag"&ClassCode&"_d"" value=""2""")
If RsAdminFlag(ClassCode) = 2 Then
Response.Write (" Checked=""Checked""")
End If 
Response.Write (" />")
End If 
If S_Title2 <> "NO" Then 
Response.Write ("<label for=""AdminFlag"&ClassCode&"_d"">"&S_Title2&"</label>")
End If 
Response.Write ("</li>")
'1
Response.Write ("<li class=""jubu"">")
If S_Value1 > -1 Then  
Response.Write ("<input style=""border:none;"" type=""radio"" Name=""AdminFlag"&ClassCode&""" id=""AdminFlag"&ClassCode&"_e"" value=""1""")
If RsAdminFlag(ClassCode) = 1 Then
Response.Write (" Checked=""Checked""")
End If 
Response.Write (" />")
End If 
If S_Title1 <> "NO" Then 
Response.Write ("<label for=""AdminFlag"&ClassCode&"_e"">"&S_Title1&"</label>")
End If 
Response.Write ("</li>")
Response.Write ("</ul>")
Response.Write ("</div>")
Response.Write ("<div style=""font:0px/0px sans-serif;clear:both;""></div>")
End Sub
'******************************
%>
<table width="100%" cellpadding="0" cellspacing="0" class="breadcrumb">
<tr>
<th colspan="2"><strong>当前位置：</strong><a href="admin.asp">首页</a> - 管理<%=ItemName%></th>
</tr>
<tr>
<td class="attention" width="50%">
<A HREF="?Action=AddForm">添加<%=ItemName%></A> <A HREF="?Action=ManageForm"><%=ItemName%>列表</A> <A HREF="?Action=ModifyPassWordForm">修改我的密码</A>
</td>
<td align="right" width="50%">
<form name="quickform" id="quickform" method="get" Action="?">
<SELECT onChange="javascript:window.open(this.options[this.selectedIndex].value,'main')" size="1" name="quicklink">
<OPTION value="" selected>快速查找</OPTION>
<OPTION value="?quicklink=all">所有<%=ItemName%></OPTION>
<OPTION value="?quicklink=IsActive">锁定的<%=ItemName%></OPTION>
</SELECT>
<input type="text" class="ipt" Name="searchkey" id="searchkey" size="20" value="<%=searchkey%>" />
<input type="submit" class="btn" Name="searchsub" value="搜 索" />
</form>
</td>
</tr>
</table>
<%
Select Case Action
'表单过程
Case "ManageForm"
Call IsCondition("ManageCondition",MyFileName)
Call ManageForm()
Case "AddForm"
Call AdminFlagMsg_Add()
Call IsCondition("AddCondition",MyFileName)
Call AddForm()
Case "EditForm"
Call AdminFlagMsg_Edit()
Call IsCondition("EditCondition",MyFileName)
Call EditForm()
Case "ModifyPassWordForm"
Call AdminFlagMsg_Edit()
Call ModifyPassWordForm()
'存储过程
Case "Add"
Call AdminFlagMsg_Add()
Call AddData()
Case "Edit"
Call AdminFlagMsg_Edit()
Call EditData()
Case "Modify"
Call AdminFlagMsg_Edit()
Call ModifyData()
Case "DelAll"
Call AdminFlagMsg_Edit()
Call DelData()
Case Else
Call IsCondition("ManageCondition",MyFileName)
Call ManageForm()
End Select
%>
<%
'管理
Sub ManageForm()
%>
<table cellpadding="0" cellspacing="0" class="main_list chg_color">
<form Name="mainform" id="mainform" method="post" Action="?Action=DelAll">
<tr>
<th width="5%" align="center">选择</th>
<th width="20%" align="center"><%=ItemName%>名称</th>
<th width="10%" align="center"><%=ItemName%>级别</th>
<th width="20%" align="center">登陆次数</th>
<th width="15%" align="center">上次登陆IP</th>
<th width="20%" align="center">上次登陆时间</th>
<th width="10%" align="center">操作</th>
</tr>
<%
'分页
Set mypage=new xdownpage
mypage.getconn=Conn
mysql="select * from [LQ_"&MyFileName&"]"
if quicklink="IsActive" then
mysql=mysql&" Where IsActive=0"
Else
mysql=mysql&" Where AdminName like '%"&searchkey&"%'"
End if
mysql=mysql&" order by "
mysql=mysql&"AddTime desc"
mypage.getsql=mysql
mypage.pagesize=10
set Rs=mypage.getrs()
if Rs.eof and Rs.bof then
Response.Write ("<tr><td align='center' colspan='7' class='attention'>对不起，没有找到信息！</td></tr>")
Else
for i=1 to mypage.pagesize
if Not Rs.eof then 
%>
<tr>
<td align="center"><%If Rs("AdminID")<>1 Then%><input style="border:none;" type="checkbox" value="<%=Int(Rs("AdminID"))%>" name="ID" id="ID" class="chkid" /><%End If%></td>
<td><%If Rs("IsActive")=0 Then response.write "<strong>[锁定]</strong>" End If%><%If Rs("AdminID")=1 Then response.write "<strong>[默认]</strong>" End If%><A HREF="SendEmail.asp?UserName=<%=Rs("AdminName")%>&UserEmail=<%=Rs("AdminEMail")%>" title="发送邮件"><%If Rs("AdminID")=1 Then response.write "<strong title='发送邮件'>"&Trim(Rs("AdminName"))&"</strong>" Else response.write Trim(Rs("AdminName")) End If%></A></td>
<td>
<%If Rs("IsSuperAdmin")=0 Then
response.Write "普通"
ElseIf Rs("IsSuperAdmin")=1 Then
response.Write "<strong>超级</strong>"
Else
response.Write "普通"
End If
%></td>
<td>非法：<%If Int(Rs("ErrLoginTimes"))>0 Then response.write "<strong>"&Int(Rs("ErrLoginTimes"))&"</strong>" Else response.write Int(Rs("ErrLoginTimes")) End If%>&nbsp;正常：<%=Int(Rs("LoginTimes"))%></td>
<td><%=Trim(Rs("LoginIP"))%></td>
<td><%=Trim(Rs("LoginDate"))%></td>
<td class="red"><a href="?Action=EditForm&ID=<%=Int(Rs("AdminID"))%>&<%=strVariable%>" Title="修改" >修改</A></td>
</tr>
<%
Rs.movenext
Else
exit For
end if
Next
End if
%>
<tr>
<td colspan="2" class="bottom">
<%Call SelectAndinvert()%>
</td>
<td colspan="5" class="bottom">
<div id="page"><%Call mypage.showpage()%></div>
</td>
</tr>
<tr>
<td colspan="7" class="bottom">
<select name="movetype" id="movetype">
<option value="">请选择级别</option>
<option value="0">普通</option>
<option value="1">超级</option>
</select>
<input type="submit" class="btn" value="修改级别" name="Del" id="Del" />
<input type="submit" class="btn" value="锁定" name="Del" id="Del" />
<input type="submit" class="btn" value="激活" name="Del" id="Del" />
<input type="submit" class="btn" value="更新时间" name="Del" id="Del" />
<input type="submit" class="btn" value="删除" name="Del" id="Del" />
</td>
</tr>
</form>
</table>
<%
Call RsClose(Rs)
Call ConnClose(Conn)
End Sub
'添加
Sub AddForm()
%>
<table cellpadding="0" cellspacing="0" class="main_containter chg_color">
<form Name="mainform" id="mainform" method="post" Action="?">
<tr> 
<th colspan="2" class="title"><strong>添加<%=ItemName%></strong></th>
</tr>
<tr>
<td width="20%" align="right">排序：</td>
<td width="80%"><input Name="Orders" type="text" class="ipt" size="5" value="<%=CountNums("[LQ_"&MyFileName&"]")+1%>" /></td>
</tr>
<tr>
<td width="20%" align="right"><%=ItemName%>帐号：</td>
<td width="80%"><input Name="AdminName" id="AdminName" type="text" class="ipt" size="30" value="" /></td>
</tr>
<tr>
<td width="20%" align="right"><%=ItemName%>密码：</td>
<td width="80%"><input Name="Password" id="Password" type="Password" class="ipt" size="30" value="" /></td>
</tr>
<tr>
<td width="20%" align="right">昵称：</td>
<td width="80%"><input Name="AdminPetName" id="AdminPetName" type="text" class="ipt" size="30" value="" /></td>
</tr>
<tr>
<td width="20%" align="right">邮件地址：</td>
<td width="80%"><input Name="AdminEMail" id="AdminEMail" type="text" class="ipt" size="30" value="" /></td>
</tr>
<tr>
<td width="20%" align="right">个性签名：<br /><strong class="gray">支持HTML代码</strong>&nbsp;&nbsp;</td>
<td width="80%"><textarea class="txa" Name="AdminSignature" id="AdminSignature" rows="3" cols="80">暂无签名</textarea></td>
</tr>
<tr>
<td width="20%" align="right">附加属性：</td>
<td width="80%">
<input style="border:none;" type="radio" Name="IsActive" id="isActive0" value="0" />
<label for="isActive0">锁定</label>
<input style="border:none;" type="radio" Name="IsActive" id="isActive1" value="1" Checked /> 
<label for="isActive1">解锁</label>
</td>
</tr>
<tr>
<td width="20%" align="right">权限设置：</td>
<td width="80%">
<input style="border:none;" type="checkbox" Name="IsSuperAdmin" id="IsSuperAdmin" value="1" />
<label for="IsSuperAdmin">超级<%=ItemName%></label>&nbsp;<span class="red">当栏目权限为空时，请将局部权限设为“无权限”。</span>
</td>
</tr>
<Tbody id="DisAdminPower">
<tr>
<td width="20%" align="right" valign="top">详细栏目权限设置：</td>
<td width="80%">
<div class="quanxian">
<%
Call AddAdminJurisdiction(0,"杂项",0,"无权限",3,"添加",2,"修改",1,"删除")
Call AddAdminJurisdiction(1,"产品",0,"无权限",3,"添加",2,"修改",1,"删除")
Call AddAdminJurisdiction(2,"文章",0,"无权限",3,"添加",2,"修改",1,"删除")
Call AddAdminJurisdiction(3,"新闻",0,"无权限",3,"添加",2,"修改",1,"删除")
Call AddAdminJurisdiction(4,"视频",0,"无权限",3,"添加",2,"修改",1,"删除")
Call AddAdminJurisdiction(5,"幻灯",0,"无权限",3,"添加",2,"修改",1,"删除")
Call AddAdminJurisdiction(6,"公告",0,"无权限",3,"添加",2,"修改",1,"删除")
Call AddAdminJurisdiction(7,"友情链接",0,"无权限",3,"添加",2,"修改",1,"删除")
Call AddAdminJurisdiction(8,"留言",0,"无权限",-1,"NO",2,"修改",1,"删除")
Call AddAdminJurisdiction(9,"图片及广告设置 ",0,"无权限",3,"添加",2,"修改",1,"删除")
Call AddAdminJurisdiction(10,"在线客服",0,"无权限",3,"添加",2,"修改",1,"删除")
Call AddAdminJurisdiction(11,"群发邮件",0,"无权限",-1,"NO",-1,"NO",1,"允许")
Call AddAdminJurisdiction(12,"投票",0,"无权限",3,"添加",2,"修改",1,"删除")
Call AddAdminJurisdiction(13,"上传文件",0,"无权限",-1,"NO",2,"上传",1,"删除")
Call AddAdminJurisdiction(14,"管理员设置",0,"无权限",-1,"NO",-1,"NO",1,"允许")
Call AddAdminJurisdiction(15,"修改我的密码",0,"无权限",-1,"NO",-1,"NO",1,"允许")
Call AddAdminJurisdiction(16,"数据库",0,"无权限",3,"备份",2,"恢复",1,"删除")
%>
</div>
</td>
</tr>
</Tbody>
<tr>
<td colspan="2" align="center" class="bottom">
<input type="hidden" name="Action" id="Action" value="Add" />
<input type="submit" class="btn" Name="AddSubmit" value="提交" />
<input type="reset" class="btn" Name="resetSubmit" value="重新填写" />
<input type="button" class="btn" Name="managebutton" value="转到列表页" onclick="window.location.href='?Action=ManageForm';" />
</td>
</tr>
</form>
</table>
<%
Call RsClose(Rs)
Call ConnClose(Conn)
End Sub
'修改
Sub EditForm()
Set Rs=server.CreateObject("adodb.recordset")
Sql="select * from [LQ_"&MyFileName&"] where AdminID="&ID&""
Rs.Open Sql,Conn,1,3
%>
<table cellpadding="0" cellspacing="0" class="main_containter chg_color">
<form Name="mainform" id="mainform" method="post" Action="?">
<tr> 
<th colspan="2" class="title"><strong>修改<%=ItemName%></strong></th>
</tr>
<%If ID=1 Then%>
<tr>
<td width="20%" align="right">提示：</td>
<td width="80%" class="red">该用户为系统默认的<%=ItemName%>，锁定、权限设置和删除功能无效！</td>
</tr>
<%End If%>
<tr>
<td width="20%" align="right">排序：</td>
<td width="80%"><input Name="Orders" type="text" class="ipt" size="5" value="<%=Int(Rs("Orders"))%>" /></td>
</tr>
<tr>
<td width="20%" align="right"><%=ItemName%>帐号：</td>
<td width="80%"><input Name="AdminName" id="AdminName" type="text" class="ipt" size="30" value="<%=Trim(Rs("AdminName"))%>" /></td>
</tr>
<tr>
<td width="20%" align="right"><%=ItemName%>密码：</td>
<td width="80%"><input Name="Password" id="Password" type="Password" class="ipt" size="30" value="" />&nbsp;<span class="red">不改密码请为空！</span></td>
</tr>
<tr>
<td width="20%" align="right">昵称：</td>
<td width="80%"><input Name="AdminPetName" id="AdminPetName" type="text" class="ipt" size="30" value="<%=Trim(Rs("AdminPetName"))%>" /></td>
</tr>
<tr>
<td width="20%" align="right">邮件地址：</td>
<td width="80%"><input Name="AdminEMail" id="AdminEMail" type="text" class="ipt" size="30" value="<%=Trim(Rs("AdminEMail"))%>" /></td>
</tr>
<tr>
<td width="20%" align="right">个性签名：<br /><strong class="gray">支持HTML代码</strong>&nbsp;&nbsp;</td>
<td width="80%"><textarea class="txa" Name="AdminSignature" id="AdminSignature" rows="3" cols="80"><%If Trim(Rs("AdminSignature"))<>"" Then Response.Write (Server.HtmlEncode(Trim(Rs("AdminSignature")))) End if%></textarea></td>
</tr>
<tr>
<td width="20%" align="right" valign="Top">登陆信息：</td>
<td width="80%">正常登陆：<%=Int(Rs("LoginTimes"))%>&nbsp;次 | 非法登陆：<span class="red"><%=Int(Rs("ErrLoginTimes"))%></span>&nbsp;次
<br />上次登陆时间：<%=Trim(Rs("LoginDate"))%> | 上次登陆IP：<%=Trim(Rs("LoginIP"))%>
<br />该用户创建人：<span class="red"><%=Trim(Rs("AddName"))%></span> | 创建日期：<%=Trim(Rs("AddTime"))%></td>
</tr>
<tr>
<td width="20%" align="right">附加属性：</td>
<td width="80%">
<input style="border:none;" type="radio" Name="IsActive" id="isActive0" value="0"<%If Int(Rs("IsActive"))=0 Then Response.Write " Checked=""Checked""" End If%> />
<label for="isActive0">锁定</label>
<input style="border:none;" type="radio" Name="IsActive" id="isActive1" value="1"<%If Int(Rs("IsActive"))=1 Then Response.Write " Checked=""Checked""" End If%> /> 
<label for="isActive1">解锁</label>
</td>
</tr>
<tr>
<td width="20%" align="right">权限设置：</td>
<td width="80%">
<input style="border:none;" type="checkbox" Name="IsSuperAdmin" id="IsSuperAdmin" value="1"<%If Rs("IsSuperAdmin")=1 Then Response.Write " Checked=""Checked""" End If%> />
<label for="IsSuperAdmin">超级<%=ItemName%></label>&nbsp;<span class="red">当栏目权限为空时，请将局部权限设为“无权限”。</span>
</td>
</tr>
<Tbody id="DisAdminPower"<%If Rs("IsSuperAdmin")=1 Then Response.Write " style='display:none'" End If%>>
<tr>
<td width="20%" align="right" valign="top">局部栏目权限设置：</td>
<td width="80%">
<%
Call EditAdminJurisdiction(0,"杂项",0,"无权限",3,"添加",2,"修改",1,"删除")
Call EditAdminJurisdiction(1,"产品",0,"无权限",3,"添加",2,"修改",1,"删除")
Call EditAdminJurisdiction(2,"文章",0,"无权限",3,"添加",2,"修改",1,"删除")
Call EditAdminJurisdiction(3,"新闻",0,"无权限",3,"添加",2,"修改",1,"删除")
Call EditAdminJurisdiction(4,"视频",0,"无权限",3,"添加",2,"修改",1,"删除")
Call EditAdminJurisdiction(5,"幻灯",0,"无权限",3,"添加",2,"修改",1,"删除")
Call EditAdminJurisdiction(6,"公告",0,"无权限",3,"添加",2,"修改",1,"删除")
Call EditAdminJurisdiction(7,"友情链接",0,"无权限",3,"添加",2,"修改",1,"删除")
Call EditAdminJurisdiction(8,"留言",0,"无权限",-1,"NO",2,"修改",1,"删除")
Call EditAdminJurisdiction(9,"图片及广告设置 ",0,"无权限",3,"添加",2,"修改",1,"删除")
Call EditAdminJurisdiction(10,"在线客服",0,"无权限",3,"添加",2,"修改",1,"删除")
Call EditAdminJurisdiction(11,"群发邮件",0,"无权限",-1,"NO",-1,"NO",1,"允许")
Call EditAdminJurisdiction(12,"投票",0,"无权限",3,"添加",2,"修改",1,"删除")
Call EditAdminJurisdiction(13,"上传文件",0,"无权限",-1,"NO",2,"上传",1,"删除")
Call EditAdminJurisdiction(14,"管理员设置",0,"无权限",-1,"NO",-1,"NO",1,"允许")
Call EditAdminJurisdiction(15,"修改我的密码",0,"无权限",-1,"NO",-1,"NO",1,"允许")
Call EditAdminJurisdiction(16,"数据库",0,"无权限",3,"备份",2,"恢复",1,"删除")
%>
</td>
</tr>
</Tbody>

<tr>
<td colspan="2" align="center" class="bottom">
<input type="hidden" name="Action" id="Action" value="Edit" />
<input type="hidden" name="ID" id="ID" value="<%=Int(Rs("AdminID"))%>" />
<input type="hidden" name="page" id="page" value="<%=page%>" />
<input type="Submit" class="btn" Name="EditSubmit" value="提交修改" />
<input type="button" class="btn" Name="Delbutton" value="删除" onclick="window.location.href='?Action=DelAll&Del=Del&ID=<%=Int(Rs("AdminID"))%>&<%=strVariable%>';" />
<input type="reset" class="btn" Name="resetSubmit" value="重新填写" />
<input type="button" class="btn" Name="managebutton" value="转到列表页" onclick="window.location.href='?Action=ManageForm&ID=<%=Int(Rs("AdminID"))%>&<%=strVariable%>';" />
</td>
</tr>
</form>
</table>
<%
Call RsClose(Rs)
Call ConnClose(Conn)
End Sub
%>
<%
'修改密码
Sub ModifyPassWordForm()
%>
<table cellpadding="0" cellspacing="0" class="main_containter chg_color">
<form Name="mainform" id="mainform" method="post" Action="?">
<tr> 
<th colspan="2" class="title"><strong>修改我的密码</strong></th>
</tr>
<tr>
<td width="20%" align="right"><%=ItemName%>名称：</td>
<td width="80%" class="red"><%=MyV_AdminName%></td>
</tr>
<tr>
<td align="right">旧 密 码：</td>
<td>
<input type="Password" class="ipt" Name="Password" id="Password" size="40" /></td>
</tr>
<tr>
<td align="right">新 密 码：</td>
<td>
<input type="Password" class="ipt" Name="password1" id="password1" size="40" /></td>
</tr>
<tr>
<td align="right">确认密码：</td>
<td>
<input type="Password" class="ipt" Name="password2" id="password2" size="40" /></td>
</tr>
<tr >
<td colspan="2" align="center" class="bottom">
<input type="hidden" name="Action" id="Action" value="Modify" />
<input type="hidden" name="page" id="page" value="<%=page%>" />
<input type="Submit" class="btn" Name="EditSubmit" value="修改我的密码" />
<input type="reset" class="btn" Name="resetSubmit" value="重新填写" />
<input type="button" class="btn" Name="managebutton" value="转到列表页" onclick="window.location.href='?Action=ManageForm&<%=strVariable%>';" />
</tr>
</form>
</table>
<%
End Sub
%>
<%
'添加
Sub AddData()
'检查表单数据的合法性
If ChkForbiddenWords(ForbiddenWords,AdminName)=False Then
Call Alert(""&ItemName&"名称不能为空且不能含有非法字符！<br />您准备提交的"&ItemName&"名称：<br />"&AdminName&"<br />以下为非法字符：<br />"&ChkSameWords(ForbiddenWords,AdminName)&"",-1)
Exit Sub
End If
If strLen(AdminName)<4 Then
Call Alert(""&ItemName&"名称长度不能小于4位！",-1)
Exit Sub
End If
If strLen(Trim(Request.Form("Password")))<6 Then
Call Alert("密码长度不能小于6位！",-1)
Exit Sub
End If
Set Rs=server.CreateObject("adodb.recordset")
Sql="Select * from [LQ_"&MyFileName&"] where AdminName='"&AdminName&"'"
Rs.Open Sql,conn,1,3
if Not(Rs.eof and Rs.bof) Then
Call Alert("您准备提交的信息：“"&AdminName&"”已存在！",-1)
Call ConnClose(Conn)
Exit Sub
Else
Rs.AddNew
Rs("Orders")=Int(Request.Form("Orders"))
Rs("AdminName")=Trim(Request.Form("AdminName"))
Rs("Password")=md5(trim(Request.form("Password")))
Rs("AdminPetName")=Trim(Request.Form("AdminPetName"))
Rs("AdminEMail")=Trim(Request.Form("AdminEMail"))
Rs("IsActive")=Int(Request.Form("IsActive"))
Rs("AdminSignature")=Trim(Request.Form("AdminSignature"))
Rs("AddName")=MyV_AdminName
Rs("LoginIP")="没有登陆过后台"
Rs("LoginDate")=Now()
Rs("ErrLoginTimes")=0
'权限
If Int(Request.Form("IsSuperAdmin"))=1 Then
Rs("IsSuperAdmin")=Int(Request.form("IsSuperAdmin"))
Rs("ListFlag")="1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1"
Rs("AdminFlag")="1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1"
Else
Rs("IsSuperAdmin")=0
Rs("ListFlag")=Int(Request.form("ListFlag0"))&","&Int(Request.form("ListFlag1"))&","&Int(Request.form("ListFlag2"))&","&Int(Request.form("ListFlag3"))&","&Int(Request.form("ListFlag4"))&","&Int(Request.form("ListFlag5"))&","&Int(Request.form("ListFlag6"))&","&Int(Request.form("ListFlag7"))&","&Int(Request.form("ListFlag8"))&","&Int(Request.form("ListFlag9"))&","&Int(Request.form("ListFlag10"))&","&Int(Request.form("ListFlag11"))&","&Int(Request.form("ListFlag12"))&","&Int(Request.form("ListFlag13"))&","&Int(Request.form("ListFlag14"))&","&Int(Request.form("ListFlag15"))&","&Int(Request.form("ListFlag16"))&","&Int(Request.form("ListFlag17"))&","&Int(Request.form("ListFlag18"))&","&Int(Request.form("ListFlag19"))&","&Int(Request.form("ListFlag20"))&","&Int(Request.form("ListFlag21"))&","&Int(Request.form("ListFlag22"))&","&Int(Request.form("ListFlag23"))&","&Int(Request.form("ListFlag24"))
Rs("AdminFlag")=Int(Request.form("AdminFlag0"))&","&Int(Request.form("AdminFlag1"))&","&Int(Request.form("AdminFlag2"))&","&Int(Request.form("AdminFlag3"))&","&Int(Request.form("AdminFlag4"))&","&Int(Request.form("AdminFlag5"))&","&Int(Request.form("AdminFlag6"))&","&Int(Request.form("AdminFlag7"))&","&Int(Request.form("AdminFlag8"))&","&Int(Request.form("AdminFlag9"))&","&Int(Request.form("AdminFlag10"))&","&Int(Request.form("AdminFlag11"))&","&Int(Request.form("AdminFlag12"))&","&Int(Request.form("AdminFlag13"))&","&Int(Request.form("AdminFlag14"))&","&Int(Request.form("AdminFlag15"))&","&Int(Request.form("AdminFlag16"))&","&Int(Request.form("AdminFlag17"))&","&Int(Request.form("AdminFlag18"))&","&Int(Request.form("AdminFlag19"))&","&Int(Request.form("AdminFlag20"))&","&Int(Request.form("AdminFlag21"))&","&Int(Request.form("AdminFlag22"))&","&Int(Request.form("AdminFlag23"))&","&Int(Request.form("AdminFlag24"))
End If
Rs.Update
Call RsClose(Rs)
'获取ID
Dim T_ID
T_ID=Conn.ExeCute("select AdminID from [LQ_"&MyFileName&"] where AdminName='"&AdminName&"'")(0)
Call ConnClose(Conn)
Call Succeed_Msg("”"&AdminName&"“添加成功！","?Action=AddForm","?Action=EditForm&ID="&T_ID&"","?Action=DelAll&Del=Del&ID="&T_ID&"","NO","?Action=ManageForm")
End If
End Sub
'修改
Sub EditData()
'检查表单数据的合法性
If ChkForbiddenWords(ForbiddenWords,AdminName)=False Then
Call Alert(""&ItemName&"标题不能为空且不能含有非法字符！<br />您准备提交的"&ItemName&"：<br />"&AdminName&"<br />以下为非法字符：<br />"&ChkSameWords(ForbiddenWords,AdminName)&"",-1)
Exit Sub
End If
If strLen(AdminName)<4 Then
Call Alert(""&ItemName&"名称长度不能小于4位！",-1)
Exit Sub
End If
'If strLen(Trim(Request.Form("Password")))<6 Then
'Call Alert("密码长度不能小于6位！",-1)
'Exit Sub
'End If
Set Rs=server.CreateObject("adodb.recordset")
Sql="select * from [LQ_"&MyFileName&"] where AdminID="&ID&""
Rs.Open Sql,conn,1,3
Rs("AdminName")=trim(Request.form("AdminName"))
if trim(Request.form("Password"))<>"" then
Rs("Password")=md5(trim(Request.form("Password")))
end If
Rs("AdminPetName")=Trim(Request.Form("AdminPetName"))
Rs("AdminEMail")=Trim(Request.Form("AdminEMail"))
Rs("AdminSignature")=Trim(Request.Form("AdminSignature"))
If Rs("AdminID")<>1 Then
Rs("LoginDate")=Rs("LoginDate")
Rs("IsActive")=Int(Request.form("IsActive"))
Rs("ErrLoginTimes")=0
'权限
If Int(Request.form("IsSuperAdmin"))=1 Then
Rs("IsSuperAdmin")=1
Rs("ListFlag")="1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1"
Rs("AdminFlag")="1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1"
Else
Rs("IsSuperAdmin")=0
Rs("ListFlag")=Int(Request.form("ListFlag0"))&","&Int(Request.form("ListFlag1"))&","&Int(Request.form("ListFlag2"))&","&Int(Request.form("ListFlag3"))&","&Int(Request.form("ListFlag4"))&","&Int(Request.form("ListFlag5"))&","&Int(Request.form("ListFlag6"))&","&Int(Request.form("ListFlag7"))&","&Int(Request.form("ListFlag8"))&","&Int(Request.form("ListFlag9"))&","&Int(Request.form("ListFlag10"))&","&Int(Request.form("ListFlag11"))&","&Int(Request.form("ListFlag12"))&","&Int(Request.form("ListFlag13"))&","&Int(Request.form("ListFlag14"))&","&Int(Request.form("ListFlag15"))&","&Int(Request.form("ListFlag16"))&","&Int(Request.form("ListFlag17"))&","&Int(Request.form("ListFlag18"))&","&Int(Request.form("ListFlag19"))&","&Int(Request.form("ListFlag20"))&","&Int(Request.form("ListFlag21"))&","&Int(Request.form("ListFlag22"))&","&Int(Request.form("ListFlag23"))&","&Int(Request.form("ListFlag24"))
Rs("AdminFlag")=Int(Request.form("AdminFlag0"))&","&Int(Request.form("AdminFlag1"))&","&Int(Request.form("AdminFlag2"))&","&Int(Request.form("AdminFlag3"))&","&Int(Request.form("AdminFlag4"))&","&Int(Request.form("AdminFlag5"))&","&Int(Request.form("AdminFlag6"))&","&Int(Request.form("AdminFlag7"))&","&Int(Request.form("AdminFlag8"))&","&Int(Request.form("AdminFlag9"))&","&Int(Request.form("AdminFlag10"))&","&Int(Request.form("AdminFlag11"))&","&Int(Request.form("AdminFlag12"))&","&Int(Request.form("AdminFlag13"))&","&Int(Request.form("AdminFlag14"))&","&Int(Request.form("AdminFlag15"))&","&Int(Request.form("AdminFlag16"))&","&Int(Request.form("AdminFlag17"))&","&Int(Request.form("AdminFlag18"))&","&Int(Request.form("AdminFlag19"))&","&Int(Request.form("AdminFlag20"))&","&Int(Request.form("AdminFlag21"))&","&Int(Request.form("AdminFlag22"))&","&Int(Request.form("AdminFlag23"))&","&Int(Request.form("AdminFlag24"))
End If
Else
Rs("IsActive")=1
End If
Rs.Update
Call RsClose(Rs)
'获取ID
Dim T_ID
T_ID=Conn.ExeCute("select AdminID from [LQ_"&MyFileName&"] where AdminName='"&AdminName&"'")(0)
Call ConnClose(Conn)
Call Succeed_Msg("”"&AdminName&"“修改成功！","?Action=AddForm&ID="&T_ID&"","?Action=EditForm&ID="&T_ID&"&"&strVariable&"","?Action=DelAll&Del=Del&ID="&T_ID&"&"&strVariable&"","NO","?"&strVariable&"")
End Sub
'删除
Sub DelData()
Dim Sel_ID,Title_List
'定义标题数组
Title_List="<ol>"&T_ArrayName(MyFileName,"AdminName",Request("ID"))&"</ol>"
If Request("ID")="" Then
	Call Alert("至少要选择一条信息，然后才能操作！",-1)
	Exit Sub
ElseIf Request("Del")="修改级别" Then
	If Request("movetype")="" Then
	Call Alert("请选择正确的级别",-1)
	Exit Sub
	End If
	If Request("movetype")=1 then
		set Rs=Conn.ExeCute("Update [LQ_"&MyFileName&"] set IsSuperAdmin = 1,ListFlag='1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1',AdminFlag='1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1' where AdminID>1 and AdminID In ("&Request("ID")&")")
	ElseIf Request("movetype")=0 then
		set Rs=Conn.ExeCute("Update [LQ_"&MyFileName&"] set IsSuperAdmin = 0,ListFlag='0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0',AdminFlag='0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0' where AdminID>1 and AdminID In ("&Request("ID")&")")
	End If
	Call ConnClose(Conn)
	Call Alert("修改级别成功！"&Title_List&"",strUrl)
ElseIf Request("Del")="锁定" Then
	set Rs=Conn.ExeCute("Update [LQ_"&MyFileName&"] set IsActive = 0 where AdminID>1 and AdminID In ("&Request("ID")&")")
	Call ConnClose(Conn)
	Call Alert("锁定成功！"&Title_List&"",strUrl)
ElseIf Request("Del")="激活" Then
	set Rs=Conn.ExeCute("Update [LQ_"&MyFileName&"] set IsActive = 1,ErrLoginTimes = 0 where AdminID In ("&Request("ID")&")")
	Call ConnClose(Conn)
	Call Alert("激活成功！"&Title_List&"",strUrl)
ElseIf Request("Del")="更新时间" Then
	Dim NowTime
	For i=1 To Request("ID").Count
	If Request("ID").Count=1 Then
	Sel_ID=Request("ID")
	Else
	Sel_ID=Replace(Request("ID")(i),"'","")
	End If
	NowTime=DateAdd("s",-(i*3),Now())
	Conn.ExeCute("Update [LQ_"&MyFileName&"] set AddTime = #"&NowTime&"# where AdminID="&Sel_ID&"")
	Next
	Call ConnClose(Conn)
	Call Alert("更新时间成功！"&Title_List&"",strUrl)
ElseIf Request("Del")="删除" Then
	Call AdminFlagMsg_Del()
	For i=1 To Request("ID").Count
	If Request("ID").Count=1 Then
	Sel_ID=Request("ID")
	Else
	Sel_ID=Replace(Request("ID")(i),"'","")
	End If
	'删除数据
	Conn.ExeCute("Delete from [LQ_"&MyFileName&"] where AdminID>1 and AdminID="&Sel_ID&"")
	Next
	Call Alert ("删除成功！"&Title_List&"",strUrl)
'单条删除
ElseIf Request("Del")="Del" Then
	Call AdminFlagMsg_Del()
	Sel_ID=Request("ID")
	'删除数据
	Conn.ExeCute("Delete from [LQ_"&MyFileName&"] where AdminID>1 and AdminID="&Sel_ID&"")
	Call Alert ("删除成功！"&Title_List&"","?Action=ManageForm&"&strVariable&"")
End If
End Sub
'修改密码
Sub ModifyData()
Set Rs=server.CreateObject("adodb.recordset")
Sql="select * from [LQ_"&MyFileName&"] where AdminName='"&MyV_AdminName&"'"
Rs.Open Sql,Conn,1,3
If trim(Request.Form("Password"))="" Then
	Call Alert("请输入旧密码！",-1)
	Exit Sub
Elseif md5(trim(Request.Form("Password")))<>Rs("Password") Then
	Call Alert("旧密码错误，请返回重新输入！",-1)
	Exit Sub
ElseIf strLen(Trim(Request.Form("password1")))<6 Then
	Call Alert("新密码长度不能小于6位！",-1)
	Exit Sub
ElseIf md5(trim(Request.Form("password1")))=Rs("Password") Then
	Call Alert("新密码与旧密码相同，请选择不同的密码！",strUrl)
	Exit Sub
ElseIf trim(Request.Form("password2"))="" Then
	Call Alert("请输入确认密码！",-1)
	Exit Sub
ElseIf trim(Request.Form("password1"))<>trim(Request.Form("password2")) Then
	Call Alert("新密码和确认密码不相同，请重新输入！",-1)
	Exit Sub
else
	Rs("Password")=md5(trim(Request.Form("password2")))
	Rs.Update
	Call RsClose(Rs)
	Call ConnClose(Conn)
	Call Alert("密码修改成功，请重新登陆！","logout.asp")
End If
End Sub
'******************************
'根据ID循环显示数组
'***************************************************
Public Function T_ArrayName(Byval Table_Name,Byval Fields_Name,Byval ID_Name)
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
Str_Name=Conn.ExeCute("select "&Fields_Name&" from [LQ_"&Table_Name&"] where AdminID="&T_Sel_ID&"")(0)
T_ArrayName=T_ArrayName&"<li>"&Str_Name&"</li>"
Next
End If
End Function
%>
</body>
</html>