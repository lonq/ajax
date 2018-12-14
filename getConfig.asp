<!--#include file="inc/conn.asp"-->
<!--#include file="inc/function.asp"--><%
'常用变量
Dim Sql, Rs
Action = Trim(Request("Action"))

'执行
Select Case Action
Case "config"
    Call config()
Case Else
    Call config()
End Select

'全局变量
Public Function config()
set Rs=server.CreateObject("adodb.recordset")
Sql="select * from LQ_Config"
Rs.Open Sql,conn,1,1
    ReturnStr = "{" & vbCrLf
    ReturnStr = ReturnStr & """websitename"": """& Trim(Rs("WebSiteName")) & """," & vbCrLf
    ReturnStr = ReturnStr & """websiteurl"": """& Trim(Rs("WebSiteUrl")) & """," & vbCrLf
    ReturnStr = ReturnStr & """tel"": """& Trim(Rs("Tel")) & """," & vbCrLf
    ReturnStr = ReturnStr & """mobiletel"": """& Trim(Rs("MobileTel")) & """," & vbCrLf
    ReturnStr = ReturnStr & """fax"": """& Trim(Rs("Fax")) & """," & vbCrLf
    ReturnStr = ReturnStr & """qq"": """& Trim(Rs("Qq")) & """," & vbCrLf
    ReturnStr = ReturnStr & """msn"": """& Trim(Rs("Msn")) & """," & vbCrLf
    ReturnStr = ReturnStr & """websiteemail"": """& Trim(Rs("WebSiteEmail")) & """," & vbCrLf
    ReturnStr = ReturnStr & """address"": """& Trim(Rs("Address")) & """," & vbCrLf
    ReturnStr = ReturnStr & """postcode"": """& Trim(Rs("PostCode")) & """," & vbCrLf
    ReturnStr = ReturnStr & """websitemaster"": """& Trim(Rs("WebSiteMaster")) & """," & vbCrLf
    ReturnStr = ReturnStr & """websitemasteremail"": """& Trim(Rs("WebSiteMasterEmail")) & """," & vbCrLf
    ReturnStr = ReturnStr & """websiteusers"": """& Trim(Rs("WebSiteUsers")) & """," & vbCrLf
    ReturnStr = ReturnStr & """websiteusersemail"": """& Trim(Rs("WebSiteUsersEmail")) & """," & vbCrLf
    ReturnStr = ReturnStr & """technology"": """& Trim(Rs("Technology")) & """," & vbCrLf
    ReturnStr = ReturnStr & """technologyemail"": """& Trim(Rs("TechnologyEmail")) & """," & vbCrLf
    ReturnStr = ReturnStr & """copyright"": """& HTMLEncodes(Trim(Rs("CopyRight"))) & """," & vbCrLf
    ReturnStr = ReturnStr & """icp"": """& HTMLEncodes(Trim(Rs("ICP"))) & """," & vbCrLf
    ReturnStr = ReturnStr & """sitestatistics"": """& Trim(Rs("SiteStatistics")) & """," & vbCrLf
    ReturnStr = ReturnStr & """scripttimeout"": "& ChkNumeric(Rs("ScriptTimeout")) & "," & vbCrLf
    ReturnStr = ReturnStr & """sessiontimeout"": "& ChkNumeric(Rs("SessionTimeout")) & "," & vbCrLf
    ReturnStr = ReturnStr & """posttimelimit"": "& ChkNumeric(Rs("PostTimeLimit")) & "," & vbCrLf
    ReturnStr = ReturnStr & """finaldatabackuptime"": """& Trim(Rs("FinalDatabackupTime")) & """," & vbCrLf
    ReturnStr = ReturnStr & """closesitecontent"": """& HTMLEncodes(Trim(Rs("CloseSiteContent"))) & """," & vbCrLf
    ReturnStr = ReturnStr & """isclosesite"": " & ChkNumeric(Rs("IsCloseSite")) & "," & vbCrLf
    ReturnStr = ReturnStr & """isusersvariable"": " & ChkNumeric(Rs("IsUsersVariable")) & "," & vbCrLf
    ReturnStr = ReturnStr & """isshow"": " & ChkNumeric(Rs("IsShow")) & "," & vbCrLf
    ReturnStr = ReturnStr & """iscomment"": " & ChkNumeric(Rs("IsComment")) & "," & vbCrLf
    ReturnStr = ReturnStr & """isshowcomment"": " & ChkNumeric(Rs("IsShowComment")) & "," & vbCrLf
    ReturnStr = ReturnStr & """ispredown"": " & ChkNumeric(Rs("IsPreDown")) & "," & vbCrLf
    ReturnStr = ReturnStr & """isfriendlink"": " & ChkNumeric(Rs("IsFriendLink")) & "," & vbCrLf
    ReturnStr = ReturnStr & """isrecommend"": " & ChkNumeric(Rs("IsRecommend")) & "," & vbCrLf
    ReturnStr = ReturnStr & """iscorrelation"": " & ChkNumeric(Rs("IsCorrelation")) & "," & vbCrLf
    ReturnStr = ReturnStr & """isonlineservice"": " & ChkNumeric(Rs("IsOnLineService")) & "," & vbCrLf
    ReturnStr = ReturnStr & """iskeywords"": " & ChkNumeric(Rs("IsKeywords")) & "," & vbCrLf
    ReturnStr = ReturnStr & """issqllog"": " & ChkNumeric(Rs("IsSqlLog")) & "," & vbCrLf
    ReturnStr = ReturnStr & """isqrcode"": " & ChkNumeric(Rs("IsqrCode")) & "," & vbCrLf
    ReturnStr = ReturnStr & """ishtmledit"": " & ChkNumeric(Rs("IsHtmlEdit")) & "," & vbCrLf
    ReturnStr = ReturnStr & """ishtmlmode"": " & ChkNumeric(Rs("IsHtmlMode")) & "," & vbCrLf
    ReturnStr = ReturnStr & """otherslistnums"": " & ChkNumeric(Rs("OthersListNums")) & "," & vbCrLf
    ReturnStr = ReturnStr & """productslistnums"": " & ChkNumeric(Rs("ProductsListNums")) & "," & vbCrLf
    ReturnStr = ReturnStr & """articleslistnums"": " & ChkNumeric(Rs("ArticlesListNums")) & "," & vbCrLf
    ReturnStr = ReturnStr & """newslistnums"": " & ChkNumeric(Rs("NewsListNums")) & "," & vbCrLf
    ReturnStr = ReturnStr & """messlistnums"": " & ChkNumeric(Rs("MessListNums")) & "," & vbCrLf
    ReturnStr = ReturnStr & """mailaddress"": """& Trim(Rs("MailAddress")) & """," & vbCrLf
    ReturnStr = ReturnStr & """mailname"": """& Trim(Rs("MailName")) & """," & vbCrLf
    ReturnStr = ReturnStr & """mailsendemail"": """& Trim(Rs("MailSendEmail")) & """," & vbCrLf
    ReturnStr = ReturnStr & """mailusername"": """& Trim(Rs("MailUserName")) & """," & vbCrLf
    ReturnStr = ReturnStr & """mailuserpassword"": """& Trim(Rs("MailUserPassword")) & """," & vbCrLf
'    ReturnStr = ReturnStr & """forbiddenwords"": """& Trim(Rs("ForbiddenWords")) & """," & vbCrLf
    ReturnStr = ReturnStr & """sqlinword"": """& Trim(Rs("SqlInword")) & """," & vbCrLf
    ReturnStr = ReturnStr & """badwords"": """& Trim(Rs("BadWords")) & """," & vbCrLf
    ReturnStr = ReturnStr & """lockip"": """& Trim(Rs("LockIP")) & """," & vbCrLf
    ReturnStr = ReturnStr & """setuploadfiles"": """& Trim(Rs("SetUploadFiles")) & """," & vbCrLf
    ReturnStr = ReturnStr & """ssinglesize"": " & ChkNumeric(Rs("sSingleSize")) & "," & vbCrLf
    ReturnStr = ReturnStr & """smaxsize"": " & ChkNumeric(Rs("sMaxSize")) & "," & vbCrLf
    ReturnStr = ReturnStr & """sexe"": """& Trim(Rs("sExe")) & """," & vbCrLf
    ReturnStr = ReturnStr & """webtitlename"": """& Trim(Rs("WebTitleName")) & """," & vbCrLf
    ReturnStr = ReturnStr & """indexkeyword"": """& Trim(Rs("IndexKeyword")) & """," & vbCrLf
    ReturnStr = ReturnStr & """indexdescription"": """& Trim(Rs("IndexDescription")) & """," & vbCrLf
    ReturnStr = ReturnStr & """indexcompanyintroduction"": """& Trim(Rs("IndexCompanyIntroduction")) & """," & vbCrLf
    ReturnStr = ReturnStr & """companyintroduction"": """& Trim(Rs("CompanyIntroduction")) & """" & vbCrLf
    ReturnStr = ReturnStr & "}"
Call RsClose(Rs)
config = ReturnStr
Response.Write (config)
End Function
%>
