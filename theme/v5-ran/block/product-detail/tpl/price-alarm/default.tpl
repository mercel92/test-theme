<div id="popup-alarm-list" class="w-100 py-1" v-cloak>
    <div class="col-12">
        <div class="block-title mb-1">{#price_alert#}</div>
        <p class="text-body">{#price_alert_info1#} <strong v-html="data.P.TITLE"></strong> {#price_alert_info2#}</p>
        <div class="w-100 mt-1 text-body">
            <div class="row mb-1 align-items-center popover-wrapper">
                <div class="col-9">
                    <input type="text" id="alarm-price-sell" class="form-control form-control-md no-arrows" :value="format(data.P.PRICE_SELL)" required disabled>
                </div>
                <div class="col-3 pl-0">{{ data.P.CURRENCY }} <span>{{ vat_text }}</span></div>
            </div>
            <div class="row mb-1 align-items-center popover-wrapper">
                <div class="col-9">
                    <input type="number" id="alarm-price" v-model="alarmPrice" class="form-control form-control-md no-arrows" placeholder="{#alarm_price#}" step="0.01" required>
                </div>
                <div class="col-3 pl-0">{{ data.P.CURRENCY }} <span>{{ vat_text }}</span></div>
            </div>
            <div class="row mb-1 align-items-center popover-wrapper">
                <div class="col-9">
                    <input type="number" id="alarm-duration" v-model="alarmDuration" class="form-control form-control-md no-arrows" placeholder="{#alarm_time#}" required>
                </div>
                <div class="col-3 pl-0">{#day#}</div>
            </div>
            <div class="row mb-1 align-items-center popover-wrapper">
                <div class="col-auto">
                    <button type="button" id="alarm-add-list" class="btn btn-primary" @click="addToList">{#add_list#}</button>
                </div>
            </div>
        </div>
        <div class="w-100 mt-2 text-body product-alarm-list" v-if="data.PRODUCTS.length > 0">
            <div class="table-responsive">
                <table class="table">
                    <thead>
                        <tr>
                            <th scope="col"></th>
                            <th scope="col">{#product_name#}</th>
                            <th scope="col">{#first_price#}</th>
                            <th scope="col">{#price_sell#}</th>
                            <th scope="col">{#alarm_price#}</th>
                            <th scope="col">{#remaining_day#}</th>
                            <th scope="col">{#upload_date#}</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-for="(P, index) in data.PRODUCTS">
                            <td scope="row">
                                <input type="checkbox" :id="'alarm_input_' + P.ALARM_ID" :value="P.ALARM_ID" :ref="'selectedAlarmItem' + index" checked class="form-control">
                                <label :for="'alarm_input_' + P.ALARM_ID" class="mb-0">
                                    <span class="input-checkbox mr-0"><i class="ti-check"></i></span>
                                </label>
                            </td>
                            <td><a :href="'/' + P.URL" class="text-body fw-bold">{{ P.TITLE }}</a></td>
                            <td>{{ format(P.PRICE_FIRST) }}</td>
                            <td>{{ format(P.PRICE_SELL) }}</td>
                            <td>{{ P.PRICE_ALARM }}</td>
                            <td>{{ P.REMAINING_DAY }}</td>
                            <td>{{ P.DATE }}</td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div class="mt-1">
                <button type="button" id="alarm-remove" class="btn btn-danger" @click="removeToSelected">{#remove_selected#}</button>
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

    const PopupAlarmList = {
        data() {
            return {
                data: DATA,
                endpoints: {
                    get: '/srv/service/profile/get-alarm-list/price',
                    add: '/srv/service/profile/add-to-alarm-list',
                    delete: '/srv/service/profile/delete-alarm-products'
                },
                alarmPrice: '',
                alarmDuration: ''
            }
        },
        methods: {
            format(p) {
                return T.format(p);
            },
            get() {
                const self = this;
                axios.get(self.endpoints.get).then(response => {
                    self.data.PRODUCTS = response.data.PRODUCTS;
                }).catch(error => console.error(`Get alarm list error => ${error}`));
            },
            addToList() {
                const self = this;
                const formData = new FormData();

                formData.append('productId', self.data.GET_PRODUCT);
                formData.append('currentPrice', self.data.P.PRICE_SELL);
                formData.append('alarmPrice', self.alarmPrice);
                formData.append('alarmDuration', self.alarmDuration);
                formData.append('currency', self.data.P.CURRENCY);
                formData.append('dipslayVat', self.data.P.VAT);

                axios.post(self.endpoints.add, formData).then(response => {
                    const result = response.data;
                    if (result.status == 1) {
                        self.get();
                    } else if (result.statusText == 'NO_MEMBER_SESSION') {
                        window.location.reload();
                    } else {
                        T.modal({
                            html: result.statusText,
                            width: '450px',
                            class: 'text-center'
                        });
                    }
                }).catch(error => console.error(`Add to alarm list error => ${error}`));
            },
            removeToSelected() {
                const self = this;
                const asArray = Object.entries(self.$refs);
                const formData = new FormData();

                asArray.forEach(input => {
                    if(input[1].checked === true) {
                        formData.append('products[]', input[1].value);
                    }
                });

                axios.post(self.endpoints.delete, formData).then(response => {
                    const result = response.data;
                    if (result.status) {
                        self.get();
                        asArray.forEach(input => input[1].checked = true);
                    } else {
                        T.modal({
                            html: result.statusText,
                            width: '450px',
                            class: 'text-center'
                        });
                    }
                }).catch(error => console.error(`Add to alarm list error => ${error}`));
            }
        },
        computed: {
            'vat_text'() {
                return this.data.P.DISPLAY_VAT == '1' ? `({#vat_inc#})` : `(+ ${this.data.P.VAT}% {#vat#})`;
            }
        }
    };

    Vue.createApp(PopupAlarmList).mount('#popup-alarm-list');
</script>