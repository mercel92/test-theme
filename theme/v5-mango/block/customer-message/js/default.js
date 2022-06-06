const MessageList = {
    name: 'MessageList',
    template: '#message-list',
    data() {
        return vm.$data
    },
    methods: {
        date(date) {
            return T.timeConverter(date, 'd.m.y | h:s')
        },
    }
};

const MessageDetail = {
    name: 'MessageDetail',
    template: '#message-detail',
    data() {
        return {
            ID : this.$route.params.id,
            DETAIL : {},
            MESSAGE : {}
        }
    },
    methods : {
        load() {
            const self = this;
            axios.get(`/api/v1/customer/messages/${self.ID}`).then(response => {
                self.DETAIL = response.data.data[0].detail;
                self.MESSAGE = response.data.data[0].message;
                self.scroll();
            });
        },
        scroll() {
            setTimeout(() => {
                const chatScroll = document.querySelector('.message-chat-list');
                if (chatScroll.scrollHeight > 380) {
                    chatScroll.scrollTop = chatScroll.scrollHeight;
                }
            }, 250);
        },
        sendMessage() {
            const self = this,
                  form = self.$refs.sendMessageForm,
                  formData = new FormData(form);

            T.buttonLock.dom = form.querySelector('button[type="submit"]');
            T.buttonLock.lock();

            if (form.querySelector(`#message${self.ID}`).value == '') {
                scroll({
                    top: T(`#message${self.ID}`)[0].parentElement.offsetTop - 120,
                    behavior: "smooth"
                });
                T(`#message${self.ID}`)[0].focus();
                T.buttonLock.unlock();
                return;
            }

            axios.post(form.action, formData).then(response => {
                const result = response.data;
                T.buttonLock.unlock();

                if (result.status == true) {
                    form.querySelector(`#message${self.ID}`).value = '';
                    T.notify({
                        text: result.message || '{#send_message#}',
                        className: 'success',
                        duration: 1800,
                    });
                    self.load();
                }
            }).catch(error => { T.buttonLock.unlock(); console.log(`Error post detail message => ${error}`); });
        },
        closeMsg(id) {
            const self = this,
                  formData = new FormData();
            formData.append('status', 0);

            axios.put(`/api/v1/customer/messages/${id}`, formData).then(response => {
                const result = response.data;
                T.notify({
                    text: result.message || '{#subject_closed#}.',
                    className: 'success',
                    duration: 1800,
                    iconClass : 'ti-thumbs-up'
                });
                self.$router.push('/');
                vm.load();
            });
        },
        date(date) {
            return T.timeConverter(date, 'd.m.y | h:s')
        },
    },
    mounted(){
        this.load();
    }
};

const newMessage = {
    name: 'NewMessage',
    template: '#new-message',
    data() {
        return vm.$data
    },
    methods: {
        sendMessage() {
            const self = this,
                  form = self.$refs.sendMessageForm,
                  formData = new FormData(form);

            if (!T.checkValidity(form)) {
                scroll({
                    top: T('.error-input')[0].parentElement.offsetTop - 120,
                    behavior: "smooth"
                });
                return;
            }

            T.buttonLock.dom = form.querySelector('button[type="submit"]');
            T.buttonLock.lock();

            axios.post(form.action, formData).then(response => {
                const result = response.data;
                T.buttonLock.unlock();

                if (result.status === 0) {
                    popoverAlert.show(form.querySelector(`[name="${result.key}"]`), result.message, 3000, `btn btn-danger no-radius text-left`);
                } else {
                    T.notify({
                        text: result.message || '{#send_message#}',
                        className: 'success',
                        duration: 1800,
                        iconClass : 'ti-thumbs-up'
                    });
                    self.$router.push('/');
                    vm.load();
                }
            }).catch(error => {
                T.notify({
                    text: error.response.data.message,
                    className: 'danger',
                    duration: 1800,
                });
                T.buttonLock.unlock();
            });
        }
    },
    created() {
        const self = this;
        if (self.DEPARTMENT_LIST == '') {
            axios.get(self.endpoints.getDepartment).then(response => {
                self.DEPARTMENT_LIST = response.data.data;
            }).catch(error => `Error get department list => ${error}`);
        }
    }
};

const routes = [
    { path: '/', component: MessageList },
    { path: '/detail/:id?', component: MessageDetail },
    { path: '/new', component: newMessage }
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

const appMessages = Vue.createApp({
    data() {
        return {
            endpoints: {
                get: '/api/v1/customer/messages',
                getDepartment: '/api/v1/public/department'
            },
            DATA: {},
            MEMBER: MEMBER_INFO,
            DEPARTMENT_LIST: ''
        }
    },
    methods: {
        load() {
            const self = this;
            axios.get(self.endpoints.get).then(response => {
                self.DATA = response.data.data;
            }).catch(error => `Get member messages error => ${error}`);
        },
    },
    mounted() {
        this.load();
    }
}).use(router);

const vm = appMessages.mount('#page-my-messages');