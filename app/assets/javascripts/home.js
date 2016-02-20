 $(document).ready(function (){
            $("#down").click(function (){
                $('html, body').animate({
                    scrollTop: $("#results").offset().top
                }, 1000);
            });
            $("#back-top").click(function (){
                $('html, body').animate({
                    scrollTop: $("#banner").offset().top
                }, 500);
            });
        });
