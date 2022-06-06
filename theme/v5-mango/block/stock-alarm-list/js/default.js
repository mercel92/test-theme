const PageStockAlarms = {
    data() {
        return {
            endpoints: {
                get: '/srv/service/profile/get-alarm-list/stock',
                delete: '/srv/service/profile/delete-alarm-products'
            },
            DATA: {},
            LOADING: true
        }
    },
    methods: {
        price: p => T.format(p),
        load() {
            const self = this;
            axios.get(self.endpoints.get).then(response => {
                self.DATA = response.data;
                self.LOADING = false;
            }).catch(error => `Get stock alarm error => ${error}`);
        },
        addToCart(id = null, variant = null, count = null) {
            if (id == null && variant == null && count == null) {
                const addInputs = T('input.price-alarms-input:checked');
                if (addInputs.length < 1) {
                    T.notify({
                        text: '{#no_selected_product#}',
                        className: 'danger',
                        duration: 1800,
                    });
                    return;
                }
                const pids = [], variants = [], counts = [];
                Array.from(addInputs).forEach(input => {
                    id = input.dataset.id;
                    variant = input.dataset.variant;
                    count = T(`#ProductCount${input.dataset.id}`);
                    pids.push(id);
                    variants.push(variant);
                    counts.push(count.length > 0 ? count[0].value : '');
                });
                multiCart = true;
                addToCart(pids, variants, counts);
            } else {
                addToCart({ productId: id, variantId: variant, quantity: count, });
            }
        },
        remove(item = null) {
            const self = this;
            const itemList = [];
            if (item == null) {
                const removeInputs = T('input.stock-alarms-input:checked');
                if (removeInputs.length < 1) {
                    T.notify({
                        text: '{#no_selected_product#}',
                        className: 'danger',
                        duration: 1800,
                    });
                    return;
                }
                Array.from(removeInputs).forEach(input => {
                    itemList.push(input.dataset.alarm);
                });
            } else {
                itemList.push(item);
            }
            self.removeList(itemList);
        },
        removeList(itemList) {
            const self = this;
            var data = new FormData();
            data.append('products[]', itemList);
            axios.post(self.endpoints.delete, data).then(response => {
                if (response.data.status == 1) {
                    T.notify({
                        text: '{#removed_list#}',
                        className: 'danger',
                        duration: 1800,
                        iconClass : 'ti-thumbs-up',
                    });
                }
                self.load();
            }).catch(error => `Get stock alarm error => ${error}`);
        },
    },
    mounted() {
        this.load();
    }
}

Vue.createApp(PageStockAlarms).mount('#page-my-stock-alarms');