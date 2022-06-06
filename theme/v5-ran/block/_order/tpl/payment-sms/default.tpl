<div id="order-sms-form" class="col-12 p-1" v-cloak>
    <div class="w-100" v-if="smsSecond !== 0">
        <div class="mb-1">
            <span class="text-primary fw-bold">+{{ data.GET_PHONE }}</span> {#sms_form_info_1#} <span class="text-primary fw-bold">{{ data.GET_REFCODE }}</span> {#sms_form_info_2#}!
        </div>
        <div class="mb-1">
            <span class="text-primary fw-bold">{{ smsSecond }}</span> {#sms_form_info_3#}!
        </div>
        <div class="col-12">
            <div class="row">
                <div class="popover-wrapper position-relative w-100 mb-1">
                    <input type="text" placeholder="{#sms_code#}" name="sms_code" id="sms-code" class="form-control form-control-lg" v-model="smsCode">
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-6">
                <button type="button" class="btn btn-success w-100" @click="ready()">{#code_enter#}</button>
            </div>
            <div class="col-6">
                <button type="button" class="btn btn-black w-100" @click="close()">{#close#}</button>
            </div>
        </div>
    </div>
    <div class="w-100" v-else>
        <div class="mb-1">
            {#sms_time_info#}.
        </div>
        <div id="sms-again" class="w-100" v-if="smsSecond === 0">
            <button type="button" class="btn btn-primary w-100" @click="again()">{#again_send_code#}</button>
        </div>
    </div>
</div>

<script>
let DATA = {};
try {
    DATA = {$DATA};
} catch (ex) {
    DATA = {};
}

const smsForm = {
    data() {
        return {
            data: DATA,
            smsSecond: null,
            smsInterval: null,
            status: false,
            smsCode: '',
        }
    },
    methods: {
        smsProcess() {
            const self = this;
            if(self.smsSecond > 0) {
                self.smsSecond--;
            }
            if (self.smsSecond === 0) {
                clearInterval(self.smsInterval);
            }
        },
        ready() {
            const self = this;
            if(self.status == true){
                return false;
            }
            if (self.smsCode == '') {
                T.modal({ html:'{#sms_code_enter#}' });
                return;
            }
            self.status = true;
            popoverAlert.hideAll();

            const formData = new FormData();
            formData.append('code', self.smsCode);
            axios.post('/srv/service/order-v5/check-sms', formData).then(result => {
                if (result.data.status === 1) {
                    T('.t-modal-backdrop').trigger('click');
                    vm.$router.push('/approve');
                } else {
                    T.modal({ html:'{#error_code#}' });
                    self.status = false;
                }                
            }).catch(error => {
                self.status = false;
            });
            return false;
        },
        close() {
            const formData = new FormData();
            formData.append('type', 0);
            axios.post('/Order/OrderAPI/setApproveType', formData).then(result => {
                if(result.data.success){
                    T('.t-modal-backdrop').trigger('click');
                }
            });
            return false;
        },
    },
    mounted() {
        const self = this;
        self.smsSecond = self.data.GET_SECOND;
        self.smsInterval = self.smsInterval || null;
        clearInterval(self.smsInterval);
        self.smsInterval = setInterval(self.smsProcess, 1000);
    },
};
Vue.createApp(smsForm).mount('#order-sms-form');
</script>