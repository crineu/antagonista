// on page ready...
document.addEventListener("DOMContentLoaded", function(event) {
  loadNewsList(document.getElementById('page').dataset.page);

  // Adiciona listeners para a navegacao entre páginas
  document.getElementById('nav_prev').addEventListener('click', function(event) {
    loadNewsList(event.target.dataset.page);  // event.target = #nav_prev
  });
  document.getElementById('nav_next').addEventListener('click', function(event) {
    loadNewsList(event.target.dataset.page);
  });
});


function updateNavButtons(page_number) {
  document.getElementById('page').dataset.page = page_number;

  var prevBtn = document.getElementById('nav_prev');
  var nextBtn = document.getElementById('nav_next');
  prevBtn.dataset.page = parseInt(page_number) - 1;
  nextBtn.dataset.page = parseInt(page_number) + 1;
  nextBtn.innerHTML = nextBtn.dataset.page + ' ->';
  prevBtn.innerHTML = '<- ' + prevBtn.dataset.page;
  prevBtn.hidden = false;

  if (page_number == 1) {
    prevBtn.hidden = true;
    prevBtn.innerHTML = '';
  }
}

// Limpa lista de notícias
function clearNews(placeholder) {
  while (placeholder.firstChild) {
    placeholder.removeChild(placeholder.firstChild);
  }
}

// Carrega lista de notícias conforme número da página
function loadNewsList(page_number) {
  var articlesPlaceholder = document.getElementById('articles');

  clearNews(articlesPlaceholder);

  var request  = new XMLHttpRequest();
  request.open('GET', '/api/v1/pagina/' + page_number, true);
  request.onload = function() {
    if (request.status >= 200 && request.status < 400) {
      var list = JSON.parse(request.responseText);

      list.forEach(function(element, index) {
        articlesPlaceholder.appendChild(createNewsInHTML(element, index));
      });

    } else {
      console.error("Servidor respondeu com erro em /api/v1/pagina/" + page_number);
      return false;
    }
  };
  request.onerror = function() {
    console.error("Falha ao tentar carregar /api/v1/pagina/" + page_number);
    return false;
  };
  request.send();

  updateNavButtons(page_number);
}


// Cria html esqueleto da notícia com espaço para conteúdo (#content[n])
function createNewsInHTML(data, id) {
  var header = document.createElement('header');
  header.appendChild(document.createTextNode(data['title']));
  var title = document.createElement('a');
  title.setAttribute('href', data['full_path']);
  title.setAttribute('target', '_blank');
  title.appendChild(header);

  var gif = document.createElement('img');
  gif.setAttribute('src', 'loading.gif');
  var paragraph = document.createElement('p');
  paragraph.appendChild(gif);
  var content = document.createElement('div');
  content.setAttribute('id', 'content' + id);
  content.appendChild(paragraph);

  var footer = document.createElement('footer');
  footer.setAttribute('class', 'date');
  footer.appendChild(document.createTextNode(data['date']));

  var article = document.createElement('article');
  article.setAttribute('data-selectable', '');
  article.appendChild(title);
  article.appendChild(content);
  article.appendChild(footer);

  fillContentPlaceholder(content, data['local_path']);
  return article;
}

function fillContentPlaceholder(placeholder, data_path) {
  var request  = new XMLHttpRequest();
  request.open('GET', data_path, true);
  request.onload = function() {
    if (request.status >= 200 && request.status < 400) {
      placeholder.innerHTML = JSON.parse(request.responseText);
    } else {
      console.error(`Servidor respondeu com erro em ${data_path}`);
      return false;
    }
  };
  request.onerror = function() {
    console.error(`Falha ao tentar carregar ${data_path}`);
    return false;
  };
  request.send();
}
