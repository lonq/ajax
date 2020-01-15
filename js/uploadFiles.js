// 表单
function initUserFaceForm($ele, eleType, eleName) {
    var title = $ele.find('.item-body>span').text();
    var value = $ele.find('.item-footer>span').html();
    var html = '';
    html += '<div id="modalForm" class="modal modal-form bg-gray" style="display: block;">' +
            '<form class="form-classics" id="stepForm" name="stepForm" method="post">' +
            '<header>' +
            '<nav class="navbar navbar-light">' +
            '<ul class="navbar-left">' +
            '<li class="js-close-btn" data-dismiss="modal"><a href="javascript:;"><i class="iconfont-angleleft"></i></a></li>' +
            '</ul>' +
            '<h3 class="navbar-title">修改' + title + '</h3>' +
            '<ul class="navbar-right">' +
            '<li id="ok"><span>确定</span></li>' +
            '</ul>' +
            '</nav>' +
            '</header>' +
            '<div class="list">' +
            '<div class="item divider">' +
            '<div class="item-body">';
    html += '<input type="hidden" name="UsersID" id="UsersID" value="' + usersid + '">';
    html += '<input type="' + eleType + '" class="form-control" name="' + eleName + '" id="' + eleName + '" value="' + value + '" placeholder="请输入' + title + '">';
    html += '<div id="container_node"></div>' +
            '<input id="fileuplaod" name="fileuplaod" type="file" accept="image/*" onchange="">' +
            '</div>' +
            '<div class="item-footer form-control-feedback iconfont-wrongcircle text-muted"></div>' +
            '</div>' +
            '</div>' +
            '<div class="list-tips"></div>' +
            '</form>' +
            '</div>';
    $('body').append(html);
    // 裁切
    $.cutPhoto(
        {
            container         : "container_node",
            browse_button     : "fileuplaod",
            save_button       : "ok",
            filters_background: ""
        },
        function (cutPhotoCacheData, initStatus) {
            var imgData  = cutPhotoCacheData();
            //todo
            let image = new Image();
            image.src = imgData;
            $('#ok').on('click', function () {
                var $target = $ele.find('.js-usersface');
                closeModal();
                $('#fileuplaod').val('');
                $target.html(image);
            })
        }
    );
    // 初始化提示消息
    initMsg($('.list-tips'), eleName);
}