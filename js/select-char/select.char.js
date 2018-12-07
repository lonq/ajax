; (function($, window, document, undefined) {
  var SelectChar = function(el, opts) {
    this.ele = el;
    this.defaults = {
      chars: ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'],
      callback: function(ret) {},
    };
    this.options = $.extend({},
    this.defaults, opts);

    this.eleWidth = $(this.ele).width();
    this.charslength = this.options.chars.length;
    this.eleHeight = $(window).height();
    if (this.charslength < 13) {
      this.eleHeight = this.charslength * 30;
    }
    this.everyCharHeight = this.eleHeight / this.charslength;
  };

  SelectChar.prototype = {
    init: function() {
      $(this.ele).css("position", "relative");
      this.show();
      return this;
    },
    show: function() {
      var cnt = '';
      cnt += '<section id="seleMask"style="width:' + this.eleWidth + 'px;height:' + this.eleHeight + 'px;position:fixed;top:0;left:0;z-index:9999">';
      cnt += '<div id="bigChar"style="position: absolute;top: 50%;left: 50%;transform: translate(-50%,-50%);-webkit-transform: translate(-50%,-50%);width: 70px;height: 70px;line-height: 70px;text-align: center;background: rgba(0,0,0,.7);border-radius: 5px;color: #fff;font-size: 32px;z-index: 999;display:none"></div>';
      cnt += '<ul id="smallChar" style="position: absolute;top:0;right:0;width:30px;height:' + this.eleHeight + 'px;cursor:pointer">';
      for (var i = 0; i < this.charslength; i++) {
        cnt += '<li style="width: 100%;height:' + this.everyCharHeight + 'px;line-height:' + this.everyCharHeight + 'px;text-align: center;font-size: 14px;color: #333;">' + this.options.chars[i] + '</li>';
      }
      cnt == '</ul></section>';
      $(this.ele).prepend(cnt);

      this.addEvent();
      return this;
    },
    hide: function() {
      return this;
    },
    addEvent: function(e) {
      var eve, options, result;
      eve = this.everyCharHeight;
      options = this.options;
      document.getElementById("smallChar").addEventListener("touchstart", function(touch) {
        $("#bigChar").show();
        $("#smallChar").css("background-color","#f5f5f5");
        $("#bigChar").html(result);
        if (touch.touches[0].pageY) {
          var _val = Math.floor((touch.touches[0].pageY - $(this).offset().top) / eve);
          result = options.chars[_val];
        }
      },
      false);
      document.getElementById("smallChar").addEventListener("touchmove", function(touch) {
        if (touch.touches[0].pageY) {
          var _val = Math.floor((touch.touches[0].pageY - $(this).offset().top) / eve);
          result = options.chars[_val];
          $("#bigChar").html(result);
        }
      },
      false);
      document.getElementById("smallChar").addEventListener("touchend", function(touch) {
        $("#bigChar").hide();
        $("#smallChar").css("background-color","transparent");
        if (result) {
          options.callback(result);
        }
      },
      false);
      return this;
    },
  };

  $.fn.seleChar = function(parse) {
    var selectchar = new SelectChar(this, parse);
    selectchar.init();
  };
})(jQuery, window, document);