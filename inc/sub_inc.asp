<%
'******************************
'功能：显示数据库中表名、字段名
'******************************
Sub ShowAllFields(T,F)
Dim Rs_Table,Rs_Fields
Set Rs_Table=Conn.OpenSchema(20)
Do Until Rs_Table.EOF
If Rs_Table(3)="TABLE" Then
response.write "表名:"&Rs_Table(2)&"<br />"
Set Rs_Fields=server.CreateObject("adodb.recordset")
Sql="select * from ["&Rs_Table(2)&"]"
response.write Sql&"<br />"
Set Rs_Fields=Conn.execute(Sql)
response.write "字段名:"
str=""
For i=0 To Rs_Fields.fields.count-1
str=str&Rs_Fields.fields(i).name&","
Next
response.write left(str,len(str)-1)
response.write "<br />"
End If
Rs_Table.MoveNext
Loop
Set Rs_Table=Nothing
Set Conn=Nothing
End Sub
'******************************
'文章附加属性
'******************************
'显示
Sub InfoLabel(Byval Label_s,Byval Label_z,Byval Label_d,Byval Label_j,Byval Label_h,Byval Label_t,Byval Label_l)
if Label_s="s" then
if Rs("IfShow")<>0 then
response.write "<strong class='red' title='已审核文章'>审</strong>&nbsp;"
Else
response.write "审&nbsp;"
end If
end If
if Label_z="z" then
Response.Write ""
end If
if Label_d="d" then
if Rs("IfTop")<>0 then
response.write "<strong class='red' title='置顶文章'>顶</strong>&nbsp;"
Else
response.write "顶&nbsp;"
end If
end If
if Label_j="j" then
if Rs("IfHot")<>0 then
response.write "<strong class='red' title='推荐文章'>荐</strong>&nbsp;"
Else
response.write "荐&nbsp;"
end If
end If
if Label_h="h" Then
	If CheckFields("IfSlide","LQ_"&MyFileName&"")=True Then
		If Rs("IfSlide")<>0 Then
		response.write "<a href='"&CheckCorrectPath(Rs("Picture"))&"' title='幻灯' target='_blank'><strong class='red' title='幻灯'>幻</strong></a>&nbsp;"
		Else
		response.write "幻&nbsp;"
		end If
	end If
end If
if Label_t="t" Then
	If CheckFields("Picture","LQ_"&MyFileName&"")=True Then
		If Rs("Picture")<>"" Then
		response.write "<a href='"&CheckCorrectPath(Rs("Picture"))&"' title='有图片的文章' target='_blank'><strong class='red' title='有图片的文章'>图</strong></a>&nbsp;"
		Else
		response.write "图&nbsp;"
		end If
	end If
end If
if Label_l="l" then
if Rs("UseLinkUrl")<>0 Then
response.write "<a href="&Rs("LinkUrl")&" title='转向链接' target='_blank'><strong class='red'>链</strong></a>"
Else
response.write "链"
end If
end If
End Sub
'添加
Sub AddInfoLabel(Byval Label_s,Byval Label_z,Byval Label_d,Byval Label_j,Byval Label_h,Byval Label_t,Byval Label_l)
if Label_s="s" then
Response.write "<input style=""border:none;"" type=""checkbox"" Name=""IfShow"" id=""IfShow"" value=""1"" "
If IsShow=1 Then
Response.Write " Checked=""Checked"""
End If
Response.write " /><label for=""IfShow"">审核</label>&nbsp;"
end If
if Label_z="z" then
Response.write "<input style=""border:none;"" type=""checkbox"" Name=""LabelType"" id=""LabelType"" value=""1"" />"
Response.write "<label for=""LabelType"">专题</label>&nbsp;"
end If
if Label_d="d" then
Response.write "<input style=""border:none;"" type=""checkbox"" Name=""IfTop"" id=""IfTop"" value=""1"" />"
Response.write "<label for=""IfTop"">置顶</label>&nbsp;"
end If
if Label_j="j" then
Response.write "<input style=""border:none;"" type=""checkbox"" Name=""IfHot"" id=""IfHot"" value=""1"" />"
Response.write "<label for=""IfHot"">推荐</label>&nbsp;"
end If
if Label_h="h" Then
'Response.write "<input style=""border:none;"" type=""checkbox"" Name=""IfSlide"" id=""IfSlide"" value=""1"" />"
'Response.write "<label for=""IfSlide"">幻灯</label>&nbsp;"
end If
if Label_t="t" then
Response.write ""
end If
if Label_l="l" then
Response.write "<input style=""border:none;"" type=""checkbox"" Name=""UseLinkUrl"" id=""UseLinkUrl"" value=""1"" />"
Response.write "<label for=""UseLinkUrl"">转向链接</label>&nbsp;"
end If
End Sub
'修改
Sub EditInfoLabel(Byval Label_s,Byval Label_z,Byval Label_d,Byval Label_j,Byval Label_h,Byval Label_t,Byval Label_l)
if Label_s="s" then
Response.write "<input style=""border:none;"" type=""checkbox"" Name=""IfShow"" id=""IfShow"" value=""1"" "
if Rs("IfShow")=1 Then
Response.Write "Checked=""Checked"""
end if
Response.write "/><label for=""IfShow"">审核</label>&nbsp;"
end If
if Label_z="z" then
Response.write ""
end If
if Label_d="d" then
Response.write "<input style=""border:none;"" type=""checkbox"" Name=""IfTop"" id=""IfTop"" value=""1"" "
if Rs("IfTop")=1 Then
Response.Write "Checked=""Checked"""
end if
Response.write "/><label for=""IfTop"">置顶</label>&nbsp;"
end If
if Label_j="j" then
Response.write "<input style=""border:none;"" type=""checkbox"" Name=""IfHot"" id=""IfHot"" value=""1"" "
if Rs("IfHot")=1 Then
Response.Write "Checked=""Checked"""
end if
Response.write "/><label for=""IfHot"">推荐</label>&nbsp;"
end If
if Label_h="h" Then
'Response.write "<input style=""border:none;"" type=""checkbox"" Name=""IfSlide"" id=""IfSlide"" value=""1"" "
'if Rs("IfSlide")=1 Then
'Response.Write "Checked=""Checked"""
'end if
'Response.write "/><label for=""IfSlide"">幻灯</label>&nbsp;"
end If
if Label_t="t" then
Response.write ""
end If
if Label_l="l" then
Response.write "<input style=""border:none;"" type=""checkbox"" Name=""UseLinkUrl"" id=""UseLinkUrl"" value=""1"" "
if Rs("UseLinkUrl")=1 Then
Response.Write "Checked=""Checked"""
end if
Response.write "/><label for=""UseLinkUrl"">转向链接</label>&nbsp;"
end If
End Sub
'******************************
'信息附加属性
Sub SelectAndinvert()
'response.write "<input type='button' class='btn' value='全选' name='chkAll' id='chkAll' />&nbsp;<input type='button' class='btn' value='反选' name='invert' id='invert' />&nbsp;<input type='button' class='btn' value='全不选' name='unchkAll' id='unchkAll' />"
response.write "<a href='javascript:;' id='chkAll'>全选</a>&nbsp;<a href='javascript:;' id='unchkAll'>取消选择</a>&nbsp;<a href='javascript:;' id='invert'>反选</a>"
End Sub
'****************************************************
'过程名：LoginError_Msg
'作  用：显示错误提示信息
'参  数：ErrMsg
'****************************************************
'错误提示
sub LoginError_Msg(ErrMsg)
Response.Write "<div class='err_bg'>"& vbCrLf
Response.Write "<div class='err_icon'><input class=""btn"" type=""submit"" value=""返 回"" onclick=""top.window.location.href='" & Request.ServerVariables("HTTP_REFERER") & "';"" /></div>"& vbCrLf
Response.Write "<div class='msg_containter'><ul>"& vbCrLf
Response.Write "<li class='blue'>※&nbsp;系统提示：</li>" & ErrMsg &""& vbCrLf
Response.Write "</ul></div></div></div>"& vbCrLf
end Sub
'****************************************************
'过程名：sSucceed_Msg
'作  用：显示成功提示信息
'参  数：SucceedMsg
'****************************************************
Sub sSucceed_Msg(SucceedMsg)
Response.Write("<div class=""info_containter"">")
Response.Write("<div class=""title"">")
Response.Write("<strong class=""succeed_title"">网站提示信息</strong>")
Response.Write("</div>")
Response.Write("<div class=""content"">")
Response.Write("<strong style=""color:#006600;"">信息："&SucceedMsg&"</strong>")
Response.Write("</div>")
Response.Write("<div class=""actions"">")
Response.Write("<a href=""javascript:onclick=history.go(-1)"">返回上一步</a>")
Response.Write("<a href=""logout.asp"" target=""_top"">安全退出</a>")
Response.Write("</div>")
Response.Write("</div>")
End Sub
'****************************************************
'过程名：sError_Msg
'作  用：显示错误提示信息
'参  数：ErrMsg
'****************************************************
Sub sError_Msg(ErrMsg)
Response.Write("<div class=""info_containter"">")
Response.Write("<div class=""title"">")
Response.Write("<strong class=""error_title"">网站提示信息</strong>")
Response.Write("</div>")
Response.Write("<div class=""content"">")
Response.Write("<strong style=""color:#cc3333;"">信息："&ErrMsg&"</strong>")
Response.Write("</div>")
Response.Write("<div class=""actions"">")
Response.Write("<a href=""javascript:onclick=history.go(-1)"">返回上一步</a>")
Response.Write("<a href=""logout.asp"" target=""_top"">安全退出</a>")
Response.Write("</div>")
Response.Write("</div>")
End Sub
'****************************************************
'过程名：Succeed_Msg
'作  用：显示成功提示信息
'参  数：无
'****************************************************
Sub Succeed_Msg(SucMsg,Add,Edit,Del,View,List)
Response.Write("<div class=""info_containter"">")
Response.Write("<div class=""title"">")
Response.Write("<strong class=""succeed_title"">网站提示信息</strong>")
Response.Write("</div>")
Response.Write("<div class=""content"">")
Response.Write("<strong style=""color:#006600;"">信息："&SucMsg&"</strong>")
Response.Write("</div>")
Response.Write("<div class=""actions"">")
Response.Write("<a href=""javascript:onclick=history.go(-1)"">返回上一步</a>")
If Add<>"NO" Then
Response.Write("<a href="""&Add&""">继续添加</a>")
End If
If Edit<>"NO" Then
Response.Write("<a href="""&Edit&""">修改</a>")
End If
If Del<>"NO" Then
Response.Write("<a href="""&Del&""">删除</a>")
End If
If View<>"NO" Then
Response.Write("<a href="""&View&""">预览</a>")
End If
If List<>"NO" Then
Response.Write("<a href="""&List&""">转到列表页</a>")
End If
Response.Write("</div>")
Response.Write("</div>")
End Sub
'***************************************************
'返回消息
'***************************************************
Sub Alert(ByVal Message,ByVal GoUrl)
Message = Replace(Message,"'","\'")
Response.Write ("<script type='text/javascript'>")
Response.Write ("$(function(){")
If GoUrl="-1" Then
Response.Write ("Boxy.alert('"&Message&"',function(){history.go(-1);},{closeable:true,title:'提示信息'});return false;")
ElseIf GoUrl="0" Then
Response.Write ("Boxy.alert('"&Message&"',function(){location.reload();},{closeable:true,title:'提示信息'});return false;")
ElseIf GoUrl="-2" Then
Response.Write ("Boxy.alert('"&Message&"',function(){history.go(-2);},{closeable:true,title:'提示信息'})return false;")
Else
Response.Write ("Boxy.alert('"&Message&"',function(){location.href='"&GoUrl&"';},{closeable:true,title:'提示信息'});return false;")
End If
Response.Write ("});")
Response.Write ("</script>")
End Sub
'***************************************************
'文章列表样式下拉列表
'Call ShowLabelType_Option(文本框名称，专题序号)
'******************************
Sub ShowLabelType_Option(Byval s_CIDName,Byval CurrentOrders)
Response.Write "<select name='"&s_CIDName&"' id='"&s_CIDName&"'>"
Dim RsLT,iLT
set RsLT=server.CreateObject("adodb.recordset")
Sql="select * From LQ_LabelType where IfShow=1 order by Orders Asc"
RsLT.open Sql,conn,1,1
if RsLT.EOF and RsLT.BOF then
Response.Write "<option value="""">请先添加文章列表样式</option>"
Else
iLT=0
Response.Write "<option value=""0"">请选择文章列表样式</option>"
do while not RsLT.EOF
iLT=iLT+1
Response.Write "<option value="""&Int(RsLT("Orders"))&""""
If Trim(cstr(CurrentOrders))=cstr(RsLT("Orders")) then
Response.Write " Selected=""Selected"""
end If
Response.Write ">"&Trim(RsLT("Title"))&""
Response.Write "</option>"
RsLT.MoveNext
Loop
end If
RsLT.Close
Set RsLT=Nothing
Response.Write "</select>"
End Sub
'***************************************************
'显示数组下拉列表
'Call ShowDropDownList_Option(选择框Name,选择框ID,当前值,数组值,数组文本,默认空值的名称,选择框事件)
'******************************
Sub ShowDropDownList_Option(Byval s_CName,Byval s_CID,Byval CurrentIDValue,Byval arrCIDValue,Byval arrText,Byval s_Name,Byval s_Event)
If IsNull(arrCIDValue) Then Exit Sub
If IsNull(arrText) Then Exit Sub
Response.Write ("<select name='"&s_CName&"' id='"&s_CID&"'"&s_Event&">") & vbCrLf
Response.Write ("<option value=''>请选择"&s_Name&"</option>") & vbCrLf
Dim i,tarrText,tarrCIDValue
tarrText = Split(arrText,",")
tarrCIDValue = Split(arrCIDValue,",")
For i = 0 To Ubound(tarrText)
Response.Write ("<option value='"&tarrCIDValue(i)&"'")
If CurrentIDValue<>"NO" Then
If Trim(CurrentIDValue)=Trim(tarrCIDValue(i)) then
Response.Write (" Selected='Selected'")
End If
End If
Response.Write (">"&tarrText(i)&"")
Response.Write ("</option>") & vbCrLf
Next
Response.Write ("</select>")
End Sub
'***************************************************
'显示数组下拉列表符合条件的值
'Call ShowDropDownList_Value()
'******************************
Sub ShowDropDownList_Value(Byval CurrentIDValue,Byval arrCIDValue,Byval arrText,Byval Result)
If IsNull(arrCIDValue) Then Exit Sub
If IsNull(arrText) Then Exit Sub
Dim i,tarrText,tarrCIDValue
tarrText = Split(arrText,",")
tarrCIDValue = Split(arrCIDValue,",")
For i = 0 To Ubound(tarrCIDValue)
If Trim(CurrentIDValue)=Trim(tarrCIDValue(i)) then
	If Result=1 Then
	Response.Write (tarrText(i))
	Else
	Response.Write (tarrCIDValue(i))
	End If
End If
Next
End Sub
'***************************************************
'显示上传表单
'Call ShowUpLoadForm(框架名,iframeName,iptName,upPath,upFiled,UV_fn,inputName)
'******************************
Sub ShowUpLoadForm(Byval iframeName,Byval UV_formsName,Byval UV_upPath,Byval UV_upFiled,Byval UV_fn,Byval inputName)
Response.Write ("<iframe name='"&iframeName&"' id='"&iframeName&"' frameborder='0' width='100%' height='30' scrolling='no' ")
Response.Write ("src='upload.asp?formsName="&UV_formsName&"&upPath="&UV_upPath&"&fn="&UV_fn&"&iptName="&inputName&"'")
Response.Write (">")
Response.Write ("</iframe>")
Response.Write ("<input name='"&inputName&"' id='"&inputName&"' type='text' class='ipt' style='display:none;' size='50'")
If UV_upFiled<>"NO" Then
Response.Write (" value='"&UV_upFiled&"'")
End If
Response.Write (" />")
End Sub
'***************************************************
'删除指定日期前的数据
'***************************************************
Sub DelDimDayData()
set Str_db=server.CreateObject("adodb.connection")
Str_db.open"provider=microsoft.jet.oledb.4.0;data source="&server.mappath(DataBaseNameLog)
Str_db.Execute("delete * from LQ_SQLIn where SqlIn_TIME < #"&dateadd("d", -7, now)&"# ")
Str_db.close
Set Str_db = Nothing
End Sub
'***************************************************
'函数名：HtmlEditor
'作用：调用html编辑器
'参数：strid ----文本框的ID
'返回值：空----"Content"
' 不空 ----strid
'***************************************************
Sub HtmlEditor(ByVal e_Name,ByVal e_Value)
Dim m_Folder
m_Folder="kindeditor"
Response.Write ("<link href='"&CheckCorrectPath(m_Folder)&"/themes/default/default.css' rel='stylesheet' type='text/css' />") & vbCrLf
Response.Write ("<link href='"&CheckCorrectPath(m_Folder)&"/plugins/code/prettify.css' rel='stylesheet' type='text/css' />")& vbCrLf
Response.Write ("<script src='"&CheckCorrectPath(m_Folder)&"/kindeditor.js' charset='utf-8'></script>")& vbCrLf
Response.Write ("<script src='"&CheckCorrectPath(m_Folder)&"/lang/zh_CN.js' charset='utf-8'></script>")& vbCrLf
Response.Write ("<script src='"&CheckCorrectPath(m_Folder)&"/plugins/code/prettify.js' charset='utf-8'></script>")& vbCrLf
Response.Write ("<script type='text/javascript'>")& vbCrLf
Response.Write ("KindEditor.ready(function(K) {")& vbCrLf
Response.Write ("var editor1 = K.create('textarea[name="""&e_Name&"""]', {")& vbCrLf
Response.Write ("cssPath : '"&CheckCorrectPath(m_Folder)&"/plugins/code/prettify.css',")& vbCrLf
Response.Write ("uploadJson : '"&CheckCorrectPath(m_Folder)&"/asp/upload_json.asp',")& vbCrLf
Response.Write ("fileManagerJson : '"&CheckCorrectPath(m_Folder)&"/asp/file_manager_json.asp',")& vbCrLf
Response.Write ("allowFileManager : true,")& vbCrLf
Response.Write ("resizeType : 1,")& vbCrLf
Response.Write ("items : ['source', 'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline','removeformat', '|', 'justifyleft', 'justifycenter','justifyright', 'insertorderedlist','insertunorderedlist', '|', 'emoticons', 'image', 'link'],")& vbCrLf
Response.Write ("afterCreate : function() {")& vbCrLf
Response.Write ("var self = this;")& vbCrLf
Response.Write ("K.ctrl(document, 13, function() {")& vbCrLf
Response.Write ("self.sync();")& vbCrLf
Response.Write ("K('form[name=mainForm]')[0].submit();")& vbCrLf
Response.Write ("});")& vbCrLf
Response.Write ("K.ctrl(self.edit.doc, 13, function() {")& vbCrLf
Response.Write ("self.sync();")& vbCrLf
Response.Write ("K('form[name=mainForm]')[0].submit();")& vbCrLf
Response.Write ("});")& vbCrLf
Response.Write ("},")& vbCrLf
Response.Write ("afterBlur: function() {")& vbCrLf
Response.Write ("var self = this;")& vbCrLf
Response.Write ("self.sync();")& vbCrLf
Response.Write ("}")& vbCrLf
Response.Write ("});")& vbCrLf
Response.Write ("prettyPrint();")& vbCrLf
Response.Write ("});")& vbCrLf
Response.Write ("</script>")& vbCrLf
Response.Write ("<textarea style='visibility:hidden;width:100%;height:200px;' name='"&e_Name&"' id='"&e_Name&"'>"&HTMLEncodes(e_Value)&"</textarea>")
End Sub
'***************************************************
'函数名：HtmlEditor
'作用：调用html编辑器
'参数：strid ----文本框的ID
'返回值：空----"Content"
' 不空 ----strid
'***************************************************
Sub UpLoadFiler()
Dim m_Folder
m_Folder="kindeditor"
%>
<script src='<%=CheckCorrectPath(m_Folder)%>/kindeditor.js' charset='utf-8'></script>
<script src='<%=CheckCorrectPath(m_Folder)%>/lang/zh_CN.js' charset='utf-8'></script>
<script src='<%=CheckCorrectPath(m_Folder)%>/plugins/code/prettify.js' charset='utf-8'></script>
<script type='text/javascript'>
KindEditor.ready(function(K) {
    if (K('#FileList>.alert').index() < 0){
    	var index = 0;
    }
	var editor = K.editor({
		cssPath : '<%=CheckCorrectPath(m_Folder)%>/plugins/code/prettify.css',
		uploadJson : '<%=CheckCorrectPath(m_Folder)%>/asp/upload_json.asp',
		fileManagerJson : '<%=CheckCorrectPath(m_Folder)%>/asp/file_manager_json.asp',
		allowFileManager : true
	});
    K('#uploadBtn').click(function() {
        editor.loadPlugin('insertfile', function() {
            editor.plugin.fileDialog({
                clickFn : function(url, title) {
                    var _list = "<div id='alert"+index+"' class='alert alert-default alert-dismissible' role='alert'>";
                        _list += "<button type='button' class='close' data-dismiss='alert' aria-label='Close'><span aria-hidden='true'>&times;</span></button>";
                        _list += "<a href='"+url+"' class='alert-link' title='点击下载'><span>"+title+"</span> <i class='glyphicon glyphicon-download-alt'></i></a>";
                        _list += "<input type='hidden' name='FileListTitle' value='"+title+"'>";
                        _list += "<input type='hidden' name='FileListUrl' value='"+url+"'>";
                        _list += "</div>";
                        index++;
                    K('#FileList').append(_list);
                    editor.hideDialog();
                }
            });
        });
    });
});
</script>
<button class='btn btn-primary' type='button' id='uploadBtn' name='uploadBtn'>上传文件</button>
<%
End Sub
%>
