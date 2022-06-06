<div id="installment-list" class="w-100" v-cloak>
    <div class="col-12">
        <div class="row">
            <div class="col-12 col-sm-6 col-md-4 py-1" v-for="BANK in DATA.BANK_LIST">
                <div class="col-12 border h-100">
                    <div class="row border-bottom">
                        <img :src="`/Data/KrediKartLogo/${BANK.ID}.jpg`" 
                            :data-src="`/Data/KrediKartLogo/${BANK.ID}.jpg`" 
                            :alt="BANK.CARD_NAME"
                            class="img-responsive d-block mx-auto lazyload">
                    </div>
                    <div class="row">
                        <div class="col-12 border-bottom">
                            <div class="row">
                                <div class="col-4 p-1 border-right d-flex align-items-center justify-content-center text-center text-body">{#installment#}</div>
                                <div class="col-4 p-1 border-right d-flex align-items-center justify-content-center text-center text-body">{#installment_total#}</div>
                                <div class="col-4 p-1 d-flex align-items-center justify-content-center text-center text-body">{#total_total#}</div>
                            </div>
                        </div>
                        <div class="col-12" v-for="(INSTALLMENT, index) in BANK.INSTALLMENT_LIST" :class="{ 'border-bottom' : index != BANK.INSTALLMENT_LIST.length - 1 }">
                            <div class="row">
                                <div class="col-4 p-1 border-right d-flex align-items-center justify-content-center text-center text-body">{{ INSTALLMENT.INSTALLMENT_NUMBER }}</div>
                                <div class="col-4 p-1 border-right d-flex align-items-center justify-content-center text-center text-body">{{ INSTALLMENT.PRICE_INSTALLMENT }} {{ DATA.TARGET_CURRENCY }}</div>
                                <div class="col-4 p-1 d-flex align-items-center justify-content-center text-center text-body">{{ INSTALLMENT.PRICE_TOTAL }} {{ DATA.TARGET_CURRENCY }}</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    let DATA = {};
    try {
        DATA = JSON.parse(`{$DATA}`);
    } catch (ex) {
        DATA = {};
    }

    const InstallmentList = {
        data() {
            return {
                DATA: DATA
            }
        },
        mounted() {
            
        }
    };

    Vue.createApp(InstallmentList).mount('#installment-list');
</script>