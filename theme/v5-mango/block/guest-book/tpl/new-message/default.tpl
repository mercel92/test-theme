<div id="guest-book-new-message" class="w-100 p-2">
    <div class="w-100 mb-1 block-title border-bottom">
        {#write_comment#}
    </div>
    <div class="col-12">
        <div class="row">
            <form id="guest-book-form" action="/srv/service/guest/send-message" method="POST" novalidate
                autocomplete="off" class="w-100">
                <div class="w-100 popover-wrapper position-relative mb-1">
                    <input id="guest-fullname" type="text" name="guest-fullname" placeholder="{#fullname#}" class="form-control form-control-md" data-toggle="placeholder" data-validate="required">
                </div>
                <div class="w-100 popover-wrapper position-relative mb-1">
                    <input id="guest-email" type="email" name="guest-email" placeholder="{#email#}" class="form-control form-control-md" data-toggle="placeholder"
                           data-validate="required, email">
                </div>
                <div class="w-100 popover-wrapper position-relative mb-1">
                    <input id="guest-phone" type="tel" name="guest-phone" placeholder="{#phone#}" class="form-control form-control-md" data-flag-masked data-toggle="placeholder"
                           data-validate="required,phone">
                </div>
                <div class="w-100 popover-wrapper position-relative mb-1">
                    <textarea id="guest-message" name="guest-message" placeholder="{#message#}" class="form-control form-control-md" data-toggle="placeholder" data-validate="required"></textarea>
                </div>
                <div class="w-100 input-group popover-wrapper position-relative mb-1">
                    <div class="input-group-prepend">
                        <img src="/SecCode.php" id="guest-captcha" />
                    </div>
                    <input type="text" name="seccode" id="seccode" class="form-control form-control-md" placeholder="{#security_code#}">
                    <div id="guest-reload-captcha" class="input-group-append">
                        <i class="ti-cw text-primary"></i>
                    </div>
                </div>
                <div class="w-100">
                    <button type="submit" class="w-100 btn btn-primary" id="guest-book-send-btn">{#send_message#}</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    setTimeout(() => initComponents(), 50);

    T(`#guest-reload-captcha`).on('click', e => {
        document.getElementById(`guest-captcha`).setAttribute('src', `/SecCode.php?${new Date().getTime()}`);
    });

    T(`#guest-book-form`).on('submit', e => {
        e.stopPropagation();
        e.preventDefault();

        const formEl = e.target;
        popoverAlert.hideAll();

        if (!T.checkValidity(formEl))
            return;

        const data = new FormData(formEl);

        T.buttonLock.dom = document.getElementById(`#guest-book-send-btn`);
        T.buttonLock.lock();

        axios.post(formEl.action, data).then(response => {
            const result = response.data;
            T(`#guest-reload-captcha`).trigger('click');

            if (result.status == 1) {
                T.notify({
                    text: result.statusText,
                    className : 'success',
                    duration: 3000,
                });
                setTimeout(function(){ location.reload(); }, 1500);
            } else {
                popoverAlert.show(
                    formEl.querySelector(`#${result.key}`),
                    result.statusText,
                    3000,
                    `btn btn-danger no-radius text-left`,
                    false,
                    result.key == 'seccode' ? '' : 'inline'
                );
            }
            T.buttonLock.unlock();
        }).catch(error => {
            console.warn(`Contact form send error => ${error}`);
        });
    });
</script>