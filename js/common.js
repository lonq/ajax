var selfUrl = 'https://' + window.location.host + ''; // 本站网址
$.fn.cookie('prevLink', document.referrer); // 来路网址

// footer菜单
function getFooter(pageName) {
    var html = '<ul class="footer affix affix-bottom tabs tabs-vertical text-center">' +
    '<li>' +
    '<a class="btn btn-clear" href="index.html">' +
    '<i class="icon"></i><span class="tip">首页</span>' +
    '</a>' +
    '</li>' +
    '<li>' +
    '<a class="btn btn-clear" href="productsList.html">' +
    '<i class="icon"></i><span class="tip">产品</span>' +
    '</a>' +
    '</li>' +
    '<li>' +
    '<a class="btn btn-clear" href="articlesList.html">' +
    '<i class="icon"></i><span class="tip">文章</span>' +
    '</a>' +
    '</li>' +
    '<li>' +
    '<a class="btn btn-clear" href="usersCenter.html">' +
    '<i class="icon"><span class="badge">6</span></i><span class="tip">我</span>' +
    '</a>' +
    '</li>' +
    '</ul>';
    $('#footer').html(html);

    _footer = $('footer>*');
    _footerH = _footer.height();
    _offsetHeight = _headerH + _footerH; //滑动束缚容器的偏移高度

    $('ul.footer>li>a').each(function(i) {
        var _t1 = $(this);
        var hrefVal = _t1.attr('href');
        if(pageName == hrefVal) {
            _t1.addClass('active');
        }
    });
    // 禁止底部主菜单激活后的事件
    $(document).on('click', 'ul.footer>li>a', function(e){
        var _t2 = $(this);
        if (_t2.hasClass('active')){
            e.preventDefault();
        }
    });
}
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
// 遮罩层
function backdropState(parent, classnames, state) {
    parent.prepend('<div class="backdrop '+ classnames +'"></div>');
    if (state == 'on') {
        $('html, body').css({
            'overflow': 'hidden'
        });
        $('.backdrop').addClass(classnames);
    }
    if (state == 'off') {
        $('html, body').css({
            'overflow': ''
        });
        $('.backdrop').remove();
    }
}
// 清除表单控件的值
function clearEleValue(flag, obj, objBtn) {
    var $flag = $(flag);
    var $obj = $(obj);
    var $val = $obj.val();
    var $objBtn = $(objBtn);
    if (!$flag) return;
    $val.length > 0 ? $objBtn.removeClass('invisible') : $objBtn.addClass('invisible');
    $obj.on('keyup', function() {
        $val = $(this).val();
        $val.length > 0 ? $objBtn.removeClass('invisible') : $objBtn.addClass('invisible');
    });
    $objBtn.on('click', function() {
        $objBtn.addClass('invisible');
        $obj.val('').focus();
    })
}