var openStudyPopup = function(id_popup){
  var btn = $("a[href='#open_"+ id_popup +"']");
  var block_popup = $("#"+id_popup);
  if (!block_popup.hasClass("open")){
    closeAllSudyPopup();
    btn.addClass("active");
    block_popup.css('left', btn.position().left + "px").css('top', btn.position().top + btn.height + 28 + "px");
    block_popup.fadeIn("slow");
    block_popup.addClass("open");
  }else{
    closeAllSudyPopup();
  }
}

var closeAllSudyPopup = function(){
  $("a[href^='#open_study_popup']").removeClass("active");
  $("div[id^='study_popup']").fadeOut("slow");
  $("div[id^='study_popup']").removeClass("open");
}
$(document).ready(function(){
  var path = location.pathname;
  var curr_li = $('#study_popup').find("a[href='"+ path +"']");
  if (curr_li.length){
    $('a[href=#open_study_popup]').text(curr_li.text());
    $('a[href=#open_study_popup]').addClass("active_page");
    curr_li.addClass("active");
  }

  var curr_li = $('#study_popup2').find("a[href='"+ path +"']");
  if (curr_li.length){
    $('a[href=#open_study_popup2]').text(curr_li.text());
    $('a[href=#open_study_popup2]').addClass("active_page");
    curr_li.addClass("active");
  }


  $("a[href^='#open_study_popup']").click(function(){
    var btn = $(this);
    var id_popup = btn.attr('href').replace("#open_","");
    openStudyPopup(id_popup);
  });


  $(document).on('click', function(e) {
    if (!$(e.target).closest("div[id^='study_popup']").length && $(e.target).prop("tagName") != "A" && !$(e.target).hasClass("noCloseStudyPopap")) {
      closeAllSudyPopup();
    }
    e.stopPropagation();
  });
})