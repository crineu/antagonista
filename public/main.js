$(function() {

    $('button').click(function(e){ e.preventDefault(); load_news($(this)) });


    function load_news(event) {
        console.log('button clicked ' + $(event).attr('action'));
        var botao = event;

        $.ajax({
            url: $(event).attr('action'),
            dataType: "html",
            type: 'GET',
            beforeSend: function(xhr, opts){
                // $('#thumb_' + input.attr('id')).html(spinning_circle);
            },
            error: function(msg){ console.log(msg); },
            success: function(response){
                // $('#thumb_' + input.attr('id')).html(a_tag);
                // input.siblings('span').html('Substituir arquivo');
                botao.replaceWith(response);
            }
        });

    }


})