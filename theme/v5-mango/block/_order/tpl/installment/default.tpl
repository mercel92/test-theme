<div id="order-installment-app" class="w-100 p-1" v-cloak>
    <div class="border-bottom block-title d-flex flex-wrap justify-content-between align-items-center position-relative mb-1">
        <strong>{#installment_table#}</strong>
        <div>
            <input type="checkbox" class="form-control" id="commercial-card-input" v-model="commercialCard" @change="setInstallment()">
            <label for="commercial-card-input">
                <span class="input-checkbox"><i class="ti-check"></i></span>
                {#commercial_card_user#}
            </label>
        </div>
    </div>
    <div class="row">
        <div class="col-12 col-sm-6 col-md-4 col-lg-3 installment-banks-item" v-for="bank in data.CARD_LIST">
            <div class="w-100 border border-round">
                <div class="bank-logo border-bottom d-flex align-items-center justify-content-center"><img :src="bank.IMAGE_URL" :alt="bank.CARD_NAME"></div>
                <div class="w-100 d-flex bank-installment-header">
                    <div class="col-4 fw-bold border-right text-left">{#installment_numbers#}</div>
                    <div class="col-4 fw-bold border-right text-center">{#monthly_payment#}</div>
                    <div class="col-4 fw-bold text-right">{#total_price#}</div>
                </div>
                <div class="w-100 installment-list">
                    <div class="w-100 border-top d-flex" v-for="ins in bank.INSTALLMENTS">
                        <div class="col-4 border-right text-left">{{ ins.INSTALLMENT }} <span v-if="Number(ins.PLUS_INSTALLMENT) > 0"> + {{ ins.PLUS_INSTALLMENT }}</span> {#installment#}</div>
                        <div class="col-4 border-right text-center">{{ format(ins.RAW_INSTALLMENT_AMOUNT) }} {{ data.CURRENCY }}</div>
                        <div class="col-4 text-right">{{ format(ins.RAW_TOTAL_AMOUNT) }} {{ data.CURRENCY }}</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    const OrderInstallment = {
        data() {
            return {
                data: {},
                commercialCard: 0,
            }
        },
        methods: {
            format(p) {
                return T.format(p);
            },
            getInstallment(id = null) {
                const self = this;
                const srv = id == null ? '' : id;
                axios.get('/srv/service/order-v4/get-installment-list/' + srv).then(result => {
                    console.log(result);
                    self.data = result.data;
                });
            },
            setInstallment() {
                const self = this;
                self.getInstallment(self.commercialCard === true ? 1 : 0);
            }
        },
        mounted() {
            this.getInstallment();
        }
    };

    Vue.createApp(OrderInstallment).mount('#order-installment-app');
</script>