const OrderList = {
    template: '#order-list',
    data() {
        return vm.$data
    },
    methods: {
        load(start) {
            vm.START = start;
            vm.load();
            scroll({
                top: 0,
                behavior: "smooth"
            });
        }
    }
};

const OrderDetail = {
    template: '#order-detail',
    data() {
        return {
            LOADING: true,
            DETAIL: {},
            ORDER_REPEAT: 0
        }
    },
    methods: {
        getDetail() {
            this.DETAIL = vm.$data.DATA.ORDERS.find(x => x.ORDER_NUMBER == this.$route.params.id);
            this.ORDER_REPEAT = vm.$data.DATA.ORDER_REPEAT;

            if (this.DETAIL.RETURNS.length > 0) {
                this.DETAIL.RETURNS.forEach(item => {
                    item.RETURNS_DETAIL.forEach(p => {
                        const product = this.DETAIL.PRODUCT_LIST.find(x=> x.PRODUCT_ID == p.PRODUCT_ID);
                        product.RETURN_STATUS = item.RETURN_STATUS;
                    });
                });
            }

            setTimeout(() => { this.LOADING = false }, 400);
        },
        price: p => T.format(p),
        repeatOrder() {
            const self = this;
            axios.get(`${vm.$data.endpoints.repeat}${self.DETAIL.ID}`).then(response => {
                const result = response.data || {};
                let uri = '';

                if(result.status != 1){
                    T.notify({
                        text: '{#error_text#}',
                        className: 'danger',
                        duration: 3000,
                    })
                    return;
                }

                switch(result.step){
                    case "cart" : 
                        uri = "/Sepet.php";
                        break;
                    case "address" :
                        uri = "/order#/";
                        break;
                    case "payment" :
                        uri = "/order#/payment";
                        break;
                    default : 
                        uri = "/order#/payment";
                        break;
                }
                window.location.href = uri;
            }).catch(error => `Order repeat error => ${error}`);
        }
    },
    async mounted() {
        if (Object.keys(vm.$data.DATA).length >= 1) {
            this.getDetail();
        } else {
            let promise = new Promise((resolve, reject) => {
                setTimeout(() => resolve(vm.load()), 600);
            });
            await promise;
            this.getDetail();
        }
    }
};

const OrderReturn = {
    template: '#order-return',
    data() {
        return {
            DATA: {},
            LOADING: true,
            CAPTCHA: `/SecCode.php?${new Date().getTime()}`
        }
    },
    methods: {
        refreshCode() {
            this.CAPTCHA = `/SecCode.php?${new Date().getTime()}`
        },
        saveForm() {
            const self = this;
            const form = self.$refs.orderReturnForm;

            if (T('.product-list-select:checked').length < 1) {
                T.notify({
                    text: '{#return_product_select#}',
                    className: 'danger',
                    duration: 3500,
                });
                return;
            }
            
            if(!T.checkValidity(form))
            return;

            const formData = new FormData(form);
            axios.post(form.action, formData).then(response => {
                const res = response.data;
                if(res.status < 1) {
                    if(res.key) {
                        popoverAlert.show(
                            form.querySelector(`input[name="${res.key}"]`), 
                            res.statusText, 
                            3000, 
                            `btn btn-danger no-radius text-left`,
                            true,
                            res.key == 'security_code' ? '' : 'inline'
                        );
                    } else {
                        T.modal({
                            html: res.statusText
                        });
                    }
                } else {
                    T.notify({
                        text: res.statusText || '{#return_form_ok#}',
                        className: 'success',
                        duration: 3500,
                        iconClass : 'ti-thumbs-up'
                    });
                    setTimeout(() => {
                        self.$router.push('/');
                    }, 2000);
                }
                self.refreshCode();
            });
        }
    },
    mounted() {
        const self = this;
        axios.get(`${vm.$data.endpoints.return}${self.$route.params.id}`).then(response => {
            self.DATA = response.data;
            self.LOADING = false;
            setTimeout(() => {
                T.inputFile(self.$refs.inputfile);
            }, 400);
        }).catch(error => `Order return error => ${error}`);
    }
}

const routes = [
    { path: '/', component: OrderList },
    { path: '/detail/:id', component: OrderDetail },
    { path: '/return/:id', component: OrderReturn },
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

const appOrder = Vue.createApp({
    data() {
        return {
            endpoints: {
                get: '/srv/service/order-v4/get-list/',
                repeat: '/srv/service/order-v4/repeat-order/',
                return: '/srv/service/order-v4/order-return/'
            },
            DATA: {},
            MOBILE: T.isMobile(),
            IS_ARCHIVE: false,
            FILTER_BY_DAY: '',
            START: 0,
            LENGTH: 20,
        }
    },
    methods: {
        load() {
            const self = this;
            axios.get(self.endpoints.get, {
                params: {
                    archive: self.IS_ARCHIVE ? 1 : 0,
                    day: self.FILTER_BY_DAY,
                    start: self.START,
                    length: self.LENGTH,
                }
            }).then(response => {
                self.DATA = response.data;
            }).catch(error => `Get order error => ${error}`);
        },
        date: date => T.timeConverter(date, 'd.m.y | h:s')
    },
    watch: {
        'IS_ARCHIVE' () {
            this.load();
        },
        'FILTER_BY_DAY' () {
            this.load();
        }
    },
    mounted() {
        this.load();
    }
}).use(router);

const vm = appOrder.mount('#page-my-order');