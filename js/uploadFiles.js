var html = '';
html += '<div id="modalUsersFaceForm" class="modal modal-form" style="background-color: #000;">' +
        // '<form class="form-classics" id="usersFaceForm" name="usersFaceForm" method="POST" style="height: 100%;">' +
        '<header>' +
        '<nav class="navbar navbar-dark bg-transparent affix affix-top">' +
        '<ul class="navbar-left">' +
        '<li class="js-close-btn" data-dismiss="modal">' +
        '<a href="javascript:;"><i class="iconfont-angleleft"></i></a>' +
        '</li>' +
        '</ul>' +
        '<h3 class="navbar-title">上传头像</h3>' +
        '<ul class="navbar-right">' +
        '<li class="sure" id="saveimg"><span>确定</span></li>' +
        '</ul>' +
        '</nav>' +
        '</header>' +
        '<ul class="list-unstyled flex-wrap horizontal-center vertical-center" id="report" style="height: 100%;">' +
        '</ul>' +
        // '</form>' +
        '</div>';
$('body').append(html);

$.cutPhoto(
    {
        container         : "container_node",
        browse_button     : "browseFile",
        save_button       : "saveimg",
        filters_background: "<%= locals.userInfo.photo_url %>"
    },
    function (cutPhotoCacheData, initStatus) {
        var imgData   = cutPhotoCacheData();
        //todo
    }
);