
$(function() {

    // Substitui os links com o conteúdo das notícias
    $('a.js-placeholder').each( function(index, element) { load_news(element) });

    function load_news(element) {
        var jquery_element = $(element);
        var path  = jquery_element.attr('href')

        $.get(path, function(response) {
            // console.log(response.length);
            if (response.length > 0) {
                jquery_element.replaceWith(response);
            } else {
                console.log("Erro ao caregar " + path);
                return false;
            }
        }, "html");
    }

})

// alert de ajuda
Mousetrap.bind('?', function(e, combo) {
    alert("[ j / k ] => navegar entre os posts\n[ p / n ] => navegar entre páginas")
});

// location.href     = "http://localhost:5000/2"
// location.origin   = "http://localhost:5000"
// location.pathname = "/2"
Mousetrap.bind('n', function(e, combo) { npNavigate(+1); });
Mousetrap.bind('p', function(e, combo) { npNavigate(-1); });

// scroll usando j / k
Mousetrap.bind('j', function(e, combo) { jkNavigate(+1); });
Mousetrap.bind('k', function(e, combo) { jkNavigate(-1); });


function npNavigate(increment) {
    var page_number = parseInt(location.pathname.slice(1));
    if (isNaN(page_number)) { page_number = 1; }

    var next_page = page_number + increment;
    if (next_page < 1) { return false; }
    location.href = location.origin + '/' + next_page
}

function jkNavigate(increment) {
    var selectables = $('[data-selectable]:visible');
    if (selectables.length == 0) {
        return false;
    }

    var current = selectables.index($('.jkselected'));

    var next = current + increment;
    if (next == selectables.length || next < 0) { return false; }

    var currentSelectable = $(selectables[current]);
    var nextSelectable    = $(selectables[next]);

    currentSelectable.removeClass('jkselected');
    nextSelectable.addClass('jkselected');

    // make sure selected item is visible within vertical display
    $('html, body').animate({ scrollTop: nextSelectable.offset().top - 20}, 200);

    $(':focus').blur(); // remove focus from any element that may be in focus
}
