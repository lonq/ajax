<%
Const Btn_First="‹‹"  '定义第一页按钮显示样式
Const Btn_Prev="‹"  '定义前一页按钮显示样式
Const Btn_Next="›"  '定义Next按钮显示样式
Const Btn_Last="››"  '定义最后一页按钮显示样式
Const XD_Align="right"     '定义分页信息对齐方式
Const XD_Width="100%"     '定义分页信息框大小
'开始翻页类
Class XDownPage
Private XD_PageCount,XD_Conn,XD_Rs,XD_SQL,XD_PageSize,Str_errors,int_curpage,str_URL,int_totalPage,int_totalRecord,XD_sURL
'=================================================================
'PageSize 属性
'设置每一页的分页大小
'=================================================================
Public Property Let PageSize(int_PageSize)
If IsNumeric(Int_Pagesize) Then
XD_PageSize=CLng(int_PageSize)
Else
str_error=str_error & "PageSize的参数不正确"
ShowError()
End If
End Property
Public Property Get PageSize
If XD_PageSize="" or (not(IsNumeric(XD_PageSize))) Then
PageSize=10
Else
PageSize=XD_PageSize
End If
End Property
'=================================================================
'GetRS 属性
'返回分页后的记录集
'=================================================================
Public Property Get GetRs()
Set XD_Rs=Server.createobject("adodb.recordset")
XD_Rs.PageSize=PageSize
XD_Rs.Open XD_SQL,XD_Conn,1,1
If not(XD_Rs.eof and XD_RS.BOF) Then
If int_curpage>XD_RS.PageCount Then
int_curpage=XD_RS.PageCount
End If
XD_Rs.AbsolutePage=int_curpage
End If
Set GetRs=XD_RS
End Property
'================================================================
'GetConn  得到数据库连接
'
'================================================================
Public Property Let GetConn(obj_Conn)
Set XD_Conn=obj_Conn
End Property
'================================================================
'GetSQL   得到查询语句
'
'================================================================
Public Property Let GetSQL(str_sql)
XD_SQL=str_sql
End Property
'==================================================================
'Class_Initialize 类的初始化
'初始化当前页的值
'
'==================================================================
Private Sub Class_Initialize
'========================
'设定一些参数的黙认值
'========================
XD_PageSize=10  '设定分页的默认值为10
'========================
'获取当前面的值
'========================
If request("Page")="" Then
int_curpage=1
ElseIf not(IsNumeric(request("Page"))) Then
int_curpage=1
ElseIf CInt(Trim(request("Page")))<1 Then
int_curpage=1
Else
Int_curpage=CInt(Trim(request("Page")))
End If
End Sub
'====================================================================
'ShowPage  创建分页导航条
'有首页、前一页、Next、末页、还有数字导航
'
'====================================================================
Public Sub ShowPage()
Dim str_tmp
XD_sURL = GetUrl()
int_totalRecord=XD_RS.RecordCount
If int_totalRecord<=0 Then
str_error=str_error & "总记录数为0"
Call ShowError()
End If
If int_totalRecord="" then
int_TotalPage=1
Else
'If int_totalRecord mod PageSize =0 Then
'int_TotalPage = CLng(int_TotalRecord / XD_PageSize * -1)*-1
'Else
'int_TotalPage = CLng(int_TotalRecord / XD_PageSize * -1)*-1+1
'End If
int_TotalPage=XD_RS.pagecount
End If
If Int_curpage>int_Totalpage Then
int_curpage=int_TotalPage
End If
'==================================================================
'显示分页信息，各个模块根据自己要求更改显求位置
'==================================================================
str_tmp=ShowFirstPrv
response.write str_tmp
str_tmp=showNumBtn
response.write str_tmp
str_tmp=ShowNextLast
response.write str_tmp
'str_tmp=ShowListPage
'response.write str_tmp
str_tmp=ShowPageInfo2
response.write str_tmp
End Sub
'====================================================================
'ShowFirstPrv  显示首页、前一页
'
'
'====================================================================
Private Function ShowFirstPrv()
Dim Str_tmp,int_prvpage
If int_curpage=1 Or int_curpage=0 Then
str_tmp="<li class='disabled'><a href='javascript:;'>"&Btn_First&"</a></li>"
str_tmp=str_tmp&"<li class='disabled'><a href='javascript:;'>"&Btn_Prev & "</a></li>"
Else
int_prvpage=int_curpage-1
str_tmp="<li><a title=""First Page - Results 1 to "&PageSize&" of "&int_totalrecord&""" href="""&XD_sURL & "" & """>" & Btn_First&"</a></li>"
str_tmp=str_tmp&"<li><a title=""Prev Page - Results "&((int_prvpage-1)*PageSize)+1&" to "&int_prvpage*PageSize&" of "&int_totalrecord&""" href=""" & XD_sURL & CStr(int_prvpage) & """>" & Btn_Prev&"</a></li>"
End If
ShowFirstPrv=str_tmp
End Function
'====================================================================
'ShowNextLast  Next、末页
'
'
'====================================================================
Private Function ShowNextLast()
Dim str_tmp,int_Nextpage,n_num
If Int_curpage>=int_totalpage Then
str_tmp="<li class='disabled'><a href='javascript:;'>"&Btn_Next&"</a></li>"
str_tmp=str_tmp&"<li class='disabled'><a href='javascript:;'>"& Btn_Last & "</a></li>"
Else
Int_NextPage=int_curpage+1
If Int_NextPage*PageSize >= int_totalrecord Then
n_num=int_totalrecord
Else
n_num=Int_NextPage*PageSize
End If
str_tmp="<li><a title=""Next Page - Results "&int_curpage*PageSize+1&" to "&n_num&" of "&int_totalrecord&""" href=""" & XD_sURL & CStr(int_nextpage) & """>" &Btn_Next&"</a></li>"
str_tmp=str_tmp&"<li><a title=""Last Page - Results "&(int_totalpage*PageSize-PageSize)+1&" to "&int_totalrecord&" of "&int_totalrecord&""" href="""& XD_sURL & CStr(int_totalpage) & """>"&Btn_Last&"</a></li>"
End If
ShowNextLast=str_tmp
End Function
'====================================================================
'ShowListPage 列表导航
'
'
'====================================================================
'Private Function ShowListPage()
'	dim goi
'	If int_curpage=int_totalpage then
'		goi=int_curpage
'	else
'		goi=int_curpage+1
'	end if
'	ShowListPage=str_tmp & "<li><span id=""span1""><Input Type=text size=3 maxlength=3 value='" & goi & "' onmouseover='this.focus();this.select()' Name='PageNum' id='PageNum'><Input Type=button id=go name=go value='GO' onclick=""javascript:try{if(document.all.PageNum.value>0 && document.all.PageNum.value<=" & i & "){window.location='" &  XD_sURL & "'+document.all.PageNum.value+'';}}catch(e){}"" onmouseover='this.focus()' onfocus='this.blur()'></span></li>" & VbCrLf
'End Function
Private Function ShowListPage()
dim goi
goi=int_curpage
ShowListPage=str_tmp & "<span id=""goi""><Input title='Please enter ...' class='text' Type=text value='" & goi & "' onmouseover='this.focus();this.select()' Name='PageNum' id='PageNum'><Input title='Go to Page ...' class='button' Type=button id=go name=go value='GO' onclick=javascript:window.location='" &  XD_sURL & "'+document.all.PageNum.value+'';></span>"
End Function
'====================================================================
'ShowGoto  快速跳转
'www.laoy8.cn
'QQ：22862559
'====================================================================
Private Function ShowGoto()
dim i,str_tmp
'显示跳转菜单开始
str_tmp="<span class=""select""><select name='select' onChange='javascript:window.location.href=(this.options[this.selectedIndex].value);'>"
for i=1 to int_totalpage
str_tmp=str_tmp & "<option value=""" & XD_sURL & CStr(i) & """"
If i=int_curpage then
str_tmp=str_tmp & " selected=""selected"""
End if
str_tmp=str_tmp & ">"&i&"</option>"
next
str_tmp=str_tmp &"</select></span>"
ShowGoto=str_tmp
'显示跳转菜单结束
End Function
'====================================================================
'ShowABBR  显示省略
'====================================================================
Private Function ShowABBR()
dim i,str_tmp
'显示...开始
str_tmp="..."
ShowABBR=str_tmp
'显示...结束
End Function
'====================================================================
'ShowNumBtn  数字导航
'
'
'====================================================================
Function showNumBtn()
Dim i,str_tmp,end_page,start_page,n_num2
start_page=1
if int_curpage=0 then
str_tmp=str_tmp&"<li class='disabled'><a href='javascript:;'>0</a></li>"
else
if int_curpage>1 then
start_page=int_curpage
if (int_curpage<=5) then
start_page=1
end if
if (int_curpage>5) then
start_page=int_curpage-2
end if
end if
end_page=start_page+4
if end_page>int_totalpage then
end_page=int_totalpage
end if
For i=start_page to end_page
if i=int_totalpage then
n_num2=int_totalrecord
Else
n_num2=i*PageSize
End If
strTemp=XD_sURL & CStr(i)
if i=int_curpage then
str_tmp=str_tmp & "<li class='active' title=""Showing results "&(i-1)*PageSize+1&" to "&n_num2&" of "&int_totalrecord&""" class=""current""><a href='javascript:;'>"&i&"</a></li>"
Else
str_tmp=str_tmp & "<li><a title=""Show results "&(i-1)*PageSize+1&" to "&n_num2&" of "&int_totalrecord&""" href=""" & XD_sURL & CStr(i) & """>"&i&"</a></li>"
end if
Next
'当前页+2（总共显示5页，当前页居中）后面如果还有页面则显示省略号
If int_totalpage > 5 And int_curpage+2 < int_totalpage Then
str_tmp=str_tmp & " ... "
End If
end if
showNumBtn=str_tmp
End Function
'====================================================================
'ShowPageInfo  分页信息
'更据要求自行修改
'
'====================================================================
Private Function ShowPageInfo()
Dim str_tmp
str_tmp="<span id='goi'>Page <strong>"&int_curpage&"</strong> of "&int_totalpage&"</span>"
'str_tmp="<span>共<strong>"&int_totalrecord&"</strong>条记录 <strong>"&XD_PageSize&"</strong>条/每页</span>"
'str_tmp="<span>页次:"&int_curpage&"/"&int_totalpage&"页 共<strong><b>"&int_totalrecord&"</b></strong>条记录 "&XD_PageSize&"条/每页</span>"
ShowPageInfo=str_tmp
End Function
Private Function ShowPageInfo2()
Dim str_tmp
'str_tmp=str_tmp & "<li id='goi'>"
'str_tmp=str_tmp & "Page <script language='JavaScript' type='text/JavaScript'>function gotopage(topagevar) { var re = /^[1-9]+[0-9]*]*$/; if (!re.test(topagevar)){alert('页面数应该为正整数！');return (false);}if (topagevar>"&int_totalpage&"){alert('页面数一共才"&int_totalpage&"页，页面填写应该在1 - "&int_totalpage&"范围内！');return (false);}window.location='"&XD_sURL&"'+topagevar+''}</script><input title='Go to Page ...' class='text' type='text' id='topage' name='topage' value='"&int_curpage&"' onmouseover='this.focus();this.select()' onChange='gotopage(this.value)'> of "&int_totalpage
'str_tmp=str_tmp & " <Input title='Please enter ...' class='text' Type=text value='" & int_curpage & "' onmouseover='this.focus();this.select()' Name='PageNum' id='PageNum'><Input title='Go to Page ...' class='button' Type=button id=GO name=GO value='GO' onclick=javascript:window.location='" &  XD_sURL & "'+document.all.PageNum.value+'';>"
'str_tmp=str_tmp & "</li>"
ShowPageInfo2=str_tmp
End Function
'==================================================================
'GetURL  得到当前的URL
'更据URL参数不同，获取不同的结果
'
'==================================================================
Private Function GetURL()
Dim StrUrl,str_url,i,j,search_str,result_url
search_str="Page="
StrUrl=Request.ServerVariables("URL")
StrUrl=split(StrUrl,"/")
i=UBound(StrUrl,1)
str_url=StrUrl(i)'得到当前页文件名
str_params=Trim(Request.ServerVariables("QUERY_STRING"))
If str_params="" Then
result_url=str_url & "?Page="
Else
If InstrRev(str_params,search_str)=0 Then
result_url=str_url & "?" & str_params &"&Page="
Else
j=InstrRev(str_params,search_str)-2
If j=-1 Then
result_url=str_url & "?Page="
Else
str_params=Left(str_params,j)
result_url=str_url & "?" & str_params &"&Page="
End If
End If
End If
GetURL=result_url
End Function
'====================================================================
' 设置 Terminate 事件。
'
'====================================================================
Private Sub Class_Terminate
XD_RS.close
Set XD_RS=nothing
End Sub
'====================================================================
'ShowError  错误提示
'
'
'====================================================================
Private Sub ShowError()
If str_Error <> "" Then
Response.Write("" & str_Error & "")
Response.End
End If
End Sub
End class
%>