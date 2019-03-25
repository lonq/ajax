<!--#include file="inc/conn.asp"-->
<!--#include file="inc/config.asp"-->
<!--#include file="inc/function.asp"-->
<!--#include file="inc/Upload_class.inc"--><%
'页面名称
Dim MyFileName,ItemName
MyFileName="Upload"
ItemName="无组件上传"
'自定义变量
Dim formsName,iptName,upPath,fn,upFiled
formsName=Request("formsName")
iptName=Request("iptName")
'upPath=Request("upPath")
upPath="/ajax/uploadfiles"
fn=Request("fn")
upFiled=Request("upFiled")

if lcase(request.ServerVariables("REQUEST_METHOD"))="post" then
	Dim upload
	set upload = new AnUpLoad
	upload.Exe = sExe
	upload.MaxSize = sMaxSize
	upload.GetData()
	if upload.ErrorID>0 then
		response.Write upload.Description
	else
		dim file,savpath
		savepath = CheckCorrectPath(upPath&"/")
		set file = upload.files("fileuplaod")
		if file.isfile Then
			result = file.saveToFile(savepath,true)
			if result then
				msg = savepath & file.filename
			else
				msg = file.Exception
			end if
		end if
	end if
	set upload = nothing
		If msg<>"" Then
			
		End If
end if
%>