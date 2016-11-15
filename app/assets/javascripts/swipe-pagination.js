$(function() {
  $('#display .container').swipe({
      swipe : function(event, direction) {

          if (direction === 'left' || direction === 'up') {

            var maxPages = $('#paginator .pagination').children().length;
            var page = document.location.href.split('=');
            if(page[1]){
              var nextPage = parseInt(page[1]) + 1;
              if(nextPage <= maxPages){
                document.location.href = '/groups?page='+nextPage;
              }
            }else{
              document.location.href = '/groups?page=2';
            }

          } else {

            var page = document.location.href.split('=');
            if(page[1]){
              var prevPage = parseInt(page[1]) - 1;
              if(prevPage > 0){
                document.location.href = '/groups?page='+prevPage;
              }
            }

          }
      }
  });
});


$(document).ready(function() {
  if ('ontouchstart' in document.documentElement){
    $('#display .container').swipe({
        swipe : function(event, direction) {

            if (direction === 'left' || direction === 'up') {

              var maxPages = $('#paginator .pagination').children().length;
              var page = document.location.href.split('=');
              if(page[1]){
                var nextPage = parseInt(page[1]) + 1;
                if(nextPage <= maxPages){
                  document.location.href = '/groups?page='+nextPage;
                }
              }else{
                document.location.href = '/groups?page=2';
              }

            } else {

              var page = document.location.href.split('=');
              if(page[1]){
                var prevPage = parseInt(page[1]) - 1;
                if(prevPage > 0){
                  document.location.href = '/groups?page='+prevPage;
                }
              }

            }
        }
    });
  }
});
