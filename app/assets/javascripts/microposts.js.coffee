$(document).ready ->
  $(".microposts").infinitescroll
    loading: {
      finishedMsg: ""
      msgText: "Now Loading..."  
    }
    navSelector: "nav.pagination" # selector for the paged navigation (it will be hidden)
    nextSelector: "nav.pagination a[rel=next]" # selector for the NEXT link (to page 2)
    itemSelector: ".microposts li" # selector for all items you'll retrieve