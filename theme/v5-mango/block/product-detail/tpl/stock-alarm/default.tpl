<div id="popup-alarm-list" class="col-12 p-1" v-cloak>
    {{ message }}
</div>

<script>
let DATA = {};
try {
    DATA = {$DATA};
} catch (ex) {
    DATA = {}
}

const PopupAlarmList = {
    data() {
        return {
            data: DATA,
            endpoints: {
                get: '/srv/service/profile/add-to-stock-alarm-list/',
            },
            message:'',
        }
    },
    methods: {
        load() {
            const self = this;
            axios.get(`${self.endpoints.get}/${self.data.GET_PRODUCT}-${self.data.GET_VARIANT}`).then(response => {
                const result = response.data;
                self.message = result.statusText;
            });
        }
    },
    mounted() {
        this.load();
    },
};

Vue.createApp(PopupAlarmList).mount('#popup-alarm-list');
</script>