const PageFavourites = {
    data() {
        return {
            endpoints: {
                get: '/srv/service/profile/get-shopping-list',
                remove: '/srv/service/profile/delete-shopping-products'
            },
            DATA: {},
            BLOCK: BLOCK,
            IDS: null,
        }
    },
    methods: {
        load() {
            const self = this;
            axios.get(self.endpoints.get).then(response => {
                self.DATA = response.data;
                setTimeout(function() {
                    initComponents();
                }, 200);
            }).catch(error => `Get favourites error => ${error}`);
        },
        vat(p, vat) {
            return T.vat(p, vat);
        },
        addSelection(category) {
            const addInputs = T(`input.favourite-check${category}:checked`);

            if (addInputs.length <= 0) {
                T.notify({
                    text: '{#no_selected_product#}',
                    className: 'danger',
                    duration: 1800,
                });
                return;
            }

            const pids = [],
                variants = [],
                counts = [];

            Array.from(addInputs).forEach(input => {
                const id = input.dataset.pid;
                      catid = input.dataset.category;
                      variant = T(`#subPro${id}${catid}`);
                      p_count = T(`#productCount${id}${catid}`);
                pids.push(id);
                variants.push(variant.length > 0 ? variant[0].value : '');
                counts.push(p_count.length > 0 ? p_count[0].value : '');
            });

            multiCart = true;
            addToCart(pids, variants, counts);
        },
        remove(cat = null, pId = null) {
            const self = this,
                  data = [],
                  pids = [];

            if (pId == null) {
                Array.from(cat.PRODUCTS).forEach(item => {
                    const input = T(`#product-selection-${item.ID}${cat.ID}:checked`);
                    if (input.length > 0 ) {
                        data.push(input[0].dataset.list);
                        pids.push(input[0].dataset.pid);
                    }
                });
                if (data.length < 1) {
                    T.notify({
                        text: '{#no_selected_product#}',
                        className: 'danger',
                        duration: 1800,
                    });
                    return;
                }
            } else {
                const input = T(`#product-selection-${pId}${cat}`);
                if (input.length < 1) return;
                data.push(input[0].dataset.list);
                pids.push(input[0].dataset.pid);
            }

            if (self.IDS === null) {
                self.IDS = LocalApi.get('favourite', []);
            }

            const formData = new FormData();
            for (var key in data) {
                formData.append('products[]', data[key]);
            }

            axios.post(self.endpoints.remove, formData).then(() => {
                pids.forEach(p => {
                    p = parseInt(p);
                    let index = self.IDS.indexOf(p);
                    if (index > -1) {
                        self.IDS.splice(index, 1);
                        LocalApi.set('favourite', self.IDS);
                        T('.tsoft-favourite-count').text(self.IDS.length);
                    }
                });
                self.load();
            }).catch(error => console.error(`Failed to delete product to favorite => ${error}`));
        },
        printSelection() {
            window.print();
        },
    },
    mounted() {
        this.load();
    }
}

Vue.createApp(PageFavourites).mount('#page-my-favourites');