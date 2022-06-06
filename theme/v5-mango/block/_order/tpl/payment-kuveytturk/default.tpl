<div id="order-kuveytturk-form" class="col-12 p-1" v-cloak>
    <div id="kuveytturk-qrCode" class="mb-1" v-if="qrCode">
        <img src="qrCode">
    </div>
    <div class="mb-1 fw-bold text-primary">{#read_qr_code#}</div>
    <button type="button" class="w-100 btn btn-black text-uppercase" @click="kuveytturkCancel()">{#cancel#}</button>
</div>

<script>
window['kuveytTurkForm'] = {
    data() {
        return {
            status: '',
            qrCode: '',
        }
    },
    methods: {
        checkout() {
        },
        init(result) {
            const self = this;
            self.status = 1;
            orderBackdrop(false);
            self.formInit(1, result);
            orderBackdrop(true);
            setTimeout(() => { self.kuveytturkListener(); }, 2000);
        },
        formInit(step, result) {
            const self = this;
            self.qrCode = `data:image/svg+xml; base64,${result.data.qr_svg}`
        },
        kuveytturkListener() {
            const self = this;
            const tm = () => {
                if (self.status == -1) return;
                setTimeout(() => { self.kuveytturkListener(); }, 2000);
            };
            const rf = (result) => {
                if (result.data && result.data.success) {
                    if (result.data.data === 1) { tm(); } else { orderBackdrop(); window.location.reload(); }
                } else { tm(); }
            };
            axios({
                url: '/Order/OrderAPI/shoppingLoanStatus',
                dataType: "json",
            }).then((result) => { rf(result); }).catch(() => { tm(); });
        },
        kuveytturkCancel() {
            if(!confirm("{#cancel_alert#}")){
                return;
            }
            orderBackdrop();
            axios({
                url: '/Order/OrderAPI/shoppingLoanCancel',
                dataType: 'json',
            }).then(result => {
                orderBackdrop(true);
                if (result.data.success) {
                    self.status = -1;
                    T('.t-modal-backdrop').trigger('click');
                } else {
                    alert(result.data.message || "{#error_again#}");
                }
            }).catch(error => {
                orderBackdrop(true);
                alert("{#error_again#}");
            });
        },
    },
};

Vue.createApp(kuveytTurkForm).mount('#order-kuveytturk-form');
</script>