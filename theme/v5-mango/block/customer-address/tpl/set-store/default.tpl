<div id="set-store" class="col-12 py-2" v-cloak>
    <div class="w-100" v-show="loading == true">
        <div class="row" v-if="step == 1">
            <div class="col-12">
                <div class="fw-bold text-primary text-uppercase mb-1">{#set_store_title#}</div>
                <div class="small-text">{#set_store_small_text#}.</div>
                <div class="border-top pos-r w-100 my-1"></div>
            </div>
            <div class="col-12">
                <div class="row">
                    <ul class="tab-nav list-style-none w-100 d-flex" v-if="deliveryFromStore">
                        <li class="col-6" :class="{'active' : service && deliveryFromStore && service.deliveryType != 1}">
                            <a href="#set-location-address" id="set-location-address-btn" class="d-block border-round text-center text-uppercase w-100" data-toggle="tab">{#delivery_address#}</a>
                        </li>
                        <li class="col-6" :class="{'active' : service && service.deliveryType == 1}">
                            <a href="#set-location-store" id="set-location-store-btn" class="d-block border-round text-center text-uppercase w-100" data-toggle="tab">{#send_to_store#}</a>
                        </li>
                    </ul>
                    <div class="tab-content col-12 mt-1">
                        <div id="set-location-address" :class="[{'tab-pane' : deliveryFromStore}, {'active' : service && deliveryFromStore && service.deliveryType != 1}]">
                            <div class="border border-dark border-round col-12 p-2">
                                <div class="row">
                                    <div class="col-6 mb-1 city-container">
                                        <div class="city-select-container">
                                            <select id="set-location-city" name="l_city" placeholder="{#city#}" class="form-control form-control-md city-select">
                                                <option value="">{#city#}</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-6 mb-1 town-container">
                                        <div class="town-select-container">
                                            <select id="set-location-town" name="l_town" placeholder="{#town#}" class="form-control form-control-md town-select">
                                                <option value="">{#town#}</option>
                                            </select>
                                        </div>
                                        <div class="town-input-container" style="display: none;">
                                            <select id="set-location-town" name="l_town_" placeholder="{#town#}" class="form-control form-control-md">
                                                <option value="">{#town#}</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-12">
                                        <button id="set-location-save-address" class="btn btn-success text-center w-100 text-uppercase" @click="saveLocation($event, 'address')">{#saved#}</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div id="set-location-store" class="tab-pane" :class="{'active' : service && service.deliveryType == 1}" v-show="deliveryFromStore">
                            <div class="border border-dark border-round p-2 pb-1">
                                <div class="row">
                                    <div class="col-6 mb-1 city-container">
                                        <div class="city-select-container">
                                            <select id="set-location-m_city" name="m_city" placeholder="{#city#}" class="form-control form-control-md city-select" @change="setStore($event)">
                                                <option value="">{#city#}</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-6 mb-1 town-container">
                                        <div class="town-select-container">
                                            <select id="set-location-m_town" name="m_town" placeholder="{#town#}" class="form-control form-control-md town-select" @change="setStore($event)">
                                                <option value="">{#town#}</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-6 mb-1 town-container">
                                        <select id="set-location-m_store" name="m_store" placeholder="{#store#}" class="form-control form-control-md">
                                            <option value="">{#store#}</option>
                                        </select>
                                    </div>
                                    <div class="col-6 mb-1">
                                        <button id="set-location-save-store" class="btn btn-success text-center w-100 text-uppercase" @click="saveLocation($event, 'store')">{#saved#}</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row" v-if="step == 2">
            <div class="col-12">
                <div class="fw-bold text-primary text-uppercase mb-1">{#delivery_time_select#}</div>
                <div class="small-text">{#delivery_time_small_text#}.</div>
                <div class="border-top pos-r w-100 my-1"></div>
            </div>
            <div class="col-12" v-if="serviceList.length > 0">
                <div class="w-100 position-relative mb-2">
                    <div id="service-times" class="swiper-container">
                        <div class="swiper-wrapper">
                            <div class="swiper-slide" v-for="(service, i) in serviceList">
                                <button :id="'service-btn' + i" class="btn text-left fw-semibold" :data-date="service.date"
                                    :class="service.items == serviceItems ? 'btn-primary text-white selected' : 'btn-light text-gray'"
                                    @click="setTimes(service.items)">
                                    {{ service.dateF }}<br>{{ service.w }}
                                </button>
                            </div>
                        </div>
                    </div>
                    <div id="swiper-prev-setStore" class="swiper-button-prev outside"><i class="ti-arrow-left"></i></div>
                    <div id="swiper-next-setStore" class="swiper-button-next outside"><i class="ti-arrow-right"></i></div>
                </div>
                <div class="w-100 service-item-list" v-if="serviceItems.length > 0">
                    <div class="w-100 service-item" v-for="item in serviceItems">
                        <input type="radio" :id="'service' + item.id" name="cargoServiceId" class="form-control" :value="item.status == 1 ? item.id : ''">
                        <label :for="'service' + item.id" class="border border-light border-round d-flex align-items-center w-100 p-1" :class="{'disabled' : item.status != 1}">
                            <span class="input-checkbox"><i class="ti-check"></i></span>
                            <div class="w-100 d-flex justify-content-between align-items-center">
                                <div><span>{{item.time_start}}</span> - <span>{{item.time_end}}</span></div>
                                <div class="text-uppercase">
                                    <span class="text-uppercase" v-if="item.status == 1">{#available#}</span>
                                    <span class="text-uppercase" v-else>{#not_available#}</span>
                                </div>
                            </div>
                        </label>
                    </div>
                    <button id="save-service-btn" class="btn btn-success text-center w-100 mt-1 text-uppercase" @click="saveService()">{#saved#}</button>
                </div>
                <div class="col-12 p-1 border border-light border-round service-item-empty" v-else>
                    {#not_found#}.
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
    DATA = {};
}

const setStroe = {
    data() {
        return {
            data: {},
            service: {},
            deliveryFromStore: null,
            step: 1,
            serviceList: {},
            serviceItems: {},
            loading: false,
            endpoints: {
                getLocation : '/srv/service/customer/get-location',
                storeList : '/srv/service/store/store-list/1',
                setLocationSrv: '/srv/service/customer/set-location-service',
                setLocation: '/srv/service/customer/set-location',
            },
        }
    },
    methods: {
        region() {
            const self = this;
            tsRegion({
                container: '#set-location-address',
                countryLimit : 0,
                country : {
                    value :  self.data && self.data.U || 'TR',
                    caption : ''
                },
                city : {
                    value : self.data && self.data.S || '',
                    caption : ''
                },
                town : {
                    value : self.data && self.data.I || '',
                    caption : ''
                },
                district : {
                    value : self.data && self.data.M || '',
                    caption : ''
                }
            });
            if (self.deliveryFromStore) {
                tsRegion({
                    container: '#set-location-store',
                    countryLimit : 0,
                    country : {
                        value :  self.data && self.data.U || 'TR',
                        caption : ''
                    },
                    city : {
                        value : self.data && self.data.S || '',
                        caption : ''
                    },
                    town : {
                        value : self.data && self.data.I || '',
                        caption : ''
                    },
                    district : {
                        value : self.data && self.data.M || '',
                        caption : ''
                    }
                });
            }
            self.loading = true;
        },
        setStore() {
            const self = this;
            Array.from(T('[name="m_store"] option')).forEach(opt => {
                if (opt.value != '') T(opt)[0].remove();
            });

            const formData = new FormData();
            formData.append('city', T('[name="m_city"]')[0].value);
            formData.append('town', T('[name="m_town"]')[0].value);

            axios.post(self.endpoints.storeList, formData).then(response => {
                const result = response.data;
                if(!result.success) return;
                if(!result.data || !result.data.length) return;
                
                Array.from(result.data).forEach(item => {
                    const option = document.createElement('option');
                          option.value = item.id;
                          option.innerText = item.Ad;
                          if (self.service && self.service.storeId) {
                              option.setAttribute('selected', 'selected');
                          }
                    T('[name="m_store"]')[0].append(option);
                });
            });
        },
        saveLocation(event, type = null) {
            const self = this;
            const formData = new FormData();
            
            if (type == 'address') {
                formData.append('location[U]', 'TR');
                formData.append('location[S]', T('[name="l_city"]')[0].value);
                formData.append('location[I]', T('[name="l_town"]')[0].value);
            } else if (type == 'store') {
                formData.append('store_id', T('[name="m_store"]')[0].value);
                formData.append('location[U]', 'TR');
                formData.append('location[S]', T('[name="m_city"]')[0].value);
                formData.append('location[I]', T('[name="m_town"]')[0].value);
            } else {
                return;
            }

            T.buttonLock.dom = event.target;
            T.buttonLock.lock();

            axios.post(self.endpoints.setLocation, formData).then(response => {
                const result = response.data;
                T.buttonLock.unlock();
                if(!result.success){
                    T.modal({ html: result.message || "hata oluştu tekrar deneyin" });
                } else if(result.serviceList && result.serviceList.length > 0){
                    self.serviceList = result.serviceList;
                    self.step = 2;
                    setTimeout(() => { 
                        self.swiper();
                        T(T('#service-times button')[0]).trigger('click');
                    }, 100);
                } else {
                    window.location.reload();
                }
            }).catch(error => { console.log(error); T.buttonLock.unlock(); });

        },
        setTimes(data) {
            const self = this;
            self.serviceItems = data;
            setTimeout(() => {
                const service = T('[name="cargoServiceId"]:checked');
                if (service.length > 0 && service[0].value == '') {
                    service[0].checked = false;
                }
            }, 100);
        },
        saveService() {
            const self = this,
                  service = T('#service-times button.selected'),
                  serviceId = T('[name="cargoServiceId"]:checked');

            if (serviceId.length < 1 || serviceId[0].value == '' || service.length < 1) {
                T.modal({
                    html: '<div class="p-1">{#available_delivery_select#}</div>',
                    width : '580px'
                });
                return;
            }
        
            const formData = new FormData();
            formData.append('id', serviceId[0].value);
            formData.append('date', service[0].dataset.date);

            axios.post(self.endpoints.setLocationSrv, formData).then(response => {
                const result = response.data;
                if(!result.success){
                    T.modal({ html: result.message || "hata oluştu tekrar deneyin" });
                } else {
                    window.location.reload();
                }
            }).catch(error => { 
                T.modal({ html: "hata oluştu tekrar deneyin" });
             });
        },
        load() {
            const self = this;
            axios.get(self.endpoints.getLocation).then(response => {
                const result = response.data;
                if (result.success) {
                    self.data = result.data;
                    self.service = result.service;
                    self.deliveryFromStore = self.service && self.service.deliveryFromStore == 1;
                    self.region();
                    setTimeout(() => { initComponents(); }, 150);
                } else {
                    T.modal({ html: result.message || "hata oluştu tekrar deneyin" });
                }
            }).catch(error => { console.log(error) });
        },
        swiper() {
            new Swiper('#service-times', {
                slidesPerView: 3,
                spaceBetween: 2,
                freeMode: true,
                navigation: {
                    nextEl: '#swiper-next-setStore',
                    prevEl: '#swiper-prev-setStore',
                },
                breakpoints: {
                    580: {
                        slidesPerView: 5,
                    },
                },
            });
        },
    },
    mounted() {
        this.load();
        this.step = 1;
    }
};

Vue.createApp(setStroe).mount('#set-store');
</script>