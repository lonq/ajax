<%
'Session.Abandon
Session("AdminID")=""
Session("AdminName")=""
Session("Password")=""
Session("AdminPetName")=""
Session("IsSuperAdmin")=""
Session("ListFlag")=""
Session("AdminFlag")=""
Response.Cookies("LQCookies")("AdminID")=""
Response.Cookies("LQCookies")("AdminName")=""
Response.Cookies("LQCookies")("Password")=""
Response.Cookies("LQCookies")("AdminPetName")=""
Response.Cookies("LQCookies")("IsSuperAdmin")=""
Response.Cookies("LQCookies")("ListFlag")=""
Response.Cookies("LQCookies")("AdminFlag")=""
Response.Cookies("LQCookies").Expires =Now()-1
Response.Redirect("login.html")
%>