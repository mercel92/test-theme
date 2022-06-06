T(`#comment-sort-${BLOCK.ID}`).on('change', el => {
    const url = new URL(window.location.href);
    const params = url.searchParams;

    if (el.target.value == '') {
        params.delete('sort');
        params.delete('dir');
    } else {
        const valArr = el.target.value.split(',');
        params.set('sort', valArr[0]);
        params.set('dir', valArr[1]);
    }

    window.location.href = url.toString();
});

document.getElementById(`form-search-${BLOCK.ID}`).addEventListener('invalid', (function () {
    return function (e) {
      e.preventDefault();
      document.getElementById(`search-word-${BLOCK.ID}`).focus();
    };
})(), true);