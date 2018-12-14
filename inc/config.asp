<%
'************************
'定义Config里的变量
'************************
Dim WebSiteName,WebSiteUrl,Tel,MobileTel,Fax,Qq,Msn,WebSiteEmail,Address,PostCode,WebSiteMaster,WebSiteMasterEmail,WebSiteUsers,WebSiteUsersEmail,Technology,TechnologyEmail,CopyRight,ICP,SiteStatistics,ScriptTimeout,SessionTimeout,PostTimeLimit,FinalDatabackupTime,CloseSiteContent,IsCloseSite,IsUsersVariable,IsShow,IsComment,IsShowComment,IsPreDown,IsFriendLink,IsRecommend,IsCorrelation,IsOnLineService,IsKeywords,IsSqlLog,IsqrCode,IsHtmlEdit,IsHtmlMode,OthersListNums,ProductsListNums,ArticlesListNums,NewsListNums,MessListNums,MailAddress,MailName,MailSendEmail,MailUserName,MailUserPassword,ForbiddenWords,SqlInword,BadWords,LockIP,SetUploadFiles,sSingleSize,sMaxSize,sExe,WebTitleName,IndexKeyword,IndexDescription,IndexCompanyIntroduction,CompanyIntroduction
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
WebSiteUsers=				Trim(Rs("WebSiteUsers"))
WebSiteUsersEmail=			Trim(Rs("WebSiteUsersEmail"))
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
IsUsersVariable=			ChkNumeric(Rs("IsUsersVariable"))
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
Dim MyUsers
Dim MyV_UsersID,MyV_UsersName,MyV_Password,MyV_UsersPetName,MyV_IsSuperUsers,MyV_ListFlag,MyV_UsersFlag
If IsUsersVariable=1 Then															'0为Session，1为Cookie
'cookies
MyV_UsersID					= Request.Cookies("LQCookies")("UsersID")
MyV_UsersName				= Request.Cookies("LQCookies")("UsersName")
MyV_Password				= Request.Cookies("LQCookies")("Password")
MyV_UsersPetName			= Request.Cookies("LQCookies")("UsersPetName")
MyV_IsSuperUsers			= Request.Cookies("LQCookies")("IsSuperUsers")
MyV_ListFlag				= Request.Cookies("LQCookies")("ListFlag")
MyV_UsersFlag				= Request.Cookies("LQCookies")("UsersFlag")
Else
'session
MyV_UsersID					= session("UsersID")
MyV_UsersName				= session("UsersName")
MyV_Password				= session("Password")
MyV_UsersPetName			= session("UsersPetName")
MyV_IsSuperUsers			= session("IsSuperUsers")
MyV_ListFlag				= session("ListFlag")
MyV_UsersFlag				= session("UsersFlag")
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
If MyV_UsersPetName<>"" Then
t_Author					= MyV_UsersPetName
Else
t_Author					= MyV_UsersName
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