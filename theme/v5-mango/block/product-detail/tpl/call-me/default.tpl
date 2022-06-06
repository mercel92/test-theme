<div id="product-callme-form" class="row">
    <form :action="'/srv/service/product-detail/call-me/' + data.GET_PRODUCT" method="post" novalidate autocomplete="off" class="col-12" ref="callMeForm" @submit.prevent="sendForm">
        <div class="row">
            <div class="col-12 col-md-6">
                <div class="row">
                    <div class="col-12 mb-1">
                        <div class="w-100 popover-wrapper position-relative">
                            <input type="text" id="callme-fullname" name="fullname" class="form-control form-control-md" placeholder="{#fullname#}" data-toggle="placeholder" data-validate="required">
                        </div>
                    </div>
                    <div class="col-12 mb-1">
                        <div class="w-100 popover-wrapper position-relative">
                            <input type="tel" id="callme-mobile_phone" name="mobile_phone" class="form-control form-control-md" placeholder="{#phone#}" data-flag-masked data-toggle="placeholder" data-validate="required,phone">
                        </div>
                    </div>
                    <div class="col-12 mb-1">
                        <div class="w-100 popover-wrapper position-relative">
                            <input type="email" id="callme-email" name="email" class="form-control form-control-md" placeholder="{#email#}" data-toggle="placeholder" data-validate="required,email">
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-12 col-md-6">
                <div class="row">
                    <div class="col-12 mb-1">
                        <div class="w-100 popover-wrapper position-relative">
                            <textarea class="form-control form-control-md" id="callme-message" name="message" placeholder="{#your_message#}" data-toggle="placeholder" data-validate="required"></textarea>
                        </div>
                    </div>
                    <div class="col-12 mb-1">
                        <div class="w-100 input-group popover-wrapper">
                            <div class="input-group-prepend">
                                <img :src="captcha" id="codeCallmeCaptcha"/>
                            </div>
                            <input type="text" id="call_me-security_code" name="security_code" class="form-control form-control-md" placeholder="{#security_code#}">
                            <div class="input-group-append" @click="refreshCode">
                                <i class="ti-cw text-primary"></i>
                            </div>
                        </div>
                    </div>
                    <div class="col-12">
                        <button type="submit" class="btn btn-primary w-100">{#send#}</button>
                    </div>
                </div>
            </div>
        </div>
    </form>
</div>
<script>
    let DATA = {};
    try {
        DATA = JSON.parse(`{$DATA}`);
    } catch (ex) {
        DATA = {};
    }

    const CallmeForm = {
        data() {
            return {
                data: DATA,
                captcha: `/SecCode.php?${new Date().getTime()}`
            }
        },
        methods: {
            sendForm() {
                const self = this;
                const form = self.$refs.callMeForm;
                const formData = new FormData(form);
                axios.post(form.action, formData).then(response => {
                    const res = response.data;
                    if(res.status < 1) {
                        popoverAlert.show(
                            form.querySelector(`[name="${res.key}"]`), 
                            res.statusText, 
                            3000, 
                            `btn btn-danger no-radius text-left`,
                            true,
                            res.key == 'security_code' ? '' : 'inline'
                        );
                    } else {
                        form.reset();
                        if (T('.focused').length > 0) {
                            T('.focused').removeClass('focused');
                        }
                        T.notify({
                            text: res.statusText,
                            duration: 3500,
                            className : 'success',
                            iconClass : 'ti-thumbs-up',
                        })
                    }
                    self.refreshCode();
                });
            },
            refreshCode() {
                T('#call_me-security_code')[0].value = '';
                this.captcha = `/SecCode.php?${new Date().getTime()}`
            }
        },
        mounted() {
            initComponents();
        }
    };

    Vue.createApp(CallmeForm).mount('#product-callme-form');
</script>