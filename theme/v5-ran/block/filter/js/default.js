const FilterBlock = {
    data() {
        return {
            LOADING: true,
            TRANSLATE: {},
            PARAMS: {
                'stock': window.location.href.indexOf('stock=') > 0,
                'discounted': window.location.href.indexOf('discounted=') > 0,
                'new': window.location.href.indexOf('new=') > 0
            },
            FILTERS: {},
            IS_MOBILE: T.isMobile() === true
        }
    },
    methods: {
        select(type, index) {
            var tmp = type.split('.');
            if (tmp.length === 1 && typeof this[type] !== 'undefined') {
                this[tmp[0]][index]['SELECTED'] = this[tmp[0]][index]['SELECTED'] === 0 ? 1 : 0;
            } else if (tmp.length === 2) {
                this[tmp[0]][tmp[1]][index]['SELECTED'] = this[tmp[0]][tmp[1]][index]['SELECTED'] === 0 ? 1 : 0;
            } else if (tmp.length === 3) {
                this[tmp[0]][tmp[1]][tmp[2]][index]['SELECTED'] = this[tmp[0]][tmp[1]][tmp[2]][index]['SELECTED'] === 0 ? 1 : 0;
            }
        },
        getSelected(arr, noJoin) {
            var el = arr.map(function(e) {
                if (e.SELECTED === 1) {
                    return e.ID;
                }
            });

            el = el.filter(n => n);
            el = !noJoin ? el.join('-') : el;
            return el;
        },
        getSelectedFilters() {
            const result = {
                multi: [],
                single: [],
                decimal: '',
            }

            for (let i = 0; i < this.FILTERS.FILTERS.length; i++) {
                const obj = this.FILTERS.FILTERS[i];
                switch (obj.TYPE) {
                    case '0': // multi
                    case '1': // single
                        const k = this.getSelected(obj.VALUES, true);
                        const r = k.map(function(e) {
                            return obj.ID + '-' + e;
                        });
                        if (obj.TYPE === '0') {
                            result.multi = result.multi.concat(r);
                        } else {
                            result.single = result.single.concat(r);
                        }
                        break;
                }
            }

            result.multi = result.multi.join('+');
            result.single = result.single.join('+');
            return result;

        },
        filter(index, subIndex) {
            let filters = this.FILTERS.FILTERS;
            if (filters[index] && filters[index].TYPE != 2 && filters[index].VALUES[subIndex] !== 'undefined') {
                filters[index].VALUES[subIndex]['SELECTED'] = filters[index].VALUES[subIndex]['SELECTED'] === 0 ? 1 : 0;
            }
        },
        run() {
            let link = window.location.href;

            if (this.FILTERS.FILTERS) {
                const filters = this.getSelectedFilters();

                link = T.getLink('multi', filters.multi, link);
                link = T.getLink('single', filters.single, link);
                //  link = T.getLink('decimal',  decimal.join('+'), link);
            }

            if (this.FILTERS.BRANDS) link = T.getLink('brand', this.getSelected(this.FILTERS.BRANDS), link);
            if (this.FILTERS.SUPPLIERS) link = T.getLink('supplier', this.getSelected(this.FILTERS.SUPPLIERS), link);
            if (this.FILTERS.MODELS) link = T.getLink('model', this.getSelected(this.FILTERS.MODELS), link);
            if (this.FILTERS.VARIANTS && this.FILTERS.VARIANTS.TYPE1_LIST) link = T.getLink('type1', this.getSelected(this.FILTERS.VARIANTS.TYPE1_LIST), link);
            if (this.FILTERS.VARIANTS && this.FILTERS.VARIANTS.TYPE2_LIST) link = T.getLink('type2', this.getSelected(this.FILTERS.VARIANTS.TYPE2_LIST), link);
            link = T.getLink('stock', this.PARAMS.stock ? '1' : '', link);
            link = T.getLink('discounted', this.PARAMS.discounted ? '1' : '', link);
            link = T.getLink('new', this.PARAMS.new ? '1' : '', link);

            window.location.href = link;
        },
        search(input, wrapper){
            if (document.querySelector('[data-filter-search="' + wrapper + '"]') == null) return;

            const searchString = String(input.target.value).toLowerCase();
            const items = document.querySelectorAll('[data-filter-search="' + wrapper + '"] > .filter-list-item');
            
            if (searchString != '') {
                items.forEach((input) => {
                    if(String(input.dataset.title).toLowerCase().indexOf(searchString) > -1) {
                        input.classList.remove('d-none');
                    } else {
                        input.classList.add('d-none');
                    }
                });
            } else {
                items.forEach((input) => {
                    input.classList.remove('d-none');
                });
            }
        },
        clearFilter(selected) {
            let url = '';
            if(selected == 'all') {
                url = window.location.href.replace(/#.*$/, '').replace(/\?.*$/, '');
            } else {
                url = new URL(document.location);
                const params = url.searchParams;
                let newParams = '';
                let splitType = selected.XTYPE == 'multi' ? ' ' : '-';
                if (selected.XTYPE != 'price') {
                    const getParams = params.get(selected.XTYPE).split(splitType);
                    const filterParams = (value) => {
                        return value != selected.VALUE;
                    }
                    newParams = getParams.filter(filterParams).join(splitType);
                }
                params.delete(selected.XTYPE);
                if (newParams && newParams != '') params.set(selected.XTYPE, newParams);
                url = url.toString();
            }
            window.location.href = url;
        },
        closeDrawer(id) {
            T(`[data-rel="${id}"]`).trigger('click');
        }
    },
    mounted() {
        const self = this,
            linkParam = window.location.href.replace(location.origin + '/', '').replace('?', '&');

        if(self.IS_MOBILE) T('#product-filter').addClass('drawer-wrapper');

        axios.get(`/srv/service/filter/get/${SETTING.PARAMS.join('-').toLowerCase()}?link=${linkParam}`).then(response => {
            self.FILTERS = response.data;
            self.LOADING = false;
            setTimeout(() => { initComponents(); }, 150);
        }).catch(err => {
            console.log(`%c Filter Error => ${err}`, 'background:#222; color:#bada55');
        });
    }
};

Vue.createApp(FilterBlock).component('slider-range', {
    props: ['id', 'min', 'max', 'start', 'currency', 'decimal','params'],
    data() {
        return {
            max_price: this.max,
            max_selected_price: this.start[1]
        }
    },
    template: `<div class="col-12">
        <div class="row">
            <div class="w-100 price-filter-text d-none d-md-flex align-items-center justify-content-center text-center">
                <div> <span :id="id + '-min-text-price'"></span> {{ currency }}</div> <span>-</span> <div> <span :id="id + '-max-text-price'"></span> {{ currency }}</div>
            </div>
            <div class="row d-md-none">
                <div class="col-6 pr-0"><input type="text" class="form-control" :id="id + '-min-price'" :data-min="min" :value="start[0]"></div>
                <div class="col-6 pr-0"><input type="text" class="form-control" :id="id + '-max-price'" :data-max="max" :value="max_selected_price"></div>
            </div>
            <div :id="id" :data-id="params" class="w-100 mb-1" :class="{'decimal-slide' : decimal}"></div>
        </div>
    </div>`,
    mounted() {
        const self = this;
        let link = '';
        const stepLength = self.max > 500 ? 10 : 1;
        let handlesSlider = document.getElementById(self.id) ;

        if(self.max <= self.min) {
            self.max_price = self.min + 1;
            self.max_selected_price = this.start[0] + 1;
        }
        noUiSlider.create(handlesSlider, {
            start: [self.start[0], self.max_selected_price],
            direction: LANGUAGE == 'ar' ? 'rtl' : 'ltr',
            step: stepLength,
            connect: true,
            range: {
                min: self.min,
                max: self.max_price
            }
        });

        if (self.decimal) {
            handlesSlider.noUiSlider.on('update', function(values, handle) {
                document.getElementById(`${self.id}-${(handle == 1 ? 'max-price' : 'min-price')}`).value = Math.round(values[handle]);
            });
            handlesSlider.noUiSlider.on('end', function() {
                const values = [];
                document.querySelectorAll('.decimal-slide').forEach(el => {
                    const val = el.noUiSlider.get(),
                          val_one = parseFloat(val[0]).toFixed(0),
                          val_two = parseFloat(val[1]).toFixed(0);
                          
                    const input = el.closest('.filter-decimal-body').querySelectorAll('input');
                    if(input[0].dataset.min != val_one || input[1].dataset.max != val_two){
                        if (val_one == val_two) {
                            let value = parseFloat(val_two);
                            value += 1;
                            values.push(el.dataset.id + '-' + val_one + '-' + value);
                        } else {
                            values.push(el.dataset.id + '-' + val_one + '-' + val_two);
                        }
                    }
                    window.location.href = T.getLink('decimal', values.join('+'));
                });
            });
        } else {
            handlesSlider.noUiSlider.on('update', function(values, handle) {
                document.getElementById(`${self.id}-${(handle == 1 ? 'max-price' : 'min-price')}`).value = T.format(values[handle]);
                document.getElementById(`${self.id}-${(handle == 1 ? 'max-text-price' : 'min-text-price')}`).innerText = T.format(values[handle]);
            });
            handlesSlider.noUiSlider.on('end', function(values) {
                if (values[0] == values[1] || self.max_price == values[1]) {
                    let value = parseFloat(values[1]);
                    value += 1;
                    window.location.href = T.getLink('price', parseFloat(values[0]).toFixed(0) + '-' + parseFloat(value).toFixed(0)); 
                } else {
                    window.location.href = T.getLink('price', parseFloat(values[0]).toFixed(0) + '-' + parseFloat(values[1]).toFixed(0)); 
                }
            });
        }
    }
}).mount('#product-filter');