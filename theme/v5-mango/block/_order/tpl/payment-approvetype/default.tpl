<div id="order-approvetype-form" class="col-12 p-1" v-cloak>
    <div class="row">
        <div id="approvetype-sms" class="col-12" :class="{'col-md-6': data.GET_APPROVEPHONE == 'true'}" v-if="data.GET_APPROVESMS == 'true'">
            <div class="block-title mb-1">{#sms_for_confirm#}</div>
            <div class="mb-1">{#sms_confirm_info#}.</div>
            <div class="mb-1 position-relative">
                <input readonly type="text" name="sms_phone" class="form-control form-control-lg" v-model="mobile">
            </div>
            <button type="button" class="btn btn-primary w-100" @click="approveType(1)">{#send#}</button>
        </div>
        <div id="approvetype-phone" class="col-12" :class="{'col-md-6': data.GET_APPROVESMS == 'true'}" v-if="data.GET_APPROVEPHONE == 'true'">
            <div class="block-title mb-1">{#phone_for_confirm#}</div>
            <div class="mb-1">{#phone_confirm_info#}.</div>
            <div class="mb-1 position-relative">
                <input readonly type="text" name="phone_phone" class="form-control form-control-lg" v-model="mobile">
            </div>
            <button type="button" class="btn btn-primary w-100" @click="approveType(2)">{#confirm#}</button>
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

const approvetypeForm = {
    data() {
        return {
            data: DATA,
            status: false,
            mobile:null,
        }
    },
    methods: {
        approveType(type) {
            const self = this;
            if (self.status) return;

            self.status = true;
            const formData = new FormData();
            formData.append('phone', self.mobile);
            formData.append('type', type);
            axios.post('/Order/OrderAPI/setApproveType', formData).then(result => {
                if (result.data.success) {
                    T('.t-modal-backdrop').trigger('click');
                    vm.nextStep();
                } else {
                    self.status = false;
                }
            }).catch(error => {
                self.status = true;
            });
        },

    },
    mounted() {
        const self = this;
        initComponents();
        self.mobile = `+${self.data.GET_PHONE}`;
    },
};
Vue.createApp(approvetypeForm).mount('#order-approvetype-form');
</script>