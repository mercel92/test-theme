T(`#reload-captcha-${BLOCK.ID}`).on('click', e => {
    document.getElementById(`captcha-${BLOCK.ID}`).setAttribute('src', `/SecCode.php?${new Date().getTime()}`);
    document.getElementById(`seccode-${BLOCK.ID}`).value = '';
});

let today = new Date();
const date = document.querySelector(`#date-${BLOCK.ID}`),
      hour = document.querySelector(`#hour-${BLOCK.ID}`),
      dd = String(today.getDate()).padStart(2, '0'),
      mm = String(today.getMonth() + 1).padStart(2, '0'),
      yyyy = today.getFullYear();
today = dd + '-' + mm + '-' + yyyy;

flatpickr(date, {
    dateFormat: 'd-m-Y',
    minDate: 'today',
    "disable": [
        function(date) {
            return (date.getDay() === 0);
        }
    ],
    "locale": {
        "firstDayOfWeek": 1
    },
    onClose : () => {
        hour.disabled = false;
        Array.from(hour.options).forEach( el => {
            if (today == date.value) {
                const toHour = new Date().getHours() + ':00';
                if (el.value != '') {
                    const arrHour = el.value.split(' - ');
                    if (arrHour[0] < toHour) {
                        el.disabled = true;
                    }
                }
            } else {
                el.disabled = false;
            }
        });
    }
});

T(`#${BLOCK.ID}`).on('submit', e => {
    e.stopPropagation();
    e.preventDefault();

    const formEl = e.target;
    popoverAlert.hideAll();

    if(!T.checkValidity(formEl))
        return;

    const data = new FormData(formEl);

    T.buttonLock.dom = T(`#send-${BLOCK.ID}`)[0];
    T.buttonLock.lock();

    axios.post(formEl.action, data).then(response => {
        const result = response.data;
        const element = T(`#${result.key}-${BLOCK.ID}`)[0];

        if (result.status > 0) {
            T.notify({
                 text: result.statusText,
                className: 'success',
                duration: 3200,
                iconClass : 'ti-thumbs-up',
            });
        } else {
            popoverAlert.show(
                element.type == 'checkbox' ? element.nextElementSibling : element,
                result.statusText,
                3000,
                `btn btn-danger no-radius text-left`,
                false,
                `${(result.key == 'seccode' || element.type == 'checkbox') ? '' : 'inline'}`
            );
        }
        T.buttonLock.unlock();
    }).catch(error => {
        console.warn(`Contact form send error => ${error}`);
    });
});
