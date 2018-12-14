<%
'定义管理员级别名称
Sub Users_Des()
If MyV_IsSuperUsers=1 Then
Response.write "超级管理员"
ElseIf MyV_IsSuperUsers=0 Then
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
Dim UsersFlag,UsersFlag0,UsersFlag1,UsersFlag2,UsersFlag3,UsersFlag4,UsersFlag5,UsersFlag6,UsersFlag7,UsersFlag8,UsersFlag9,UsersFlag10,UsersFlag11,UsersFlag12,UsersFlag13,UsersFlag14,UsersFlag15,UsersFlag16,UsersFlag17,UsersFlag18,UsersFlag19,UsersFlag20,UsersFlag21,UsersFlag22,UsersFlag23,UsersFlag24
UsersFlag=split(MyV_UsersFlag,",")
UsersFlag0	=ChkNumeric(UsersFlag(0))
UsersFlag1	=ChkNumeric(UsersFlag(1))
UsersFlag2	=ChkNumeric(UsersFlag(2))
UsersFlag3	=ChkNumeric(UsersFlag(3))
UsersFlag4	=ChkNumeric(UsersFlag(4))
UsersFlag5	=ChkNumeric(UsersFlag(5))
UsersFlag6	=ChkNumeric(UsersFlag(6))
UsersFlag7	=ChkNumeric(UsersFlag(7))
UsersFlag8	=ChkNumeric(UsersFlag(8))
UsersFlag9	=ChkNumeric(UsersFlag(9))
UsersFlag10	=ChkNumeric(UsersFlag(10))
UsersFlag11	=ChkNumeric(UsersFlag(11))
UsersFlag12	=ChkNumeric(UsersFlag(12))
UsersFlag13	=ChkNumeric(UsersFlag(13))
UsersFlag14	=ChkNumeric(UsersFlag(14))
UsersFlag15	=ChkNumeric(UsersFlag(15))
UsersFlag16	=ChkNumeric(UsersFlag(16))
UsersFlag17	=ChkNumeric(UsersFlag(17))
UsersFlag18	=ChkNumeric(UsersFlag(18))
UsersFlag19	=ChkNumeric(UsersFlag(19))
UsersFlag20	=ChkNumeric(UsersFlag(20))
UsersFlag21	=ChkNumeric(UsersFlag(21))
UsersFlag22	=ChkNumeric(UsersFlag(22))
UsersFlag23	=ChkNumeric(UsersFlag(23))
UsersFlag24	=ChkNumeric(UsersFlag(24))
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
Sub UsersFlagMsg_Add()
If FtUsersFlag > 3 Or FtUsersFlag = 0 Then
Call sError_Msg("您没有管理或添加“"&ItemName&"”的权限！")
Response.End
End If
End Sub
'Edit
Sub UsersFlagMsg_Edit()
If FtUsersFlag > 2 Or FtUsersFlag = 0 Then
Call sError_Msg("您没有管理或修改“"&ItemName&"”的权限！")
Response.End
End If
End Sub
'Del
Sub UsersFlagMsg_Del()
If FtUsersFlag > 1 Or FtUsersFlag = 0 Then
Call sError_Msg("您没有管理或删除“"&ItemName&"”的权限！")
Response.End
End If
End Sub
%>