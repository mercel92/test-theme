window.ugMemberLoginFn = (result, options) => {
    console.log(options);
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