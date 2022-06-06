const AddressList = {
    template: '#address-list',
    data() {
        return {
            data: {}
        }
    },
    methods: {
        load() {
            const self = this;
            axios.get(vm.address).then(response => {
                self.data = response.data.data;
                setTimeout(() => { initComponents(); }, 150);
            }).catch(error => `Get member addresses error => ${error}`);
        },
    },
    mounted() {
        this.load();
        window['deleteAadress'] = (element, target) => {
            const id = element.dataset.id;
            axios.delete(vm.address + id).then(response => {
                const result = response.data;
                T.notify({ text: result.message, className: 'success', duration: 2400, iconClass : 'ti-thumbs-up', });
                this.load();
            });
        };
    }
};

const AddressEdit = {
    template: '#address-edit',
    data() {
        return {
            loading: true,
            address: {},
            requirements : {},
        }
    },
    methods: {
        load() {
            const self = this,
                formData = new FormData();
                formData.append('page', 'customer-insert-address-modal');
                
            const requirements = axios.post(vm.requirements, formData),
                  address = (self.$route.params.id) ? axios.get(`${vm.$data.address}${self.$route.params.id}`) : '';

            self.loading = true;
            Promise.all([requirements, address]).then(response => {
                self.requirements = response[0].data.data[0];
                self.address = response[1] == '' ? {} : response[1].data.data[0];
                self.address.is_company_active = self.address.is_company_active || 0;
                self.loading = false;

                setTimeout(() => {
                    formLoader({
                        selector: '#edit-address-form',
                        data: self.address,
                        callback: function (data) {
                            tsRegion({
                                container: '#edit-address-form',
                                countryLimit : 0,
                                country : {
                                    value : self.address.country_code || 'TR',
                                    caption : self.address.country
                                },
                                state : {
                                    value: self.address.province_code,
                                    caption: self.address.province
                                },
                                city : {
                                    value : self.address.city_code,
                                    caption : self.address.city
                                },
                                town : {
                                    value : self.address.town_code,
                                    caption : self.address.town
                                },
                                district : {
                                    value : self.address.district_code,
                                    caption : self.address.district
                                }
                            });
                        }
                    });
                    initComponents();
                }, 100);
            });
        },
        saveForm() {
            const self = this,
                  formData = new FormData(self.$refs.addressEditForm);
            T.buttonLock.dom = self.$refs.saveFormButton;

            if (formData.get('nationality') == '1') {
                formData.set('identity_number', ' ');
            } else {
                formData.set('nationality', 0);
            }
            T.buttonLock.lock();

            axios({
                method: self.$route.params.id ? 'put' : 'post',
                url: self.$refs.addressEditForm.action,
                data: formData
            }).then(response => {
                const result = response.data;
                T.notify({
                    text: result.message,
                    className: 'success',
                    duration: 2400,
                    iconClass : 'ti-thumbs-up',
                });
                vm.$router.push('/');
                T.buttonLock.unlock();
            }).catch(error => {
                let result = {};
                if (error.response) {
                    result = error.response.data.data[0];
                } else if (error.request) {
                    result = JSON.parse(error.request.response).data[0];
                }
                popoverAlert.show(
                    document.querySelector(`#edit-address-form [name="${result.key}"]`),
                    result.statusText, 
                    2400, 
                    'btn btn-danger no-radius text-left',
                    true,
                );
                T.buttonLock.unlock();
            });
        }
    },
    watch: {
        'address.is_company_active'(value) {
            if (value == 1) {
                setTimeout(() => {
                    taxLoader({
                        selector: 'input[name="tax_office"]', limit: 15
                    });
                }, 300);
            }
        },
    },
    mounted() {
        this.load();
    }
};

const routes = [
    { path: '/', component: AddressList },
    { path: '/edit/:id?', component: AddressEdit },
];

const router = VueRouter.createRouter({
    history: VueRouter.createWebHashHistory(),
    routes,
    scrollBehavior(to, from, savedPosition) {
        if (savedPosition && to.path === '/') {
            setTimeout(() => { window.scrollTo(0, savedPosition.y); }, 400);
        } else {
            window.scrollTo(0, 0);
        }
    },
});

const appAddress = Vue.createApp({
    data() {
        return {
            address : '/api/v1/public/address/',
            requirements : 'api/v1/block/get-page-requirements',
        }
    },
}).use(router);

const vm = appAddress.mount('#page-my-addresses');