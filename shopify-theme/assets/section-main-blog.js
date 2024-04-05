function attachLoadMoreEvent() {
  const $loadMore = document.querySelector('.js-loadmore');
  if ($loadMore) {
    onLoadMoreArticles($loadMore);
  }
}

function onLoadMoreArticles($btn) {
  $btn.addEventListener('click', (event) => {
    event.preventDefault();
    $btn.disabled = true;

    fetch(`${$btn.href}`)
    .then((response) => response.text())
    .then((responseText) => {
      const html = new DOMParser().parseFromString(responseText, 'text/html');
      const source = html.querySelector('.blog-articles');
      const destination = document.querySelector('.blog-articles');
      if (source && destination) {
        destination.innerHTML = destination.innerHTML + source.innerHTML;
        AOS.init();
      }

      const btnContainer = html.querySelector('.blog-articles__loadmore');
      const originalBtn = document.querySelector('.blog-articles__loadmore');
      if (originalBtn) {
        originalBtn.innerHTML = btnContainer ? btnContainer.innerHTML : '';
        attachLoadMoreEvent();
      }
    })
  })
}

window.addEventListener('DOMContentLoaded', () => {
  attachLoadMoreEvent();
});
