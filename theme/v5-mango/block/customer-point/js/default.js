const PagePoints = {
    data() {
        return {
            endpoints: {
                get: '/srv/service/profile/load-points/'
            },
            DATA: {},
            LOADING: true,
            FILTER_ID: 0,
            BLOCK: BLOCK
        }
    },
    methods: {
        load() {
            const self = this;
            axios.get(self.endpoints.get + self.FILTER_ID).then(response => {
                self.DATA = response.data;
                self.LOADING = false;
                setTimeout(function() {
                    initComponents();
                }, 200);
            }).catch(error => `Get member points error => ${error}`);
        },
        timeConverter(time) {
            return T.timeConverter(time);
        }
    },
    watch: {
        'FILTER_ID'() {
            this.load();
        }
    },
    mounted() {
        this.load();
    }
}

Vue.createApp(PagePoints).mount('#page-my-points');