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
        <title>前端开发需求单 - 修改表单</title>
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
            <%
            Select Case Action
                '表单过程
                Case "AddForm"
                Call AdminFlagMsg_Add()
                Call AddForm()
                Case "EditForm"
                Call AdminFlagMsg_Edit()
                Call EditForm()
                Case "ViewForm"
                Call AdminFlagMsg_Edit()
                Call ViewForm()
                '存储过程
                Case "Save"
                Call AdminFlagMsg_Add()
                Call SaveData()
                Case "Insert"
                Call AdminFlagMsg_Add()
                Call InsertFileList()
                Case "Edit"
                Call AdminFlagMsg_Edit()
                Call EditData()
                Case "View"
                Call AdminFlagMsg_Edit()
                Call ViewData()
                Case "DelAll"
                Call AdminFlagMsg_Edit()
                Call DelData()
                Case "Finished"
                Call AdminFlagMsg_Edit()
                Call Finished()
                Case Else
                Call AddForm()
            End Select
            '主体内容
            Sub AddForm()
            %>
            <div class="panel panel-default panel-form">
                <form id="mainForm" name="mainForm" method="post">
                    <div class="panel-heading no-padding">
                        <h4 class="bg-primary form-group form-group-flex vertical clear-text padding no-margin">
                            <i class="glyphicon glyphicon-th-list"></i>
                            <div class="col margin-left">
                                <input type="text" class="form-control field-input" id="Title" name="Title" placeholder="请输入项目名称" value="<%=Title%>">
                                <i class="clear-text-btn glyphicon glyphicon-remove-sign invisible"></i>
                            </div>
                        </h4>
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-md-6 col-sm-12 form-group form-group-flex vertical clear-text">
                                <label class="control-label" for="ProductManager">产品经理：</label>
                                <div class="col">
                                    <input type="text" class="form-control field-input" id="ProductManager" name="ProductManager">
                                    <i class="clear-text-btn glyphicon glyphicon-remove-sign invisible"></i>
                                </div>
                            </div>
                            <div class="col-md-6 col-sm-12 form-group form-group-flex vertical clear-text">
                                <label class="control-label" for="Designer">设计师：</label>
                                <div class="col">
                                    <input type="text" class="form-control field-input" id="Designer" name="Designer">
                                    <i class="clear-text-btn glyphicon glyphicon-remove-sign invisible"></i>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 col-sm-12 form-group form-group-flex vertical clear-text">
                                <label class="control-label" for="FrontEnd">前端开发：</label>
                                <div class="col">
                                    <input type="text" class="form-control field-input" id="FrontEnd" name="FrontEnd">
                                    <i class="clear-text-btn glyphicon glyphicon-remove-sign invisible"></i>
                                </div>
                            </div>
                            <div class="col-md-6 col-sm-12 form-group form-group-flex vertical clear-text">
                                <label class="control-label" for="Developer">后台开发：</label>
                                <div class="col">
                                    <input type="text" class="form-control field-input" id="Developer" name="Developer">
                                    <i class="clear-text-btn glyphicon glyphicon-remove-sign invisible"></i>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12 form-group form-group-flex vertical clear-text">
                                <label class="control-label" for="SVNURL">SVN地址：</label>
                                <div class="col">
                                    <input type="text" class="form-control field-input" id="SVNURL" name="SVNURL">
                                    <i class="clear-text-btn glyphicon glyphicon-remove-sign invisible"></i>
                                </div>
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
                                <div class="col">
                                    <label class="checkbox-inline">
                                        <input type="checkbox" name="BrowserPC" id="BrowserPC1" value="IE7">IE7
                                    </label>
                                    <label class="checkbox-inline">
                                        <input type="checkbox" name="BrowserPC" id="BrowserPC2" value="IE8">IE8
                                    </label>
                                    <label class="checkbox-inline">
                                        <input type="checkbox" name="BrowserPC" id="BrowserPC3" value="IE9+">IE9+
                                    </label>
                                </div>
                            </div>
                            <div class="col-md-8 col-sm-12 form-group form-group-flex">
                                <label class="control-label" for="BrowserMobi">移动端：</label>
                                <div class="col">
                                    <div>
                                        <label class="checkbox-inline">
                                            <input type="checkbox" name="BrowserMobi" id="BrowserMobi1" value="Android4.0">Android4.0
                                        </label>
                                        <label class="checkbox-inline">
                                            <input type="checkbox" name="BrowserMobi" id="BrowserMobi2" value="Android5.0">Android5.0
                                        </label>
                                        <label class="checkbox-inline">
                                            <input type="checkbox" name="BrowserMobi" id="BrowserMobi3" value="Android6.0">Android6.0
                                        </label>
                                        <label class="checkbox-inline">
                                            <input type="checkbox" name="BrowserMobi" id="BrowserMobi4" value="Android7.0">Android7.0
                                        </label>
                                    </div>
                                    <div>
                                        <label class="checkbox-inline">
                                            <input type="checkbox" name="BrowserMobi" id="BrowserMobi5" value="iOS7">iOS7
                                        </label>
                                        <label class="checkbox-inline">
                                            <input type="checkbox" name="BrowserMobi" id="BrowserMobi6" value="iOS8">iOS8
                                        </label>
                                        <label class="checkbox-inline">
                                            <input type="checkbox" name="BrowserMobi" id="BrowserMobi7" value="iOS9">iOS9
                                        </label>
                                        <label class="checkbox-inline">
                                            <input type="checkbox" name="BrowserMobi" id="BrowserMobi8" value="iOS10">iOS10
                                        </label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12 form-group form-group-flex vertical clear-text">
                                <label class="control-label" for="Cycle">项目周期：</label>
                                <div class="col">
                                    <input class="form-control" type="text" id="Cycle" name="Cycle" placeholder="2015-02-10 至 2015-02-10" autocomplete="off" readonly>
                                    <i class="clear-text-btn glyphicon glyphicon-remove-sign invisible"></i>
                                </div>
                            </div>
                        </div>
                        <div class="row no-border">
                            <div class="col-sm-12 form-group form-group-flex vertical">
                                <label class="control-label">页面交互与逻辑：</label>
                                <div class="col">
                                     <%Call UpLoadFiler()%>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12 form-group form-group-flex vertical">
                                <label class="control-label"></label>
                                <div id="FileList" class="col alert-group"><%Call ShowFileList(ID)%></div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12 form-group form-group-flex">
                                <label class="control-label" for="Direction">需求说明：</label>
                                <div class="col">
                                    <%Call HtmlEditor("Direction",Direction)%>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="panel-footer">
                        <div class="row">
                            <div class="col-sm-6">
                                <input type="reset" class="btn btn-danger" id="Reset" value="清空">
                                <input type="button" class="btn btn-info" id="Save" value="保存">
                            </div>
                            <%If S_IsState <> 1 Then%>
                            <div class="col-sm-6 text-right">
                                <input type="button" class="btn btn-primary" id="Finished" value="任务完成">
                            </div>
                            <%End If%>
                        </div>
                    </div>
                </form>
            </div>
            <%
            End Sub
            %>
        </div>

        <%
        '添加
        Sub SaveData()
            '检查表单数据的合法性
            If ChkForbiddenWords(ForbiddenWords,Title)=False Then
                Response.Write "<script>alert('项目名称不能为空且不能含有非法字符！');history.go(-1);</script>"
                Exit Sub
            End If
            Set Rs=server.CreateObject("adodb.recordset")
            Sql="Select * from LQ_Requirement where Title='"&Title&"'"
            Rs.Open Sql,Conn,1,3
            If Not(Rs.eof And Rs.bof) Then
                Rs("Title") = Title
                Rs("ProductManager") = ProductManager
                Rs("Designer") = Designer
                Rs("FrontEnd") = FrontEnd
                Rs("Developer") = Developer
                Rs("SVNURL") = SVNURL
                Rs("BrowserPC") = BrowserPC
                Rs("BrowserMobi") = BrowserMobi
                Rs("Cycle") = Cycle
                Rs("Direction") = Direction
                Rs("IsShow") = 1
                Rs("IsTop") = 0
                Rs.Update
                Call RsClose(Rs)
                '插入文件列表
                Call InsertFileList()
                Call ConnClose(Conn)
                Response.Write "<script>alert('添加成功');history.go(-1);</script>"
            End If
        End Sub
        '循环插入文件列表
        Sub InsertFileList()
            Dim i,FileListParentID
            FileListParentID = Conn.ExeCute("select ID,Title from LQ_Requirement where Title='"&Trim(Request.Form("Title"))&"'")(0)
            For i = 1 To Request.Form("FileListTitle").Count
                Set Rs=server.CreateObject("adodb.recordset")
                Sql="Select * from LQ_FileList"
                Rs.Open Sql,Conn,1,3
                Rs.AddNew
                Rs("ParentID") = FileListParentID
                Rs("Title") = Request.Form("FileListTitle")(i)
                Rs("Url") = Request.Form("FileListUrl")(i)
                Rs("IsShow") = 1
                Rs.Update
                Call RsClose(Rs)
            Next
        End Sub
        '任务完成
        Sub Finished()
            '检查表单数据的合法性
            If ChkForbiddenWords(ForbiddenWords,Title)=False Then
                Response.Write "<script>alert('项目名称不能为空且不能含有非法字符！');history.go(-1);</script>"
                Exit Sub
            End If
            Set Rs=server.CreateObject("adodb.recordset")
            Sql="Select * from LQ_Requirement where Title='"&Title&"'"
            Rs.Open Sql,Conn,1,3
            If Not(Rs.eof And Rs.bof) Then
                Rs("EditDate") = EditDate
                Rs("IsState") = 1
                Rs.Update
                Call RsClose(Rs)
                Call ConnClose(Conn)
            End If
        End Sub
        %>

        <script src="js/jquery-1.11.0.js" type="text/javascript" charset="utf-8"></script>
        <script src="plugins/bootstrap/js/bootstrap.min.js" type="text/javascript" charset="utf-8"></script>
        <script src="plugins/jquery-validation/dist/jquery.validate.min.js"></script>
        <script src="plugins/jquery-validation/dist/localization/messages_zh.min.js"></script>
        <script src="plugins/bootstrap-daterangepicker-master/moment.min.js"></script>
        <script src="plugins/bootstrap-daterangepicker-master/daterangepicker.js"></script>
        <script src="js/common.js"></script>
        <script type="text/javascript">
           //关闭网页提示
           function formIsDirty(form) {
             for (var i = 0; i < form.elements.length; i++) {
               var element = form.elements[i];
               var type = element.type;
               if (type == "checkbox" || type == "radio") {
                 if (element.checked != element.defaultChecked) {
                   return true;
                 }
               }
               else if (type == "hidden" || type == "password" || type == "text" || type == "textarea") {
                 if (element.value != element.defaultValue) {
                   return true;
                 }
               }
               else if (type == "select-one" || type == "select-multiple") {
                 for (var j = 0; j < element.options.length; j++) {
                   if (element.options[j].selected != element.options[j].defaultSelected) {
                     return true;
                   }
                 }
               }
             }
             return false;
           }
           window.onbeforeunload = function (e) {
             e = e || window.event;
             if (formIsDirty(document.forms["mainForm"])) {
               // IE 和 Firefox
               if (e) {
                 e.returnValue = "对不起，页面数据已做修改，尚未保存，确定要刷新或离开本页面？";
               }
               // Safari浏览器
               return "对不起，页面数据已做修改，尚未保存，确定要刷新或离开本页面？";
             }
           };

            $(function(){
                //时间选择器
                $('#Cycle').daterangepicker({
                    timePicker: true,
                    timePickerIncrement: 30,
                    format: 'YYYY-MM-DD',
                    separator: "至"
                }, function(start, end, label) {
                    $('#Cycle').focus();
                });
                //点击选择文件
                $('#selectBtn').on("click", function(){
                    $("#file").trigger("click");
                });
                //表单验证
                var $form = $("#mainForm"); //表单名称
                var parentWrap = ".col"
                var $validator = $form.validate({
                    ignore: "",
                    rules: {
                        Title: {
                            required: true,
                            minlength: 2,
                            remote: {
                                url: "returnData.asp?AjaxAction=CheckFormTitle",     //后台处理程序
                                type: "post",               //数据发送方式
                                dataType: "text",
                                data: {                     //要传递的数据
                                    Title: function() {
                                        return $("#Title").val();
                                    }
                                }
                            }
                        },
                       ProductManager: {required: true},
                       Designer: {required: true},
                       FrontEnd: {required: true},
                       Developer: {required: true},
                       SVNURL: {required: true},
                       BrowserPC: {required: true},
                       BrowserMobi: {required: true},
                       Cycle: {required: true},
                       Direction: {required: true}
                    },
                    messages: {
                        Title: {
                            required: "请填写项目名称",
                            minlength: "最少2个字符",
                            remote: "项目名称已存在"
                        }
                    },
                    errorElement: "span",
                    errorPlacement: function (error, element) {
                        // Add the `help-block` class to the error element
                        error.addClass( "help-block" );
                        if (element.prop("type") === "checkbox") {
                            error.appendTo(element.parents(parentWrap));
                        } else {
                            error.insertAfter(element);
                        }
                    },
                    highlight: function (element, errorClass, validClass) {
                        $(element).parents(parentWrap).addClass("has-error").removeClass("has-success");
                    },
                    unhighlight: function (element, errorClass, validClass) {
                        $(element).parents(parentWrap).addClass("has-success").removeClass("has-error");
                    }
                });
                //button表单保存
                $("#Save").on("click", function(){
                    if($form.valid()) {
                        //通过表单验证
                        doPostBack(mainForm,'?Action=Save');
                    }else{
                        //校验不通过，什么都不用做，校验信息已经正常显示在表单上
                        $validator.focusInvalid();
                        return false;
                    }
                });
                //button任务完成
                $("#Finished").on("click", function(e){
                    if($form.valid()) {
                        //通过表单验证
                        doPostBack(mainForm,'?Action=Finished');
                    }else{
                        //校验不通过，什么都不用做，校验信息已经正常显示在表单上
                        $validator.focusInvalid();
                        return false;
                    }
                 });
                //button表单重置
                $("#Reset").click(function(){
                    $validator.resetForm();
                    $form.find(parentWrap).removeClass("has-error has-success");
                    $form.find(".clear-text-btn").addClass("invisible");
                 });
            });
            //button提交事件
            function doPostBack(formObj, actionFile){
                formObj.action = actionFile;
                formObj.submit();
            }
        </script>
    </body>

</html>