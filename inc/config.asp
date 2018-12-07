<%
'************************
'定义Config里的变量
'************************
Dim WebSiteName,WebSiteUrl,Tel,MobileTel,Fax,Qq,Msn,WebSiteEmail,Address,PostCode,WebSiteMaster,WebSiteMasterEmail,WebSiteAdmin,WebSiteAdminEmail,Technology,TechnologyEmail,CopyRight,ICP,SiteStatistics,ScriptTimeout,SessionTimeout,PostTimeLimit,FinalDatabackupTime,CloseSiteContent,IsCloseSite,IsAdminVariable,IsShow,IsComment,IsShowComment,IsPreDown,IsFriendLink,IsRecommend,IsCorrelation,IsOnLineService,IsKeywords,IsSqlLog,IsqrCode,IsHtmlEdit,IsHtmlMode,OthersListNums,ProductsListNums,ArticlesListNums,NewsListNums,MessListNums,MailAddress,MailName,MailSendEmail,MailUserName,MailUserPassword,ForbiddenWords,SqlInword,BadWords,LockIP,SetUploadFiles,sSingleSize,sMaxSize,sExe,WebTitleName,IndexKeyword,IndexDescription,IndexCompanyIntroduction,CompanyIntroduction
set Rs=server.CreateObject("adodb.recordset")
Sql="select * from LQ_Config"
Rs.Open Sql,conn,1,1
WebSiteName=				Trim(Rs("WebSiteName"))
WebSiteUrl=					Trim(Rs("WebSiteUrl"))
Tel=						Trim(Rs("Tel"))
MobileTel=					Trim(Rs("MobileTel"))
Fax=						Trim(Rs("Fax"))
Qq=							Trim(Rs("Qq"))
Msn=						Trim(Rs("Msn"))
WebSiteEmail=				Trim(Rs("WebSiteEmail"))
Address=					Trim(Rs("Address"))
PostCode=					Trim(Rs("PostCode"))
WebSiteMaster=				Trim(Rs("WebSiteMaster"))
WebSiteMasterEmail=			Trim(Rs("WebSiteMasterEmail"))
WebSiteAdmin=				Trim(Rs("WebSiteAdmin"))
WebSiteAdminEmail=			Trim(Rs("WebSiteAdminEmail"))
Technology=					Trim(Rs("Technology"))
TechnologyEmail=			Trim(Rs("TechnologyEmail"))
CopyRight=					Trim(Rs("CopyRight"))
ICP=						Trim(Rs("ICP"))
SiteStatistics=				Trim(Rs("SiteStatistics"))
ScriptTimeout=				Trim(Rs("ScriptTimeout"))
SessionTimeout=				Trim(Rs("SessionTimeout"))
PostTimeLimit=				Trim(Rs("PostTimeLimit"))
FinalDatabackupTime=		Trim(Rs("FinalDatabackupTime"))
CloseSiteContent=			Trim(Rs("CloseSiteContent"))
IsCloseSite=				ChkNumeric(Rs("IsCloseSite"))
IsAdminVariable=			ChkNumeric(Rs("IsAdminVariable"))
IsShow=						ChkNumeric(Rs("IsShow"))
IsComment=					ChkNumeric(Rs("IsComment"))
IsShowComment=				ChkNumeric(Rs("IsShowComment"))
IsPreDown=					ChkNumeric(Rs("IsPreDown"))
IsFriendLink=				ChkNumeric(Rs("IsFriendLink"))
IsRecommend=				ChkNumeric(Rs("IsRecommend"))
IsCorrelation=				ChkNumeric(Rs("IsCorrelation"))
IsOnLineService=			ChkNumeric(Rs("IsOnLineService"))
IsKeywords=					ChkNumeric(Rs("IsKeywords"))
IsSqlLog=					ChkNumeric(Rs("IsSqlLog"))
IsqrCode=					ChkNumeric(Rs("IsqrCode"))
IsHtmlEdit=					ChkNumeric(Rs("IsHtmlEdit"))
IsHtmlMode=					ChkNumeric(Rs("IsHtmlMode"))
OthersListNums=				ChkNumeric(Rs("OthersListNums"))
ProductsListNums=			ChkNumeric(Rs("ProductsListNums"))
ArticlesListNums=			ChkNumeric(Rs("ArticlesListNums"))
NewsListNums=				ChkNumeric(Rs("NewsListNums"))
MessListNums=				ChkNumeric(Rs("MessListNums"))
MailAddress=				Trim(Rs("MailAddress"))
MailName=					Trim(Rs("MailName"))
MailSendEmail=				Trim(Rs("MailSendEmail"))
MailUserName=				Trim(Rs("MailUserName"))
MailUserPassword=			Trim(Rs("MailUserPassword"))
ForbiddenWords=				Trim(Rs("ForbiddenWords"))
SqlInword=					Trim(Rs("SqlInword"))
BadWords=					Trim(Rs("BadWords"))
LockIP=						Trim(Rs("LockIP"))
SetUploadFiles=				Trim(Rs("SetUploadFiles"))
sSingleSize=				ChkNumeric(Rs("sSingleSize"))
sMaxSize=					ChkNumeric(Rs("sMaxSize"))
sExe=						Trim(Rs("sExe"))
WebTitleName=				Trim(Rs("WebTitleName"))
IndexKeyword=				Trim(Rs("IndexKeyword"))
IndexDescription=			Trim(Rs("IndexDescription"))
IndexCompanyIntroduction=	Trim(Rs("IndexCompanyIntroduction"))
CompanyIntroduction=		Trim(Rs("CompanyIntroduction"))
Call RsClose(Rs)
'************************************************
'没在数据库记录的变量
'************************
'定义cookie或session的变量名
'************************
Dim MyAdmin
Dim MyV_AdminID,MyV_AdminName,MyV_Password,MyV_AdminPetName,MyV_IsSuperAdmin,MyV_ListFlag,MyV_AdminFlag
If IsAdminVariable=1 Then															'0为Session，1为Cookie
'cookies
MyV_AdminID					= Request.Cookies("LQ_Cookies")("AdminID")
MyV_AdminName				= Request.Cookies("LQ_Cookies")("AdminName")
MyV_Password				= Request.Cookies("LQ_Cookies")("Password")
MyV_AdminPetName			= Request.Cookies("LQ_Cookies")("AdminPetName")
MyV_IsSuperAdmin			= Request.Cookies("LQ_Cookies")("IsSuperAdmin")
MyV_ListFlag				= Request.Cookies("LQ_Cookies")("ListFlag")
MyV_AdminFlag				= Request.Cookies("LQ_Cookies")("AdminFlag")
Else
'session
MyV_AdminID					= session("AdminID")
MyV_AdminName				= session("AdminName")
MyV_Password				= session("Password")
MyV_AdminPetName			= session("AdminPetName")
MyV_IsSuperAdmin			= session("IsSuperAdmin")
MyV_ListFlag				= session("ListFlag")
MyV_AdminFlag				= session("AdminFlag")
End If
'************************
'普通变量
'************************
Dim Ellipsis
Ellipsis					= "..."
'************************
'文章信息的变量
'************************
Dim Art_Info,t_CopyFrom,t_Author
Art_Info					= 1														'0为系统默认未知，1为系统自定义的变量
If Art_Info=1 Then
t_CopyFrom					= WebSiteName
If MyV_AdminPetName<>"" Then
t_Author					= MyV_AdminPetName
Else
t_Author					= MyV_AdminName
End If
Else
t_CopyFrom					= "不详"
t_Author					= "佚名"
End If
Dim arrCopyFrom,arrAuthor
arrCopyFrom					= ""&t_CopyFrom&",不详,转载"
arrAuthor					= ""&t_Author&",佚名,不详,未知"
'************************
'数据库备份目录
'************************
Dim SetBackupDBPath
SetBackupDBPath					= "databackup"
%>