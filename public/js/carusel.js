$(document).ready(function(){
    if($(".swiper-container").length){
        var slidesPerGroup = 3
        if (window.innerWidth <= 980) slidesPerGroup = 1;
        var swiper = new Swiper('.swiper-container', {
          pagination: '.swiper-pagination',
          nextButton: '.swiper-button-next',
          prevButton: '.swiper-button-prev',
          slidesPerView: "auto",
          slidesPerGroup: slidesPerGroup,
          centeredSlides: true,
          paginationClickable: true,
          spaceBetween: 0,
          speed: 200
        });        
    }

});