<div id="creditcard-campaign-form p-1" v-cloak>
    <div class="block-title mb-1">
        {#campaing#}
    </div>
    <div class="row">
        <div class="col-12 mb-1">
            <input type="radio" name="creditCardCampaignCode" id="credit-cart-code-00" class="form-control" value="" checked>
            <label for="credit-cart-code-00" class="w-100 h-100 d-flex align-items-center mb-0">
                <span class="input-radio"><i class="ti-circle"></i></span>
                <div>{#want_campaing#}</div>
            </label>
        </div>
        <div class="col-12 mb-1" v-for="(C, i) in cmpList">
            <input type="radio" name="creditCardCampaignCode" :id="'credit-cart-code-' + i" class="form-control" :value="C.code">
            <label :for="'credit-cart-code-' + i" class="w-100 h-100 d-flex align-items-center mb-0">
                <span class="input-radio"><i class="ti-circle"></i></span>
                <div v-html="C.message"></div>
            </label>
        </div>
    </div>
    <div class="row">
        <div class="col-12">
            <button type="button" class="btn btn-success w-100" @click="checkout()">{#ready#}</button>
        </div>
    </div>
</div>

<script>
    window['creditCardCampaingForm'] = {
        data() {
            return {
                cmpList : {},
            }
        },
        methods: {
            checkout() {
                vm.checkoutRequest();
                T('.t-modal-backdrop').trigger('click');
            },
            init(campaigns) {
                const self = this;
                self.cmpList = campaigns;
            },
        },
    }

    Vue.creatApp(creditCardCampaingForm).mount('#creditcard-campaign-form');
</script>