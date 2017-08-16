$(document).ready(function(){
    $(document).on('click', '.click_open_show_block', function(){
        var btn = $(this).find(".cross");
        var parent_block = btn.closest(".block__show_conteiner");
        var open_blocks = $(parent_block.data('hidden-rec-ids'));
        parent_block.toggleClass("open");
        if (parent_block.hasClass("open")){
          open_blocks.fadeIn("slow");
        }else{
          open_blocks.fadeOut("slow");
        }
    });
    
    $(".block__show_conteiner").each(function(n, e){
        $( $(e).data("hidden-rec-ids") ).hide();
    });
})