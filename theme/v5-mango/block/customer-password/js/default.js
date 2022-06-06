T(`#forgot-captcha-code-${BLOCK.ID}`).on('click', e => {
    document.getElementById(`forgot-security-code-img-${BLOCK.ID}`).setAttribute('src', `/SecCode.php?${new Date().getTime()}`);
});

T(`#forgot-password-${BLOCK.ID}`).on('submit', e => {
    e.stopPropagation();
    e.preventDefault();

    const formEl = e.target;
    popoverAlert.hideAll();

    const data = new FormData(formEl);

    T.buttonLock.dom = document.getElementById(`#forgot-password_btn-${BLOCK.ID}`);
    T.buttonLock.lock();

    let url,
        forgotType = "email";

    const selectedType = T(`#forgot-type-${BLOCK.ID}`).length > 0 ? T(`#forgot-type-${BLOCK.ID}`)[0] : null;
    if (selectedType != null) {
        forgotType = selectedType.querySelector('li.active').dataset.type;
        const otherForgotType = forgotType == 'email' ? 'phone' : 'email';
        url = formEl.action + encodeURI(T(`#${forgotType}-${BLOCK.ID}`)[0].value.replace(/\ /g, '').replace(/\(/g, '').replace(/\)/g, ''));
        T(`#${otherForgotType}-${BLOCK.ID}`)[0].dataset.validate = '';
        T(`#${forgotType}-${BLOCK.ID}`)[0].dataset.validate = `required,${forgotType}`;
    } else {
        url = formEl.action + encodeURI(T(`#${forgotType}-${BLOCK.ID}`)[0].value);
    }
    
    if(!T.checkValidity(formEl))
        return;

    axios.post(url, data).then(response => {
        const result = response.data;
        popoverAlert.show(
            T(`#${forgotType}-${BLOCK.ID}`)[0],
            result.statusText,
            3200,
            `btn ${(result.status === 1) ? 'btn-success' : 'btn-danger'} text-left`,
            false,
            ''
        );

        T.buttonLock.unlock();
    }).catch(error => {
        console.warn(`Forgot Password Error => ${error}`);
    });
});

T(`#forgot-reset_password-${BLOCK.ID}`).on('submit', e => {
    e.stopPropagation();
    e.preventDefault();

    const formEl = e.target;
    popoverAlert.hideAll();

    if(!T.checkValidity(formEl))
        return;

    const data = new FormData(formEl);
    
    T.buttonLock.dom = document.getElementById(`#forgot-reset_btn-${BLOCK.ID}`);
    T.buttonLock.lock();

    const url = formEl.action + document.getElementById(`reset-token-${BLOCK.ID}`).value;
    axios.post(url, data).then(response => {
        const result = response.data;

        popoverAlert.show(
            T(`#password_new-${BLOCK.ID}`)[0],
            result.statusText, 
            2400,
            `btn ${(result.status === 1) ? 'btn-success' : 'btn-danger'} text-left`,
            false,
            `${(result.status === 1) ? '' : 'inline'}`
        );        

        if (result.status == 1) {
            setTimeout(function() {
                window.location.href = '/';
            }, 2500);
        }

        T.buttonLock.unlock();
    }).catch(error => {
        console.warn(`Forgot Reset Error => ${error}`);
    })
});