var triggerGallery = function( group_url){
  $('#gallery'+group_url+':first').trigger( "click" )
}

var ambient_content = function(){
  $.get("/ambient_content", function(data) {
    $('#ambient_content').children().remove();
    $.each( data, function( key, value ){
      $('#ambient_content').append('<a class="fancybox-ambient-content" data-fancybox-group="ambient-content" href="'+value.file.url+'"></a>')
    });
    $('#ambient_content a:first').trigger('click');
  });
}

$(document).click( function() {
  clearTimeout( initial );
  initial=setTimeout(function() {
    if(location.pathname == "/"){
      location.reload();
    } else {
      ambient_content();
    }
  },300000);
});

var initial=setTimeout(function() {
  ambient_content();
},300000);

$(document).ready(function() {

  var render = function(){
    $.get("/render_uploads", function(data) {
      $("#uploaded_files").html(data);
    });
    $.get("/render_uploads_pagination", function(data) {
      $("#paginator").html(data);
    });
  }

  setInterval(function(){

    $.get("/groups_count", function(data) {
      if(data != $("#uploaded_files").data('group-count')){
        $("#uploaded_files").data('group-count', data);
        $.get("/last_updated", function(data) {
          $("#uploaded_files").data('last-updated', data[0].id);
        });
        render();
      }
    });

    $.get("/last_updated", function(data) {
      var d = new Date(data[0].updated_at.toString()).toUTCString();
      var time = d.split(' ');
      if((data[0].id + " " + time[4]) != $("#uploaded_files").data('last-updated')){
        $("#uploaded_files").data('last-updated', (data[0].id + " " + time[4]));
        render();
      }
    });

    $.get("/ambient_content_count", function(data) {
      if(data != $("#ambient_content").data('ambient-content-count')){
        $("#ambient_content").data('ambient-content-count', data);
        $.get("/ambient_content", function(data) {
          $('#ambient_content').children().remove();
          $.each( data, function( key, value ){
            $('#ambient_content').append('<a class="fancybox-ambient-content" data-fancybox-group="ambient-content" href="'+value.file.url+'"></a>')
          });
        });
      }
    });
  }, 3000)


  if(location.pathname == "/")
  {
    ambient_content();
  }

});
