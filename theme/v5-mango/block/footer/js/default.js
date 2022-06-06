T(`#newsletter-form-${BLOCK.ID}`).on('submit', e => {
    e.stopPropagation();
    e.preventDefault();
    const formEl = e.target;
    popoverAlert.hideAll();
    if(!T.checkValidity(formEl))
        return;
    var data = new FormData(formEl);
    axios.post('/srv/service/guest/subscribeNewsletter', data).then(response => {
        const result = response.data;
        const element = T(`#news_${result.key}-${BLOCK.ID}`)[0] || formEl.querySelector('[name="email"]');
        if(result.status == 1) {
            T.notify({
                text: result.message,
                className: 'success',
                stopOnFocus : true,
                duration: 3200,
            });
            formEl.reset();
            return;
        }
        if (element) {
            popoverAlert.show(
                element.type == 'checkbox' ? element.nextElementSibling : element, 
                result.message || result.statusText,
                3000, 
                `btn btn-danger no-radius text-left`,
                false,
                `${element.type == 'checkbox' ? '' : 'inline'}`
            );
        }
    });
});
