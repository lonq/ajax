var selfUrl = 'http://' + window.location.host + '/ajax'; // 本站网址
$.fn.cookie('prevLink', document.referrer); // 来路网址

$(function () {
    // 禁止底部主菜单激活后的行为
    $('.footer.tabs-vertical .btn').on('click', function(e){
        var _t = $(this);
        if (_t.hasClass('active')){
            e.preventDefault();
        }
    });
});


// 返回来路网址
function forwardUrl(prevLink) {
    if ($.trim(prevLink) == '') {
        location.href = selfUrl + '/index.html';
    } else {
        if (prevLink.indexOf(selfUrl) == -1) { //来自其它站点
            location.href = selfUrl + '/index.html';
        }
        if (prevLink.indexOf('register.html') != -1) { //来自注册页面
            location.href = selfUrl + '/index.html';
        }
        location.href = prevLink;
    }
}