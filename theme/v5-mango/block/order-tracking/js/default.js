T(`#order-tracking-tab-${BLOCK.ID} a[data-toggle="tab"]`).on('click', e => {
    document.getElementById(`order-tracking-type-${BLOCK.ID}`).value = e.target.parentElement.dataset.type;
});

T(`#order-tracking-form-${BLOCK.ID}`).on('submit', e => {
    e.stopPropagation();
    e.preventDefault();

    if (!T.checkValidity(e.target)) return;

    const type = T(`#order-tracking-type-${BLOCK.ID}`)[0].value;
    if (T(`#order-${type}-${BLOCK.ID}`)[0].value == '' || type == 'phone' ? T(`#order-${type}-${BLOCK.ID}`)[0].value.replace(/\D/g, '').length < 12 : '') {
        e.stopPropagation();
        e.preventDefault();
        popoverAlert.show(
            T(`#order-${type}-${BLOCK.ID}`)[0],
            '{#required#}',
            3000,
            `btn btn-danger no-radius text-left`,
            false
        );
        return;
    }

    popoverAlert.hideAll();

    let url = T.getLink('type', type);
    url = T.getLink('order', T(`#order-no-${BLOCK.ID}`)[0].value, url);
    url = T.getLink(T(`#order-${type}-${BLOCK.ID}`)[0].name, T(`#order-${type}-${BLOCK.ID}`)[0].value, url);
    window.location.href = url;
});
