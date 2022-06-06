window.ugMemberLoginFn = (result, options) => {

    popoverAlert.show(

        document.getElementById(`${options.prefix}${options.type}`), 

        result.message, 

        2400, 

        `btn ${(result.status === true) ? 'btn-success' : 'btn-danger'} text-left`

    );



    if(result.status === true) {

        setTimeout(() => {

            window.location.href = result.page.url || '/';

        }, 2000);

    }

}



T(`#toggleVisiblePassword${BLOCK.ID}`).on('click', e => {

    icon = e.target;

    if(icon == null) 

        return;



    if(T(icon).hasClass('ti-eye-off')) {

        T(icon).removeClass('ti-eye-off', 'text-light');

        T(icon).addClass('ti-eye', 'text-primary');

        icon.closest('.input-group').querySelector('input').type = 'text';

    } else {

        T(icon).removeClass('ti-eye', 'text-primary');

        T(icon).addClass('ti-eye-off', 'text-light');

        icon.closest('.input-group').querySelector('input').type = 'password';

    }

});



T(`#register-form-${BLOCK.ID} > form`).on('submit', e => {

    e.stopPropagation();

    e.preventDefault();

    const form = e.target,

          data = new FormData(form);



    if (!T.checkValidity(form)) return;



    axios.post(form.action, data).then(response => {

        const result = response.data;

        if (result.status == true) {

            T.notify({

                text: result.message,

                className: 'success',

                duration: 3200,

                iconClass : 'ti-thumbs-up',

            });

            LocalApi.set('v5token', result.data[0].bearer, result.data[0].exp_at);

            setTimeout(() => {

                window.location.href = result.page.url || '/order';

            }, 2000);

        }

    }).catch(error => {

        const errData = error.data.data[0];

        const element = form.querySelector(`[name="${errData.key}"]`);

        popoverAlert.show(

            element,

            errData.statusText,

            2400,

            'btn text-left btn-danger',

            false,

            `${(errData.key == 'seccode' || element.type == 'checkbox') ? '' : 'inline'}`

        );

    });

});



T(`#membership-form-${BLOCK.ID} > form`).on('submit', e => {

    e.stopPropagation();

    e.preventDefault();



    const form = e.target,

          data = new FormData(form);



    if (!T.checkValidity(form)) return;



    axios.post(form.action, data).then(response => {

        const result = response.data;

        if (result.status == true) {

            popoverAlert.show(

                T(`#without-email-${BLOCK.ID}`)[0],

                result.message,

                2400,

                'btn text-left btn-success',

                false

            );

            LocalApi.set('v5token', result.data[0].bearer, result.data[0].exp_at);

            setTimeout(() => {

                window.location.href = result.page.url || '/order';

            }, 2000);

        }

    }).catch(error => {

        const errData = error.data;

        popoverAlert.show(

            T(`#without-email-${BLOCK.ID}`)[0],

            errData.message,

            2400,

            'btn text-left btn-danger',

            false

        );

    });

});