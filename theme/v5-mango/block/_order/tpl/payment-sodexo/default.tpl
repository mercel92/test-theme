<form id="order-sodexo-form" class="col-12 p-1">
    <div class="mb-1">
        {#sodexo_info#}
    </div>
    <label for="sodexo-phone" class="d-flex">
        {#sodexo_gsm#}
    </label>
    <div class="w-100 popover-wrapper position-relative mb-1">
        <input id="sodexo-phone" type="tel" name="phone" data-flag-masked class="form-control form-control-lg" data-validate="required,phone">
    </div>
    <label for="sodexo-code" class="d-flex">
        {#sodexo_mobile_code#}
    </label>
    <div class="w-100 popover-wrapper position-relative mb-1">
        <input id="sodexo-code" type="text" name="code" class="form-control form-control-lg" autocomplete="off" data-validate="required">
    </div>
    <button type="submit" class="w-100 btn btn-primary text-uppercase" id="sodexo-checkout-btn">{#send#}</button>
</form>

<script>
setTimeout(() => initComponents(), 50);
T(`#order-sodexo-form`).on('submit', e => {
    e.stopPropagation();
    e.preventDefault();

    const formEl = e.target;
    popoverAlert.hideAll();

    if (!T.checkValidity(formEl))
        return;

    const opt = {
        phone: '',
        otp: '',
    };
    
    opt.phone = T('#sodexo-phone')[0].value;
    opt.otp = T('#sodexo-code')[0].value;

    vm.checkoutRequest(opt);
    setTimeout(() => { T('.t-modal-backdrop').trigger('click'); }, 150);
});
</script>