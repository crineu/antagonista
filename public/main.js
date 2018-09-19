
document.addEventListener("DOMContentLoaded", function(event) {
  console.log(document.attachEvent)

  // Varre as notícias com 'js-placeholder' e carrega notícias
  var elements = document.querySelectorAll('a.js-placeholder');
  Array.prototype.forEach.call(elements, function(element, index) {
    load_news(element)
  });
});


// Substitui links pelo conteúdo das notícias usando ajax
function load_news(element) {
	var internal_api_path = element.getAttribute('href')

	var request = new XMLHttpRequest();
	request.open('GET', internal_api_path, true);

	request.onload = function() {
	  if (request.status >= 200 && request.status < 400) {
	    // Success!
	    element.outerHTML = request.responseText;
	  } else {
	    // We reached our target server, but it returned an error
	    console.error("Servidor respondeu com erro em " + internal_api_path);
	    return false;
	  }
	};

	request.onerror = function() {
	  console.error("Falha ao tentar carregar " + internal_api_path);
	  return false;
	};

	request.send();
}


// alert de ajuda
Mousetrap.bind('?', function(e, combo) {
	alert("[ j | k ] => navegar pelos posts\n[ p | n ] => navegar pelas páginas")
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
