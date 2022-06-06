document.getElementById(`form-search-${BLOCK.ID}`).addEventListener('invalid', (function () {
  return function (e) {
    e.preventDefault();
    document.getElementById(`search-word-${BLOCK.ID}`).focus();
  };
})(), true);