var redirectToCurrentCity = function(){
   var curr_city = $.cookie('city') || ymaps.geolocation.city;
   var find_url = $("#study_popup2 a[data-city='"+ curr_city +"']").attr("href");
   // if ( window.location.href.search(find_url) < 0){
   //     window.location.href = find_url;
   // } 
}
$(document).ready(function(){
    setTimeout(function(){
        redirectToCurrentCity();
    }, 200);
    
});