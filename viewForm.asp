<!--#include file="inc/conn.asp"-->
<!--#include file="inc/config.asp"-->
<!--#include file="inc/admin_check.asp" -->
<!--#include file="inc/function.asp"-->
<!--#include file="inc/sub_inc.asp" -->
<!--#include file="inc/power.asp"--><%
'页面名称
Dim ItemName
ItemName="需求单"
'权限
Dim FtListFlag,FtAdminFlag
FtListFlag=ListFlag1
FtAdminFlag=AdminFlag1
Call ListFlagMsg()
'常用变量
Dim Sql,Rs,Action,ID,SearchKeyWord,quickSearch,Page,StrAddDate,StrVariable,StrUrl
Action=Trim(Request("Action"))
ID=ChkNumeric(Request("ID"))
SearchKeyWord=Trim(Request("SearchKeyWord"))
quickSearch=Trim(Request("quickSearch"))
Page=Request("Page")
StrAddDate=year(Now())&"-"&right("0"&month(Now()),2)&"-"&right("0"&day(Now()),2)
StrVariable = "SearchKeyWord="&SearchKeyWord&"&Page="&Page&""
StrUrl=Request.ServerVariables("http_referer")
'基本设置，定义表单控件变量
Dim SN,OneCatID,TwoCatID,Title,ProductManager,Designer,FrontEnd,Developer,SVNURL,TerminalPC,TerminalMobi,BrowserPC,BrowserMobi,Cycle,Timelimit,Direction,AddDate,EditDate,S_IsShow,S_IsTop,S_IsState
Set Rs=server.CreateObject("adodb.recordset")
Sql="Select * from LQ_Requirement where ID="&ID&""
Rs.Open Sql,Conn,1,3
If Rs.eof And Rs.bof Then
    Response.Write "<script>alert('信息不存在！');history.go(-1);</script>"
    Call ConnClose(Conn)
Else
    SN = Rs("SN")
    OneCatID = Rs("OneCatID")
    TwoCatID = Rs("TwoCatID")
    Title = Rs("Title")
    ProductManager = Rs("ProductManager")
    Designer = Rs("Designer")
    FrontEnd = Rs("FrontEnd")
    Developer = Rs("Developer")
    SVNURL = Rs("SVNURL")
    TerminalPC = Rs("TerminalPC")
    TerminalMobi = Rs("TerminalMobi")
    BrowserPC = Rs("BrowserPC")
    BrowserMobi = Rs("BrowserMobi")
    Cycle = Rs("Cycle")
    Timelimit = Rs("Timelimit")
    Direction = Rs("Direction")
    AddDate = Rs("AddDate")
    EditDate = Rs("EditDate")
    S_IsShow = Rs("IsShow")
    S_IsTop = Rs("IsTop")
    S_IsState = Rs("IsState")
    Call RsClose(Rs)
End If
'文件列表
Sub ShowFileList(PID)
    Dim Rs_FileList
    Set Rs_FileList=server.CreateObject("adodb.recordset")
    Sql="Select * From LQ_FileList where ParentID = "&PID&" and IsShow = 1"
    Rs_FileList.Open Sql,Conn,1,1
    If Rs_FileList.eof And Rs_FileList.bof Then
        Response.Write "暂无相关文件"
    Else
        Do While Not Rs_FileList.eof
        Response.Write "<div id='alert"&Rs_FileList("ID")&"' class='alert alert-default alert-dismissible' role='alert'>"
        Response.Write "<a href='"&Rs_FileList("Url")&"' class='alert-link' title='点击下载'><span>"&Rs_FileList("Title")&"</span> <i class='glyphicon glyphicon-download-alt'></i></a>"
        Response.Write "</div>"
        Rs_FileList.movenext
        Loop
    End If
    Call RsClose(Rs_FileList)
    Call ConnClose(Conn)
End Sub
%><!DOCTYPE html>
<html lang="zh-CN" class="no-js">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1">
        <meta name="renderer" content="webkit">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="keyword" content=" ">
        <meta name="description" content=" ">
        <meta name="author" content="lonq">
        <meta name="copyright" content="eeduol.com">
        <title>前端开发需求单 - 预览表单</title>
        <link href="css/normalize.min.css" rel="stylesheet">
        <link href="plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="css/global.css" rel="stylesheet">
        <link href="css/style.css" rel="stylesheet">
        <link href="plugins/bootstrap-daterangepicker-master/daterangepicker-bs3.css" rel="stylesheet">
        <script src="js/modernizr.min.js"></script>
        <!--[if lt IE 9]>
        <script src="js/html5shiv/html5shiv.min.js"></script>
        <script src="js/html5shiv/respond.min.js"></script>
        <![endif]-->
    </head>
    <body>
        <div class="container">
            <div class="row show-grid">
                <div class="col-md-12 text-right">
                    你好：<a href="ManageAdmin.asp"><%=MyV_AdminName%></a>&nbsp;&nbsp;<a href="logout.asp">[注销]</a>
                </div>
            </div>
            <div class="row show-grid">
                <h3 class="col-sm-5 col-md-5 no-margin">前端开发需求单</h3>
                <form id="quickForm" name="quickForm" method="get" Action="?">
                    <div class="col-sm-4 col-md-5">
                        <div class="input-group">
                            <input type="text" class="form-control" id="SearchKeyWord" Name="SearchKeyWord" placeholder="请输入项目名称或参与者姓名" value="<%=SearchKeyWord%>">
                            <div class="input-group-btn">
                                <button type="button" class="btn btn-default" id="searchsub" name="searchsub" onclick="doPostBack(quickForm,'index.asp?')"><i class="glyphicon glyphicon-search"></i></button>
                                <ul class="dropdown-menu dropdown-menu-right">
                                    <li><a <%If quickSearch="all" Then Response.Write ("class='active'")%> href="index.asp?quickSearch=all">全部</a></li>
                                    <li><a <%If quickSearch="IsState1" Then Response.Write ("class='active'")%> href="index.asp?quickSearch=IsState1">已完成</a></li>
                                    <li><a <%If quickSearch="IsState0" Then Response.Write ("class='active'")%> href="index.asp?quickSearch=IsState0">进行中</a></li>
                                    <li><a <%If quickSearch="IsShow1" Then Response.Write ("class='active'")%> href="index.asp?quickSearch=IsShow1">已审核</a></li>
                                    <li><a <%If quickSearch="IsShow0" Then Response.Write ("class='active'")%> href="index.asp?quickSearch=IsShow0">未审核</a></li>
                                    <li><a <%If quickSearch="IsTop" Then Response.Write ("class='active'")%> href="index.asp?quickSearch=IsTop">置顶</a></li>
                                </ul>
                                <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    <%
                                    If quickSearch="all" Then
                                        Response.Write ("全部")
                                    ElseIf quickSearch="IsState1" Then
                                        Response.Write ("已完成")
                                    ElseIf quickSearch="IsState0" Then
                                        Response.Write ("进行中")
                                    ElseIf quickSearch="IsShow1" Then
                                        Response.Write ("已审核")
                                    ElseIf quickSearch="IsShow0" Then
                                        Response.Write ("未审核")
                                    ElseIf quickSearch="IsTop" Then
                                        Response.Write ("置顶")
                                    Else
                                        Response.Write ("筛选")
                                    End If
                                    %>
                                     <span class="caret"></span>
                                    <span class="sr-only">Toggle Dropdown</span>
                                </button>
                            </div>
                        </div>
                    </div>
                </form>
                <div class="col-sm-3 col-md-2">
                    <a href="addForm.asp" class="btn btn-primary form-control"><i class="glyphicon glyphicon-plus"></i> 新建需求单</a>
                </div>
            </div>
        </div>

        <div class="container">
            <div class="panel panel-default panel-form">
                <div class="panel-heading no-padding">
                    <h4 class="bg-primary form-group form-group-flex vertical clear-text padding no-margin">
                        <i class="glyphicon glyphicon-th-list"></i>
                        <div class="col margin-left"><%=Title%></div>
                    </h4>
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-md-6 col-sm-12 form-group form-group-flex vertical clear-text">
                            <label class="control-label" for="ProductManager">产品经理：</label>
                            <div class="col"><%=ProductManager%></div>
                        </div>
                        <div class="col-md-6 col-sm-12 form-group form-group-flex vertical clear-text">
                            <label class="control-label" for="Designer">设计师：</label>
                            <div class="col"><%=Designer%></div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 col-sm-12 form-group form-group-flex vertical clear-text">
                            <label class="control-label" for="FrontEnd">前端开发：</label>
                            <div class="col"><%=FrontEnd%></div>
                        </div>
                        <div class="col-md-6 col-sm-12 form-group form-group-flex vertical clear-text">
                            <label class="control-label" for="Developer">后台开发：</label>
                            <div class="col"><%=Developer%></div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12 form-group form-group-flex vertical clear-text">
                            <label class="control-label" for="SVNURL">SVN地址：</label>
                            <div class="col"><%=SVNURL%></div>
                        </div>
                    </div>
                    <div class="row no-border">
                        <div class="col-sm-12 form-group form-group-flex vertical">
                            <label class="control-label">适配浏览器：</label>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-4 col-sm-12 form-group form-group-flex">
                            <label class="control-label" for="BrowserPC">PC端：</label>
                            <div class="col"><%=BrowserPC%></div>
                        </div>
                        <div class="col-md-8 col-sm-12 form-group form-group-flex">
                            <label class="control-label" for="BrowserMobi">移动端：</label>
                            <div class="col"><%=BrowserMobi%></div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12 form-group form-group-flex vertical clear-text">
                            <label class="control-label" for="Cycle">项目周期：</label>
                            <div class="col"><%=Cycle%></div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12 form-group form-group-flex">
                            <label class="control-label">页面交互与逻辑：</label>
                            <div id="FileList" class="col alert-group"><%Call ShowFileList(ID)%></div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12 form-group form-group-flex">
                            <label class="control-label" for="Direction">需求说明：</label>
                            <div class="col"><%=Direction%></div>
                        </div>
                    </div>
                </div>
                <%If S_IsState <> 1 Then%>
                <div class="panel-footer">
                    <div class="row">
                        <div class="col-sm-12 text-right">
                            <input type="button" class="btn btn-primary" id="Edit" value="修改" onclick="window.location.href='editForm.asp?ID=<%=ID%>'">
                        </div>
                    </div>
                </div>
                <%End If%>
            </div>
        </div>

        <script src="js/jquery-1.11.0.js" type="text/javascript" charset="utf-8"></script>
        <script src="plugins/bootstrap/js/bootstrap.min.js" type="text/javascript" charset="utf-8"></script>
        <script src="js/common.js"></script>
        <script type="text/javascript">
            //button提交事件
            function doPostBack(formObj, actionFile){
                formObj.action = actionFile;
                formObj.submit();
            }
        </script>
    </body>

</html>