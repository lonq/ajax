let HtmlUtil = (function(){
    return {
        // 1.对Date的扩展，将 Date 转化为指定格式的String
        // 月(M)、日(d)、小时(H)、分(m)、秒(s)、季度(q) 可以用 1-2 个占位符，
        // 年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字)
        // 例子：
        // dateFormat("yyyy-MM-dd HH:mm:ss.S", new Date()) ==> 2006-07-02 08:09:04.423
        // dateFormat.Format("yyyy-M-d H:m:s.S", new Date())      ==> 2006-7-2 8:9:4.18
        dateFormat: function(fmt, date) {
            var o = {
                "M+": date.getMonth() + 1, //月份
                "d+": date.getDate(), //日
                "H+": date.getHours(), //小时
                "m+": date.getMinutes(), //分
                "s+": date.getSeconds(), //秒
                "q+": Math.floor((date.getMonth() + 3) / 3), //季度
                S: date.getMilliseconds() //毫秒
            };
            if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (date.getFullYear() + "").substr(4 - RegExp.$1.length));
            for (var k in o) if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k] : ("00" + o[k]).substr(("" + o[k]).length));
            return fmt;
        },
        // 2.用浏览器内部转换器实现html转码
        htmlEncode: function(html) {
            //1.首先动态创建一个容器标签元素，如DIV
            var temp = document.createElement("div");
            //2.然后将要转换的字符串设置为这个元素的innerText(ie支持)或者textContent(火狐，google支持)
            temp.textContent != undefined ? (temp.textContent = html) : (temp.innerText = html);
            //3.最后返回这个元素的innerHTML，即得到经过HTML编码转换的字符串了
            var output = temp.innerHTML;
            temp = null;
            return output;
        },
        // 3.用浏览器内部转换器实现html解码
        htmlDecode: function(text) {
            //1.首先动态创建一个容器标签元素，如DIV
            var temp = document.createElement("div");
            //2.然后将要转换的字符串设置为这个元素的innerHTML(ie，火狐，google都支持)
            temp.innerHTML = text;
            //3.最后返回这个元素的innerText(ie支持)或者textContent(火狐，google支持)，即得到经过HTML解码的字符串了。
            var output = temp.innerText || temp.textContent;
            temp = null;
            return output;
        },
        // 4.用正则表达式实现html转码
        htmlEncodeByRegExp: function(str) {
            var s = "";
            if (str.length == 0) return "";
            s = str.replace(/&/g, "&amp;");
            s = s.replace(/</g, "&lt;");
            s = s.replace(/>/g, "&gt;");
            s = s.replace(/ /g, "&nbsp;");
            s = s.replace(/\'/g, "&#39;");
            s = s.replace(/\"/g, "&quot;");
            return s;
        },
        // 5.用正则表达式实现html解码
        htmlDecodeByRegExp: function(str) {
            var s = "";
            if (str.length == 0) return "";
            s = str.replace(/&amp;/g, "&");
            s = s.replace(/&lt;/g, "<");
            s = s.replace(/&gt;/g, ">");
            s = s.replace(/&nbsp;/g, " ");
            s = s.replace(/&#39;/g, "'");
            s = s.replace(/&quot;/g, '"');
            return s;
        },
        // 5-1.清除富文本标签
        htmlClaer: function(str) {
            var s = "";
            if (str.length == 0) return "";
            s = str.replace(/(\n)/g, "");
            s = s.replace(/(\t)/g, "");
            s = s.replace(/(\r)/g, "");
            s = s.replace(/<\/?[^>]*>/g, "");
            s = s.replace(/\s+([\u4e00-\u9fa5])/ig,"$1");
            return s;
        },
        // 6.获取地址栏参数，str:参数名称
        getUrlParms: function(str) {
            var reg = new RegExp("(^|&)" + str + "=([^&]*)(&|$)");
            var r = window.location.search.substr(1).match(reg);
            if (r != null) return unescape(r[2]);
            return null;
        },
        // 7.读取cookie数组，str:参数名称
        getCookie: function(arr, str) {
            //'username=abc; password=123456; aaa=123; bbb=4r4er'是一个字符串
            // var arr = document.cookie.split('&');
            if (!arr) return;
            arr = arr.split("&");
            var i = 0;
            //arr->['username=abc', 'password=123456', ...]
            for (i = 0; i < arr.length; i++) {
                //arr2->['username', 'abc']
                var arr2 = arr[i].split("=");
                if (arr2[0] == str) {
                    return arr2[1];
                }
            }
            return null;
        },
        // 8.修正定位在底部的元素
        fixBottom: function($obj) {
            var winH = $(window).height();
            var $foot = $(document).find("." + $obj);
            if ($foot.length < 1) return;
            if ($foot.position().top + $foot.height() < winH) {
                $foot.addClass("affix affix-bottom");
            } else {
                $foot.removeClass("affix affix-bottom");
            }
        },
        // 9.无阻断消息提示(基于“dialog2-master”插件)
        msg: function(str) {
            $(document).dialog({
                type: 'notice',
                infoText: str,
                autoClose: 1500,
                position: 'bottom'
            });
        },
        // 消息提示
        loadingMsg: function(str) {
            loading = $(document).dialog({
                type: 'toast',
                infoIcon: 'js/dialog2-master/dist/images/icon/loading.gif',
                infoText: str
            });
        },
        // 9-1.消息提示
        noDataMsg: function(target, type, text) {
            let color, icon;
            let pullUp = target.next('.pull-up');
            let pullDown = target.prev('.pull-down');
            switch (type) {
                case 'primary':
                    color = 'msg msg-primary';
                    icon = 'icon iconfont-success';
                    break;
                case 'danger':
                    color = 'msg msg-danger';
                    icon = 'icon iconfont-error';
                    break;
                default:
                    color = 'msg msg-default';
                    icon = 'icon iconfont-infocircle';
            }
            var str = '';
            str += '<div class="' + color + '">';
            str += '<h1><i class="' + icon + '"></i></h1>' +
                '<h3 class="text-center">' + text + '</h3>' +
                '</div>';
            if (pullUp) pullUp.hide();
            if (pullDown) pullDown.hide();
            target.html(str);
        },
        // 10.判断图片加载
        isImgLoad: function(obj, callback) {
            // 查找所有图，迭代处理
            $(obj).each(function () {
                // 找到为0就将isImgLoaded设为false，并退出each
                if (this.height === 0) {
                    isImgLoaded = false;
                    return false;
                }
            });
            // 为true，没有发现为0的。加载完毕
            if (isImgLoaded) {
                clearTimeout(imgTimer); // 清除定时器
                // 回调函数
                callback();
                // 为false，因为找到了没有加载完成的图，将调用定时器递归
            } else {
                isImgLoaded = true;
                imgTimer = setTimeout(function () {
                    HtmlUtil.isImgLoad(obj, callback); // 递归扫描
                }, 500); // 我这里设置的是500毫秒就扫描一次，可以自己调整
            }
        },
        // 5.返回等比缩放后的图片宽高
        getImgInfo: function (url, maxWidth, maxHeight) {
            return new Promise(function (resolve, reError) {
                let _width, _height;
                let img = new Image();
                img.src = url;
                img.onload = function () {
                    if (img.width > 0 && img.height > 0) {
                        if (img.width / img.height >= maxWidth / maxHeight) {
                            if (img.width > maxWidth) {
                                _width = maxWidth;
                                _height = (img.height * maxWidth) / img.width;
                            } else {
                                _width = img.width;
                                _height = img.height;
                            }
                        } else {
                            if (img.height > maxHeight) {
                                _height = maxHeight;
                                _width = (img.width * maxHeight) / img.height;
                            } else {
                                _width = img.width;
                                _height = img.height;
                            }
                        }
                    }
                    resolve({
                        width: _width,
                        height: _height
                    });
                };
                img.onerror = function () {
                    reError(new Error('图片载入失败'));
                }
            });
        },
        // 3.判断系统
        isOs: function() {
            var ua = navigator.userAgent,
                isWindowsPhone = /(?:Windows Phone)/.test(ua),
                isSymbian = /(?:SymbianOS)/.test(ua) || isWindowsPhone,
                isAndroid = /(?:Android)/.test(ua),
                isFireFox = /(?:Firefox)/.test(ua),
                isChrome = /(?:Chrome|CriOS)/.test(ua),
                isTablet = /(?:iPad|PlayBook)/.test(ua) || (isAndroid && !/(?:Mobile)/.test(ua)) || (isFireFox && /(?:Tablet)/.test(ua)),
                isPhone = /(?:iPhone)/.test(ua) && !isTablet,
                isPc = !isPhone && !isAndroid && !isSymbian;
            return {
                isTablet: isTablet,
                isPhone: isPhone,
                isAndroid: isAndroid,
                isPc: isPc
            };
        },
        // 4.判断微信端
        isWechart: function() {
            var rst = true;
            if (window.navigator.userAgent.match(/(phone|pad|pod|iPhone|iPod|ios|iPad|Android|Mobile|BlackBerry|IEMobile|MQQBrowser|JUC|Fennec|wOSBrowser|BrowserNG|WebOS|Symbian|Windows Phone)/i)) {
                var ua = navigator.userAgent.toLowerCase();
                if (!(ua.match(/MicroMessenger/i) == "micromessenger")) {
                    rst = false;
                }
            } else {
                rst = false;
            }
            return rst;
        },
        // 6.byte格式化
        getFileSize: function(size) {
            if (!size) return;
            var num = 1024.00; //byte
            if (size < num)
                return size + "B";
            if (size < Math.pow(num, 2))
                return (size / num).toFixed(2) + "K"; //kb
            if (size < Math.pow(num, 3))
                return (size / Math.pow(num, 2)).toFixed(2) + "M"; //M
            if (size < Math.pow(num, 4))
                return (size / Math.pow(num, 3)).toFixed(2) + "G"; //G
            return (size / Math.pow(num, 4)).toFixed(2) + "T"; //T
        },
        // 7.base64转blob对象
        dataUrltoBlob: function (dataUrl) {
            var arr = dataUrl.split(','),
                mime = arr[0].match(/:(.*?);/)[1],
                bstr = atob(arr[1]),
                n = bstr.length,
                u8arr = new Uint8Array(n);
            while (n--) {
                u8arr[n] = bstr.charCodeAt(n);
            }
            return new Blob([u8arr], { type: mime });
        },
        // 8.blob对象转base64
        blobToDataUrl: function (blob) {
            var n = new FileReader();
            n.readAsDataUrl(blob); // 读取文件保存在result中
            n.onload = function (e) {
                var getRes = e.target.result; // 读取的结果在result中
            }
        }
    }
})();