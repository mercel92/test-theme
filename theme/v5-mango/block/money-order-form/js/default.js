const PageMoneyForm = {
    data() {
        return { 
            endpoints : {
                get : '/srv/remittance-form/get-data',
            },
            DATA : {},
            LOADING : true
        }
    },
    methods : {
        load() {
            const self = this;

            axios.get(self.endpoints.get).then( response => {
                self.DATA = response.data.data[0];
                self.LOADING = false;
                setTimeout(() => { initComponents(); }, 240);
            }).catch(error => `Get money form error => ${error}`);
        },
        sendForm(ref) {
            const self = this;

            const formEl = self.$refs[ref];
            popoverAlert.hideAll();
        
            if(!T.checkValidity(formEl))
                return;

            const formData = new FormData(formEl);

            axios.post(self.DATA.SAVE_URL, formData).then(response => {
                const result = response.data;
                T.notify({
                    text: result.success == true ? '{#send_notify#}' : result.message,
                    className: result.success == true ? 'success' : 'danger',
                    duration: 3200,
                    iconClass : result.success == true ? 'ti-thumbs-up' : 'ti-thumbs-down'
                });
                self.LOADING = true;
                self.load();
            });
        },
    },
    mounted() {
        this.load();
    }
}
Vue.createApp(PageMoneyForm).mount('#page-my-money-order');