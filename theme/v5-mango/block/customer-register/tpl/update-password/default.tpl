<div id="update-password" class="col-12 py-1" cloak>
    <div class="w-100" v-if="data.PASSWORD_STRENGTH != undefined">
        <div class="mb-1 fw-bold">{#change_password#}.</div>
        <ul class="mb-1">
            <li>{#pass_strength_text1#},</li>
            <li>{#pass_strength_text2#},</li>
            <li>{#pass_strength_text3#},</li>
            <li>{#pass_strength_text4#},</li>
            <li>.#?!@$%^&amp;*- {#pass_strength_text5#}.</li>
        </ul>
    </div>
    <form action="/api/v1/customer/update/password" method="POST" autocomplete="off" class="row" ref="updatePass" @submit.prevent="updatePass" novalidate>
        <div class="col-12 mb-1">
            <div class="w-100 popover-wrapper input-group">
                <input type="password" name="password_old" class="form-control form-control-md" placeholder="{#current_password#}" data-validate="required,min:6">
                <div class="input-group-append no-animate">
                    <i class="ti-eye-off text-light" @click="toggleVisiblePassword($event)"></i>
                </div>
            </div>
        </div>
        <div class="col-12 mb-1">
            <div class="w-100 popover-wrapper input-group">
                <input type="password" name="password_new" class="form-control form-control-md" placeholder="{#new_password#}" data-validate="required,min:6">
                <div class="input-group-append no-animate">
                    <i class="ti-eye-off text-light" @click="toggleVisiblePassword($event)"></i>
                </div>
            </div>
        </div>
        <div class="col-12 mb-1">
            <div class="w-100 popover-wrapper input-group">
                <input type="password" name="password_new_again" class="form-control form-control-md" placeholder="{#again_new_password#}" data-validate="'required,min:6">
                <div class="input-group-append no-animate">
                    <i class="ti-eye-off text-light " @click="toggleVisiblePassword($event)"></i>
                </div>
            </div>
        </div>
        <div class="col-12">
            <button type="submit" id="update-password-btn" class="btn btn-primary w-100">{#update#}</button>
        </div>
    </form>
</div>

<script>
    const updatePassword = {
        data() {
            return {
                data: MEMBER_INFO,
            }
        },
        methods: {
            toggleVisiblePassword(icon) {
                icon = icon.target;
                if(icon == null) 
                    return;
                
                if(icon.classList['contains']('ti-eye-off')) {
                    icon.classList.remove('ti-eye-off', 'text-light');
                    icon.classList.add('ti-eye', 'text-primary');
                    icon.closest('.input-group').querySelector('input').type = 'text';
                } else {
                    icon.classList.remove('ti-eye', 'text-primary');
                    icon.classList.add('ti-eye-off', 'text-light');
                    icon.closest('.input-group').querySelector('input').type = 'password';
                }
            },
            updatePass() {
                const self = this;
                const form = self.$refs.updatePass;
                const formData = new FormData(form);
    
                if (!T.checkValidity(form)) {
                    return;
                }
    
                T.buttonLock.dom = T('#update-password-btn')[0];
                T.buttonLock.lock();
    
                axios.post(form.action, formData).then(response => {
                    const res = response.data;
                    T.notify({
                        text: res.message,
                        className: res.status == true ? 'success' : 'danger',
                        duration: 3000,
                        iconClass : res.status == true ? 'ti-thumbs-up' : '',
                    });
                    if(res.status === true) {
                        window.location.reload();
                     }
                     T.buttonLock.unlock();
                }).catch(error => {
                    if (error.response) {
                        const msg = error.response.data.data[0];
                        popoverAlert.show(
                            form.querySelector(`[name="${msg.key}"]`), 
                            msg.statusText, 
                            2000, 
                            `btn btn-danger no-radius text-left`,
                            true,
                            ['checkbox', 'radio'].includes(form.querySelector(`[name="${msg.key}"]`).type) || msg.key == 'security_code' ? '' : 'inline'
                        );
                    } else if (error.request) {
                        const msg = JSON.parse(error.request.response).data[0];
                        popoverAlert.show(
                            form.querySelector(`[name="${msg.key}"]`), 
                            msg.statusText, 
                            2000, 
                            `btn btn-danger no-radius text-left`,
                            true,
                            ['checkbox', 'radio'].includes(form.querySelector(`[name="${msg.key}"]`).type) || msg.key == 'security_code' ? '' : 'inline'
                        );
                    }
                    T.buttonLock.unlock();
                });
            },
        },
    };

    Vue.createApp(updatePassword).mount('#update-password');
</script>