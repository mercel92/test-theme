const memberRegister = {
    data() {
        return {
            endpoints: {
                getFields: MEMBER_INFO.ID > 0 ? '/api/v1/block/customer-register?type=update' : '/api/v1/block/customer-register',
                register: MEMBER_INFO.ID > 0 ? '/api/v1/customer/update' : '/api/v1/authentication/register',
                changePass: '/api/v1/customer/update/password',
                reloadCaptcha: `/api/v1/security/captcha/customer-register`,
            },
            BLOCK: BLOCK,
            LOADING: true,
            FORM_FIELDS: {},
            IS_MEMBER_LOGGED_IN: MEMBER_INFO.ID > 0,
            DETAIL_INFO: {},
            captcha: ``,
            birthdate: '',
            parse_birthdate: ['','',''],
        }
    },
    methods: {
        loadField() {
            const self = this;
            axios.get(self.endpoints.getFields).then(response => {
                const result = response.data;
                self.FORM_FIELDS = result.data[0];
                self.DETAIL_INFO = self.FORM_FIELDS.account.customerInfo;
                self.captcha = self.FORM_FIELDS.security;
                self.LOADING = false;
                self.birthdate = self.DETAIL_INFO.birthdate;
                if (self.DETAIL_INFO.representative_id == undefined) {
                    self.DETAIL_INFO.representative_id = '';
                }
                if (self.DETAIL_INFO.gender == undefined) {
                    self.DETAIL_INFO.gender = 2;
                }
                setTimeout(() => {
                    flatpickr('.flatpickr', {
                        dateFormat: 'd-m-Y',
                        maxDate: new Date()
                    });
                    formLoader({
                        selector: '#member-register-form' + self.BLOCK.ID,
                        data: self.DETAIL_INFO,
                        callback: function (data) {
                            regionLoader({
                                country: {
                                    selector: '#country_code', value: data.country_code
                                },
                                city: {
                                    selector:'#city_code', value: data.city_code
                                },
                                town: {
                                    selector: '#town_code', value: data.town_code
                                },
                                district: {
                                    selector: '#district_code', value: data.district_code
                                },
                                countryLimit : false
                            });
                            if (data.country_code == 'TR' || !data.country_code) {
                                taxLoader({
                                    selector: '#tax_office', limit: 15
                                });
                            }
                        }
                    });
                    initComponents();
                }, 100);
            }).catch(error => console.warn(`Register field not loaded = ${error}`));
        },
        refreshCode() {
            T('[name="security_code"]')[0].value = '';
            axios.get(this.endpoints.reloadCaptcha).then(response => {
                this.captcha = response.data.data[0].path;
            });
        },
        saveForm(btn = null) {
            const self = this;
            const form = self.$refs.memberRegister;
            const formData = new FormData(form);

            if (!T.checkValidity(form)) {
                scroll({
                    top: T(`#${form.id} .error-input`)[0].closest('.popover-wrapper').offsetTop - 120,
                    behavior: "smooth"
                });
                return;
            }

            T.buttonLock.dom = btn != null && btn.target != null ? (btn.target.nodeName == 'FORM' ? btn.target.submitter : btn.target) : T(`#register-form-btn-${self.BLOCK.ID}`)[0];
            T.buttonLock.lock();

            if (formData.get('nationality') == '1') {
            } else {
                formData.set('nationality', 0);
            }

            axios({
                method: self.IS_MEMBER_LOGGED_IN == true ? 'put' : 'post',
                url: self.endpoints.register,
                data: formData
            }).then(response => {
                const res = response.data;
                if (typeof SignPageTracking !== 'undefined' && typeof SignPageTracking.Callback === 'function') {
                    SignPageTracking.Callback(res);
                }
                if(res.status === false) {
                    self.formErrorMsg(form, res.data[0]);
                } else {
                    if (res.data[0] && res.data[0].loginError) {
                        T.notify({
                            text: res.data[0].loginError,
                            className: 'success',
                            duration: 2000,
                        });
                    } else {
                        T.notify({
                            text: self.IS_MEMBER_LOGGED_IN == true ? res.message : '{#register_form_ok#}.',
                            className: 'success',
                            duration: 2000,
                            iconClass : 'ti-thumbs-up'
                        });
                        if (self.IS_MEMBER_LOGGED_IN == false) {
                            LocalApi.set('v5token', res.data[0].bearer, res.data[0].exp_at);
                        }
                    }
                    if (self.IS_MEMBER_LOGGED_IN == false) {
                        setTimeout(() => {
                            window.location.href = res.data[0].url;
                        }, 2000);
                    }
                    T.buttonLock.unlock();
                }
            }).catch(error => {
                if (error.response) {
                    self.formErrorMsg(form, error.response.data.data[0]);
                } else if (error.request) {
                    self.formErrorMsg(form, JSON.parse(error.request.response).data[0]);
                }
            });
        },
        formErrorMsg(form, msg) {
            T.buttonLock.unlock();
            if (document.querySelector('[name="security_code"]')) {
                this.refreshCode();
            }
            popoverAlert.show(
                form.querySelector(`[name="${msg.key}"]`), 
                msg.statusText, 
                2000, 
                `btn btn-danger no-radius text-left`,
                true,
                ['checkbox', 'radio'].includes(form.querySelector(`[name="${msg.key}"]`).type) || msg.key == 'security_code' ? '' : 'inline'
            );
        },
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
        updatePassword() {
            const self = this;
            const form = self.$refs.memberUpdpass;
            const formData = new FormData(form);

            if (!T.checkValidity(form)) {
                scroll({
                    top: T(`#${form.id} .error-input`)[0].closest('.popover-wrapper').offsetTop - 120,
                    behavior: "smooth"
                });
                return;
            }

            T.buttonLock.dom = T(`#updpass-form-btn-${self.BLOCK.ID}`)[0];
            T.buttonLock.lock();

            axios.post(self.endpoints.changePass, formData).then(response => {
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
                    self.formErrorMsg(form, error.response.data.data[0]);
                } else if (error.request) {
                    self.formErrorMsg(form, JSON.parse(error.request.response).data[0]);
                }
                T.buttonLock.unlock();
            });
        },
    },
    watch: {
        'birthdate'(value) {
            if (value) {
                this.parse_birthdate = value.split('-');
            }
        },
    },
    mounted() {
        this.loadField();
    }
};

Vue.createApp(memberRegister).mount('#member-register');