<div id="hopi-container" class="col-12" v-cloak>
    <div class="row">
        <div id="hopi-signin-container" class="col-12 p-3" v-if="signin == false">
            <div class="row align-items-center">
                <div class="col-12 col-md-7">
                    <div class="mb-2 d-flex align-items-center justify-content-center">
                        <img class="hopi-logo" src="/theme/standart/images/KrediKart/hopi-logo.jpg">
                    </div>
                    <div class="mb-2 text-center">
                        <b class="hopi-text">Hopi</b>'n varsa, kampanyalardan yararlanmak ve <b class="hopi-text">Paracık</b>'larınla alışveriş yapmak için aşağıya <b class="hopi-text">Hopi Kimlik Kodunu gir</b>.
                    </div>
                    <form id="hopi-signin-form" class="w-100 mb-2" ref="hopiSignin" method="POST" action="/srv/service/hopi/signin" novalidate autocomplete="off">
                        <div class="w-100 popover-wrapper position-relative mb-1">
                            <input type="text" class="form-control form-control-md hopi-text" name="token" placeholder="HOPİ KİMLİK KODUNUZU GİRİNİZ" data-validate="required">
                        </div>
                        <div class="d-flex justify-content-center">
                            <button type="button" class="col-8 col-lg-6 no-radius border-rounded btn btn-hopi text-uppercase" @click="signinSubmit($event)">Devam</button>
                        </div>
                    </form>
                    <div class="text-center small-text">
                        Hopi'n yok mu? <a href="http://www.hopi.com.tr/" target="_blank" class="hopi-text text-underline"><b>Hemen tıkla</b></a>, Hopi'nle tanış!
                    </div>
                </div>
                <div class="col-12 col-md-5 d-none d-md-flex align-items-center justify-content-center">
                    <img src="/theme/standart/images/KrediKart/hopi-phone.jpg">
                </div>
            </div>
        </div>
        <div id="hopi-campaign-container" class="col-12 p-1" v-if="signin == true">
            <div class="row">
                <div class="col-12" v-if="data.summary && data.summary.customer">
                    <div class="row align-items-center">
                        <div class="col-12 col-md-7 my-1">
                            <div class="mb-1 d-flex align-items-center">
                                <img class="hopi-logo" src="/theme/standart/images/KrediKart/hopi-logo.jpg">
                            </div>
                            <div class="mb-1">Merhaba, <b class="hopi-text">{{ name }}</b>, toplam <b class="hopi-text">{{ format(data.summary.customer.coinBalance) }} Paracık</b>'ın bulunuyor.</div>
                            <div>Kampanya ya da <b class="hopi-text">Paracık</b> kullanmak istemiyorsan <b class="hopi-text">"DEVAM"</b> butonuna basman yeterli.</div>
                        </div>
                        <div class="col-12 col-md-5">
                            <div class="col-12 p-1 mb-1 border border-round">
                                <div class="w-100 position-relative mb-1">
                                    <label for="hopiUseCoinControl">Paracık Kullanımı</label>
                                    <input type="number" name="useCoinInput" id="hopiUseCoinControl" placeholder="Paracık Kullanımı" class="form-control form-control-md no-arrows" v-model="hopiUseCoin">
                                </div>
                                <div class="w-100 mb-1">
                                    <label for="hopiUseMoneyControl">TL Karşılığı</label>
                                    <input type="text" name="useCoinInput" id="hopiUseMoneyControl" placeholder="TL Karşılığı" class="form-control form-control-md no-arrows" readonly v-model="hopiUseMoney">
                                </div>
                                <div class="w-100 mb-1">
                                    Kalan Paracık : 
                                    <span class="fw-bold">
                                        {{ format(hopiUseCoin == '' || hopiUseCoin < 0 ? data.summary.customer.coinBalance : (data.summary.customer.coinBalance - hopiUseCoin)) }}
                                    </span>
                                </div>
                                <div class="w-100 fw-bold">
                                    Sepet Tutarı : {{ format(hopiUseCoin == '' || hopiUseCoin < 0 ? data.cartPrice : (data.cartPrice - hopiUseCoin)) }}
                                </div>
                            </div>
                        </div>
                        <div class="w-100 d-flex">
                            <div class="col-12 col-md-5 ml-auto">
                                <button type="button" class="w-100 no-radius border-rounded btn btn-hopi text-uppercase" @click="setCampaign()">Devam</button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-12 mt-1" v-if="campaigns.length > 0">
                    <div class="row">
                        <div class="col-12" v-for="c in campaigns">
                            <div class="position-relative mb-1" v-if="c._appropriate">
                                <input type="radio" :id="'hopi-id-' + c.id" name="hopiCampaignCode" :value="c.code" :data-type="c._benefit.type" class="form-control">
                                <label :for="'hopi-id-' + c.id" class="border border-round d-flex align-items-center p-1">
                                    <span class="input-radio"><i class="ti-circle"></i></span>
                                    <div>
                                        <span v-html="c.name" :data-title="c.description" data-toggle="tooltip"></span>
                                        <div class="w-100 small-text mt-1 text-gray">Son Kullanım Tarihi : <span class="fw-bold">{{ date(c.finish_date) }}</span></div>
                                    </div>
                                </label>
                            </div>
                            <div class="position-relative mb-1" v-else>
                                <input type="radio" :id="'hopi-id-' + c.id" name="hopiCampaignCode" :value="c.code" :data-type="c._benefit.type" class="form-control">
                                <label :for="'hopi-id-' + c.id" class="border border-round d-flex align-items-center p-1">
                                    <span class="input-radio"><i class="ti-circle"></i></span>
                                    <div>
                                        <span v-html="c.name" :data-title="c.description" data-toggle="tooltip"></span>
                                        <div class="w-100 small-text mt-1 text-gray">Son Kullanım Tarihi : <span class="fw-bold">{{ date(c.finish_date) }}</span></div>
                                    </div>
                                </label>
                            </div>
                        </div>
                        <div class="col-12">
                            <div class="position-relative mb-1">
                                <input type="radio" id="hopi-id-not" name="hopiCampaignCode" :value="" class="form-control">
                                <label for="hopi-id-not" class="border border-round d-flex align-items-center p-1">
                                    <span class="input-radio"><i class="ti-circle"></i></span>
                                    <span>Kampanyadan yararlanmadan devam etmek istiyorum</span>
                                </label>
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
        DATA = {$DATA};
    } catch (ex) {
        DATA = {}
    }

    const hopiContainer = {
        data() {
            return {
                data: {},
                endpoints: {
                    get: '/srv/service/hopi/get-campaigns',
                    set: '/srv/service/hopi/set-campaign',
                },
                signin: null,                
                name: DATA.CUSTOMER.FIRSTNAME,
                campaigns: [],
                hopiUseCoin: '',
                hopiUseMoney: '',
                isDisabled: 0,
            }
        },
        methods: {
            format(p) {
                return T.format(p);
            },
            vat(p, vat) {
                return T.vat(p, vat);
            },
            date(date) {
                return T.timeConverter(date, 'd.m.y')
            },
            signinSubmit(btn) {
                const self = this;
                const form = self.$refs.hopiSignin;
                popoverAlert.hideAll();

                if(!T.checkValidity(form))
                return;

                const formData = new FormData(form);

                T.buttonLock.dom = btn.target;
                T.buttonLock.lock();

                axios.post(form.action, formData).then(response => {
                    const result = response.data;
                    T.notify({
                        text: `${result.success ? 'Hopi girişi başarıyla yapıldı.' : 'Hatalı giriş, lütfen bilgilerinizi kontrol ediniz.'}`,
                        className: `${result.success ? 'success' : 'danger'}`,
                        stopOnFocus : true,
                        duration: `${result.success ? 2200 : 3200}`,
                        iconClass : `${result.success ? 'ti-thumbs-up' : ''}`,
                    });
                    if (result.success) {
                        self.load();
                    }
                    T.buttonLock.unlock();
                }).catch(error => {
                    console.warn(`Hopi Signin form send error => ${error}`);
                    T.buttonLock.unlock();
                });
            },
            load() {
                const self = this;
                axios.get(self.endpoints.get).then(response => {
                    self.data = response.data;
                    if (self.data.summary && self.data.summary.customer && self.data.summary.customer.signedIn == 1) {
                        self.signin = true;
                        self.campaigns = self.data.campaigns;
                        cartVue.load(true);
                    } else {
                        self.signin = false;
                    }
                    setTimeout(() => { initComponents(); }, 200);
                }).catch(error => {
                    console.warn(`Hopi Campaigns List get error => ${error}`);
                });
            },
            getCampaignByCode(code) {
                const self = this,
                      item = Array.from(self.campaigns).find(x => x.code == code);
                let cmp = false;

                if (item) cmp = item;
                if(typeof cmp._benefit != "undefined"){
                    cmp._benefit.promotion_value = parseFloat(cmp._benefit.promotion_value);
                    cmp._benefit.promotion_max_value = parseFloat(cmp._benefit.promotion_max_value);
                }

                return cmp;
            },
            setCampaign() {
                const self = this;
                if (self.isDisabled == 1) return;

                const status = self.campaigns.length > 0 ? 1 : 0;
                let cmpVal = '';
                if (status == 1) {
                    const code = T('[name=hopiCampaignCode]:checked');
                    if (code.length < 1) {
                        T.modal({
                            html : 'Sepetine uygun bir kampanya seçmelisin',
                        });
                        return false;
                    } else if (code[0].value != '' && code[0].value != '-1' && code[0].dataset.type == 'booster' && self.hopiUseCoin == '') { 
                        T.modal({
                            html : 'Booster kampanyasından faydalanmak için paracık kullanmalısın',
                        });
                        return false;
                    } else {
                        cmpVal = code[0].value;
                    }
                }

                const formData = new FormData();
                      formData.append('coin', self.hopiUseCoin);
                      formData.append('campaign', cmpVal);

                self.isDisabled = 1;

                axios.post(self.endpoints.set, formData).then(respose => {
                    const result = respose.data;
                    if (result.success) {
                        cartVue.load(true);
                        T('.t-modal-backdrop').trigger('click');
                    } else if (result.error == 'TIMEOUT') {
                        self.isDisabled = 0;
                        T('.t-modal-backdrop').trigger('click');
                        loadSubFolder({
                            pageId: 30,
                            blockParentId: 1054,
                            subFolder: 'hopi',
                            params : {},
                            success:  function(loadRes){
                                cartVue.load(true);
                                T.modal({ html: loadRes, width:'768px' });
                            }
                        });
                    } else {
                        T.modal({ html: result.message || 'hata oluştu tekrar deneyin', });
                    }
                }).catch(error => {
                    self.isDisabled = 0;
                });

            },
        },
        mounted() {
            this.load();
        },
        watch: {
            'hopiUseCoin'(value) {
                const self = this;

                if (value < 0) value = 0;
                if (value > self.data.summary.customer.coinBalance) value = self.data.summary.customer.coinBalance;
                if (value > self.data.cartPrice) value = self.data.cartPrice;

                value = Math.floor(value * 100) / 100;
                let bt = value;
                const code = T("[name=hopiCampaignCode]:checked");
                if (code.length > 0) {
                    const selectCmp = self.getCampaignByCode(T("[name=hopiCampaignCode]:checked")[0].value);
                    if (selectCmp) {
                        if(selectCmp._benefit.type == 'booster' && selectCmp._benefit.promotion_value > 0){
                            bt = value * selectCmp._benefit.promotion_value;
                            if(value > selectCmp._benefit.promotion_max_value && selectCmp._benefit.promotion_max_value > 0){
                                bt = (selectCmp._benefit.promotion_max_value * selectCmp._benefit.promotion_value) + (value - selectCmp._benefit.promotion_max_value);
                            }
                            if(bt > self.data.cartPrice){
                                bt = self.data.cartPrice;
                                const bb = bt / selectCmp._benefit.promotion_value;
                                if(bb > selectCmp._benefit.promotion_max_value && selectCmp._benefit.promotion_max_value > 0){
                                    value = self.data.cartPrice - (selectCmp._benefit.promotion_max_value * (selectCmp._benefit.promotion_value - 1));
                                }
                                else {
                                    value = bb;
                                }
                            }
                            if(bt > selectCmp._cartSummary.amount){
                                const wPromox = selectCmp._cartSummary.amount;
                                const wPromo  = wPromox / selectCmp._benefit.promotion_value;
                                if(selectCmp._benefit.promotion_max_value > 0 && wPromo > selectCmp._benefit.promotion_max_value){
                                    wPromox = selectCmp._benefit.promotion_max_value * selectCmp._benefit.promotion_value;
                                    wPromo = wPromox / selectCmp._benefit.promotion_value;
                                    bt = value - wPromo + wPromox;
                                }
                                else {
                                    bt = value - wPromo + wPromox;
                                }
                            }
                            bt = Math.floor(bt * 100) / 100;
                        }
                    }
                }
                if (value > 0) self.hopiUseCoin = value;
                self.hopiUseMoney = `${self.format(bt)} TL`;
            },
        },
    };

    Vue.createApp(hopiContainer).mount('#hopi-container');
</script>