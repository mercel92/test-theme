var CartPage = Vue.createApp({
    data() {
        return {
            endpoints: {
                'cart'             : '/srv/service/cart/load',
                'setCampaign'      : '/srv/service/cart/set-campaign-code/',
                'updGiftPackage'   : '/srv/service/cart/update-field/',
                'getGiftNotes'     : '/srv/service/cart/get-gift-notes/',
                'getOrderNotes'    : '/srv/service/cart/get-order-notes/',
                'selectCampaign'   : '/srv/campaign-v2/campaign/select-campaign/',
                'cancelCampaign'   : '/srv/campaign-v2/campaign/deselect-campaign/',
                'generalOrderNote' : '/srv/service/cart/set-general-order-note/',
                'getImageNotes'    : '/srv/service/cart/get-image-notes/',
                'setDeliveryDate'  : '/srv/service/cart/set-delivery-date/',
                'setDeliveryHour'  : '/srv/service/cart/set-delivery-hour/',
                'sendImageNotes'   : '/srv/service/cart/send-image-notes',
                'hopiRemove'       : '/srv/service/hopi/remove-campaign',
                'zubizuSignout'     : '/srv/service/zubizu/signout',
            },
            LOADING: true,
            CART: {},
            GIFT_NOTE: {},
            PRODUCT_ORDER_NOTE: {},
            GENERAL_ORDER_NOTE: '',
            MOBILE: T.isMobile(),
            MEMBER: MEMBER_INFO,
            BLOCK: BLOCK
        }
    },
    methods: {
        load(init = null) {
            const self = this;
            axios.get(self.endpoints.cart).then(response => {
                self.CART = response.data;
                self.CART._hasCoupon = (self.CART.COUPON_CODE && self.CART.COUPON_CODE != '') ? true : false;
                self.CART._showPanelType = '';
                self.GENERAL_ORDER_NOTE = self.CART.GENERAL_ORDER_NOTE;

                if(self.LOADING || init != null) {
                    setTimeout(() => {
                        initComponents();
                    }, 200);
                }

                self.LOADING = false;
            }).catch(error => console.warn(`Cart page load error => ${error}`));
        },
        format(p) {
            return T.format(p);
        },
        vat(p, vat) {
            return T.vat(p, vat);
        },
        closeDrawer() {
            setTimeout(() => T('.drawer-overlay.active').trigger('click'), 240);
        },
        showNotify(text, status = 1) {
            T.notify({
                text: text,
                className: `${status === 0 ? 'danger' : 'success'}`,
                iconClass : `${status === 0 ? 'ti-thumbs-down' : 'ti-thumbs-up'}`,
                duration: 2000
            });
        },
        deleteItem(product = {}) {
            if(product.CART_ID < 0) return;
            const self = this;
            Cart.delete(product.CART_ID, result => {
                self.load();
                if (result.status > 0) {
                    T('.cart-soft-count').text(result.totalQuantity);
                    T('.cart-soft-price').text(result.totalPrice);

                    if (typeof mobileApp !== 'undefined') {
                        try { mobileApp.changedCartCount(result.totalQuantity); } 
                        catch (err) { }
                    }

                    if (typeof webkit !== 'undefined') {
                        try { webkit.messageHandlers.callbackHandler.postMessage(result.totalQuantity); } 
                        catch (err) { }
                    }
                }
            });
        },
        giftPackage(index) {
            const self = this;
            self.CART.PRODUCTS[index].IS_GIFT_PACKAGE_ACTIVE = self.CART.PRODUCTS[index].IS_GIFT_PACKAGE_ACTIVE == 1 ? 0 : 1;
            axios.get(`${self.endpoints.updGiftPackage}${index}/HedPaket/${self.CART.PRODUCTS[index].IS_GIFT_PACKAGE_ACTIVE}`).then(() => self.load());
        },
        getGiftNote(sessIndex) {
            const self = this;
            axios.get(`${self.endpoints.getGiftNotes}${sessIndex}`).then(response => {
                self.GIFT_NOTE = response.data;
                self.$refs.saveGiftNoteForm.action = self.$refs.saveGiftNoteForm.action + sessIndex;
            }).catch(error => {
                console.warn(`Get gift note error => ${error}`);
            });
        },
        saveGiftNote() {
            const self = this;
            const form = self.$refs.saveGiftNoteForm;
            const formData = new FormData(form);

            var button = Array.from(form.elements).find(el => el.nodeName == 'BUTTON');
            T.buttonLock.dom = button;
            T.buttonLock.tmp = button.innerHTML;
            T.buttonLock.lock();

            axios.post(form.action, formData).then(response => {
                T.buttonLock.unlock();
                self.showNotify('{#saved_note#}.', 1);
                self.CART.PRODUCTS[self.CART._showPanelType.split('gift_package_note')[1]].GIFT_NOTES = formData.get('content');
                self.closeDrawer();
            }).catch(error => {
                console.warn(`Save gift note error => ${error}`);
                T.buttonLock.unlock();
            });
        },
        getProductOrderNote(sessIndex) {
            const self = this;
            axios.get(`${self.endpoints.getOrderNotes}${sessIndex}`).then(response => {
                self.PRODUCT_ORDER_NOTE = response.data;
                self.$refs.saveProductOrderNoteForm.action = self.$refs.saveProductOrderNoteForm.action + sessIndex;
            }).catch(error => {
                console.warn(`Get gift note error => ${error}`);
            });
        },
        saveProductOrderNote() {
            const self = this;
            const form = self.$refs.saveProductOrderNoteForm;
            const formData = new FormData(form);

            var button = Array.from(form.elements).find(el => el.nodeName == 'BUTTON');
            T.buttonLock.dom = button;
            T.buttonLock.tmp = button.innerHTML;
            T.buttonLock.lock();

            axios.post(form.action, formData).then(response => {
                T.buttonLock.unlock();
                self.showNotify('{#saved_note#}.', 1);
                self.CART.PRODUCTS[self.CART._showPanelType.split('product_order_note')[1]].ORDER_NOTES = formData.get('content');
                self.closeDrawer();
            }).catch(error => {
                console.warn(`Save gift note error => ${error}`);
                T.buttonLock.unlock();
            });
        },
        setCampaign(campaign = {}, input) {
            const self = this;
            if(campaign.SELECTED == '1') {
                axios.get(`${self.endpoints.cancelCampaign}/${campaign.ID}`).then(() => {
                    self.showNotify('{#campaing_cancel#}.', 0);
                    self.load();
                }).catch(error => console.warn(`Cancel campaign error => ${error}`));
            } else {
                axios.get(`${self.endpoints.selectCampaign}/${campaign.GROUP}/${campaign.ID}`).then(response => {
                    const result = response.data;
                    if(result.status) {
                        self.showNotify(result.statusText, 1);
                        self.load();
                    } else {
                        T.modal({
                            html: result.statusText,
                            width: '500px'
                        });
                        input.target.checked = false;
                    }
                }).catch(error => console.warn(`Set campaign error => ${error}`));
            }
        },
        addCoupon() {
            const self = this;
            axios.post(self.endpoints.setCampaign + encodeURIComponent(self.CART.COUPON_CODE), {}).then(response => {
                self.showNotify(response.data.statusText, response.data.status);
                if (response.data.status === 0) return;
                self.closeDrawer();
                self.load();
            }).catch(error => console.error(`Add coupon error => ${error}`));
        },
        removeCoupon() {
            const self = this;
            axios.post(self.endpoints.setCampaign, {}).then(response => {
                self.showNotify(response.data.statusText, response.data.status);
                self.closeDrawer();
                self.load();
            }).catch(error => console.error(`Remove coupon error => ${error}`));
        },
        saveGeneralOrderNote() {
            const self = this;
            const data = new FormData();

            data.append('content', self.CART.GENERAL_ORDER_NOTE);

            axios.post(self.endpoints.generalOrderNote, data).then(response => {
                self.GENERAL_ORDER_NOTE = self.CART.GENERAL_ORDER_NOTE;
                self.showNotify('{#success#}', 1);
                self.closeDrawer();
            }).catch(error => console.error(`Set general order note error => ${error}`));
        },
        addToFav() {
            const ids = [];
            this.CART.PRODUCTS.filter(i => ids.push(i.ID));
            favouriteProducts.add(ids);
        },
        saveImageNotes() {
            const self = this;
            const form = self.$refs.saveImageNotesForm;
            const formData = new FormData(form);
            axios.post(self.endpoints.sendImageNotes, formData).then(response => {
                const res = response.data;
                if(res.status < 1) {
                    T.modal({
                        html: res.statusText
                    });
                } else {
                    self.showNotify(res.statusText, 1);
                }
            });
        },
        setCartDeliveryHour() {
            const self = this;
            axios.get(self.endpoints.setDeliveryHour + self.CART.DELIVERY_HOUR).then(() => {
                self.showNotify('{#success#}', 1);
            }).catch(error => console.error(`Set delivery date error => ${error}`));
        },
        setSubscribe(index, event) {
            const self = this,
                  val = event.target.value;
            axios.get(`${self.endpoints.updGiftPackage}${index}/SubscribeFrequency/${val}`).then(() => self.load());
        },
        goCartPrice(el) {
            scrollBehavior((el));
        },
        back() {
            if (document.referrer == '' || document.referrer == window.location.href.replace(window.location.hash, '')) {
                window.location.href = '/';
            } else {
                window.history.back();
            }
        },
        hopiRemove() {
            const self = this;
            axios.get(self.endpoints.hopiRemove).then(() => {
                self.LOADING = true;
                self.load();
            });
            return false;
        },
        zubizuSignout() {
            const self = this;
            axios.get(self.endpoints.zubizuSignout).then(() => {
                self.LOADING = true;
                self.load();
            });
            return false;
        },
        printSelection() {
            window.print();
        },
    },
    computed: {
        writeNote: function() {
            return this.CART.GENERAL_ORDER_NOTE.trim() == '' ? '' : `(${this.CART.GENERAL_ORDER_NOTE.substr(0, 10)}...)`;
        }
    },
    watch: {
        'CART._showPanelType' (value) {
            const self = this;
            if (value.indexOf('gift_package_note') > -1) {
                const exp = value.split('gift_package_note');
                self.getGiftNote(exp[1]);
            }
            if (value.indexOf('product_order_note') > -1) {
                const exp = value.split('product_order_note');
                self.getProductOrderNote(exp[1]);
            }
            if (value == 'order_delivery_time') {
                setTimeout(() => {
                    if (self.CART.IS_DELIVERY_DATE_ACTIVE == 1) {
                        flatpickr(self.$refs.delivery_date_datepicker, {
                            dateFormat: 'd.m.Y',
                            minDate: new Date(),
                            inline: true,
                            defaultDate: self.CART.DELIVERY_DATE || '',
                            onChange: function(selectedDates, dateStr) {
                                axios.get(self.endpoints.setDeliveryDate + dateStr).then(() => {
                                    self.CART.DELIVERY_DATE = dateStr;
                                    self.showNotify('{#success#}', 1);
                                }).catch(error => console.error(`Set delivery date error => ${error}`));
                            }
                        });
                    }
                    if (self.CART.IS_DELIVERY_HOUR_ACTIVE == 1) {
                        for (let i = 8; i < 24; i++) {
                            const j = i < 10 ? "0" + i : i;
                            const value = j + ':00';
                            const option = document.createElement('option');
                            option.value = value;
                            option.innerHTML = value;
                            option.selected = self.CART.DELIVERY_HOUR == value;
                            self.$refs.delivery_hour_datepicker.appendChild(option);

                            const option2 = document.createElement('option');
                            const value2 = j + ':30';
                            option2.value = value2;
                            option2.innerHTML = value2;
                            option2.selected = self.CART.DELIVERY_HOUR == value2;
                            self.$refs.delivery_hour_datepicker.appendChild(option2);
                        }
                    }
                }, 100);
            }
            if (value == 'image_notes') {
                setTimeout(() => {
                    T.inputFile(self.$refs.image_notes_file);
                }, 100);
            }
        },
        'GIFT_NOTE.GIFT_NOTES' (value) {
            this.GIFT_NOTE.GIFT_NOTES = value.substr(0, this.GIFT_NOTE.GIFT_NOTES_LIMIT);
            this.$refs.saveGiftNoteForm.querySelector('p > span').innerHTML = value.length;
        },
        'PRODUCT_ORDER_NOTE.ORDER_NOTES' (value) {
            this.PRODUCT_ORDER_NOTE.ORDER_NOTES = value.substr(0, this.PRODUCT_ORDER_NOTE.ORDER_NOTES_LIMIT);
            this.$refs.saveProductOrderNoteForm.querySelector('p > span').innerHTML = value.length;
        }
    },
    mounted() {
        this.load();
    }
});

window['cartVue'] = CartPage.mount('#cart-page');

window['qtyIncrease' + BLOCK.ID] = (value, oldVal, qty) => {
    const product = cartVue.CART.PRODUCTS[qty.dataset.pid];
    qty.setAttribute('disabled', true);
    Cart.update(product.CART_ID, value, result => {
        cartVue.load();
        if (result.status > 0) {
            T('.cart-soft-count').text(result.totalQuantity);
            T('.cart-soft-price').text(result.totalPrice);
        } else {
            if (T('#modal-popup-qty-error').length < 1) {
                T.modal({
                    id: 'modal-popup-qty-error',
                    html: result.statusText,
                });
                T(`#qty${product.ID}${qty.dataset.pid}`)[0].setAttribute('disabled', true);
            }
        }
        qty.removeAttribute('disabled');
        T(`#qty${product.ID}${qty.dataset.pid}`)[0].removeAttribute('disabled');
    });
}