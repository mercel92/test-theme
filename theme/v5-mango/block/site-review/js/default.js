T('.vote-click').on('click', function(e) {
    e.preventDefault();
    var voteId = e.target.dataset.commentId;
    var vote = e.target.dataset.vote;
    axios.post('/srv/service/product-detail/vote-comment/' + voteId + '/' + vote).then(response => {
        T(`.vote-click[data-comment-id="${voteId}"]`)[0].disabled = true;
        T(`.vote-click[data-comment-id="${voteId}"]`)[1].disabled = true;
        T.notify({
            text: "{#vote_send#}.",
            className: 'success',
            duration: 3200,
            iconClass : 'ti-thumbs-up'
        });
    }); 
});

T(`#comment-form-${BLOCK.ID}`).on('submit', e => {
    e.stopPropagation();
    e.preventDefault();

    const formEl = e.target;
    popoverAlert.hideAll();

    if (!T.checkValidity(formEl))
        return;

    const data = new FormData(formEl);

    axios.post(formEl.action, data).then( () => {
        formEl.reset();
        T.notify({
            text: "{#comment_send#}",
            className: 'success',
            duration: 3200,
        });
    }).catch(error => {
        console.warn(`Comment form send error => ${error}`);
    });
});

Array.from(T('.comment-more')).forEach(el => {
    const lineHeight = parseInt(window.getComputedStyle(el)['lineHeight'].replace(/\D/g, '')) || 18;
    if ((el.offsetHeight / lineHeight) > 3) {
        T(el).addClass('comment-description');
        el.parentNode.querySelector('.comment-more-btn').classList.remove('d-none');
    }
});

T('.comment-more-btn').on('click', el => {
    const description = el.target.closest('.comment-info').querySelector('.comment-more');
    T(el.target).text(T(description).hasClass('comment-description') ? el.target.dataset.hideText : el.target.dataset.showText);
    T(description).toggleClass('comment-description');
});

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