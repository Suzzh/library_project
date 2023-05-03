$(function(){
    $(window).scroll(function(){
        let position = $(window).scrollTop();
        $(window).scroll
        if(position<50){
            $('.header-upper-box').css('height', '78px');
            $('.header-upper-box').css('visibility', 'visible');
            $('.header-upper').css('height', '78px');
            $('.header-upper').css('visibility', 'visible');
            // $('.hide').addClass('header-upper');
            // $('.hide').removeClass('hide');
            $('.header-location').css('height', '129px');
            $('.header-upper-box').css('opacity', '100%');
            $('.header-upper').css('opacity', '100%');
        }
        else{
            $('.header-upper-box').css('height', '0px');
            $('.header-upper-box').css('visibility', 'hidden');
            $('.header-upper-box').css('opacity', '0%');
            $('.header-upper').css('height', '0px');
            $('.header-upper').css('visibility', 'hidden');
            $('.header-upper').css('opacity', '0%');
            // $('.header-upper').addClass('hide');
            // $('.header-upper').removeClass('header-upper');
            $('.header-location').css('height', '50px');
        }

    });

});