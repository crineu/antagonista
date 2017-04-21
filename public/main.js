
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

Mousetrap.bind('j', function(e, combo) {
    console.log(combo); // logs 'ctrl+shift+up'
});

Mousetrap.bind('k', function(e, combo) {
    console.log(combo); // logs 'ctrl+shift+up'
});

// location.href     = "http://localhost:5000/2"
// location.origin   = "http://localhost:5000"
// location.pathname = "/2"

Mousetrap.bind('n', function(e, combo) {
    var proxima_pagina = parseInt(location.pathname.slice(1)) + 1
    location.href = location.origin + '/' + proxima_pagina
});

Mousetrap.bind('p', function(e, combo) {
    var pagina_anterior = parseInt(location.pathname.slice(1)) - 1
    if (pagina_anterior === 0) { return false; }
    location.href = location.origin + '/' + pagina_anterior
});

// alert de ajuda

Mousetrap.bind('?', function(e, combo) {
    alert("j / k para navegar entre os posts\np / n para páginas")
});
