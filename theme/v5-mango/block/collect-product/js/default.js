const PageCollectProduct = {
    data() {
        return {
            endpoints: {
                get: '/srv/service/collect/data'
            },
            DATA: {},
            pathURL : window.location.href,
            SETTING: SETTING,
            CURRENCY: 'TL',
        }
    },
    methods: {
        format(p) {
            return T.format(p);
        },
        vat(p, vat) {
            return T.vat(p, vat);
        },
        add(pid, cntrlSub) {
            if (cntrlSub == 1 && T(`#subPro${pid}`)[0].value == 0) {
                T.notify({
                    text: "{#choose_sub_product#}",
                    className: 'danger',
                    duration: 3200,
                });
                return;
            }
            addToCart(pid, T(`#subPro${pid}`)[0].value, T(`#pro-qty${pid}`)[0].value);
        },
        empty() {
            T.notify({
                text: "{#choose_product#}",
                className: 'danger',
                duration: 3200,
            });
        },
        load() {
            const self = this;
            axios.get(self.endpoints.get).then(response => {
                self.DATA = response.data.CATEGORY_LIST;
                self.CURRENCY = response.data.CURRENCY;
                setTimeout(function() {
                    initComponents();
                }, 200);
            }).catch(error => `Get collect product error => ${error}`);
        },
        collectChange(el, event) {
            const self = this,
                  id = event.dataset.id,
                  catid = event.dataset.catid;
                  
            if (id == undefined || catid == undefined) return;

            self.DATA[catid].PRODUCT = self.DATA[catid].PRODUCTS[id];
            el.closest('.collect-item').classList.add('active');

            setTimeout(function() {
                const varaintWrapper = document.querySelector(`.variant-wrapper-${self.DATA[catid].PRODUCTS[id].ID}`);
                Array.from(varaintWrapper.querySelectorAll('select')).forEach(el => {
                    el.value = 0;
                });
                initComponents();
                self.collectTotal();
            }, 100);

        },
        collectTotal() {
            const self = this,
                  count = [],
                  data = self.DATA;
            let total = 0;
            for (let i=0; i<data.length; i++) {
                if(data[i].PRODUCT != null || data[i].PRODUCT != undefined) {
                    count.push(data[i].PRODUCT);
                    T(`#collect-total-length`).html(count.length);

                    price = T(`#product-price${data[i].PRODUCT.ID}`)[0].innerText.replace(/\./g,"").replace(",",".");
                    total += price * parseFloat(T(`#pro-qty${data[i].PRODUCT.ID}`)[0].value);
                    T(`#collect-total-price`).html(T.format(total));
                }
            }
        },
        addFav() {
            const self = this;
            if (T('.collect-title').length <= 0) {
                self.empty();
                return;
            }
            const ids = [];
            Array.from(self.DATA).forEach(el => {
                if (el.PRODUCT) ids.push(el.PRODUCT.ID);
            });
            favouriteProducts.add(ids);
        },
        selectAllAdd() {
            const self = this;
            if (T('.collect-title').length <= 0) {
                self.empty();
                return;
            }
            const pids = [],
                  variants = [],
                  counts = [];
            Array.from(self.DATA).forEach(el => {
                if (el.PRODUCT) {
                    pids.push(el.PRODUCT.ID);
                    variants.push(T(`#subPro${el.PRODUCT.ID}`)[0].value);
                    counts.push(T(`#pro-qty${el.PRODUCT.ID}`)[0].value);
                }
            });
            multiCart = true;
            addToCart(pids, variants, counts);
        },
        collectVariant() {
            setTimeout(() => {
                this.collectTotal();
            }, 1000);
        }
    },
    mounted() {
        this.load();
        window[`collectChange`] = (element, eventTarget) => {
            this.collectChange(element, eventTarget);
        }
        window[`collectQty`] = (count, oldCount, qty) => {
            this.collectTotal();
        }
    }
}
Vue.createApp(PageCollectProduct).mount('#page-collect-product');