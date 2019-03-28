(function() {
    var input = document.getElementById('fileuplaod');
    input.onchange = function () {
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
        lrz(this.files[0], {
            before: function() {
            },
            fail: function(err) {
                //console.error(err);
            },
            always: function() {
            },
            done: function (results) {
               $('#modalUsersFaceForm').css('display', 'block');
               demo_report("原始图片", results.blob, results.origin.size);
               setTimeout(function() {
                   demo_report("客户端预压的图片", results.base64, results.base64.length * 0.8);
                   var xhr = new XMLHttpRequest();
                   var data = { base64: results.base64, size: results.base64.length };
                   xhr.open("POST", "upload.asp", true);
                   xhr.setRequestHeader("Content-Type", "application/json; charset=utf-8");
                   xhr.onreadystatechange = function() {
                       if (xhr.readyState === 4 && xhr.status === 200) {
                           var result = JSON.parse(xhr.response);
                           result.error ? alert("服务端错误，未能保存图片") : demo_report("服务端实存的图片", result.src, result.size);
                       }
                   };
                   xhr.send(JSON.stringify(data));
               }, 100);
            }
        });
    }
    function demo_report(title, src, size) {
        var img = new Image(),
            li = document.createElement("li"),
            size = (size / 1024).toFixed(2) + "KB";
        img.onload = function() {
            var content = "<ul>" + "<li>" + title + "（" + img.width + " X " + img.height + "）</li>" + '<li class="text-cyan">' + size + "</li>" + "</ul>";
            li.className = "img-responsive";
            // li.innerHTML = content;
            li.appendChild(img);
            document.getElementById("report").appendChild(li);
        };
        img.src = src;
    }
    window.onload = function() {
        input.style.display = "block";
    };
})();
