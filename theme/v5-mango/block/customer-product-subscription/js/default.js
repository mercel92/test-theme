const subsList = {
    template : '#subscribe-list',
    data() {
        return vm.$data
    },
    methods: {
        date(date) {
            return T.timeConverter(date, 'd.m.y');
        },
        cancel(id = '') {
            const self = this;
            if (id == '') return;
            axios.get(`${vm.$data.endpoints.cancel}${id}`).then(() => vm.load() );
        },
    },
};

const subDetail = {
    template : '#subscribe-detail',
    data() {
        return {
            DETAIL: [],
            SUBS: {},
            MOBILE: T.isMobile(),
        }
    },
    methods: {
        date(date) {
            return T.timeConverter(date, 'd.m.y');
        },
        getDetail() {
            const self = this;
            const data = {
                start: 0,
                limit: 20
            }
            axios.post(`${vm.$data.endpoints.transactions}${this.$route.params.id}`, data).then(response => {
                self.DETAIL = response.data.data;
                self.SUBS = response.data.subscribe;
            });
        },
    },
    mounted() {
        this.getDetail();
        initComponents();
    }
};

const routes = [
    { path: '/', component: subsList },
    { path : '/detail/:id', component: subDetail}
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

const appSubs = Vue.createApp({
    data() {
        return {
            endpoints: {
                get : '/srv/service/profile/subscribe-list',
                cancel : '/srv/service/profile/subscribe-stop/',
                transactions: '/srv/service/profile/subscribe-transactions/',
            },
            DATA : {},
        }
    },
    methods: {
        load() {
            const self = this;
            axios.get(self.endpoints.get).then(response => {
                self.DATA = response.data;
            }).catch(error => `Subs return error => ${error}`);
        },
    },
    mounted() {
        this.load();
        initComponents();
    }
}).use(router);

const vm = appSubs.mount('#page-my-subscription');