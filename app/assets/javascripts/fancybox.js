$(document).ready(function() {
  var hideShowButtons = function(){
    $('.fancybox-close').hide();
    $('.fancybox-next').hide();
    $('.fancybox-prev').hide();

    $('.fancybox-opened').on('click',function(){
      $('.fancybox-close').toggle();
      $('.fancybox-next').toggle();
      $('.fancybox-prev').toggle();
    });
  }

  $('.fancybox').fancybox({
    autoDimensions: false,
    width         : '100%',
    height        : 400,
    autoScale     : false,
    padding       : 0,
    margin        : 0,
    border        : 0,
    tpl: {
      closeBtn: '<a title="Close" class="fancybox-item fancybox-close myClose" href="javascript:;"> <img src="/assets/back.svg"> Back</img></a>'
    },
    afterShow : function(){
      hideShowButtons();
    }
  });

  $('.fancybox-gallery').fancybox({
    autoDimensions: false,
    padding       : 0,
    width         : '100%',
    height        : 400,
    autoScale     : false,
    autoPlay      : true,
    playSpeed     : 30000,
    nextSpeed     : 500,
    prevSpeed     : 500,
    openSpeed     : 500,
    speedOut      : 500,
    margin        : 0,
    border        : 0,
    tpl: {
      closeBtn: '<a title="Close" class="fancybox-item fancybox-close myClose" href="javascript:;"> <img src="/assets/back.svg"> Back</img></a>',
    },
    afterShow : function(){
      hideShowButtons();
      if ('ontouchstart' in document.documentElement){
        $('.fancybox-nav').css('display','none');
        $('.fancybox-wrap').swipe({
            swipe : function(event, direction) {
                if (direction === 'left' || direction === 'up') {
                    $.fancybox.prev( direction );
                } else {
                    $.fancybox.next( direction );
                }
            }
        });
      }
    }
  });

  $(".fancybox-iframe").fancybox({
    autoDimensions: false,
    width         : '100%',
    height        : 400,
    autoScale     : false,
    padding       : 0,
    margin        : 0,
    border        : 0,
    type          : 'iframe',
    tpl: {
      closeBtn: '<a title="Close" class="fancybox-item fancybox-close myClose white" href="javascript:;"> <img src="/assets/back_white.svg"> Back</img></a>'
    },
    afterLoad : function(){
      //$('iframe').contents().find("video").removeAttr( "autoplay" );
      var video = $('iframe').contents().find("video");
      video.bind( "play", function() {
        clearTimeout( initial );
        initial=setTimeout(function() {
          if (video.get(0).paused)
          {
            video.get(0).play();
          }

        },600000);
      });

      var initial=setTimeout(function() {
        if (video.get(0).paused)
        {
          video.get(0).play();
        }

       },600000);

    }
  });

  $('.fancybox-ambient-content').fancybox({
    autoDimensions: false,
    width         : '100%',
    height        : 400,
    autoScale     : false,
    autoPlay      : true,
    playSpeed     : 30000,
    nextSpeed     : 500,
    prevSpeed     : 500,
    openSpeed     : 500,
    speedOut      : 500,
    padding       : 0,
    margin        : 0,
    border        : 0,
    arrows        : false,
    type          : 'iframe',
    tpl: {
      closeBtn: '',
    },
    helpers: {
      media: {}
    },
    afterLoad : function(){
      $('iframe').attr('allowfullscreen','true');
      $('iframe').attr('webkitallowfullscreen','true');
      $('iframe').attr('mozallowfullscreen','true');

      $('iframe').contents().find("body").css( 'text-align', 'center' );
      $('iframe').contents().find("body").css( 'width', '100%' );
      $('iframe').contents().find("body").css( 'height', '100%' );
      $('iframe').contents().find("body img").css( 'display', 'inline-block' );
      $('iframe').contents().find("body img").css( 'max-width', '100%' );
      $('iframe').contents().find("body img").css( 'max-height', '100%' );
      $('iframe').contents().find("body img").css( 'position', 'absolute' );
      $('iframe').contents().find("body img").css( 'top', '0' );
      $('iframe').contents().find("body img").css( 'left', '0' );
      $('iframe').contents().find("body img").css( 'right', '0' );
      $('iframe').contents().find("body img").css( 'bottom', '0' );
      $('iframe').contents().find("body img").css( 'margin', 'auto' );

      var video = null;
      video = $('iframe').contents().find("body video");
      if ( video.length && $.fancybox.player.isActive ) {
        $.fancybox.play();
      } else if (!$.fancybox.player.isActive) {
        $.fancybox.play();
      };
    },
    afterShow : function(){
      if ('ontouchstart' in document.documentElement){
        $('.fancybox-nav').css('display','none');
        $('.fancybox-wrap').swipe({
            swipe : function(event, direction) {
                if (direction === 'left' || direction === 'up') {
                    $.fancybox.prev( direction );
                } else {
                    $.fancybox.next( direction );
                }
            }
        });
      }
      var video = null;
      video = $.fancybox.inner.find('iframe').contents().find("body video");
      if ( video.length ) {
        video.bind("ended", function(e) {
          $.fancybox.next( );
        });
      };
    },
    beforeShow: function() {
      $("iframe").contents().find('body').on("click", function() {
        $.fancybox.close();
      });
    }
  });
});
