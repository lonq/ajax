$(function () {
    // 验证登录
    $.ajax({
        type: 'post',
        url: 'token.asp',
        timeout: 15000,
        dataType: 'html',
        success: function (reponse) {
            if (reponse === 'Login Failed') {
                window.location.href = 'login.html';
            } else {
                $.fn.cookie('prevLink', { expires: -1 });
            }
        },
        error: function (xhr, type, errorThrown) {
            $('body').html('数据错误');
        }
    });
});