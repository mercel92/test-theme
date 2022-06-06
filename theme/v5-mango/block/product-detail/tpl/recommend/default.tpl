<div id="product-recommend-form" class="row">
    <form :action="'/srv/service/product-detail/recommend/' + data.GET_PRODUCT" method="post" novalidate autocomplete="off" class="col-12" ref="recommendForm" @submit.prevent="sendForm">
        <div class="row">
            <div class="col-12 col-md-6">
                <div class="row">
                    <div class="col-12 mb-1">
                        <div class="w-100 popover-wrapper position-relative">
                            <input type="text" id="recommend-fromName" name="fromName" v-model="fullname" class="form-control form-control-md" placeholder="{#fullname#}" data-toggle="placeholder" data-validate="required">
                        </div>
                    </div>
                    <div class="col-12 mb-1">
                        <div class="w-100 popover-wrapper position-relative">
                            <input type="email" id="recommend-fromMail" name="fromMail" class="form-control form-control-md" placeholder="{#email#}" data-toggle="placeholder" data-validate="required,email">
                        </div>
                    </div>
                    <div class="col-12 mb-1">
                        <div class="w-100 popover-wrapper position-relative">
                            <input type="text" id="recommend-toName" name="toName" class="form-control form-control-md" placeholder="{#buyer#} {#fullname#}" data-toggle="placeholder" data-validate="required">
                        </div>
                    </div>
                    <div class="col-12 mb-1">
                        <div class="w-100 popover-wrapper position-relative">
                            <input type="email" id="recommend-toMail" name="toMail" class="form-control form-control-md" placeholder="{#buyer#} {#email#}" data-toggle="placeholder" data-validate="required,email">
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-12 col-md-6">
                <div class="row">
                    <div class="col-12 mb-1">
                        <div class="w-100 popover-wrapper position-relative">
                            <textarea class="form-control form-control-md" id="recommend-message" name="message" placeholder="{#your_message#}" data-toggle="placeholder" data-validate="required"></textarea>
                        </div>
                    </div>
                    <div class="col-12 mb-1">
                        <div class="w-100 input-group popover-wrapper">
                            <div class="input-group-prepend">
                                <img :src="captcha" id="codeRecommendCaptcha"/>
                            </div>
                            <input type="text" id="recommend-security_code" name="security_code" class="form-control form-control-md" placeholder="{#security_code#}">
                            <div class="input-group-append" @click="refreshCode">
                                <i class="ti-cw text-primary"></i>
                            </div>
                        </div>
                    </div>
                    <div class="col-12">
                        <button type="submit" id="recommend-send" class="btn btn-primary w-100">{#send#}</button>
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

    const RecommendForm = {
        data() {
            return {
                data: DATA,
                captcha: `/SecCode.php?${new Date().getTime()}`,
                fullname: DATA.CUSTOMER.FIRSTNAME ? `${DATA.CUSTOMER.FIRSTNAME} ${DATA.CUSTOMER.LASTNAME}` : '',
            }
        },
        methods: {
            sendForm() {
                const self = this;
                const form = self.$refs.recommendForm;
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
                T('#recommend-security_code')[0].value = '';
                this.captcha = `/SecCode.php?${new Date().getTime()}`
            }
        },
        mounted() {
            initComponents();
        }
    };

    Vue.createApp(RecommendForm).mount('#product-recommend-form');
</script>