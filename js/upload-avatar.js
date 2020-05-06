/* ========================================================================
 * upload-avatar.js v1.0.0
 * Copyright 2020/01/30 lonq
 * ======================================================================== */

; (function ($, global) {
    'use strict';
    // 全局变量
    var cropImage; // 裁切函数

    $.fn.uploadAvatar = function (options) {
        return new uploadAvatar(this, options);
    };

    var uploadAvatar = function (element, options) {
        this.$element = $(element);
        this.options = $.extend({}, uploadAvatar.defaults, options); // 合并参数设置
        this.init();
    };
    // 插件的方法
    uploadAvatar.prototype = {
        init: function () {
            var self = this;
            self.renderDOM();
            self.bindEvents();
        	self.$modalForm.submit(function($form, params) {
                self.options.submit.call(self, self.$modalForm); // 执行自定义事件
        		return false;
        	});
        },
        // 渲染模态框DOM结构
        renderDOM: function () {
            var self = this;
            self.createDOM();
        },
        // 执行事件
        bindEvents: function () {
            var self = this;
            self.$element.on('change', function (e) {
                self.upload(self.$element, this);
            });
            self.$cropBtn.on('click', function (e) {
                self.clip();
            });
            self.$resetBtn.on('click', function (e) {
                self.reset();
            });
            self.$closeModalBtn.on('click', function (e) {
                self.closeModal();
            });
        },
        // 创建文档
        createDOM: function () {
            var self = this;
            self.$modal = $('<div id="' + cutFirstStr(self.options.modalContainer) + '" class="modal modal-form" style="display: block;"></div>');
            self.$modalForm = $('<form id="' + cutFirstStr(self.options.modalForm) + '" name="' + cutFirstStr(self.options.modalForm) + '" method="POST" action="#"></form>');
            self.$modalHeader = $('<header><nav class="navbar navbar-light">' +
                '<ul class="navbar-left"><li></li></ul>' +
                '<h3 class="navbar-title">' + self.options.modalTitle + '</h3>' +
                '<ul class="navbar-right"><li></li></ul>' +
                '</nav></header>');
            self.$closeModalBtn = $('<a class="' + cutFirstStr(self.options.modalCloseBtn) + '" href="javascript:;"><i class="iconfont-angleleft"></i></a>');
            self.$submitBtn = $('<input name="' + cutFirstStr(self.options.modalSubmitBtn) + '" id="' + cutFirstStr(self.options.modalSubmitBtn) + '" name="' + cutFirstStr(self.options.modalSubmitBtn) + '" class="btn btn-clear" type="submit" value="确定">');
            self.$modalHeader.find('.navbar-left>li').append(self.$closeModalBtn);
            self.$modalHeader.find('.navbar-right>li').append(self.$submitBtn);

            self.$modalBody = $('<div class="padding text-sm">' +
                '<div class="padding-vertical text-warning"><i class="iconfont-infocircle"></i> 拖动边缘控制区调整裁切范围</div>' +
                '<input type="hidden" name="' + cutFirstStr(self.options.modalInput) + '" id="' + cutFirstStr(self.options.modalInput) + '">' +
                '<div class="img-clip"></div>' +
                '<div class="img-show"></div>' +
                '</div>');

            self.$modalFooter = $('<footer id="footer"><div class="footer affix affix-bottom buttons"></div></footer>');
            self.$cropBtn = $('<a href="javascript:;" id="' + cutFirstStr(self.options.cropBtn) + '" class="item-flex btn btn-clear text-primary">裁剪</a>');
            self.$resetBtn = $('<a href="javascript:;" id="' + cutFirstStr(self.options.resetBtn) + '" class="item-flex btn btn-clear text-muted border-left">重置</a>');

            self.$modalFooter.find('.footer').append(self.$cropBtn);
            self.$modalFooter.find('.footer').append(self.$resetBtn);

            self.$modalForm.append(self.$modalHeader);
            self.$modalForm.append(self.$modalBody);
            self.$modalForm.append(self.$modalFooter);
            self.$modal.append(self.$modalForm);

            self.options.modalTemplate = self.$modal;
        },
        // 上传图片
        upload: function ($obj, obj) {
            var self = this;
            var $this = $obj;
            var files = obj.files, file;
            if (files && files.length) {
                file = files[0];
                var maxFileSize = self.options.maxFileSize;
                var filesize = file.size;
                var getFileSize = HtmlUtil.getFileSize(maxFileSize);
                if (filesize > maxFileSize) {
                    $this.val('');
                    HtmlUtil.msg('最大只能上传' + getFileSize + '的文件');
                    return false;
                }
                // 判断是否是图像文件
                if (/^image\/\w+$/.test(file.type)) {
                    self.init();
                    $('body').append(self.options.modalTemplate);
                    var reader = new FileReader();
                    reader.onload = function (ev) {
                        //更换图片，同时初始化裁切
                        var result = ev.target.result;
                        var img = new Image();
                        img.src = result;
                        img.onload = function () {
                            self.destroy();
                            cropImage = new ImageClip({
                                container: '.img-clip',
                                img,
                                sizeTipsStyle: 0,
                                compressScaleRatio: 1.1,
                                iphoneFixedRatio: 1.8,
                                maxCssHeight: window.innerHeight * 0.7,
                                captureRadius: 30,
                                isUseOriginSize: false,
                                maxWidth: 0,
                                forceWidth: 0,
                                forceHeight: 0,
                                quality: 0.5,
                                mime: 'image/jpeg'
                            });
                        };
                    }
                    reader.readAsDataURL(file);
                    self.options.isClip = false;
                    $this.val(''); // 清除input[file]的值
                } else {
                    $this.val('');
                    HtmlUtil.msg('请选择一个图像');
                }
            }
        },
        // 裁切图片
        clip: function () {
            var self = this;
            cropImage.clip();
            self.options.isClip = true;
            var imgData = self.getUrlData();
            var img = new Image();
            $(img).css({
                'margin': '0 auto',
                'display': 'block',
                'max-width': '100%',
                'max-height': window.innerHeight * 0.7,
            })
            img.src = imgData;

            img.onload = function () {
                self.changeContent(img, true);
            };
        },
        // 重置裁切
        reset: function () {
            var self = this;
            self.changeContent(null, false);
            cropImage.resetClipRect();
            self.options.isClip = false;
        },
        // 销毁裁切
        destroy: function (e) {
            cropImage && cropImage.destroy();
        },
        // 获取裁切base64
        getUrlData: function (e) {
            return cropImage.getClipImgData();
        },
        closeModal: function () {
            var self = this;
            self.$modal.remove();
        },
        // 裁切和显示结果状态切换
        changeContent: function (img, isShowContent) {
            if (isShowContent) {
                $('.img-show').removeClass('hide');
                $('.img-clip').addClass('hide');
                $('.img-show').html(img);
                $('#cropBtn').addClass('disabled');
                $('.form-preview-header').addClass('invisible');
            } else {
                $('.img-show').addClass('hide');
                $('.img-clip').removeClass('hide');
                $('#cropBtn').removeClass('disabled');
                $('.form-preview-header').removeClass('invisible');
            }
        },
    };
    // 默认配置项
    uploadAvatar.defaults = {
        modalTemplate: '', // 模态框结构
        modalContainer: '#modalForm', // 模态框ID
        modalForm: '#stepForm', // 表单ID
        modalTitle: '', // 模态框标题
        modalInput: '#UsersFace', // 提交的控件ID
        modalSubmitBtn: '#ok', // 提交
        modalCloseBtn: '.js-close-btn', // 关闭
        maxFileSize: 5 * (1024 * 1024), // 最大文件尺寸：5兆
        isClip: false, // 裁切状态
        croppedContainer: '.js-usersface', // 裁切结果显示容器
        cropBtn: '#cropBtn', // 裁切
        resetBtn: '#resetBtn', // 重置裁切
        submit: function ($form, params) { // 提交逻辑
            // 裁剪后的处理
            var imgData = this.getUrlData();
            var $target = $(this.options.croppedContainer);
            if (!this.options.isClip) {
                HtmlUtil.msg('请先裁切');
                return;
            }
            var img = new Image();
            img.src = imgData;
            img.onload = function () {
                $target.html(img);
                self.closeModal();
            }
        }
    };
    // 清除特定的第一个字符
    function cutFirstStr(str) {
        if (typeof (str) != 'string') return;
        var tmpStr = '';
        var firstStr = str.substr(0, 1);
        if (firstStr == '#' || firstStr == '.') {
            tmpStr = str.substr(1);
        } else {
            tmpStr = str;
        }
        return tmpStr;
    }
    global['uploadAvatar'] = uploadAvatar;
})(window.jQuery || window.Zepto, window, document);