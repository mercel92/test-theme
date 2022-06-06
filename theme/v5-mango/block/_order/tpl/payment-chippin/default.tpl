<div id="order-chippin-form" class="col-12 p-1" v-cloak>
    <div class="w-100" v-if="data.GET_STEP == '0'">
        <label for="chippin-no" class="d-flex">
            <img src="/theme/standart/images/KrediKart/chippin-masterpass.png">
        </label>
        <div class="w-100 position-relative mb-1">
            <input id="chippin-no" type="number" name="chippinno" placeholder="Chippin No" class="form-control form-control-lg no-arrows" v-model="opt.chippinno">
        </div>
        <button type="button" class="w-100 btn btn-primary text-uppercase" @click="checkout();">{#send#}</button>
    </div>
    <div class="w-100" v-if="data.GET_STEP == '1'">
        <div class="fw-bold mb-1">{#chippin_info#}.</div>
        <button type="button" class="w-100 btn btn-black text-uppercase" @click="cancel();">{#cancel#}</button>
    </div>
</div>

<script>
let DATA = {};
try {
    DATA = {$DATA};
} catch (ex) {
    DATA = {};
}

const chippinForm = {
    data() {
        return {
            data: DATA,
            chippinStatus: '',
            opt: {
                chippinno: '',
            },
        }
    },
    methods: {
        checkout() {
            const self = this;
            if (self.opt.chippinno == '') {
                T.modal({ html:'{#chippin_no_enter#}.' });
                return;
            }
            vm.checkoutRequest(self.opt);
            setTimeout(() => { T('.t-modal-backdrop').trigger('click'); }, 150);
        },
        cancel() {
            const self = this;
            self.chippinCancel();
        },
        chippinListener() {
            const self = this;
            const tm = () => {
                if (self.chippinStatus == -1) return;
                setTimeout(() => { self.chippinListener(); }, 2000);
            };
            const rf = (result) => {
                if (self.chippinStatus == -1) return;
                if (result.data && result.data.success) {
                    if (result.data.data === 1) { tm(); } else { orderBackdrop(); window.location.reload(); }
                } else { tm(); }
            };
            axios({
                url: '/Order/OrderAPI/chippinStatus',
                dataType: "json",
            }).then((result) => { rf(result); }).catch(() => { tm(); });
        },
        chippinCancel() {
            if(!confirm("{#cancel_alert#}")){
                return;
            }
            orderBackdrop();
            axios({
                url: '/Order/OrderAPI/chippinCancel',
                dataType: 'json',
            }).then(result => {
                orderBackdrop(true);
                if (result.data.success) {
                    self.chippinStatus = -1;
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
    mounted() {
        const self = this;
        if (self.data.GET_STEP == 1) {
            self.chippinStatus = 1;
            orderBackdrop(true);
            setTimeout(() => { self.chippinListener(); }, 2000);
        }
    }
};

Vue.createApp(chippinForm).mount('#order-chippin-form');
</script>