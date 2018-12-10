$(function () {
    // 验证登录
    $.ajax({
        type: 'post',
        url: 'token.asp',
        timeout: 15000,
        dataType: 'json',
        success: function (reponse) {
            if (reponse == 0) {
                window.location.href = 'login.html';
            } else {
                $.fn.cookie('prevLink', { expires: -1 });
            }
        },
        error: function (xhr, type, errorThrown) {
            $('body').html('加载失败！');
        }
    });
});