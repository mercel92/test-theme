T(`.letter-item-titles .active`).on('click', el => {
    el.preventDefault();
    window.location.href = T.getLink('letter', '');
});

document.getElementById(`form-search-${BLOCK.ID}`).addEventListener('invalid', (function () {
  return function (e) {
    e.preventDefault();
    document.getElementById(`search-word-${BLOCK.ID}`).focus();
  };
})(), true);