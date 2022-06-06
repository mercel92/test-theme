<div id="zubizu-container" class="col-12 p-3" v-cloak>
    <div class="row">
        <div id="zubizu-signin-container" class="col-12" v-if="signin == false">
            <form id="zubizu-form" class="w-100" ref="zubizuSignin" method="POST" action="/srv/service/zubizu/signin" novalidate autocomplete="off">
                <div class="row align-items-flex-end">
                    <div class="col-2 col-sm-1 pr-0 mb-1 d-flex">
                        <img class="zubizu-logo" src="/theme/standart/images/KrediKart/zubizu_icon.png">
                    </div>
                    <div class="col-10 col-sm-8 mb-1">
                        <label for="zubizu-token-control">{#zubizu_qr_phone#} *</label>
                        <div class="w-100 popover-wrapper position-relative">
                            <input type="text" name="token" id="zubizu-token-control" class="form-control form-control-md" data-validate="required">
                        </div>
                    </div>
                    <div class="col-12 col-sm-3 mb-1 pl-sm-0">
                        <button type="button" class="w-100 btn btn-gray btn-zubizu text-uppercase" @click="signinSubmit($event)">{#send#}</button>
                    </div>
                </div>
            </form>
            <div class="w-100 small-text">
                {#zubizu_info_1#}.
            </div>
        </div>
        <div id="zubizu-campaign-container" class="col-12" v-else>
            <div class="mb-1">{#dear#} <b>{{ customer.customerFirstName }} {{ customer.customerLastName }}</b>,</div>
            <div class="mb-1" v-if="campaigns.length == 0">
                <div class="mb-1">{#zubizu_info_2#}.</div>
                <div>{#happy_shopping#}</div>
            </div>
            <div class="mb-1" v-if="campaigns.length == 1">
                <div v-if="singleCmp == true">
                    <div class="mb-1">{#zubizu_info_3#}.</div>
                    <div>{#happy_shopping#}</div>
                </div>
                <div v-else>
                    <div class="mb-1">{#zubizu_info_2#}.</div>
                    <div>{#happy_shopping#}</div>
                </div>
            </div>
            <div class="zubizu-campaign-list" v-if="campaigns.length > 1">
                <div class="mb-1">{#zubizu_info_4#}.</div>
                <div class="w-100 mb-1" v-for="(CMP, i) in campaigns">
                    <div class="col-12 py-1 border border-light border-round campaign-item">
                        <div class="row align-items-center">
                            <div class="col">
                                <div class="fw-bold campaign-title">{{ CMP.TITLE }}</div>
                                <div class="campaign-description">{{ CMP.DESCRIPTION }}</div>
                            </div>
                            <div class="col-auto">
                                <input type="radio" :name="'campaign' + CMP.GROUP" class="form-control" 
                                        :value="CMP.ID" 
                                        :checked="CMP.SELECTED == 1" 
                                        :class="{ 'checked' : CMP.SELECTED == 1 }" 
                                        :id="'zubizu-cmp-' + CMP.ID"
                                        @change="setCampaign(CMP, $event)">
                                <label :for="'zubizu-cmp-' + CMP.ID" 
                                        class="select-cmp-label px-1 border border-round d-flex align-items-center justify-content-center" 
                                        :class="{ 'border-success text-success fw-bold' : CMP.SELECTED == 1, 'border-light text-body' : CMP.SELECTED != 1 }">
                                    <span class="input-checkbox" :class="{'border-success' : CMP.SELECTED == 1, 'border-light' : CMP.SELECTED != 1}"><i class="ti-check" v-if="CMP.SELECTED == 1"></i></span>
                                    {{ CMP.SELECTED == 1 ? '{#active#}' : '{#activate#}' }}
                                </label>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="d-flex justify-content-flex-end">
                <button type="button" class="btn btn-primary text-uppercase" @click="close()">{#okey#}</button>
            </div>
        </div>
    </div>
</div>

<script>
    const zubizuContainer = {
        data() {
            return {
                campaigns: [],
                singleCmp : false,
                customer: {},
                signin: false,
                endpoints: {
                    getCampaign: '/srv/service/zubizu/get-campaigns',
                    setCampaign: '/srv/service/zubizu/set-campaign/',
                    unsetCampaign: '/srv/service/zubizu/unset-campaign/',
                    summary: '/srv/service/zubizu/summary',
                },
            }
        },
        methods: {
            signinSubmit(btn = null) {
                const self = this;
                const form = self.$refs.zubizuSignin;
                popoverAlert.hideAll();

                if(!T.checkValidity(form))
                return;

                const formData = new FormData(form);

                T.buttonLock.dom = btn.target;
                T.buttonLock.lock();

                axios.post(form.action, formData).then(response => {
                    const result = response.data;
                    T.notify({
                        text: `${result.success ? '{#zubizu_login#}.' : result.message || '{#error_login#}.'}`,
                        className: `${result.success ? 'success' : 'danger'}`,
                        stopOnFocus : true,
                        duration: `${result.success ? 2200 : 3200}`,
                        iconClass : `${result.success ? 'ti-thumbs-up' : ''}`,
                    });
                    if (result.success) {
                        self.reload();
                    }
                    T.buttonLock.unlock();
                }).catch(error => {
                    console.warn(`Zubizu Signin form send error => ${error}`);
                    T.buttonLock.unlock();
                });
            },
            load() {
                const self = this;
                axios.get(self.endpoints.summary).then(response => {
                    const result = response.data;
                    if (result.success) {
                        self.summary = result.data;
                        if (self.summary.customer && self.summary.customer.signedIn == 1) {
                            self.signin = true;
                            self.getCampaign();
                        } else {
                            self.signin = false;
                        }
                    } else {
                        T.modal({ html: '{#error_again#}' });
                    }
                }).catch(error => {
                    console.warn(`Zubizu Load error => ${error}`);
                });
            },
            getCampaign() {
                const self = this;
                axios.get(self.endpoints.getCampaign).then(response => {
                    self.campaigns = response.data.campaigns;
                    self.customer = response.data.customer;
                    if (self.campaigns.length == 1) {
                        self.setCampaign(self.campaigns[0].GROUP, self.campaigns[0].ID, true);
                    }
                }).catch(error => {
                    console.warn(`Zubizu Campaigns List get error => ${error}`);
                });
            },
            setCampaign(campaign = {}, input, single = false) {
                const self = this;
                if (single == false) {
                    if(campaign.SELECTED == '1') {
                        axios.get(`${self.endpoints.unsetCampaign}/${campaign.ID}`).then(() => {
                            self.reload();
                        }).catch(error => console.warn(`Cancel campaign error => ${error}`));
                    } else {
                        axios.get(`${self.endpoints.setCampaign}/${campaign.GROUP}/${campaign.ID}`).then(response => {
                            const result = response.data;
                            if(result.status === 1) {
                                self.reload();
                            } else {
                                T.modal({
                                    html: result.statusText,
                                    width: '500px'
                                });
                                input.target.checked = false;
                            }
                        }).catch(error => console.warn(`Set campaign error => ${error}`));
                    }
                } else {
                    axios.get(`${self.endpoints.setCampaign}/${campaign.GROUP}/${campaign.ID}`).then(response => {
                        const result = response.data;
                        if(result.status === 1) {
                            self.reload();
                            self.singleCmp = true;
                        } else {
                            self.singleCmp = false;
                        }
                    }).catch(error => console.warn(`Set campaign error => ${error}`));
                }
            },
            reload() {
                const self = this;
                cartVue.load(true);
                self.load();
            },
            close() {
                T('.t-modal-backdrop').trigger('click');
            },
        },
        mounted() {
            this.load();
        }
    };

    Vue.createApp(zubizuContainer).mount('#zubizu-container');
</script>