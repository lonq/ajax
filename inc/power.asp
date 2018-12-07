<%
'定义管理员级别名称
Sub Admin_Des()
If MyV_IsSuperAdmin=1 Then
Response.write "超级管理员"
ElseIf MyV_IsSuperAdmin=0 Then
Response.write "普通管理员"
Else
Response.write "非法操作"
End If
End Sub
'***************************************************
'总权限
Dim ListFlag,ListFlag0,ListFlag1,ListFlag2,ListFlag3,ListFlag4,ListFlag5,ListFlag6,ListFlag7,ListFlag8,ListFlag9,ListFlag10,ListFlag11,ListFlag12,ListFlag13,ListFlag14,ListFlag15,ListFlag16,ListFlag17,ListFlag18,ListFlag19,ListFlag20,ListFlag21,ListFlag22,ListFlag23,ListFlag24
ListFlag=split(MyV_ListFlag,",")
ListFlag0	=ChkNumeric(ListFlag(0))
ListFlag1	=ChkNumeric(ListFlag(1))
ListFlag2	=ChkNumeric(ListFlag(2))
ListFlag3	=ChkNumeric(ListFlag(3))
ListFlag4	=ChkNumeric(ListFlag(4))
ListFlag5	=ChkNumeric(ListFlag(5))
ListFlag6	=ChkNumeric(ListFlag(6))
ListFlag7	=ChkNumeric(ListFlag(7))
ListFlag8	=ChkNumeric(ListFlag(8))
ListFlag9	=ChkNumeric(ListFlag(9))
ListFlag10	=ChkNumeric(ListFlag(10))
ListFlag11	=ChkNumeric(ListFlag(11))
ListFlag12	=ChkNumeric(ListFlag(12))
ListFlag13	=ChkNumeric(ListFlag(13))
ListFlag14	=ChkNumeric(ListFlag(14))
ListFlag15	=ChkNumeric(ListFlag(15))
ListFlag16	=ChkNumeric(ListFlag(16))
ListFlag17	=ChkNumeric(ListFlag(17))
ListFlag18	=ChkNumeric(ListFlag(18))
ListFlag19	=ChkNumeric(ListFlag(19))
ListFlag20	=ChkNumeric(ListFlag(20))
ListFlag21	=ChkNumeric(ListFlag(21))
ListFlag22	=ChkNumeric(ListFlag(22))
ListFlag23	=ChkNumeric(ListFlag(23))
ListFlag24	=ChkNumeric(ListFlag(24))
'每个栏目下的具体权限
Dim AdminFlag,AdminFlag0,AdminFlag1,AdminFlag2,AdminFlag3,AdminFlag4,AdminFlag5,AdminFlag6,AdminFlag7,AdminFlag8,AdminFlag9,AdminFlag10,AdminFlag11,AdminFlag12,AdminFlag13,AdminFlag14,AdminFlag15,AdminFlag16,AdminFlag17,AdminFlag18,AdminFlag19,AdminFlag20,AdminFlag21,AdminFlag22,AdminFlag23,AdminFlag24
AdminFlag=split(MyV_AdminFlag,",")
AdminFlag0	=ChkNumeric(AdminFlag(0))
AdminFlag1	=ChkNumeric(AdminFlag(1))
AdminFlag2	=ChkNumeric(AdminFlag(2))
AdminFlag3	=ChkNumeric(AdminFlag(3))
AdminFlag4	=ChkNumeric(AdminFlag(4))
AdminFlag5	=ChkNumeric(AdminFlag(5))
AdminFlag6	=ChkNumeric(AdminFlag(6))
AdminFlag7	=ChkNumeric(AdminFlag(7))
AdminFlag8	=ChkNumeric(AdminFlag(8))
AdminFlag9	=ChkNumeric(AdminFlag(9))
AdminFlag10	=ChkNumeric(AdminFlag(10))
AdminFlag11	=ChkNumeric(AdminFlag(11))
AdminFlag12	=ChkNumeric(AdminFlag(12))
AdminFlag13	=ChkNumeric(AdminFlag(13))
AdminFlag14	=ChkNumeric(AdminFlag(14))
AdminFlag15	=ChkNumeric(AdminFlag(15))
AdminFlag16	=ChkNumeric(AdminFlag(16))
AdminFlag17	=ChkNumeric(AdminFlag(17))
AdminFlag18	=ChkNumeric(AdminFlag(18))
AdminFlag19	=ChkNumeric(AdminFlag(19))
AdminFlag20	=ChkNumeric(AdminFlag(20))
AdminFlag21	=ChkNumeric(AdminFlag(21))
AdminFlag22	=ChkNumeric(AdminFlag(22))
AdminFlag23	=ChkNumeric(AdminFlag(23))
AdminFlag24	=ChkNumeric(AdminFlag(24))
'总权限2
Sub ListFlagMsg()
If FtListFlag <> 1 Then
Response.Write("<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd'>") & _
"<html xmlns='http://www.w3.org/1999/xhtml'>" & _
"<head>" & _
"<title>网站提示信息</title>" & _
"<meta http-equiv='Content-Type' content='text/html; charset=utf-8' />" & _
"<link href='css/info.css' type='text/css' rel='stylesheet' />" & _
"</head>" & _
"<body>"
Call sError_Msg("您没有管理“"&ItemName&"”的权限！")
Response.Write("</body>") & _
"</html>"
Response.End
End If
End Sub
'每个栏目下的具体权限
'Add
Sub AdminFlagMsg_Add()
If FtAdminFlag > 3 Or FtAdminFlag = 0 Then
Call sError_Msg("您没有管理或添加“"&ItemName&"”的权限！")
Response.End
End If
End Sub
'Edit
Sub AdminFlagMsg_Edit()
If FtAdminFlag > 2 Or FtAdminFlag = 0 Then
Call sError_Msg("您没有管理或修改“"&ItemName&"”的权限！")
Response.End
End If
End Sub
'Del
Sub AdminFlagMsg_Del()
If FtAdminFlag > 1 Or FtAdminFlag = 0 Then
Call sError_Msg("您没有管理或删除“"&ItemName&"”的权限！")
Response.End
End If
End Sub
%>