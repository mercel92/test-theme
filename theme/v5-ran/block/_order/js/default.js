 window['OrderAddress'] = {
    template: '#order-address',
    data() {
        return vm.$data
    },
    methods: {
        setOrderAddress(id, type) {
            axios.post(`${vm.endpoints.setOrderAddress}${type}/${id}`).then(response => {
                const result = response.data;
                if (result.status == 0) {
                    vm.$router.push('/');
                    T.modal({ 
                        html: result.statusText 
                    });
                }
            });
        },
        getOrderAddress() {
            const self = this;
            axios.get(vm.endpoints.getAddresses).then(response => {
                vm.addresses = response.data;
                if (vm.addresses && vm.addresses.ADDRESS_LIST.length < 1) vm.$router.push('/address');
                if (vm.addresses && vm.addresses.DELIVERY_FROM_STORE == 1) { 
                    self.storeAddress();
                    if (vm.addresses.DELIVERY_ADDRESS.STOREID != null) vm.storeTab = 1;
                }
                for (var i = 0; i < OrderCallback.address.length; i++) {
                    OrderCallback.address[i]?.();
                }
                setTimeout(() => { initComponents(); }, 250);
                vm.saveGoogleAnalyticsVirtualPage('/order#/');
            });
        },
        storeAddress() {
            const self = this;
            axios.get(vm.endpoints.storeAddress).then(response => {
                vm.storeAddressList = response.data;
                vm.storeAddressList.storeId = vm.addresses.DELIVERY_ADDRESS.STOREID || '';
                vm.storeAddressList.countries = [];

                vm.storeAddressList.data.forEach(item => {
                    if (!Array.from(vm.storeAddressList.countries).find(c => c.code == item.Ulke)) {
                        vm.storeAddressList.countries.push({ 
                            'code': item.Ulke, 'name': item.UlkeAdi
                        });
                    }
                });
                self.storeSelect(vm.storeAddressList.exportCountry, 'country');
            });
        },
        storeFilter(value, type) {
            if (type == 'country') { 
                vm.storeAddressList.cities = [];
            }
            if (type == 'city' || type == 'country') {
                vm.storeAddressList.towns = [];
            };

            if (value == '') {
                Array.from(T('.address-store-filter select')).forEach(el => {
                    if (el.value != '') value = el.value;
                });
            }
            const arr = [];
            vm.storeAddressList.data.forEach(item => {
                if (item.Ulke == value || item.Il == value || item.Ilce == value) {
                    if (item.is_delivery_store == 1) {
                        arr.push(item);
                    }
                }
            });
            vm.storeAddressList['stories'] = arr;
        },
        storeSelect(element, type) {
            const self = this;
            let value = '';
            if (typeof element == 'string') {
                value = element;
            } else {
                value = element.target.value;
            }

            self.storeFilter(value, type);

            vm.storeAddressList.data.forEach(item => {
                if (item.Ulke == value && !Array.from(vm.storeAddressList.cities).find(c => c.code == item.Il)) {
                    vm.storeAddressList.cities.push({
                        'code' : item.Il, 'name' : item.IlAdi
                    });
                } else if (item.Il == value && !Array.from(vm.storeAddressList.towns).find(c => c.code == item.Ilce)) {
                    vm.storeAddressList.towns.push({
                        'code' : item.Ilce, 'name' : item.IlceAdi
                    });
                }
            });
        },
        storeNext() {
            if (vm.storeTab == 1) {
                const data = {
                    storeId : vm.storeAddressList.storeId,
                    firstName : T('#store-delivery-name')[0].value,
                    mobilePhone : T('#store-delivery-phone')[0].value,
                    hasInvoice  : T('#store-invoice-address:checked').length > 0 ? 1 : 0,
                    invoiceAddress : T('[name="x-invoice_address"]:checked').length > 0 && T('#store-invoice-address:checked').length > 0 ? T('[name="x-invoice_address"]:checked')[0].value : 0
                }
    
                if (data.storeId == '' || data.storeId == 0) {
                    T.modal({ html: '{#select_store_receive_delivery#}' });
                    return;
                } else if (data.firstName == '') {
                    popoverAlert.show(
                        T('#store-delivery-name')[0],
                        '{#recipient_fullname_enter#}', 
                        2200, 
                        `btn btn-danger no-radius text-left`,
                        true,
                        ''
                    );
                    return;
                } else if (data.mobilePhone.replace(/\D+/g, '').length < 12) {
                    popoverAlert.show(
                        T('#store-delivery-phone')[0],
                        '{#check_phone#}', 
                        2200, 
                        `btn btn-danger no-radius text-left`,
                        true,
                        ''
                    );
                    return;
                } else if (data.hasInvoice == 1 && data.invoiceAddress == 0) {
                    T.modal({ html: '{#select_invoice_address#}' });
                    return;
                }
    
                var formData = new FormData();
                for (var key in data) {
                    formData.append(key, data[key]);
                }
    
                axios.post(vm.endpoints.setStores, formData).then(response => {
                    const result = response.data;
                    if (result.status != 1) {
                        T.modal({ html: result.message || result.statusText || "{#error_message#}" });
                    } else {
                        vm.nextStep();
                    }
                }).catch(error => {
                    T.modal({ html: '{#error_message#}' });
                });
            } else {
                if (T('[name="delivery_address"]:checked').length < 1) {
                    T.modal({ 
                        html: '{#select_address_enter#}' 
                    });
                    return;
                }
                vm.nextStep();
            }
        },
    },
    mounted() {
        this.getOrderAddress();
        window.PAGE_TYPE = 'address';
    }
};

window['OrderAddressDetail'] = {
    template: '#order-address-detail',
    data() {
        return vm.$data
    },
    methods: {
        saveAddress() {
            const self = this,
                  formData = new FormData(self.$refs.saveAddressForm);

            T.buttonLock.dom = self.$refs.saveFormButton;
            T.buttonLock.lock();

            formData.get('nationality') == 'on' ? formData.set('nationality', 1) : formData.set('nationality', 0);

            axios({
                method: self.$route.params.id ? 'put' : 'post',
                url: self.$refs.saveAddressForm.action,
                data: formData
            }).then(response => {
                const result = response.data;
                if (vm.storeTab == 1) {
                    /* Teslimat Noktasindan geliyor */
                    OrderAddress.methods.setOrderAddress(result.data[0], 'invoice');
                    showError(0, '', result.message, '/');
                } else {
                    /* Normal Adres eklemeden geliyor */
                    if (vm.addresses.ADDRESS_LIST.length < 1) {
                        /* eger adres yok ise */
                        if (LocalApi.get('invoiceActive') == true) {
                            /* Fatura Adresi Farkli Girilecek ise */
                            vm.invoiceAddress = true;
                            OrderAddress.methods.setOrderAddress(result.data[0], 'delivery');
                            self.addressDetail.nationality = 0;
                            self.$refs.saveAddressForm.reset();
                            OrderAddress.methods.getOrderAddress();
                            regionLoader({
                                country: { selector: 'select[name="country_code"]', value: self.addressDetail.countryCode || '' },
                                countryLimit : false
                            });
                        } else {
                            /* Fatura adresi farkli girilmeyecekse */
                            OrderAddress.methods.setOrderAddress(result.data[0], 'delivery');
                            OrderAddress.methods.setOrderAddress(result.data[0], 'invoice');
                            showError(0, '', result.message, '/payment');
                        }
                    } else if (LocalApi.get('invoiceActive') == true) {
                        /* Fatura Adresi girildikten sonra */
                        OrderAddress.methods.setOrderAddress(result.data[0], 'invoice');
                        showError(0, '', result.message, '/payment');
                        LocalApi.remove('invoiceActive');
                        vm.invoiceAddress = false;
                    } else {
                        /* Normal adres girisi */
                        showError(0, '', result.message, '/');
                    }
                }
                T.buttonLock.unlock();
            }).catch(error => {
                let result = {};
                if (error.response) {
                    result = error.response.data.data;
                } else if (error.request) {
                    result = JSON.parse(error.request.response).data;
                }
                result.forEach(item => {
                    showError(1, document.querySelector(`#order-address-form [name="${item.key}"]`), item.statusText);
                });
                T.buttonLock.unlock();
            });
        },
        load() {
            const self = this,
                  fieldFormData = new FormData();

            fieldFormData.append('page', 'customer-insert-address-modal');
            const getFields = axios.post(vm.endpoints.getAddressFormFields, fieldFormData),
                  getAddressDetail = (vm.$route.params.id) ? axios.get(vm.endpoints.getAddressDetail + vm.$route.params.id) : '';

            vm.loading = true;
            Promise.all([getFields, getAddressDetail]).then(response => {
                vm.addressFields = response[0].data.data[0];
                vm.addressDetail = response[1] == '' ? {} : response[1].data.data[0];
                vm.addressDetail.is_company_active = vm.addressDetail.is_company_active || 0;
                vm.loading = false;

                if (vm.addressFields.configs.eExportSystem == true) self.eExportLoad();

                setTimeout(() => {
                    formLoader({
                        selector: '#order-address-form',
                        data: vm.addressDetail,
                        callback: function (data) {
                            tsRegion({
                                container: '#order-address-form',
                                countryLimit : 0,
                                regionLimit : vm.addressFields.configs.page === 'order' && (vm.addresses.ADDRESS_LIST.length == 0 || vm.addressFields.configs.CONFIGS.hasDeliveryAddress == 0) ? 1 : 0,
                                country : {
                                    value : vm.addressFields.configs.eExportCountry || vm.addressDetail.country_code || 'TR',
                                    caption : vm.addressDetail.country
                                },
                                state : {
                                    value: vm.addressDetail.province_code,
                                    caption: vm.addressDetail.province
                                },
                                city : {
                                    value : vm.addressDetail.city_code,
                                    caption : vm.addressDetail.city
                                },
                                town : {
                                    value : vm.addressDetail.town_code,
                                    caption : vm.addressDetail.town
                                },
                                district : {
                                    value : vm.addressDetail.district_code,
                                    caption : vm.addressDetail.district
                                }
                            });
                            
                            if (vm.nextOrderResult.focus || vm.nextOrderResult.msg) {
                                showError(1, T(`[name="${vm.nextOrderResult.focus}"]`)[0], vm.nextOrderResult.msg);
                            }
                        }
                    });
                    initComponents();
                }, 100);
            });
        },
        setApiInvoice(el) {
            LocalApi.set('invoiceActive', el.target.checked);
        },
        eExport(element) {
            T(element).addClass('d-none');
            T('.eExport-overlay').removeClass('d-none');
            T('.eExport-select')[0].focus();
            T('.eExport-select').on('change', el => {
                axios.get('/srv/shopping/shopping/set-country/' + el.target.value).then(() => {
                    const self = this,
                                 formData = new FormData(self.$refs.saveAddressForm),
                                 data = {};

                    for (let [key, val] of formData.entries()) {
                        Object.assign(data, {[key]: val});
                    }
                    LocalApi.set('addressApi', data);
                    location.reload();
                });
            });
        },
        eExportOverlay() {
            T('.eExport-btn').removeClass('d-none');
            T('.eExport-overlay').addClass('d-none');
        },
        eExportLoad() {
            const addressDetail = LocalApi.get('addressApi');
            if (!addressDetail) return;

            for (var key in addressDetail) {
                if (addressDetail[key] == 'on') {
                    addressDetail[key] = 1;
                }
                vm.addressDetail[key] = addressDetail[key];
            }
            setTimeout(() => {
                LocalApi.remove('addressApi');
            }, 1500);
        },
    },
    watch: {
        'addressDetail.is_company_active'(value) {
            if (value == 1) {
                setTimeout(() => {
                    taxLoader({
                        selector: 'input[name="tax_office"]', limit: 15
                    });
                }, 300);
            }
        }
    },
    mounted() {
        LocalApi.remove('invoiceActive');
        vm.invoiceAddress = false;
        OrderAddress.methods.getOrderAddress();
        this.load();
        window['eExport'] = (element, target) => {
            this.eExport(element);
        };
    },
};

window['OrderPayment'] = {
    template: '#order-payment',
    data() {
        return vm.$data
    },
    methods: {
        format(p) {
            return T.format(p);
        },
        getOrderSummary() {
            axios.get(vm.endpoints.getOrderSummary).then(response => {
                vm.summaryData = response.data;
            });
        },
        getCargoList() {
            axios.get(vm.endpoints.getCargoCompanies).then(response => {
                vm.cargoCompanies = response.data;
            }).catch(error => console.warn(`Get cargo campanies error => ${error}`));
        },
        setCompany(value) {
            const self = this;
            self.getPaymentOptions(value);
            
            vm.cargoServices = Array.from(vm.cargoCompanies.CARGO_COMPANY_LIST).find(x => x.ID == value);
            if (vm.cargoServices.SERVICES) {
                const data = Array.from(vm.cargoServices.SERVICES).find(x => x.DATE == vm.cargoCompanies.SELECTED_COMPANY.SERVICEDATE);
                if (data) self.selectCargoService(data.ITEMS, vm.cargoCompanies.SELECTED_COMPANY.SERVICEDATE);
                
                const idItems = Array.from(data.ITEMS).find(x => x.ID == vm.cargoCompanies.SELECTED_COMPANY.SERVICEID);
                if (idItems) setTimeout(() => { self.setCargoServices(idItems.ID); }, 200);
            }
            vm.companyId = value;
        },
        selectCargoService(data, date) {
            vm.cargoCompanies.SELECTED_COMPANY.SERVICEDATE = date;
            vm.cargoServicesItems = data;

            setTimeout(() => {
                const service = T('[name="cargoServiceId"]:checked');
                if (service.length > 0 && service[0].value == '') {
                    service[0].checked = false;
                }
            }, 100);
        },
        checkCargoServices() {
            if (vm.cargoServices && vm.cargoServices.HAS_SERVICE != 1) {
                return true;
            }
            const cargoServiceId = T('.payment-cargo-services [name="cargoServiceId"]:checked');
            const cargoServiceDate = T('.payment-cargo-services .cargo-services-btn.selected');

            if (cargoServiceDate.length > 0 && cargoServiceId.length > 0) {
                return {
                    id: cargoServiceId[0].value,
                    date: cargoServiceDate[0].dataset.date
                };
            } else {
                return false;
            }
        },
        setCargoServices(id) {
            const self = this;
            vm.cargoCompanies.SELECTED_COMPANY.SERVICEID = id;
            const params = self.checkCargoServices();
            if (typeof params != "object") return
            masterPass.ajaxPost({
                url: '/Order/OrderAPI/setCargoService',
                data: params,
                success: function(result) {
                    if (!result.success) {
                        window.location.reload();
                    }
                },
                error: function() {
                    window.location.reload();
                }
            });
        },
        getPaymentOptions(id = '') {
            const self = this;
            hideOrderNextElement();
            axios.get(vm.endpoints.getPaymentTypes + id).then(response => {
                vm.paymentTypeList = response.data;

                Array.from(vm.paymentTypeList.PAYMENT_LIST).forEach(payment => {
                    const id = payment.ID;
                    if (id == "-13" || id == "-21" || id == "-18" || id == "-17") {
                        vm.scriptEval(payment.DECLERATION, 'payment' + id);
                    }
                });
                
                self.getOrderSummary();
                setTimeout(() => {
                    hideOrderNextElement(true);
                }, 1000);
            }).catch(error => console.warn(`Get payment type options error => ${error}`));
        },
        flipCard(status) {
            this.creditCard.isCardFlipped = status;
            status === true ? this.focusInput() : this.blurInput();
        },
        focusInput() {
            clearTimeout(this.creditCard.isInputFocused);
            this.creditCard.isInputFocused = true;
        },
        blurInput() {
            vm.creditCard.isInputFocused = setTimeout(() => {
                vm.creditCard.isInputFocused = false;
            }, 1000);
        },
        setPaymentID(paymentID) {
            const self = this;
            vm.paymentID = paymentID;
            self.setPaymentType(paymentID);
            axios.get(vm.endpoints.setPaymentTitleFromTab + paymentID).then(() => {
                self.getOrderSummary();
            }).catch(error => console.error(`Set payment type => ${error}`));
            if (T.isMobile() === true ) vm.scroll(T(`.payment-list-item${paymentID}`)[0]);
        },
        setPaymentType(id) {
            const self = this;
            let el = `.payment-list-item .accordion-title[data-id="${id}"]`;
            if (!T(el).hasClass('active')) {
                el = `.payment-list-item .accordion-title:not([data-id="${id}"])`;
            }
            T(`${el} + .accordion-body`).removeClass('show');
            T(`${el}`).removeClass('active');

            for (var i = 0; i < OrderCallback.paymentChange.length; i++) {
                OrderCallback.paymentChange[i]?.(id);
            }

            vm.payAgreements = false;

            if (id == -13 || id == -21) { self.iyzicoInit(id); } 
            if (id == -18) { self.payTrInit(); }
        },
        getInstallment(number) {
            const self = this;
            if (self.$refs) self.$refs.installmentOptions.dataset.bin = number;
            axios.get(vm.endpoints.getBin + number).then(response => {
                vm.insOpt = response.data;
                self.setInstallment({
                    CREDIT_DEBIT: vm.insOpt.CREDIT_DEBIT,
                    INSTALLMENT: 0,
                    ID: 0,
                    POS_ID: vm.insOpt.SINGLE_POS_ID
                });
                vm.creditCard.cardType = vm.insOpt.ISSUER;
            }).catch(error => console.error(`Error get bin => ${error}`));
        },
        setInstallment(data) {
            const self = this,
                  postData =  new FormData();

            postData.append('creditdebit', vm.insOpt.CREDIT_DEBIT);
            postData.append('installmentCount', data.INSTALLMENT);
            postData.append('installmentId', data.ID);
            postData.append('posId', data.POS_ID);

            vm.creditCard.installmentCount = data.INSTALLMENT;
            vm.creditCard.installmentId = data.ID;
            vm.creditCard.posId = data.POS_ID;
            vm.secure3d = data.ID == 0 ? vm.insOpt.SINGLE_POS_OPTIONS.baseSecure3D : data.POS_OPTIONS.baseSecure3D;
 
            vm.mandatoryCvv = data.ID == 0 ? vm.insOpt.SINGLE_POS_OPTIONS.mandatoryCvv : data.POS_OPTIONS.mandatoryCvv;
            masterPass.setPosDetails();

            axios.post(vm.endpoints.setInstallment, postData).then(() => {
                self.getOrderSummary();
            }).catch(error => console.error(`Error instalment => ${error}`));
        },
        cardPointInit(value) {
            vm.cardPoint.status = vm.summaryData.PERMISSIONS.USABLECARDPOINT;
            if (!vm.cardPoint.status) return;

            const cartNumber = () => {
                if (/[^0-9-\s]+/.test(value)) { return false; }
                let nCheck = 0,
                    bEven = false;
                for (let n = value.length - 1; n >= 0; n--) {
                    var cDigit = value.charAt(n),
                        nDigit = parseInt(cDigit, 10);
        
                    if (bEven && (nDigit *= 2) > 9) { nDigit -= 9; }
                    nCheck += nDigit;
                    bEven = !bEven;
                }
                if ((nCheck % 10) == 0) { return value; }
                return false;
            }

            const number = cartNumber();
            if (vm.cardPoint.number != number) {
                vm.cardPoint.number = number;
                vm.cardPoint.step = 1;
                vm.cardPoint.pointList = [];
            }

        },
        getCardPoint() {
            vm.cardPoint.step = 1;
            const formData = T('.credit-card-wrapper [name]');
            for (let i=0; i<formData.length; i++) {
                if (formData[i].classList.contains('required') && !formData[i].value){
                    if (T.isMobile() === true ) self.scroll(T(`#${formData[i].name}`)[0]);
                    popoverAlert.show(
                        document.getElementById(`${formData[i].name}`),
                        '{#form_required#}!', 
                        2000,
                        `btn btn-danger no-radius text-left`,
                        false,
                        ''
                    );
                    return false;
                }
            }

            const rf = (result) => {
               const ok = result && result.success && result.data;
                if (!ok) {
                    alert(result.message || "{#error_again#}");
                } else {
                    vm.cardPoint.pointList = result.data.point || [];
                    vm.cardPoint.step = 2;
                }
            };
            masterPass.ajaxPost({
                url: '/Order/OrderAPI/getCardPoint',
                data: {
                    cardNumber: vm.creditCard.cardNumber,
                    cardHolder: vm.creditCard.cardHolder,
                    expireMonth: vm.creditCard.expireMonth,
                    expireYear: vm.creditCard.expireYear,
                    cvc: vm.creditCard.cvc
                },
                success: rf,
                error: rf
            });
        },
        getUserPoint() {
            if (vm.cardPoint.pointList.length == 0) {
                return null;
            }
            let items = [],
                amount, item;
            for (let i in vm.cardPoint.pointList) {
                item = vm.cardPoint.pointList[i];
                if (typeof item.amount == "undefined") {
                    continue;
                }
                amount = T(`#credit-card-point .card-gift-amount-control[data-type="${item.type}"]`)[0].value;
                items.push({ amount: amount, type: item.type });
            }
            return items;
        },
        cardpointAll(amount, id) {
            if (amount == null) {
                T(`#${id}`)[0].checked = false;
                return;
            }
            T(`#${id}`)[0].value = amount;
        },
        setValsecure3d() {
            const postData =  new FormData();
            setTimeout(function() {
                const value3d = T('#secure-3d-check:checked').length > 0 ? 1 : 0;
                postData.append('secure3d', value3d)
                axios.post(vm.endpoints.setSecure3d, postData).then(() => { });
            }, 10);
        },
        cardStorageSelect(cardId) {
            const card = Array.from(vm.cardStorageList).find(x=> x.ID == cardId);
            if (card == null) {
                vm.creditCard.cardNumber = '';
                this.$refs.installmentOptions.dataset.bin = '';
                vm.insOpt = {};
                T("#credit-cart-form").show();
                T("#card-cardstorage").show();
            } else {
                T("#credit-cart-form").hide();
                T("#card-cardstorage").hide();
                vm.creditCard.cardNumber = card.CARD_MASK.substr(0, 6);
            }
        },
        cardStorageDelete(cardId) {
            const rf = (result) => {
                if (!result.success) { alert(result.message || "{#error_again#}"); }
                else {
                    const card = Array.from(vm.cardStorageList).find(x=> x.ID == cardId);
                    const index = vm.cardStorageList.indexOf(card);
                    vm.cardStorageList.splice(index, 1);
                    if (vm.cardStorageList.length > 0) {
                        setTimeout(() => {
                            T('#cStorageCardId0').trigger('change');
                            T('#cStorageCardId0')[0].checked = true;
                        }, 50);
                    } else {
                        T("#credit-cart-form").show();
                        T("#card-cardstorage").show();
                    }
                }
            };
            masterPass.ajaxPost({ url: "/srv/service/customer/delete-card/" + cardId, success: rf });
        },
        checkoutBexAPIutils(type = '') {
            const self = this;
            if (type == '') return;

            const typeEl = type == 'PayTR' ? 'paytr-bkmexpress-payment-modal-container' : 'bkm2-bkmexpress-payment-modal-container';
            if (T(`#${typeEl}`).length > 0) T(`#${typeEl}`)[0].remove();

            const typeDiv = document.createElement('div');
            typeDiv.id = typeEl;
            typeDiv.setAttribute('style', 'z-index:1000000001 !important; position:relative;');
            document.body.appendChild(typeDiv);

            const skipButton = true;
            if (type == 'PayTR') {
                typeDiv.innerHTML = '<div id="paytr-bkmexpress-payment-modal"></div>';
                var opt = {
                    container: "paytr-bkmexpress-payment-modal",
                    buttonSize: [],
                    skipButton: skipButton,
                    onComplete: self.paytrOnComplete.bind(this, ""),
                    onCancel: self.nextBexAPIutils
                };
                hideOrderNextElement();
                window["bex_timeout"] = function() {
                    T.modal({ html: '{#error_pay#}', });
                    self.nextBexAPIutils();
                };
                BexUtil.showModal("/Order/OrderAPI/paytrBKMInitialize", "", opt);
            } else if (type == 'BKM2') {
                typeDiv.innerHTML = '<div id="bkm2-bkmexpress-payment-modal"></div>';
                var opt = {
                    container: "bkm2-bkmexpress-payment-modal",
                    buttonSize: [],
                    skipButton: skipButton,
                    onComplete: self.bkm2OnComplete.bind(this, ""),
                    onCancel: self.nextBexAPIutils
                };
                hideOrderNextElement();
                window["bex_timeout"] = function() {
                    T.modal({ html: '{#error_pay#}', });
                    self.nextBexAPIutils();
                };
                BexUtil.showModal("/Order/OrderAPI/bkm2Initialize", "", opt);
            } else {
                return;
            }
        },
        paytrOnComplete() {
            masterPass.ajaxPost({
                url: '/Order/OrderAPI/paytrBKMComplete',
                dataType: 'html',
                success: function() {
                    setTimeout(function() {
                        window.location.href = "/order";
                    }, 1500);
                }
            });
        },
        bkm2OnComplete() {
            setTimeout(function() {
                window.location.href = "/order";
            }, 200);
        },
        nextBexAPIutils() {
            hideOrderNextElement(true);
        },
        mobilnik(data) {
            const src = 'https://acquiring.mobilnik.kg/static/js/acquiring.js';
            const onload = () => {
                mobilnik.buy({
                    jwt: data.jwtToken,
                    key: data.sellerIdentifier,
                    success: function(e) { window.location.reload(); },
                    failure: function(e) { T.modal({ html: e, }); }
                });
            };
            const onerror = () => {
                window.location.reload();
            };
            vm.getScript(src, onload, onerror);
        },
        chippinInit(id) {
            if (id == 1) orderBackdrop(false);
            loadSubFolder({
                pageId: 91,
                blockParentId: 1119,
                subFolder: 'payment-chippin',
                params: { step : id, },
                success:  function(loadRes){
                    T.modal({ html: loadRes, width:'480px' });
                }
            });
        },
        sodexoInit() {
            loadSubFolder({
                pageId: 91,
                blockParentId: 1119,
                subFolder: 'payment-sodexo',
                success:  function(loadRes){
                    T.modal({ html: loadRes, width:'480px' });
                }
            });
        },
        kuveytTurkInit(result) {
            loadSubFolder({
                pageId: 91,
                blockParentId: 1119,
                subFolder: 'payment-kuveytturk',
                success:  function(loadRes){
                    T.modal({ html: loadRes, width:'480px' });
                    kuveytTurkForm.methods.init(result);
                }
            });
        },
        smsInit(durationSecond, phone, referenceCode) {
            loadSubFolder({
                pageId: 91,
                blockParentId: 1119,
                subFolder: 'payment-sms',
                params: { second: durationSecond, phone: phone, refCode: referenceCode },
                success:  function(loadRes){
                    T.modal({ html: loadRes, width:'480px' });
                }
            });
        },
        approveTypeInit(result) {
            loadSubFolder({
                pageId: 91,
                blockParentId: 1119,
                subFolder: 'payment-approvetype',
                params: { approvePhone: result.approvePhone, approveSMS: result.approveSMS, phone: result.phone },
                success:  function(loadRes){
                    T.modal({ 
                        html: loadRes, 
                        width: result.approvePhone && result.approveSMS ? '768px' : '480px' 
                    });
                    if (typeof eventOrderApproveTypeLoad == "function") {
                        self.eventOrderApproveTypeLoad(result);
                    }
                }
            });
        },
        payAgreementsAdd(id, parent, form) {
            if (T(`#${id}`).length < 1) {
                const payAgreement = document.createElement('div');
                payAgreement.id = id;
                payAgreement.classList.add('bg-light', 'border-round');
                payAgreement.innerHTML = `
                    <input type="checkbox" name="confirmDistanceSellingAgreement" id="input-${id}" class="form-control">
                    <label for="input-${id}" class="m-0 d-flex align-items-center fw-regular p-1">
                        <span class="input-checkbox"><i class="ti-check"></i></span>
                        <div>
                            <a href="/srv/service/order-v4/get-preliminary-information-form" data-width="800" class="popupwin text-primary">{#preliminary_information#}</a>
                            ve <a href="/srv/service/order-v4/get-distance-agreement" data-width="800" class="popupwin text-primary">{#distance_agreement#}</a>
                            {#accept#}
                        </div>
                    </label>
                `;
                T(`#${parent}`)[0].parentNode.insertBefore(payAgreement, T(`#${parent}`)[0]);
            }

            vm.payAgreements = true;
            T(`#${form}`).html('{#other_agreements#}');
            T(`#${id}`).on('click', () => {
                if (T(`#input-${id}:not(:checked)`).length > 0) 
                     { T(`#${form}`).show(); } 
                else { T(`#${form}`).hide(); }
                return;
            });
            initComponents();
        },
        iyzicoInit(id) {
            const self = this;
            const iyzicoMethod = T(`.payment-list-item${id} .iyzipay-checkout-form-container`)[0].dataset.apiMethod;
            switch (iyzicoMethod) {
            case "iframe":
                setTimeout(() => {
                    self.payAgreementsAdd('iyzico-agreements', 'iyzipay-checkout-form-container', 'iyzipay-checkout-form-cover');
                }, 50);
                break;
            }
        },
        payTrInit() {
            const self = this;
            setTimeout(() => {
                self.payAgreementsAdd('paytr-agreements', 'paytr-checkout-form-container', 'paytr-checkout-form-cover');
            }, 50);
        },
        bulutTahsilatSubmit(result) {
            const self = this;
            hideOrderNextElement();
            orderBackdrop(true);
            if (T('#orderHiddenFormCont').length > 0) T('#orderHiddenFormCont')[0].remove();
            if (T('#buluttahsilatwin').length > 0) T('#buluttahsilatwin')[0].remove();

            const buluttahsilatEl = document.createElement('div');
            buluttahsilatEl.innerHTML = `
            <iframe id="buluttahsilatwin" name="buluttahsilatwin" style="width:100%; height:100%; top:0; bottom: 0; left:0; right:0; position:absolute; z-index:99999; background:#fff;"></iframe>
            <div id="orderHiddenFormCont"><form name="orderHiddenForm" id="orderHiddenForm" method="post" action="${result.data.formUrl}" target="buluttahsilatwin">${result.data.hiddenFields}</div>`;
            
            document.body.appendChild(buluttahsilatEl);
            document.getElementById('orderHiddenForm').submit();
            setTimeout(() => { self.bulutTahsilatListener(); }, 1000);
        },
        bulutTahsilatListener() {
            const self = this;
            const tm = () => {
                setTimeout(() => { self.bulutTahsilatListener(); }, 2000);
            };
            const rf = (result) => {
                if (result && result.success) {
                    if (result.data === 1) { tm(); } else { window.location.reload(); }
                }
            };
            axios({
                url: '/Order/OrderAPI/checkoutState',
                dataType: "json",
            }).then(() => { rf(); }).catch(() => { tm(); });
        },
        loadCompleteCampaigns(result) {
            loadSubFolder({
                pageId: 91,
                blockParentId: 1119,
                subFolder: 'complete-campaign',
                params: {},
                success:  function(loadRes){
                    T.modal({ html: loadRes, width:'480px' });
                    completeCampaingForm.methods.init(result);
                }
            });
        },
        loadCreditCardCampaigns(campaigns) {
            loadSubFolder({
                pageId: 91,
                blockParentId: 1119,
                subFolder: 'credit-card-campaign',
                params: {},
                success:  function(loadRes){
                    T.modal({ html: loadRes, width:'480px' });
                    creditCardCampaingForm.methods.init(campaigns);
                }
            });
        },
        mpSave(event) {
            masterPass.isSave = event.target.checked;
        },
        hiddenFormReady(result) {
            const self = this;
            if (typeof result.data.provider != "undefined") {
                switch (result.data.provider) {
                    case 'mobilnik':
                        self.mobilnik(result.data);
                        return;
                    case "buluttahsilat":
                        self.bulutTahsilatSubmit(result);
                        return;
                    case "chippin":
                        self.chippinInit(1);
                        return;
                    case "kuveytturk":
                        return self.kuveytTurkInit(result);
                }
            }

            hideOrderNextElement();
            if (T("#orderHiddenFormCont").length > 0) {
                T("#orderHiddenFormCont")[0].remove();
            }

            const fMethod = result.data.formMethod ? result.data.formMethod : "POST";
            const orderHiddenFormCont = document.createElement('div');
            orderHiddenFormCont.id = 'orderHiddenFormCont';
            var h = '<form name="orderHiddenForm" id="orderHiddenForm" method="' + fMethod + '" action="' + result.data.formUrl + '">' + result.data.hiddenFields;
        
            if (result.data && result.data.cardFieldsNames) {
                for (var i in result.data.cardFieldsNames) {
                    switch (i) {
                        case 'cardHolder':
                            h += `<input type="hidden" name="${result.data.cardFieldsNames[i]}" value="${vm.creditCard.cardHolder}">`;
                            break;
                        case 'cardNumber':
                            h += `<input type="hidden" name="${result.data.cardFieldsNames[i]}" value="${vm.creditCard.cardNumber.replace(/\D+/g, '')}">`;
                            break;
                        case 'expireMonth':
                            h += `<input type="hidden" name="${result.data.cardFieldsNames[i]}" value="${vm.creditCard.expireMonth}">`;
                            break;
                        case 'expireYear':
                            h += `<input type="hidden" name="${result.data.cardFieldsNames[i]}" value="${vm.creditCard.expireYear}">`;
                            break;
                        case 'cvc':
                            h += `<input type="hidden" name="${result.data.cardFieldsNames[i]}" value="${vm.creditCard.cvc.replace(/\D+/g, '')}">`;
                            break;
                    }
                }
            }
            h += '</form>';
            orderHiddenFormCont.innerHTML = h;
            document.body.appendChild(orderHiddenFormCont);

            if (result.data.iframe.open == 1) {
                T.modal({
                    id: 'hiddenForms',
                    html:'<iframe id="myOrder3DFrame" name="myOrder3DFrame" frameborder="0" vspace="0" hspace="0" src="about:blank" style="width:100%;border:0;margin:0;padding:0;height:100%;"></iframe>',
                });
                setTimeout(function() {
                    document.getElementById('orderHiddenForm').setAttribute('target', 'myOrder3DFrame');
                    document.getElementById('orderHiddenForm').submit();
                    hideOrderNextElement(true);
                }, 10);
            } else {
                document.getElementById('orderHiddenForm').submit();
            }
        },
        checkoutPayment(formData) {
            const self = this;
            axios.post(vm.endpoints.checkout, formData).then(response => {
                const result = response.data;
                hideOrderNextElement(true);
                if (result && result.status == -2 && result.message) {
                    hideOrderNextElement(true);
                    T.modal({ html : result.message });
                    return;
                }
                if (vm.paymentID == -2) {
                    if (result.state == 97) {
                        vm.$router.push('/approve'); //pos onayı bekleniyor..
                    } else if (result.state == 96) {
                        vm.$router.push('/approve'); //online havale/eft bekliyor..
                    } else if (result.status == 0) { //odeme başarısız
                        var errorStr = '{#error_pay#}.'
                        if (typeof result.reason !== 'undefined') {
                            errorStr += ' (' + result.reason + ')';
                        }
                        if (typeof result.transactionMessage != 'undefined' && result.transactionMessage != "") {
                            errorStr = result.transactionMessage;
                        }
                        T.modal({ html : errorStr });
                    } else if (result.state == 2) { // prepayment
                        if (result.status == 1) {
                            self.checkoutRequest();
                        } else {
                            //ödeme başarısız
                            T.modal({ html : '{#error_pay#}.' });
                        }
                    } else if (result.state == 5) { // creditCardCampaign (+3 taksit,taksit erteleme vs.)
                        self.loadCreditCardCampaigns(result.data.campaigns);
                    } else if (result.state == 99) { // success
                        if (result.completedCampaigns) {
                            self.loadCompleteCampaigns(result);
                        }
                        vm.$router.push('/approve'); //ETC-9670
                    } else if (result.state == 1) { // hiddens
                        hideOrderNextElement();
                        self.hiddenFormReady(result);
                    } else {
                        window.location.reload();
                    }
                } else {
                    if (result.status == 0) {
                        //ödeme başarısız, result.reason olabilir //CREDIT_LOW (Kredi yetersiz)
                        var msg = "";
                        if (result && result.transactionMessage) {
                            msg = result.transactionMessage;
                        } else if (result && result.reason) {
                            msg = result.reason;
                        }
                        T.modal({ html : `{#error_pay#}. ${msg}` });
                    } 
                    else if (result.status == 1) {
                        vm.$router.push('/approve');
                    } 
                    else if (result.status == 2) { // hiddens
                        self.hiddenFormReady(result);
                    } 
                    else if (result.status == 3) { // sms onayı
                        self.smsInit(result.durationSecond, result.phone, result.referenceCode);
                    } 
                    else if (result.status == 4) { // onay seçimi
                        self.approveTypeInit(result);
                    } 
                    else {
                        window.location.reload();
                    }
                }
            }).catch(error => {
                window.location.reload();
            });
        },
     },
    computed: {
        getCardType () {
            let number = String(vm.creditCard.cardNumber);
            let re = new RegExp("^4");
            if (number.match(re) != null) return 'visa';

            re = new RegExp("^(34|37)");
            if (number.match(re) != null) return 'amex';

            re = new RegExp("^5[1-5]");
            if (number.match(re) != null) return 'mastercard';

            re = new RegExp("^6011");
            if (number.match(re) != null) return 'discover';

            re = new RegExp('^9792')
            if (number.match(re) != null) return 'troy';

            return number ? 'visa' : '';
        },
        generateCardNumberMask () {
            return this.getCardType === 'amex' ? this.creditCard.amexCardMask : this.creditCard.otherCardMask;
        },
        minCardMonth () {
            if (vm.creditCard.expireYear === vm.creditCard.minCardYear) return new Date().getMonth() + 1;
            return 1;
        },
        cardNumberFirst6Char() {
            return vm.creditCard.cardNumber.replace(/[^\dA-Z]/g, '').replace(/\D+/g, '').substr(0, 6);
        }
    },
    watch: {
        'cargoCompanies.SELECTED_COMPANY.ID'(value) {
            const self = this;
            self.setCompany(value);
        },
        'paymentTypeList'(value) {
            setTimeout(() => {
                initComponents();
                if (vm.paymentID == '') {
                    T('.payment-list-item .accordion-title')[0].click();
                } else {
                    T(`.payment-list-item .accordion-title[data-id="${vm.paymentID}"]`)[0].click();
                }
                masterPass.init(value);

                if (!value || !value.PAYMENT_LIST || value.PAYMENT_LIST.length == 0) return;

                const cardStorage = Array.from(value.PAYMENT_LIST).find(x=> x.ID == "-2");
                if (cardStorage && cardStorage.CARDSTORAGE == 1) {
                    vm.cardStorageList = cardStorage.CUSTOMERCARDLIST;
                    if (vm.cardStorageList.length > 0) {
                        setTimeout(() => {
                            this.cardStorageSelect(vm.cardStorageList[0].ID);
                            T(`#card-storage-${vm.cardStorageList[0].ID}`)[0].checked = true;
                        }, 150);
                    }
                }
            }, 150);
        },
        'creditCard.cardNumber'(value) {
            let number = value.replace(/[^\dA-Z]/g, '').replace(/\D+/g, '');
            if (number.length > 5 && this.$refs.installmentOptions.dataset.bin != number.substr(0, 6)) {
                this.getInstallment(number.substr(0, 6));
            }
            value = String(number.substr(0, 16));
            value = value.replace(/(\d{4})/g, "$1 ");
            vm.creditCard.cardNumber = value;
            this.cardPointInit(number);
        },
        'creditCard.expireYear'() {
            if (vm.creditCard.expireMonth < vm.creditCard.minCardMonth) {
                vm.creditCard.expireMonth = '';
            }
        },
        'creditCard.cvc'(value) {
            value = value.replace(/D+/g, '');
            vm.creditCard.cvc = value.substr(0, 4);
        },
        'msCardName'(value) {
            masterPass.saveForm.cardName = value; 
        },
        'setMsisdn'(value) {
            masterPass.msisdn = value;
        }
    },
    mounted() {
        this.getCargoList();
        if (vm.companyId != '') this.setCompany(vm.companyId);
        setTimeout(() => { initComponents();}, 150);
        vm.saveGoogleAnalyticsVirtualPage('/order#/payment');
        window.PAGE_TYPE = 'payment';
        for (var i = 0; i < OrderCallback.payment.length; i++) {
            OrderCallback.payment[i]?.();
        }
    },
};

const OrderApprove = {
    template : '#order-approve',
    data() {
        return vm.$data
    },
    methods: {
        getApprove() {
            hideOrderNextElement(true);
            T('.cart-soft-count').text('0');
            axios.get(vm.endpoints.approve).then(content => {
                vm.approveData = content.data;
                vm.saveGoogleAnalyticsVirtualPage('/order#/approve');
                setTimeout(function() {
                    try {
                        mobileApp.sendOrderNumber(vm.approveData.transaction);
                    } catch (err) {};
                    try {
                        webkit.messageHandlers.sendOrderNumber.postMessage(vm.approveData.transaction);
                    } catch (err) {};
                    try {
                        sendOrderNumber.postMessage(vm.approveData.transaction);
                    } catch (err) {};

                    vm.saveGoogleAnalyticsEcommerce();
                    masterPass.initComplete();
                    for (var i = 0; i < OrderCallback.approve.length; i++) {
                        OrderCallback.approve[i]?.(vm.approveData);
                    }
                }, 50);
            });
            return true;
        }
    },
    mounted() {
        this.getApprove();
        window.PAGE_TYPE = 'approve';
    }
};

const routes = [
    { path: '/', component: OrderAddress },
    { path: '/address/:id?', component: OrderAddressDetail },
    { path: '/payment', component: OrderPayment },
    { path: '/approve', component: OrderApprove },
];

const router = VueRouter.createRouter({
    linkActiveClass: 'active',
    history: VueRouter.createWebHashHistory(),
    routes,
    scrollBehavior(to, from, savedPosition) {
        if (savedPosition && to.path === '/') {
            setTimeout(() => { window.scrollTo(0, savedPosition.y); }, 400);
        } else {
            window.scrollTo(0, 0);
        }
    },
});

const order = Vue.createApp({
    data() {
        return {
            loading: true,
            disabledLink: true,
            nextPaymentStep: 'payment',
            endpoints: {
                nextStep: '/srv/service/order-v5/next-order/',
                approve: '/srv/service/order-v5/step/approve',
                getAddresses: '/srv/service/order-v5/get-address-list/',
                setOrderAddress: '/srv/service/order-v5/set-address/',
                getAddressDetail: '/api/v1/public/address/',
                deleteAddres: '/srv/service/address/delete/',
                getAddressFormFields: '/api/v1/block/get-page-requirements/',
                getOrderSummary: '/srv/service/order-v5/get-summary/',
                getCargoCompanies: '/srv/service/order-v5/get-cargo-companies/',
                getPaymentTypes: '/srv/service/order-v5/get-payment-types/',
                setPaymentTitleFromTab: '/srv/service/order-v5/setPaymentTitleFromTab/',
                getBin: '/srv/service/order-v5/get-bin/',
                setInstallment: '/srv/service/order-v5/set-installment/',
                setSecure3d: '/srv/service/order-v5/customerSelect3d',
                checkout: '/srv/service/order-v5/checkout',
                storeAddress : '/srv/service/store/store-list',
                setStores: '/srv/service/order-v5/delivery-from-store',
            },
            addresses: [],
            addressDetail: {},
            addressFields: {},
            storeAddressList : [],
            storeTab: 0,
            summaryData: {},
            cargoCompanies: {},
            paymentTypeList: {},
            creditCard: {
                cardHolder: '',
                cardNumber: '',
                expireMonth: '',
                expireYear: '',
                cvc: '',
                minCardYear: new Date().getFullYear(),
                amexCardMask: '#### ###### #####',
                otherCardMask: '#### #### #### ####',
                isCardFlipped: false,
                isInputFocused: false,
                cardType: '',
                creditCardCampaignCode: '',
                installmentCount: '',
                installmentId: '0',
                posId: '',
            },
            insOpt: {},
            masterPassCards: [],
            nextOrderResult: {},
            cargoServices: {},
            cargoServicesItems: {},
            paymentID : '',
            companyId: '',
            approveData: '',
            secure3d: '',
            orderCcCampaigns: '',
            completeCamp: '',
            msCardName: '',
            setMsisdn: '',
            mandatoryCvv: '',
            payAgreements: false,
            cardPoint: {
                status: false,
                number:null,
                pointList: [],
                step:0,
            },
            cardStorageList: {},
            invoiceAddress: false,
            themeFolder: THEME_FOLDER,
        }
    },
    methods: {
        format(p) {
            return T.format(p);
        },
        scroll(el) {
            scroll({
                top: el.getBoundingClientRect().top + document.documentElement.scrollTop - 120,
                behavior: "smooth"
            });
        },
        scriptEval(content, type) {
            content = content.replace(/\s+/g, ' ');
            var startRegex = "<\s*script.*?>";
            var finishRegex = "<\s*\/\s*script\s*>";
            var mainRegex = new RegExp(startRegex + ".*?" + finishRegex, "ig");
            var res = content.match(mainRegex) || [];

            for (let i=0; i<res.length; i++) {
                try{
                    const parser = new DOMParser();
                    const doc = parser.parseFromString(res[i], 'text/html');
                    const src = doc.querySelector('script').getAttribute('src');
                    const html = doc.querySelector('script').innerHTML || '';

                    if (T(`#${type + i}`).length > 0) T(`#${type + i}`)[0].remove();
                    const script = document.createElement('script');
                    script.id = type + i;
                    if (src != undefined) script.src = src;
                    script.innerHTML = html;
                    document.body.appendChild(script);
                }catch(ex){
                    console.log(ex);
                }
            }
        },
        getScript(src, onload, onerror) {
            const script = document.createElement('script'); 
            script.src = src; 
            script.type = 'text/javascript';
            script.onload = () => { onload(); }
            script.onerror = () => { onerror(); }
            document.body.appendChild(script);
        },
        checkoutRequest(requestOpt) {
            const self = this;
            if (self.paymentID == '') {
                T.modal({ html: '{#select_pay_type#}' });
                return;
            }    
            const data = {
                paymentId: self.paymentID,
                serviceDate: "",
                serviceId: "",
            };

            popoverAlert.hideAll();
            const serviceParams = OrderPayment.methods.checkCargoServices();
            if (serviceParams === false) {
                T.modal({ html: '{#select_delivery_date#}' });
                return;
            } else if (serviceParams !== true && typeof serviceParams == "object") {
                data.serviceDate = serviceParams.date;
                data.serviceId = serviceParams.id;
            }

            const orderAgreementsInputs = T('#order-agreements input[type=checkbox]'),
                  orderAgreementsInputsCheck = T('#order-agreements input[type=checkbox]:not(:checked)');
            if (orderAgreementsInputs.length > 0 && orderAgreementsInputsCheck.length > 0) {
                if (T.isMobile() === true ) self.scroll(T('#order-agreements')[0]);
                T.modal({ html: '{#pay_aggrements#}' });
                return false;
            }

            switch (self.paymentID) {
                case '-1':
                    const paymentBank = T('[name=payment_Havale]:checked');
                    if (paymentBank.length === 0) {
                        if (T('[name=payment_Havale]').length > 0) self.scroll(T('[name=payment_Havale]')[0].parentNode);
                        T.modal({ html: '{#select_bank#}' });
                        return false;
                    }
                    data.paymentSubId = document.querySelector('[name=payment_Havale]:checked').value;
                    break;
                case '-2':
                    if (masterPass.active) {
                        if (!masterPass.newCardPanel && masterPass.hasCard) {
                            return masterPass.purchase();
                        }
                        if (masterPass.isSave && !masterPass.isLinkedPanel) {
                            return masterPass.purchaseAndRegister();
                        }
                        if (vm.insOpt.BANK_CODE != "undefined" && vm.insOpt.BANK_CODE != "" && masterPass.isCRPanel) {
                            return masterPass.purchaseDirect();
                        }
                    }

                    const cardEls = ["cardType", "installmentCount", "installmentId", "posId", "cardHolder", "cardNumber", "expireMonth", "expireYear", "cvc"];
                    data.cardId = T('#card-storage-list [name=cStorageCardId]:checked').length > 0 ? T('#card-storage-list [name=cStorageCardId]:checked')[0].value : '';

                    for (let i=0; i<cardEls.length; i++) {
                        const key = cardEls[i];
                        data[key] = self.creditCard[key];

                        if (self.creditCard[key] === '' && T(`#${key}`).length > 0) {
                            if (cardEls.indexOf(T(`#${key}`)[0].name) > -1 && data.cardId) {
                                //kayıtlı kart ile
                            } else if (T(`#${key}`)[0].classList.contains('required')) {
                                if (T.isMobile() === true ) self.scroll(T(`#${key}`)[0]);
                                popoverAlert.show(
                                    T(`#${key}`)[0],
                                    '{#form_required#}', 
                                    2000,
                                    `btn btn-danger no-radius text-left`,
                                    false,
                                    ''
                                );
                                return false;
                            }
                        }
                    }

                    document.querySelector('[name=creditCardCampaignCode]:checked') ? data.creditCardCampaignCode = document.querySelector('[name=creditCardCampaignCode]:checked').value : '';
                    data.cardPoint = OrderPayment.methods.getUserPoint();
                    data.cardSave = T('#card-save-control:checked').length > 0 ? 1 : 0;
                    data.cardAlias = T('#card-alias-control').length > 0 ? T('#card-alias-control')[0].value : '';
                    if (data.cardSave == 1 && data.cardAlias == '' && data.cardId == '') {
                        popoverAlert.show(
                            document.getElementById('card-alias-control'),
                            '{#card_name_enter#}', 
                            2200, 
                            `btn btn-danger no-radius text-left`,
                            false,
                            ''
                        );
                        return false;
                    }
                    if (data.posId == '') {
                        T.modal({ html: '{#select_installment#}' });
                        return false;
                    }
                    break;
                case '-9':
                    const bexProvider = T('#bkmexpress-checkout-form-container').length > 0 ? T('#bkmexpress-checkout-form-container')[0].dataset.bkmexpressProvider : '';
                    switch (bexProvider) {
                        case "PayTR":
                            return  OrderPayment.methods.checkoutBexAPIutils('PayTR');
                        case "BKM2":
                            return  OrderPayment.methods.checkoutBexAPIutils('BKM2');
                    }
                    break;
                case '-13':
                case '-21':
                    data.apiMethod = T(`.payment-list-item${data.paymentId} .iyzipay-checkout-form-container`)[0].dataset.apiMethod || '';
                    break;
                case '-24':
                    if (typeof requestOpt == "undefined") {
                        OrderPayment.methods.sodexoInit();
                        return;
                    } else {
                        data.phone = requestOpt.phone;
                        data.otp = requestOpt.otp;
                    }
                    break;
                case '-26':
                    if (typeof requestOpt == "undefined") {
                        OrderPayment.methods.chippinInit(0);
                        return;
                    } else {
                        data.chippinno = requestOpt.chippinno;
                    }
                    break;
                default:
                    if (document.querySelectorAll(`[name=pay${self.paymentID}]`).length > 0) {
                        if (document.querySelectorAll(`[name=pay${self.paymentID}]:checked`).length === 0) {
                            T.modal({ html: '{#select_underpayment#}' });
                            return false;
                        }
                        data.paymentSubId = document.querySelector(`[name=pay${self.paymentID}]:checked`).value;
                    }
                    break;
            }

            var formData = new FormData();
            for (var key in data) {
                formData.append(key, data[key]);
            }
            hideOrderNextElement();
            OrderPayment.methods.checkoutPayment(formData);
            return true;
        },
        nextStep() {
            const self = this;
            T.buttonLock.dom = self.$refs.orderNextBtn;
            T.buttonLock.text = `{#wait#}...`;
            T.buttonLock.lock();
            axios.get(self.endpoints.nextStep + self.nextPaymentStep).then(response => {
                const result = response.data;
                T.buttonLock.unlock();

                if (result.status !== 1) {
                    if (typeof result.stock != "undefined") {
                        T.modal({
                            html: `
                                <p>{#cart_stok_alert#}</p>
                                <div class="w-100 d-flex justify-content-flex-end">
                                    <a href="/${window['PAGE_LINK'].CART}" class="btn btn-secondary">{#okey#}</a>
                                </div>
                            `
                        });
                        return false;
                    } else if (result.status === -1) {
                        vm.nextOrderResult = { focus: result.key, msg: result.statusText };
                        vm.$router.push(`/address/${result.addressId}`);
                        return false;
                    } else if (result.status == -2) {
                        T.modal({
                            html: `
                                <p>${result.statusText}</p>
                                <div class="w-100 d-flex justify-content-flex-end">
                                    <a href="/${window['PAGE_LINK'].CART}" class="btn btn-secondary">{#okey#}</a>
                                </div>
                            `
                        });
                        setTimeout(() => { window.location.href=`/${window['PAGE_LINK'].CART}` }, 2000);
                        return false;
                    } else if (result.status == -3) {
                        T.modal({ html: result.statusText });
                        return;
                    }
                    T.modal({ html: result.statusText });
                    setTimeout(function() {
                        var eStep = result.errorStep || "";
                        switch (eStep) {
                            case 'address':
                                vm.$router.push('/');
                                break;
                            case 'basket':
                                window.location.href = `/${window['PAGE_LINK'].CART}`;
                                break;
                            default: 
                                window.location.reload();
                                break;
                        }
                    }, 2000);
                    return false;
                }
                if (self.nextPaymentStep === 'payment') {
                    vm.$router.push('/payment');
                    self.nextPaymentStep = 'approve';
                } else if (self.nextPaymentStep === 'approve') {
                    self.checkoutRequest();
                } else {
                    T.modal({ html: '{#general_error#}' });
                }
            });
        },
        storeNextStep() {
            OrderAddress.methods.storeNext();
        },
        saveGoogleAnalyticsVirtualPage(p) {
            // apps den yüklenen gelişmiş eticaret
            if (typeof GA_Enhanced_Ecommerce !== 'undefined') {
                return false;
            }
        
            if (typeof ga == "function") {
                ga('set', { page: p, title: '' });
                ga('send', 'pageview');
            } else if (typeof _gaq == "object") {
                _gaq.push(['_trackPageview', p]);
            }
        },
        saveGoogleAnalyticsEcommerce() {
            // apps den yüklenen gelişmiş eticaret
            if (typeof GA_Enhanced_Ecommerce !== 'undefined') {
                return false;
            }
        
            if (typeof approveOrderData == "undefined" || typeof approveOrderData == "string") {
                return;
            }
            if (typeof ga == "function") {
                ga('require', 'ecommerce', 'ecommerce.js');
                ga('ecommerce:addTransaction', {
                    id: approveOrderData.transaction,
                    affiliation: approveOrderData.firm,
                    revenue: approveOrderData.amount_without_vat,
                    shipping: approveOrderData.cargo_price,
                    tax: approveOrderData.total_vat
                });
        
                for (var i = 0; i < approveOrderData.products.length; i++) {
                    ga('ecommerce:addItem', {
                        id: approveOrderData.transaction,
                        sku: approveOrderData.products[i].code,
                        name: approveOrderData.products[i].name,
                        category: approveOrderData.products[i].category,
                        price: approveOrderData.products[i].amount,
                        quantity: approveOrderData.products[i].quantity
                    });
                }
                ga('ecommerce:send');
            } else if (typeof _gaq == "object") {
                _gaq.push(['_addTrans',
                    approveOrderData.transaction,
                    approveOrderData.firm,
                    approveOrderData.amount_without_vat,
                    approveOrderData.total_vat,
                    approveOrderData.cargo_price,
                    approveOrderData.city,
                    approveOrderData.province,
                    approveOrderData.country
                ]);
                for (var i = 0; i < approveOrderData.products.length; i++) {
                    _gaq.push(['_addItem',
                        approveOrderData.transaction,
                        approveOrderData.products[i].code,
                        approveOrderData.products[i].name,
                        approveOrderData.products[i].category,
                        approveOrderData.products[i].amount,
                        approveOrderData.products[i].quantity
                    ]);
                }
                _gaq.push(['_trackTrans']);
            }
        },
        erpPointReq() {
            const rf = (result) => {
                orderBackdrop(true);
                const ok = result && result.success;
                if (!ok) { alert(result.message || "{#error_again#}"); }
                else { OrderPayment.methods.getOrderSummary(); }
            };
            orderBackdrop();
            masterPass.ajaxPost({
                url: '/Order/OrderAPI/loadErpPoint',
                success: rf,
                error: rf
            });
        },
        erpPointSet(point, type) {
            const pointVal = T(`#${point}`)[0].value;
            if (pointVal == '') {
                showError(1, T(`#${point}`)[0], '{#amount_enter#}');
                return;
            }
            const rf = (result) => {
                orderBackdrop(true);
                const ok = result && result.success;
                if (!ok) alert(result.message || "{#error_again#}");
                OrderPayment.methods.getOrderSummary();
                if (vm.companyId != '') OrderPayment.methods.setCompany(vm.companyId);
            };
            orderBackdrop();
            const url = type == 'site' ? `/Order/OrderAPI/setCustomerPoint/${pointVal}` : `/Order/OrderAPI/setErpPoint/${pointVal}`;
            masterPass.ajaxPost({
                url: url,
                success: rf,
                error: rf,
            });
        },
        goOrderSummary(el) {
            scrollBehavior((el));
        },
    },
    watch: {
        '$route' (to, from){
            const self = this;
            switch (to.path) {
                case '/payment':
                    self.nextPaymentStep = 'approve';
                    setTimeout(() => {
                        if (self.paymentTypeList.PAYMENT_LIST) OrderPayment.watch.paymentTypeList(self.paymentTypeList);
                    }, 150);
                    break;
                default:
                    this.nextPaymentStep = 'payment';
                    break;
            }
        }
    },
    mounted() {
        const self = this;
        self.cardNumberTemp = self.otherCardMask;
        axios.get(self.endpoints.getOrderSummary).then(response => {
            self.summaryData = response.data;
            self.loading = false;
            setTimeout(() => { initComponents() }, 150);
        });
    }
}).use(router);

function showError(error = 0, selector = '', message = '', redirect = false) {
    if (error === 1 && selector) {
        popoverAlert.show(selector, message, 3000, `btn btn-danger no-radius text-left`);
    } else {
        T.notify({
            text: message,
            duration: 1800,
            className: 'btn btn-success'
        });
        if (redirect !== false) {
            vm.$router.push(redirect);
        }
    }
};

function hideOrderNextElement(reverse) {
    T.buttonLock.dom = T('.order-next-btn')[0];
    T.buttonLock.text = `{#wait#}...`;
    if (reverse == true) {
        T.buttonLock.unlock();
    } else {
        T.buttonLock.lock();
    }
    orderBackdrop(reverse);
};

window['orderBackdrop'] = function orderBackdrop(reverse) {

    if(T("#orderBackdrop").length > 0) document.body.removeChild(T("#orderBackdrop")[0]); 
    if(T("#orderBackdropL").length > 0) document.body.removeChild(T("#orderBackdropL")[0]); 

    if (reverse !== true) {
        let orderBackdrop = document.createElement('div');
        orderBackdrop.id = 'orderBackdrop';
        orderBackdrop.className = 'orderBackdrop';
        orderBackdrop.style.cssText = `
            position: fixed;
            top: 0;
            right: 0;
            bottom: 0;
            left: 0;
            z-index: 1000000000;
            background-color: #fff;
            opacity: 0.5;
            display: block;
        `;

        let orderBackdropL = document.createElement('div');
        orderBackdropL.id = 'orderBackdropL';
        orderBackdropL.className = 'orderBackdropL';
        orderBackdropL.style.cssText = `
            position: fixed;
            top: 50%;
            left: 50%;
            z-index: 1000000000;
            display: block;
        `;

        orderBackdropL.innerHTML = '<div class="is-loading"></div>'

        document.body.appendChild(orderBackdrop);
        document.body.appendChild(orderBackdropL);
    }
};

window['masterPass'] = {
    active: null,
    isSave: null,
    isCRPanel: false, /* complete register */
    isRPanel: false, /* register */
    inited: null,
    newCardPanel: false,
    isLinkedPanel: false,
    clientId: null,
    msisdn: null,
    hasAccount: false,
    hasCard: false,
    lastQueryToken: "",
    cards: [],
    validResponses: ["5001", "5002", "5008", "5010", "5015", "1422", "1410", "1078", "5460"],
    templateCardList: null,
    selectedCard: null,
    mandatoryCvv: null,
    isRefreshToken: null,
    isRefreshedToken: null,
    modal: null,
    otpMpinObject: { call: null, pinType: null },
    saveForm: { cardName: "" },
    init: function(result) {
        /* masterpass global */
        T("#have-masterpass-global-account").hide();
        if (T("#masterpass-global-active")[0].value == 1) {
            masterPass.globalInit(result);
        }

        if (masterPass.inited != null) {
            if (masterPass.hasCard) {
                vm.masterPassCards = masterPass.cards;
            }
            masterPass.setPanels();
            return;
        }

        masterPass.inited = true;
        masterPass.active = parseInt(T("#masterpass-active")[0].value) == 1 ? true : false;

        if (typeof MFS == "object" && masterPass.active == true) {
            masterPass.check();
            masterPass.setPanels();
        } else {
            masterPass.active = false;
            T("#masterpass-save-panel").hide();
            T("#credit-cart-form").show();
            T("#masterpass-card-list").hide();
        }
    },
    initComplete: function() {
        if (typeof approveOrderData == "undefined" || !approveOrderData || approveOrderData == null) {
            return;
        }
        if (typeof approveOrderData['__addtionalPDetail'] == "undefined" || approveOrderData['__addtionalPDetail'] == null) {
            return;
        }

        if (typeof approveOrderData['__addtionalPDetail']['__payment'] == "undefined") {
            return;
        }
        var $p = approveOrderData['__addtionalPDetail']['__payment'];
        if ($p.provider != 'MasterPass') {
            return;
        }
        if (parseInt($p.direct) != 1) {
            masterPass.showSuccessMessage('purchase');
            return;
        }
        if (masterPass.msisdn == null && approveOrderData.__member.phone != "") {
            masterPass.msisdn = approveOrderData.__member.phone;
        }
        masterPass.lastQueryToken = $p.token;
        masterPass.completeRegister();
    },
    ajaxPost: function(opt) {
        let options = {
            type: 'POST',
            dataType: 'json',
            url: '',
            data: '',
            success: function() {},
            error: function() {},
        };
        for (let i in opt) {
            if (i == 'data') {
                opt[i] = JSON.stringify(opt[i]);
            }
            options[i] = opt[i];
        }

        axios({
            url: options.url,
            method: options.type,
            data: options.data,
            responseType: options.dataType,
        }).then(response => { options.success(response.data); }).catch(error => {
            console.log(error);
            if (error.response && error.response.data) {
                options.error(error.response.data);
            } else if (error.request && error.request.response) {
                options.error(JSON.parse(error.request.response));
            }
        });
    },
    call: function(callBack, data) {
        var nData = { phone: masterPass.msisdn };
        if (typeof data != "undefined") {
            for (var i in data) {
                nData[i] = data[i];
            }
        }
        if (masterPass.isRefreshToken == true) {
            nData.refreshToken = 1;
            masterPass.isRefreshToken = null;
        }
        masterPass.ajaxPost({ url: '/Order/OrderAPI/masterPassToken', data: nData, success: callBack });
    },
    createForm: function(ob) {
        const form = document.createElement('form');
        form.method = 'POST';
        form.id = 'masterPassForm';

        for (const key in ob) {
            const input = document.createElement('input');
            input.type = 'hidden';
            input.name = key;
            input.value = ob[key];
            form.appendChild(input);
        }

        if (T('#masterPassForm').length > 0) T('#masterPassForm')[0].remove();
        document.body.appendChild(form);
    },
    checkResponse: function(status, response) {
        if (response.responseCode !== "" || response.accountStatus == "") {
            if (response.responseCode == "1419" && masterPass.isRefreshedToken != true) {
                masterPass.isRefreshedToken = true;
                masterPass.isRefreshToken = true;
                masterPass.check();
                return;
            }
            masterPass.active = false;
            masterPass.setPanels();
        } else {
            let hasMasterPassAccount = response.accountStatus.substr(1, 1); /* hesap var (1) */
            let hasMasterPassCard = response.accountStatus.substr(2, 1); /* kart var (1) */
            let isLinkedCard = response.accountStatus.substr(3, 1); /* kartlar ilişkili (1) */
            let isLockedAccount = response.accountStatus.substr(4, 1);
            let isChangedMpin = response.accountStatus.substr(5, 1);

            masterPass.hasAccount = hasMasterPassAccount == "1";
            masterPass.isLinkedPanel = false;

            if (isLockedAccount == "1") {
            } else if (hasMasterPassCard == "1" && isLinkedCard == "0") {
                masterPass.linkAccount();
            } else if (hasMasterPassCard == "1" && isLinkedCard == "1") {
                masterPass.listCard();
            }
        }
    },
    check: function() {
        var rf = function(result) {

            if (!result.success) return;

            masterPass.isCRPanel = result.client.isActiveCompleteRegister == 1; /* complete register */
            masterPass.isRPanel = result.client.isActiveCompleteRegister == 1 && result.client.isNotActiveRegister == 1 ? false : true;
            masterPass.setPanels();

            MFS.setAddress(result.clientSideUrl);

            if (result.data.msisdn == "") {
                return false;
            }

            vm.setMsisdn = result.data.msisdn;
            masterPass.msisdn = result.data.msisdn;

            masterPass.createForm({
                msisdn: result.data.msisdn,
                userId: result.data.msisdn,
                referenceNo: result.data.referenceNo,
                sendSms: result.data.sendSms,
                sendSmsLanguage: result.data.sendSmsLanguage,
                token: result.token
            });
            masterPass.clientId = result.data.clientId;
            masterPass.lastQueryToken = result.token;
            MFS.setClientId(result.data.clientId);
            MFS.checkMasterPass(T("#masterPassForm"), masterPass.checkResponse);
        };
        masterPass.call(rf);
    },
    listCardResponse: function(status, response) {
        masterPass.hasCard = false;
        masterPass.cards = [];

        masterPass.setPanels();

        if (response.responseCode == "1078") {
            /* geçersiz kullanıcı id */
            masterPass.linkAccount("updateUserID");
            return false;
        }

        if (typeof response.cards == "undefined") {
            return false;
        }

        if (response.cards == null) {
            return false;
        }

        if (response.cards.length > 0) {
            masterPass.hasCard = true;
            masterPass.cards = response.cards;
            vm.masterPassCards = masterPass.cards;
        }

        masterPass.setPanels();
    },
    listCard: function() {
        var rf = function(result) {
            masterPass.lastQueryToken = result.token;
            MFS.setClientId(masterPass.clientId);
            MFS.listCards(masterPass.msisdn, result.token, masterPass.listCardResponse);
        };
        masterPass.call(rf);
    },
    updateUserIDResponse: function(status, response) {
        orderBackdrop(true);
        if (response.responseCode == "0000" || response.responseCode == "") {
            masterPass.isLinkedPanel = false;
            masterPass.saveCustomer();
            masterPass.showSuccessMessage("link");
            masterPass.listCard();
        } else if (masterPass.validResponses.indexOf(response.responseCode) > -1) {
            masterPass.otpmpin(response, "updateUserIDResponse");
        } else {
            masterPass.showErrorMessage(response.responseDescription);
        }
    },
    updateUserID: function() {
        var rf = function(result) {
            if (!result.success) {
                return false;
            }
            var f = {
                token: result.token,
                msisdn: masterPass.msisdn,
                oldValue: 1,
                theNewValue: result.data.userId,
                valueType: "USER_ID",
                sendSmsLanguage: result.data.sendSmsLanguage,
                referenceNo: result.data.referenceNo,
                sendSms: result.data.sendSms,
                fP: ''
            };
            masterPass.createForm(f);
            MFS.setClientId(masterPass.clientId);
            MFS.updateUser(T("#masterPassForm"), masterPass.updateUserIDResponse);
        };
        masterPass.call(rf);
    },
    linkCardResponse: function(status, response) {
        orderBackdrop(true);
        if (response.responseCode == "0000" || response.responseCode == "") {
            masterPass.saveCustomer();
            masterPass.showSuccessMessage("link");
            masterPass.check();
        } else if (masterPass.validResponses.indexOf(response.responseCode) > -1) {
            masterPass.otpmpin(response, "linkCardResponse");
        } else {
            masterPass.showErrorMessage(response.responseDescription);
        }
    },
    linkCard: function() {
        var rf = function(result) {
            if (!result.success) {
                return false;
            }
            var f = {
                token: result.token,
                msisdn: masterPass.msisdn,
                referenceNo: result.data.referenceNo,
                sendSms: result.data.sendSms,
                sendSmsLanguage: result.data.sendSmsLanguage,
            };
            masterPass.createForm(f);
            masterPass.lastQueryToken = result.token;
            MFS.setClientId(result.client.clientId);
            MFS.linkCardToClient(T("#masterPassForm"), masterPass.linkCardResponse);
        };
        masterPass.call(rf);
    },
    linkAccount: function(cb) {
        if (typeof cb == "undefined") {
            cb = "linkCard";
        }
        masterPass.isLinkedPanel = true;
        masterPass.modalClose();
        let tpl = `
            <div class="col-12 p-1">
                <p>{#masterpass_has_card_1#} <span class="text-primary text-uppercase">"{#okey#}"</span>a {#masterpass_has_card_1#}</p>
                <p class="text-primary font-bold">{#masterpass_note#}</p>
                <button type="button" onclick="masterPass.linkApprove('${cb}')" id="mpLINKButtonApprove" class="btn btn-primary text-uppercase w-100 mb-1">{#okey#}</button>
                <div id="masterPassErrorMessage" class="mb-1" style="display:none;"><div class="text-danger fw-bold"></div></div>
                <div style="background:url('/theme/standart/images/KrediKart/bg_masterpass.png') center right no-repeat; background-size:cover; height:55px;"></div>
            </div>
        `;
        masterPass.modalOpen(tpl);
        masterPass.setPanels();
    },
    linkApprove: function(cb) {
        T("#mpLINKButtonApprove")[0].setAttribute("disabled", true);
        masterPass[cb]();
    },
    deleteResponse: function(status, response) {
        if (response.responseCode != "" && response.responseCode != "0000") {
            masterPass.showErrorMessage(response.responseDescription);
            return false;
        }
        masterPass.listCard();
    },
    deleteCard: function(event) {
        const cardUniqueId = event.dataset.id;
        if (!confirm('{#want_to_delete#}')) {
            return false;
        }
        var card = null;
        Array.from(masterPass.cards).forEach((item) => {
            if (item.UniqueId == cardUniqueId) {
                card = item;
            }
        });

        var rf = function(result) {
            if (!result.success) {
                return false;
            }
            var f = {
                token: result.token,
                accountAliasName: card.Name,
                msisdn: masterPass.msisdn,
                actionType: 'E',
                clientIp: '',
                delinkReason: 'User request',
                eActionType: 'D',
                cardTypeFlag: "05",
                cpinFlag: "Y",
                defaultAccount: "Y",
                mmrpConfig: "110010",
                identityVerificationFlag: "Y",
                mno: result.client.mnoId,
                mobileAccountConfig: "MWA",
                programOwnerName: result.client.programOwnerName,
                programOwnerNumber: result.client.programOwnerNumber,
                programParticipantName: result.client.programParticipantName,
                programParticipantNumber: result.client.programParticipantNumber,
                programSponsorName: result.client.programSponsorName,
                programSponsorNumber: result.client.programSponsorNumber,
                referenceNo: result.data.referenceNo,
                sendSms: result.data.sendSms,
                sendSmsLanguage: result.data.sendSmsLanguage,
                timeZone: result.data.timeZone,
                uiChannelType: 6
            };
            masterPass.createForm(f);
            masterPass.lastQueryToken = result.token;
            MFS.setClientId(result.client.clientId);
            MFS.deleteCard(T("#masterPassForm"), masterPass.deleteResponse);
        };
        masterPass.call(rf);
    },
    purchaseResponse: function(status, response) {
        if (response.responseCode == "0000" || response.responseCode == "") {
            masterPass.checkout(response.token);
        } else if (masterPass.validResponses.indexOf(response.responseCode) > -1) {
            hideOrderNextElement(true);
            masterPass.otpmpin(response, "purchaseResponse");
        } else {
            hideOrderNextElement(true);
            masterPass.showErrorMessage(response.responseDescription);
        }
    },
    purchase: function() {
        if (!masterPass.validatePurchase('purchase')) {
            return false;
        }
        
        var card = masterPass.selectedCard;
        var rf = function(result) {
            if (!result.success || !masterPass.validatePurchaseParams(result)) {
                hideOrderNextElement(true);
                return false;
            }
            var f = {
                token: result.token,
                amount: result.order.orderTotal,
                aav: 'aav',
                clientIp: '',
                encCPin: '',
                encPassword: '',
                macroMerchantId: result.client.macroMerchantId,
                referenceNo: result.data.referenceNo,
                orderNo: result.order.orderNumber,
                password: "",
                sendSms: result.data.sendSms,
                sendSmsLanguage: result.data.sendSmsLanguage,
                sendSmsMerchant: "N",
                userId: masterPass.msisdn,
                msisdn: masterPass.msisdn,
                listAccountName: card.Name,
                installmentCount: result.payment.installmentCount,
                cvc: T("#mpControlCVV")[0].value
            };
            masterPass.createForm(f);
            masterPass.lastQueryToken = result.token;
            MFS.setClientId(result.client.clientId);
            MFS.setAdditionalParameters(result.additionalParameters);
            MFS.purchase(T("#masterPassForm"), masterPass.purchaseResponse);
        };
        hideOrderNextElement(false);
        masterPass.call(rf, {
            purchase: 1, 
            cc1: card.Value1.substring(0, 6), 
            cc2: card.Value1.substring(card.Value1.length - 4)
        });
    },
    purchaseAndRegisterResponse: function(status, response) {
        if (response.responseCode == "0000" || response.responseCode == "") {
            if (typeof response.token != "undefined") {
                masterPass.checkout(response.token);
            } else {
                /* token not found.... */
            }
        } else if (masterPass.validResponses.indexOf(response.responseCode) > -1) {
            hideOrderNextElement(true);
            masterPass.otpmpin(response, "purchaseAndRegisterResponse");
        } else {
            if (response.responseCode == "5196") {
                if (!masterPass.hasAccount) {
                    masterPass.saveCustomer();
                }
            }
            hideOrderNextElement(true);
            masterPass.showErrorMessage(response.responseDescription);
            return false;
        }
    },
    purchaseAndRegister: function() {
        if (!masterPass.validatePurchase('purchaseAndRegister')) {
            return false;
        }

        hideOrderNextElement();
        var rf = function(result) {
            if (!result.success || !masterPass.validatePurchaseParams(result)) {
                hideOrderNextElement(true);
                return false;
            }
            var f = {
                cardHolderName: vm.creditCard.cardHolder,
                rtaPan: vm.creditCard.cardNumber.replace(/ /g, ""),
                expiryDate: vm.creditCard.expireYear + vm.creditCard.expireMonth,
                cvc: vm.creditCard.cvc,
                installmentCount: result.payment.installmentCount,
                actionType: 'A',
                clientIp: '',
                delinkReason: '',
                eActionType: 'A',
                cardTypeFlag: '05',
                cpinFlag: 'Y',
                defaultAccount: 'Y',
                mmrpConfig: '110010',
                identityVerificationFlag: 'Y',
                mno: result.client.mnoId,
                mobileAccountConfig: 'MWA',
                programOwnerName: result.client.programOwnerName,
                programOwnerNumber: result.client.programOwnerNumber,
                programParticipantName: result.client.programParticipantName,
                programParticipantNumber: result.client.programParticipantNumber,
                programSponsorName: result.client.programSponsorName,
                programSponsorNumber: result.client.programSponsorNumber,
                referenceNo: result.data.referenceNo,
                sendSms: result.data.sendSms,
                sendSmsLanguage: result.data.sendSmsLanguage,
                timeZone: result.data.timeZone,
                uiChannelType: 6,
                merchantId: result.client.macroMerchantId,
                macroMerchantId: result.client.macroMerchantId,
                orderNo: result.order.orderNumber,
                amount: result.order.orderTotal,
                token: result.token,
                accountAliasName: vm.msCardName,
                msisdn: result.data.msisdn
            };
            masterPass.createForm(f);
            masterPass.msisdn = result.data.msisdn;
            masterPass.lastQueryToken = result.token;
            MFS.setClientId(result.client.clientId);
            MFS.setAdditionalParameters(result.additionalParameters);
            MFS.purchaseAndRegister(T("#masterPassForm"), masterPass.purchaseAndRegisterResponse);
        };
        var c = vm.creditCard.cardNumber.replace(/ /g, "");
        masterPass.call(rf, {
            purchase: 1,
            cc1: c.substring(0, 6),
            cc2: c.substring(c.length - 4)
        });
    },
    purchaseDirectResponse: function(status, response) {
        if (response.responseCode == "0000" || response.responseCode == "") {
            if (typeof response.token != "undefined") {
                masterPass.checkout(response.token, true);
            } else {
                /* token not found.... */
            }
        } else if (masterPass.validResponses.indexOf(response.responseCode) > -1) {
            hideOrderNextElement(true);
            masterPass.otpmpin(response, "purchaseDirectResponse");
        } else {
            hideOrderNextElement(true);
            masterPass.showErrorMessage(response.responseDescription);
            return false;
        }
    },
    purchaseDirect: function() {
        if (!masterPass.validatePurchase('purchaseDirect')) {
            return false;
        }

        hideOrderNextElement();
        var rf = function(result) {
            if (!result.success || !masterPass.validatePurchaseParams(result)) {
                hideOrderNextElement(true);
                return false;
            }
            masterPass.lastQueryToken = result.token;
            var f = {
                msisdn: masterPass.msisdn,
                rtaPan: vm.creditCard.cardNumber,
                expiryDate: vm.creditCard.expireYear + vm.creditCard.expireMonth,
                cvc: vm.creditCard.cvc,
                cardHolderName: vm.creditCard.cardHolder,
                amount: result.order.orderTotal,
                referenceNo: result.data.referenceNo,
                sendSms: result.data.sendSms,
                sendSmsLanguage: result.data.sendSmsLanguage,
                timeZone: result.data.timeZone,
                merchantId: result.client.macroMerchantId,
                orderNo: result.order.orderNumber,
                token: result.token
            };
            masterPass.createForm(f);
            MFS.setAdditionalParameters(result.additionalParameters);
            MFS.directPurchase(T("#masterPassForm"), masterPass.purchaseDirectResponse);
        };
        var c = vm.creditCard.cardNumber.replace(/ /g, "");
        masterPass.call(rf, { purchase: 1, directPurchase: 1, cc1: c.substring(0, 6), cc2: c.substring(c.length - 4) });
    },
    checkout: function(token, completeRegister) {
        if (!masterPass.hasAccount) {
            masterPass.saveCustomer();
        }
        var rf = function(result) {
            masterPass.modalClose();
            if (result.status == 0) {
                T.modal({ html:'{#error_pay#}.' });
                hideOrderNextElement(true);
            } else if (result.state == 99) { /* success */
                hideOrderNextElement(true);
                if (result.completedCampaigns) {
                    /* TODO */
                } else {
                    /*loadApproveTpl();*/
                }
            } else {
                masterPass.reloadRoute();
            }
        };
        masterPass.ajaxPost({ url: '/Order/OrderAPI/masterPassCheckout', data: { token: token, cvv: "" }, success: rf });
    },
    selectCard: function(event) {
        setTimeout(function() {
            let cardId = event.value || '';
            
            masterPass.selectedCard = null;
            if (cardId == '') {
                masterPass.newCardPanel = true;
                vm.creditCard.cardNumber = '';
                T('.card-installment')[0].dataset.bin = '';
                vm.insOpt = {};
            } else {
                masterPass.newCardPanel = false;
                let cardItem = null;
                Array.from(masterPass.cards).forEach((item) => {
                    if (item.UniqueId == cardId) {
                        cardItem = item;
                    }
                });
                if (cardItem) {
                    masterPass.selectedCard = cardItem;
                    const value = String(cardItem.Value1.substr(0, 6));
                    OrderPayment.methods.getInstallment(value);
                }
            }
            masterPass.setPanels();
            masterPass.setCvvPanel();
        }, 1);
    },
    reloadRoute: function() {
        window.location.reload();
    },
    showSuccessMessage: function(type) {
        masterPass.modalClose();
        var msg = '';
        switch (type) {
            case 'link':
                msg = '{#masterpass_success#}';
                break;
            case 'purchase':
                msg = '{#masterpass_done#}';
                break;
        };
        const tpl = `
            <div class="col-12 p-1">
                <div class="w-100 d-flex align-items-center mb-1">
                    <div class="otp-logo mr-1"><img src="/theme/standart/images/KrediKart/tick.jpg" /></div>
                    <div class="otp-text">${msg}</div>
                </div>
                <div style="background:url('/theme/standart/images/KrediKart/bg_masterpass.png') center right no-repeat; background-size:cover; height:55px;"></div>
            </div>
        `;

        masterPass.modalOpen(tpl);
        setTimeout(function() {
            masterPass.modalClose();
        }, 3000);
    },
    showErrorMessage: function(message) {
        if (T("#masterPassErrorMessage").length == 1) {
            T("#masterPassErrorMessage .alert").text(message);
            T("#masterPassErrorMessage").show();

            if (T("#mpOTPButtonSend").length > 0) T("#mpOTPButtonSend")[0].setAttribute("disabled", false);
            if (T("#mpOTPButtonReSend").length > 0) T("#mpOTPButtonReSend")[0].setAttribute("disabled", false);
            if (T("#mpLINKButtonApprove").length > 0) T("#mpLINKButtonApprove")[0].setAttribute("disabled", false);
        } else {
            T.modal({ html: message });
        }
    },
    saveCustomer: function() {
        masterPass.ajaxPost({ url: '/Order/OrderAPI/masterPassSaveCustomer', data: { msisdn: masterPass.msisdn } });
    },
    otpControlResponse: function(status, response) {
        hideOrderNextElement(true);
        if (response.responseCode == "0000" || response.responseCode == "") {
            orderBackdrop();
            masterPass[masterPass.otpMpinObject.call](status, response);
        } else if (response.responseCode == "1409") {
            masterPass.showErrorMessage(response.responseDescription);
        } else if (masterPass.validResponses.indexOf(response.responseCode) > -1) {
            masterPass.otpmpin(response, masterPass.otpMpinObject.call);
        } else {
            orderBackdrop();
            masterPass.modalClose();
            document.body.removeChild(T('#masterPassErrorMessage')[0]);
            masterPass[masterPass.otpMpinObject.call](status, response);
        }
    },
    otpControlSend: function() {
        if (T("#mpOTPControlVcode")[0].value == "") {
            masterPass.showErrorMessage("{#otp_code_enter#}");
            return false;
        }
        if (masterPass.otpMpinObject.checkInputId != '') {
            if (T(`#${masterPass.otpMpinObject.checkInputId}:checked`).length == 0) {
                T.notify({
                    text: '{#form_required#}',
                    duration: 1800,
                    className: 'btn btn-danger'
                });
                return false;
            }
        }
        T("#masterPassErrorMessage").hide();
        T("#mpOTPButtonSend")[0].setAttribute("disabled", true);
        hideOrderNextElement();
        var rf = function(result) {
            if (!result.success) {
                hideOrderNextElement(true);
                return false;
            }
            masterPass.createForm({
                validationCode: T("#mpOTPControlVcode")[0].value,
                referenceNo: result.data.referenceNo,
                sendSms: result.data.sendSms,
                sendSmsLanguage: result.data.sendSmsLanguage,
                pinType: masterPass.otpMpinObject.pinType,
                token: result.token
            });
            MFS.setClientId(result.client.clientId);
            MFS.validateTransaction(T("#masterPassForm"), masterPass.otpControlResponse);
        };
        masterPass.call(rf);
    },
    otpControlResend: function() {
        T("#masterPassErrorMessage").hide();
        T("#mpOTPButtonReSend")[0].setAttribute("disabled", true);
        let l = masterPass.otpMpinObject.call.length;
        let f = masterPass.otpMpinObject.call.substring(0, l - 8);
        masterPass[f]();
    },
    otpmpin: function(response, cb) {
        var otpText = '';
        var pinType = '';
        var otpTextLogo = '';
        if (response.responseCode == "5010") {
            hideOrderNextElement();
            if (!masterPass.hasAccount) {
                masterPass.saveCustomer();
            }
            var rf = function(result) {
                if (result.success) {
                    var u = response.url3D;
                    if (u.indexOf("?") == -1) {
                        u += '?';
                    }
                    window.location.href = u + "&returnUrl=" + result.returnUrl;
                } else {
                    masterPass.reloadRoute();
                }
            };
            masterPass.ajaxPost({ url: '/Order/OrderAPI/masterPass3DLocation', success: rf });
            return false;
        } else if (response.responseCode == "1078") {
            masterPass.linkAccount("updateUserID"); /* geçersiz kullanıcı id */
            return false;
        } else if (response.responseCode == "5460") {
            masterPass.linkAccount("linkCard"); /* geçersiz kullanıcı id */
            return false;
        } else if (response.responseCode == "1422" || response.responseCode == "1410") {
            T("#mpOTPMPINPanelCode").hide();
            T("#mpOTPMPINPanelResend").show();
            masterPass.showErrorMessage(response.responseDescription);
            return false;
        } else if (response.responseCode == "5008") {
            otpText = '{#enter_phone_code#}';
            pinType = 'otp';
            otpTextLogo = '<img src="/theme/standart/images/KrediKart/sms_validation.png">';
        } else if (response.responseCode == "5001") {
            /* otp-form */
            otpText = '{#enter_phone_sms_code#}';
            pinType = 'otp';
            otpTextLogo = '<img src="/theme/standart/images/KrediKart/credit_card.png">';
        } else if (response.responseCode == "5002") {
            otpText = mpin;
            pinType = 'mpin';
            otpTextLogo = '<img src="/theme/standart/images/KrediKart/credit_card.png">';
        } else if (response.responseCode == "5015") {
            otpText = '{#mpin_creat#}';
            pinType = 'mpin';
            otpTextLogo = '<img src="/theme/standart/images/KrediKart/credit_card.png">';
        }

        var btnBlock = '<button onclick="masterPass.otpControlSend()" class="btn btn-success text-uppercase text-center w-100" id="mpOTPButtonSend">{#verify#}</button>';
        var confBlock = '';

        masterPass.otpMpinObject.call = cb;
        masterPass.otpMpinObject.pinType = pinType;
        masterPass.otpMpinObject.checkInputId = '';

        if (cb == 'completeRegisterResponse' && response.responseCode == "5008") {
            otpTextLogo = '<img src="/theme/standart/images/KrediKart/credit_card.png">';
            otpText = save_your_credit_cart_width_masterpass;
            btnBlock = `
            <div class="row">
                <div class="col-6">
                    <button type="button" onclick="masterPass.otpControlSend()" class="btn btn-success w-50" id="mpOTPButtonSend">{#save#}</button>
                </div>
                <div class="col-6">
                    <button type="button" onclick="masterPass.modalClose()" class="btn btn-gray w-50">{#give_up#}</button>
                </div>
            </div>
            `;
            confBlock = `
                <div class="row mb">
                    <div class="col-12 popover-wrapper">
                        <input type="checkbox" id="mpCompleteRegisterTermUseApprove" class="form-control" />
                        <label for="mpCompleteRegisterTermUseApprove">
                            <span class="input-checkbox"><i class="ti-circle"></i></span>
                            <a href="/Order/OrderAPI/masterPassTermofUse/1" target="_blank">{#masterpass_terms_use#}</a>
                            {#accept#}
                        </label>
                    </div>
                </div>
            `;
            masterPass.otpMpinObject.checkInputId = 'mpCompleteRegisterTermUseApprove';
        }

        let tpl = `
            <div class="col-12 p-1">
                <div class="w-100 d-flex align-items-center mb-1">
                    <div class="otp-logo mr-1">${otpTextLogo}</div>
                    <div class="otp-text">${otpText}</div>
                </div>
                <div id="mpOTPMPINPanelCode" class="w-100 mb-1">
                    <input type="text" class="form-control form-control-lg required mb-1" id="mpOTPControlVcode" placeholder="{#enter_phone_code#}" />
                    ${btnBlock}
                </div>
                ${confBlock}
                <div id="mpOTPMPINPanelResend" class="mb-1" style="display:none;">
                    <button onclick="masterPass.otpControlResend()" class="btn btn-primary w-100" id="mpOTPButtonReSend">{#again_send_code#}</button>
                </div>
                <div id="masterPassErrorMessage" style="display:none" class="mb-1"><div class="text-danger fw-bold"></div></div>
                <div style="background:url('/theme/standart/images/KrediKart/bg_masterpass.png') center right no-repeat; background-size:cover; height:55px;"></div>
            </div>
        `;

        masterPass.modalOpen(tpl);
    },
    modalOpen: function(tpl) {
        masterPass.modal = T('#masterPassPOPUP')[0];
        masterPass.modalClose();
        T.modal({
            id: 'masterPassPOPUP',
            width: `480px`,
            html: tpl,
            close: true
        });
    },
    modalClose: function() {
        if (masterPass.modal) {
            T('.t-modal-backdrop').trigger('click');
            masterPass.modal == null;
        }
    },
    validatePurchase: function(type) {
        if (type == 'purchase' && masterPass.selectedCard == null) {
            T.modal({ html: '{#dont_cart_select#}' });
            return false;
        }
        if (type == 'purchase' && masterPass.mandatoryCvv && T("#mpControlCVV")[0].value == '') {
            T.modal({ html: '{#masterpass_cvc#}' });
            return false;
        }

        if (type == 'purchaseAndRegister' || type == 'purchaseDirect') {
            var formData = T('#credit-cart-form [name].required');
            for (var i = 0; i < formData.length; i++) {
                if (formData[i].value === '') {
                    popoverAlert.show(T('#' + formData[i].name)[0], '{#form_required#}!', 3000, 'btn btn-danger', false, '');
                    return false;
                }
            }
        }
        if (type == 'purchaseAndRegister') {
            if (T("#mp-control-card-name")[0].value == '') {
                popoverAlert.show(T('#mp-control-card-name')[0], '{#card_name_enter#}', 3000, 'btn btn-danger', false, '');
                return false;
            }
            if (masterPass.msisdn == '') {
                popoverAlert.show(T('#mp-control-phone-number')[0], '{#your_phone#}', 3000, 'btn btn-danger', false, '');
                return false;
            }
        }

        if (T("#credit-cart-form [name=posId]")[0].value == '' && type != 'globalCheckout') {
            T.modal({ html: '{#select_installment#}' });
            return false;
        }

        if (T("#order-agreements input[type=checkbox]").length > 0 && T("#order-agreements input[type=checkbox]:not(:checked)").length > 0) {
            T.modal({ html: '{#pay_aggrements#}' });
            return false;
        }
        return true;
    },
    validatePurchaseParams: function(result) {
        if (
            String(result.payment.installmentCount) != String(T("#credit-cart-form [name=installmentCount]")[0].value) ||
            String(result.payment.installmentId) != String(T("#credit-cart-form [name=installmentId]")[0].value) ||
            result.payment.installmentCount == null
        ) {
            T.modal({ html: '{#select_installment#}' });
            return false;
        }

        return true;
    },
    completeRegisterResponse: function(status, response) {
        orderBackdrop(true);
        if (response.responseCode == "0000" || response.responseCode == "") {
            /* this is ok */
            masterPass.showSuccessMessage('link');
        } else if (masterPass.validResponses.indexOf(response.responseCode) > -1) {
            masterPass.otpmpin(response, "completeRegisterResponse");
        } else {
            masterPass.showErrorMessage(response.responseDescription);
            T("#mpCompleteRegisterBtn")[0].setAttribute("disabled", false);
            return false;
        }
    },
    completeRegister: function() {
        if (approveOrderData.__addtionalCDetail.cType != 'CREDITCARD') {
            return;
        }
        var rf = function(result) {
            if (!result.success) {
                return false;
            }
            var cn;
            if (approveOrderData.__addtionalCDetail.brand != "") {
                cn = approveOrderData.__addtionalCDetail.brand + ' ' + "KK";
            } else {
                cn = 'KK';
            }
            var f = {
                token: result.token,
                cardAliasName: cn,
                referenceNo: result.data.referenceNo,
                sendSms: result.data.sendSms,
                sendSmsLanguage: result.data.sendSmsLanguage,
                msisdn: masterPass.msisdn,
            };
            masterPass.createForm(f);
            /* masterPass.lastQueryToken = result.token; */
            MFS.setAddress(result.clientSideUrl);
            MFS.setClientId(result.client.clientId);
            MFS.completeRegistration(T("#masterPassForm"), masterPass.lastQueryToken, masterPass.completeRegisterResponse);
        };
        masterPass.call(rf);
    },
    completeRegister_: function() {
        var c = true;
        if (T("#mpCompleteRegisterCardName")[0].value == "") {
            popoverAlert.show(T('#mpCompleteRegisterCardName')[0], '{#form_required#}', 1800, 'btn btn-danger');
            c = false;
        }
        if (T("#mpCompleteRegisterTermUseApprove:checked").length == 0) {
            popoverAlert.show(T('#mpCompleteRegisterTermUseApprove')[0], '{#form_required#}', 1800, 'btn btn-danger');
            c = false;
        }
        if (c == false) {
            return false;
        }
        var rf = function(result) {
            if (!result.success) {
                return false;
            }
            var f = {
                token: result.token,
                cardAliasName: T("#mpCompleteRegisterCardName")[0].value,
                referenceNo: result.data.referenceNo,
                sendSms: result.data.sendSms,
                sendSmsLanguage: result.data.sendSmsLanguage,
                msisdn: masterPass.msisdn,
            };
            masterPass.createForm(f);
            /* masterPass.lastQueryToken = result.token; */
            MFS.setAddress(result.clientSideUrl);
            MFS.setClientId(result.client.clientId);
            MFS.completeRegistration(T("#masterPassForm"), masterPass.lastQueryToken, masterPass.completeRegisterResponse);
        };
        T("#mpCompleteRegisterBtn")[0].setAttribute("disabled", true);
        masterPass.call(rf);
    },
    completeRegisterPopup_: function() {
        masterPass.modalClose();
        let tpl = `
            <div class="w-100">
                <img src="/theme/standart/images/KrediKart/credit_card.png" style="padding-right:20px" />
                <p style="font-size:20px;">{#masterpass_save#}</p>
            </div>
            <div class="w-100 mt-1">
                <label for="mpCompleteRegisterCardName">{#card_name_enter#}</label>
                <div class="popover-wrapper">
                    <input type="text" name="mpCompleteRegisterCardName" id="mpCompleteRegisterCardName" class="form-control" />
                </div>
            </div>
            <div class="w-100 mt-1">
                <button type="button" onclick="masterPass.completeRegister()" id="mpCompleteRegisterBtn" class="btn btn-success w-50">{#save#}</button>
                <button type="button" onclick="masterPass.modalClose()" class="btn btn-primary w-50">{#give_up#}</button>
            </div>
            <div class="w-100 mt-1">
                <div class="popover-wrapper">
                    <input type="checkbox" id="mpCompleteRegisterTermUseApprove" class="form-control">
                    <label for="mpCompleteRegisterTermUseApprove">
                        <span class="input-checkbox"><i class="ti-check"></i></span>
                        <a href="/Order/OrderAPI/masterPassTermofUse/1" target="_blank">{#masterpass_terms_use#}</a> {#accept#}
                    </label>
                </div>
            </div>
            <div class="w-100 mt-1"id="masterPassErrorMessage" style="display:none">
                <div class="w-100 bg-danger p-1"></div></div>
            </div>
            <div style="background:url('/theme/standart/images/KrediKart/bg_masterpass.png') center right no-repeat; background-size:cover; height:66px; position:relative; margin:-1px;"></div>
        `;
        masterPass.modalOpen(tpl);
    },
    setPanels: function() {
        if (!masterPass.active) {
            T("#masterpass-save-panel").hide();
            T("#masterpass-card-list").hide();
            T("#credit-cart-form").show();
            return;
        }
        if (masterPass.hasCard) {
            T("#masterpass-card-list").show();
            T("#credit-cart-form").hide();
            T("#masterpass-save-panel").hide();
            if (masterPass.newCardPanel) {
                T("#credit-cart-form").show();
                T("#masterpass-save-panel").show();
            }
        } else if (masterPass.isLinkedPanel) {
            T("#masterpass-save-panel").hide();
            T("#masterpass-card-list").hide();
            T("#credit-cart-form").show();
        } else {
            T("#masterpass-card-list").hide();
            T("#credit-cart-form").show();
            T("#masterpass-save-panel").show();
        }

        if (masterPass.isRPanel == false) {
            T("#masterpass-save-panel").hide();
            masterPass.isSave = false;
        }
    },
    setCvvPanel: function() {
        T("#masterPassCVVPanel").hide();
        if (masterPass.mandatoryCvv && masterPass.selectedCard != null) {
            T("#masterPassCVVPanel").show();
        }
    },
    setPosDetails: function() {
        setTimeout(function() {
            masterPass.mandatoryCvv = parseInt(vm.mandatoryCvv) == 1;
            masterPass.setCvvPanel();
        }, 10);
    },
};

masterPass.globalInit = function(result) {
    var conf = {};
    Array.from(result.PAYMENT_LIST).forEach((k, v) => {
        if (typeof k.MASTERPASSCONF != "undefined") {
            conf = k.MASTERPASSCONF;
        }
    });
    if (parseInt(conf.isGlobalActive) != 1) {
        return;
    }

    if (T("#jsMasterpassGlobalClient").length == 0) {
        let a = document.createElement("script");
        a.src = conf.mpGlobalClient;
        a.id = "jsMasterpassGlobalClient";
        document.body.appendChild(a);
    }
    T("#have-masterpass-global-account").show();
};

masterPass.globalCheckout = function() {
    if (!masterPass.validatePurchase('globalCheckout')) {
        return false;
    }

    let rf = function(result) {
        if (result.status != 2) {
            T.modal({ html: "an error occured, plase try again" });
        } else {
            let d = {
                "requestToken": result.data.RequestToken,
                "callbackUrl": result.data.callbackUrl,
                "merchantCheckoutId": result.data.merchantCheckoutId,
                "allowedCardTypes": ["master,amex,diners,discover,maestro,visa"],
                "suppressShippingAddressEnable": true,
                "version": "v6"
            };
            MasterPass.client.checkout(d);
        }
    };

    masterPass.ajaxPost({
        url: '/Order/OrderAPI/masterPassGlobalCheckout',
        data: {},
        success: rf,
        error: function() { }
    });
};

window['BexUtil'] = {
    BexJS: undefined,
    createTicket: (url, params) => {
        return axios.post(url, params).then(result => {
            const response = result.data;
            if(response.response == "timeout") return false;
            if (!BexUtil.BexJS) {
                const src = response.config.baseJs;
                const onload = () => {
                    BexUtil.BexJS = Bex;
                    return response.response;
                };
                const onerror = () => { console.log('script yüklenemedi'); };
                vm.getScript(src, onload, onerror);
            }
            return response.response;
        });
    },
    showModal: (url, params, modalOptions) => {
        BexUtil.createTicket(url, params).then(ticket => {
            if(ticket === false || ticket === "timeout"){
                bex_timeout();
            } else {
                const bexControl = () =>  {
                    if (BexUtil.BexJS == undefined) {
                        setTimeout(() => { bexControl(); }, 250);
                        return;
                    } else { Bex.init(ticket, "modal", modalOptions); }
                }
                bexControl();
            }
        });
    }
}

window['iyzicoEventBeforePayment'] = function(event) {
    var c = false,
        u = '';
    const formData = new FormData();
    formData.append('token', iyziInit.token);
    axios.post('/Order/OrderAPI/iyzicoEventBeforePayment', formData).then(result => {
        if (result.data.success) {
            c = true;
        } else {
            if (result.data.errorStep == "address") {
                u = "/order#/";
            } else if (result.errorStep == "basket") {
                u = "/Sepet.php";
            }
        }
        if (c == false) {
            if (u == "") {
                window.location.reload();
            } else {
                window.location.href = u;
            }
            throw "token not saved";
        }
    });
};

window['deleteAddress'] = (element, target) => {
    const id = element.dataset.id;
    axios.delete(vm.endpoints.deleteAddres + id).then(response => {
        const result = response.data;
        showError(0, '', result.statusText);
        OrderAddress.methods.getOrderAddress();
    });
};

window['vm'] = order.mount('#order-steps');

window['orderState'] = document.getElementById('orderState').value;
window['orderStateMessage'] = document.getElementById('orderStateMessage').value;
window['currentPage'] = document.getElementById('currentPage').value;

if (orderState == 'error') {
    if (currentPage == 'approve') {
        vm.$router.push('/approve');
    } else if (currentPage == 'payment') {
        vm.$router.push('/payment');
    } else if (currentPage == 'address') {
        vm.$router.push('/');
    }
    setTimeout(() => {
        T.modal({ html: orderStateMessage });
    }, 1500);
} else if (orderState == 'completed') {
    vm.$router.push('/approve');
}