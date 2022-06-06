regionLoader({
    country: {
        selector: ``, value: 'TR'
    },
    city: {
        selector: `#city-${BLOCK.ID}`, value: document.querySelector(`#city-${BLOCK.ID}`).value
    },
    town: {
        selector: `#town-${BLOCK.ID}`, value: document.querySelector(`#town-${BLOCK.ID}`).value
    },
    countryLimit : false
});

T(`#supplier-form-${BLOCK.ID}`).on('submit', e => {
    e.stopPropagation();
    e.preventDefault();

    const formEl = e.target;
    popoverAlert.hideAll();

    if (!T.checkValidity(formEl))
        return;

    const data = new FormData(formEl);

    T.buttonLock.dom = document.getElementById(`#supplier-form-btn-${BLOCK.ID}`);
    T.buttonLock.lock();

    axios.post(formEl.action, data).then(response => {
        const result = response.data;
        console.log(result);
        const element = T('#' + result.key + `-${BLOCK.ID}`)[0];
        console.log(element);
        if(result.status == 1) {
            T.notify({
                text: result.statusText,
                className: 'success',
                stopOnFocus : true,
                duration: 3200,
            });
            return;
        }
        popoverAlert.show(
            element, 
            result.statusText,
            3000, 
            `btn btn-danger no-radius text-left`,
            true,
            `${element.name == 'tax_number' || element.type == 'password' ? '' : 'inline'}`
        );
    }).catch(error => {
        console.warn(`Contact form send error => ${error}`);
        T.buttonLock.unlock();
    });
});
