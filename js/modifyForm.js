/* ========================================================================
 * modify-form.js v1.0.2
 * Copyright 2020/01/30 lonq
 * ======================================================================== */

; (function ($, global) {
    'use strict';

    $.fn.modifyForm = function (options) {
        return new modifyForm(this, options);
    };

    var modifyForm = function (element, options) {
        this.$element = $(element);
        this.options = $.extend({}, modifyForm.defaults, options); // 合并参数设置
        this.init();
    };
    // 插件的方法
    modifyForm.prototype = {
        init: function () {
            var self = this;
            self.renderDOM();
            self.bindEvents();
            self.options.initialization.call(self, self.$modalFooter); // 初始化消息
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
            $('body').append(self.options.modalTemplate);
            self.$closeModalBtn.on('click', function (e) {
                self.closeModal();
            });
            // 清除表单控件的值
            if (self.options.widgetType == 'textarea' || self.options.widgetType == 'text') {
                self.clearValue('.js-clear-value', '.js-clear-ele', '.js-clear-btn');
            }
        },
        // 创建模态框
        createDOM: function () {
            var self = this;
            self.$modal = $('<div id="' + cutFirstStr(self.options.modalContainer) + '" class="modal modal-form" style="display: block;"></div>');
            self.$modalForm = $('<form class="form-classics" id="' + cutFirstStr(self.options.modalForm) + '" name="' + cutFirstStr(self.options.modalForm) + '" method="POST" Action="#"></form>');
            self.$modalHeader = $('<header><nav class="navbar navbar-light">' +
                '<ul class="navbar-left"><li></li></ul>' +
                '<h3 class="navbar-title">' + self.options.modalTitle + '</h3>' +
                '<ul class="navbar-right"><li></li></ul>' +
                '</nav></header>');
            self.$closeModalBtn = $('<a class="' + cutFirstStr(self.options.modalCloseBtn) + '" href="javascript:;"><i class="iconfont-angleleft"></i></a>');
            self.$submitBtn = $('<input name="' + cutFirstStr(self.options.modalSubmitBtn) + '" id="' + cutFirstStr(self.options.modalSubmitBtn) + '" name="' + cutFirstStr(self.options.modalSubmitBtn) + '" class="btn btn-clear" type="submit" value="确定">');
            self.$modalHeader.find('.navbar-left>li').append(self.$closeModalBtn);
            self.$modalHeader.find('.navbar-right>li').append(self.$submitBtn);

            self.$modalBody = $('<div class="items"></div>');

            self.$modalBodyWidget = '';
            if (self.options.widgetType == 'textarea') {
                self.$modalBodyWidget += '<div class="item js-clear-value">'+
                    '<div class="item-body">'+
                    '<textarea class="form-control js-clear-ele" name="' + self.options.widget + '" id="' + self.options.widget + '">' + self.options.widgetValue + '</textarea>'+
                    '</div>'+
                    '<div class="item-footer form-control-feedback"><i class="iconfont-wrongcircle text-muted js-clear-btn"></i></div>'+
                    '</div>'+
                    '</div>';
            } else if (self.options.widgetType == 'text') {
                self.$modalBodyWidget += '<div class="item js-clear-value">'+
                    '<div class="item-body">'+
                    '<input type="text" class="form-control js-clear-ele" name="' + self.options.widget + '" id="' + self.options.widget + '" value="' + self.options.widgetValue + '">'+
                    '</div>'+
                    '<div class="item-footer form-control-feedback"><i class="iconfont-wrongcircle text-muted js-clear-btn"></i></div>'+
                    '</div>'+
                    '</div>';
            } else {
                self.$modalBodyWidget = '';
            }

            self.$modalFooter = $('<div class="items-tips"></div>');

            self.$modalForm.append(self.$modalHeader);
            self.$modalBody.append(self.$modalBodyWidget);
            self.$modalForm.append(self.$modalBody);
            self.$modalForm.append(self.$modalFooter);
            self.$modal.append(self.$modalForm);

            self.options.modalTemplate = self.$modal;
        },
        closeModal: function () {
            var self = this;
            self.$modal.remove();
        },
        // 清除表单控件的值
        clearValue: function (flag, obj, objBtn) {
            var $flag = $(flag);
            var $obj = $(obj);
            var $val = $obj.val();
            var $objBtn = $(objBtn);
            if (!$flag) return;
            $val.length > 0 ? $objBtn.removeClass('invisible') : $objBtn.addClass('invisible');
            $obj.on('keyup', function() {
                var $this = $(this);
                $val = $this.val();
                $val.length > 0 ? $objBtn.removeClass('invisible') : $objBtn.addClass('invisible');
            });
            $objBtn.on('click', function() {
                $objBtn.addClass('invisible');
                $obj.val('').focus();
            })
        }
    };
    // 默认配置项
    modifyForm.defaults = {
        modalTemplate: '', // 模态框结构
        modalContainer: '#modalForm', // 模态框ID
        modalForm: '#stepForm', // 表单ID
        modalTitle: '', // 模态框标题
        modalSubmitBtn: '#ok', // 提交
        modalCloseBtn: '.js-close-btn', // 关闭
        widget: '', // 提交的控件ID
        widgetValue: '', // 控件值
        widgetType: '', // 控件类型
        resultContainer: '', // 结果显示容器
        initialization: function ($form, params) { // 初始化
        },
        submit: function ($form, params) { // 提交逻辑
            // 裁剪后的处理
            var $target = $(this.options.resultContainer);
            $target.html();
            self.closeModal();
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
    global['modifyForm'] = modifyForm;
})(window.jQuery || window.Zepto, window, document);