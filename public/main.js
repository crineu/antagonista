// Initialize the jk plugin
jk.init({
    elements: 'article',
    activeClass: 'current'
});


$(function() {

    // Substitui os links com o conteúdo das notícias
    $('a.js-placeholder').each( function(index, element) { load_news(element) });

    function load_news(element) {
        var jquery_element = $(element);
        var path  = jquery_element.attr('href')

        $.get(path, function(response) {
            jquery_element.replaceWith(response);
        }, "html");
    }

})
