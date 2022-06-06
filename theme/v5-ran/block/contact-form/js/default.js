T(`#reload-captcha-${BLOCK.ID}`).on('click', e => {
    document.getElementById(`contactform-captcha-${BLOCK.ID}`).setAttribute('src', `/SecCode.php?${new Date().getTime()}`);
});

T(`#contact-form-${BLOCK.ID}`).on('submit', e => {
    e.stopPropagation();
    e.preventDefault();

    const formEl = e.target;
    popoverAlert.hideAll();

    if(!T.checkValidity(formEl))
        return;

    const data = new FormData(formEl);

    T.buttonLock.dom = document.getElementById(`#contactform-sendbtn-${BLOCK.ID}`);
    T.buttonLock.lock();

    axios.post(formEl.action, data).then(response => {
        const result = response.data;
        const element = T(`#contactform-${result.msg}-${BLOCK.ID}`)[0] || T(`#contactform-${result.key}-${BLOCK.ID}`)[0];
        T.buttonLock.unlock();
        T(`#reload-captcha-${BLOCK.ID}`).trigger('click');

        if(result.success > 0) {
            T.notify({
                text: '{#send_form#}',
                className: 'success',
                duration: 3200,
                iconClass : 'ti-thumbs-up',
            });
            formEl.reset();
            T(`#contactform-resetbtn-${BLOCK.ID}`).trigger('click');
            return;
        }

        popoverAlert.show(
            element.type == 'checkbox' ? element.nextElementSibling : element, 
            '{#required#}', 
            3000, 
            `btn btn-danger no-radius text-left`,
            true,
            `${(result.msg == 'seccode' || element.type == 'checkbox') ? '' : 'inline'}`
        );
    }).catch(error => {
        console.warn(`Contact form send error => ${error}`);
        T.buttonLock.unlock();
    });
});

T(`#contactform-resetbtn-${BLOCK.ID}`).on('click', e => {
    Array.from(e.target.closest('form').querySelectorAll('.input-placeholder.focused, .error-input')).forEach(item => {
        item.classList.remove('focused');
        item.classList.remove('error-input');
    });
    Array.from(e.target.closest('form').querySelectorAll('.error-input-msg')).forEach(item => {
        item.remove();
    });
});