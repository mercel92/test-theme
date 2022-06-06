<div data-rel="product-filter" class="drawer-overlay"></div>
<div id="product-filter" class="col-12 pb-3" data-position="left" v-cloak>
    <div class="row" v-if="IS_MOBILE">
        <div class="col-12 drawer-title border-bottom border-light mb-2">
            <i class="ti-filter mr-1"></i>
            <span>{#filter#}</span>
            <div class="drawer-close" @click="closeDrawer('product-filter')">
                <i class="ti-close"></i>
            </div>
        </div>
    </div>
    <div class="w-100" v-if="!LOADING">
        <div class="w-100 border border-light mb-1">
            <section class="col-12 filter-card" v-if="FILTERS.CATEGORIES && FILTERS.CATEGORIES.length">
                <div class="row">
                    <div class="w-100 filter-category">
                        <div class="w-100 filter-category-list" v-for="(CAT, index) in FILTERS.CATEGORIES" :class="{'mb-1' : FILTERS.CATEGORIES.length < index + 1}">
                            <h5 class="col-12 py-1 d-flex filter-title accordion-title active" data-toggle="accordion">
                                <a :href="'/' + CAT.URL" class="filter-title-item">{{ CAT. NAME }}</a>
                                <span class="ml-auto">
                                    <i class="ti-arrow-down"></i>
                                    <i class="ti-arrow-up"></i>
                                </span>
                            </h5>
                            <div class="col-12 filter-body accordion-body mb-1 show" v-if="CAT.CHILDREN.length">
                                <ul class="list-style-none filter-list">
                                    <li class="filter-list-item" v-for="SUB in CAT.CHILDREN">
                                        <a :href="'/' + SUB.URL" class="filter-item" :class="{'text-primary' : SUB.SELECTED == 1}">{{ SUB. NAME }}</a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </section>  
            <section class="col-12 filter-card d-md-none" v-if="FILTERS.SELECTED.length > 0">
                <div class="row">
                    <h5 class="col-12 py-1 d-flex filter-title accordion-title active" data-toggle="accordion">
                        {#selected_filters#}
                        <span class="ml-auto">
                            <i class="ti-arrow-down"></i>
                            <i class="ti-arrow-up"></i>
                        </span>
                    </h5>
                    <div class="col-12 filter-body accordion-body mb-1 show">
                        <span class="selected-item btn btn-sm btn-light" v-for="SELECTED in FILTERS.SELECTED" @click="clearFilter(SELECTED)" >
                            <i class="ti-close text-gray"></i> {{ SELECTED.TEXT }}
                        </span>
                        <div class="mt-1" v-if="FILTERS.SELECTED.length > 1">
                            <button type="button" class="btn btn-sm btn-black selected-clear-btn" @click="clearFilter('all')">
                                <i class="ti-trash-o"></i> {#clear_all_filter#}
                            </button>
                        </div>
                    </div>
            </section>
            <section class="col-12 filter-card" v-if="FILTERS.VARIANTS && FILTERS.VARIANTS.TYPE1_LIST && FILTERS.VARIANTS.TYPE1_LIST.length">
                <div class="row">
                    <h5 class="col-12 py-1 d-flex filter-title accordion-title active" data-toggle="accordion">
                        {{ FILTERS.VARIANTS.TYPE1_NAME }}
                        <span class="ml-auto">
                            <i class="ti-arrow-down"></i>
                            <i class="ti-arrow-up"></i>
                        </span>
                    </h5>
                    <div class="col-12 filter-body accordion-body mb-1 show">
                        <div class="w-100 position-relative filter-search ti-search mb-1" v-if="FILTERS.VARIANTS.TYPE1_LIST.length > 9">
                            <input type="text" class="form-control" :placeholder="FILTERS.VARIANTS.TYPE1_NAME + ' {#search#}'" @keyup="search($event, 'filter-search-v1')"/>
                        </div>
                        <ul class="list-style-none filter-list" data-filter-search="filter-search-v1">
                            <li class="filter-list-item" v-for="(V1, index) in FILTERS.VARIANTS.TYPE1_LIST" :data-title="V1.NAME">
                                <input type="checkbox" :id="'type1_' + V1.ID" :checked="V1.SELECTED == 1" class="form-control" @change="select('FILTERS.VARIANTS.TYPE1_LIST', index)">
                                <label :for="'type1_' + V1.ID" :id="'label-type1_' + V1.ID" class="filter-item" :class="{'text-black' : V1.SELECTED == 1}">
                                    <span class="input-checkbox">
                                        <i class="ti-check"></i>
                                    </span>
                                    {{ V1.NAME }}
                                </label>
                            </li>
                        </ul>
                    </div>
                </div>
            </section>
            <section class="col-12 filter-card" v-if="FILTERS.VARIANTS && FILTERS.VARIANTS.TYPE2_LIST && FILTERS.VARIANTS.TYPE2_LIST.length">
                <div class="row">
                    <h5 class="col-12 py-1 d-flex filter-title accordion-title active" data-toggle="accordion">
                        {{ FILTERS.VARIANTS.TYPE2_NAME }}
                        <span class="ml-auto">
                            <i class="ti-arrow-down"></i>
                            <i class="ti-arrow-up"></i>
                        </span>
                    </h5>
                    <div class="col-12 filter-body accordion-body mb-1 show">
                        <div class="w-100 position-relative filter-search ti-search mb-1" v-if="FILTERS.VARIANTS.TYPE2_LIST.length > 9">
                            <input type="text" class="form-control" :placeholder="FILTERS.VARIANTS.TYPE2_NAME + ' {#search#}'" @keyup="search($event, 'filter-search-v2')"/>
                        </div>
                        <ul class="list-style-none filter-list" data-filter-search="filter-search-v2">
                            <li class="filter-list-item" v-for="(V2, index) in FILTERS.VARIANTS.TYPE2_LIST" :data-title="V2.NAME">
                                <input type="checkbox" :id="'type2_' + V2.ID" :checked="V2.SELECTED == 1" class="form-control" @change="select('FILTERS.VARIANTS.TYPE2_LIST', index)">
                                <label :for="'type2_' + V2.ID" :id="'label-type2_' + V2.ID" class="filter-item" :class="{'text-black' : V2.SELECTED == 1}">
                                    <span class="input-checkbox">
                                        <i class="ti-check"></i>
                                    </span>
                                    {{ V2.NAME }}
                                </label>
                            </li>
                        </ul>
                    </div>
                </div>
            </section>
            <section class="col-12 filter-card" v-if="FILTERS.BRANDS && FILTERS.BRANDS.length">
                <div class="row">
                    <h5 class="col-12 py-1 d-flex filter-title accordion-title active" data-toggle="accordion">
                        {#brand#}
                        <span class="ml-auto">
                            <i class="ti-arrow-down"></i>
                            <i class="ti-arrow-up"></i>
                        </span>
                    </h5>
                    <div class="col-12 filter-body accordion-body mb-1 show">
                        <div class="w-100 position-relative filter-search ti-search mb-1" v-if="FILTERS.BRANDS.length > 9">
                            <input type="text" class="form-control" placeholder="{#brand#} {#search#}" @keyup="search($event, 'filter-search-brand')"/>
                        </div>
                        <ul class="list-style-none filter-list" data-filter-search="filter-search-brand">
                            <li class="filter-list-item" v-for="(B, index) in FILTERS.BRANDS" :data-title="B.NAME">
                                <input type="checkbox" :id="'brand' + B.ID" :checked="B.SELECTED == 1" class="form-control" @change="select('FILTERS.BRANDS', index)">
                                <label :for="'brand' + B.ID" :id="'label-brand' + B.ID" class="filter-item" :class="{'text-black' : B.SELECTED == 1}">
                                    <span class="input-checkbox">
                                        <i class="ti-check"></i>
                                    </span>
                                    {{ B.NAME }}
                                </label>
                            </li>
                        </ul>
                    </div>
                </div>
            </section>
            <section class="col-12 filter-card" v-if="FILTERS.MODELS && FILTERS.MODELS.length">
                <div class="row">
                    <h5 class="col-12 py-1 d-flex filter-title accordion-title active" data-toggle="accordion">
                        {#model#}
                        <span class="ml-auto">
                            <i class="ti-arrow-down"></i>
                            <i class="ti-arrow-up"></i>
                        </span>
                    </h5>
                    <div class="col-12 filter-body accordion-body mb-1 show">
                        <div class="w-100 position-relative filter-search ti-search mb-1" v-if="FILTERS.MODELS.length > 9">
                            <input type="text" class="form-control" placeholder="{#model#} {#search#}" @keyup="search($event, 'filter-search-model')"/>
                        </div>
                        <ul class="list-style-none filter-list" data-filter-search="filter-search-model">
                            <li class="filter-list-item" v-for="(M, index) in FILTERS.MODELS" :data-title="M.NAME">
                                <input type="checkbox" :id="'model' + M.ID" :checked="M.SELECTED == 1" class="form-control" @change="select('FILTERS.MODELS', index)">
                                <label :for="'model' + M.ID" :id="'label-model' + M.ID" class="filter-item" :class="{'text-black' : M.SELECTED == 1}">
                                    <span class="input-checkbox">
                                        <i class="ti-check"></i>
                                    </span>
                                    {{ M.NAME }}
                                </label>
                            </li>
                        </ul>
                    </div>
                </div>
            </section>
            <section class="col-12 filter-card" v-for="(FILTER, index) in FILTERS.FILTERS" v-if="FILTERS.FILTERS">
                <div class="row">
                    <h5 class="col-12 py-1 d-flex filter-title accordion-title active" data-toggle="accordion">
                        {{ FILTER.NAME }}
                        <span class="ml-auto">
                            <i class="ti-arrow-down"></i>
                            <i class="ti-arrow-up"></i>
                        </span>
                    </h5>
                    <div class="col-12 filter-body accordion-body mb-1 show" v-if="FILTER.TYPE != 2">
                        <div class="w-100 position-relative filter-search ti-search mb-1" v-if="FILTER.VALUES.length > 9">
                            <input type="text" class="form-control" :placeholder="FILTER.NAME + ' {#search#}'" @keyup="search($event, 'filter-search-f' + index)"/>
                        </div>
                        <ul class="list-style-none d-flex flex-wrap filter-list-color" :data-filter-search="'filter-search-f' + index" v-if="FILTER.VIEW == 'color'">
                            <li class="filter-list-item" v-for="(F, subIndex) in FILTER.VALUES" :data-title="F.NAME">
                                <input type="checkbox" :id="'filter-' + FILTER.ID + F.ID" :checked="F.SELECTED == 1" class="form-control" @change="filter(index,subIndex)">
                                <label :for="'filter-' + FILTER.ID + F.ID" :id="'label-' + FILTER.ID + F.ID" class="filter-color d-flex w-100 m-0 position-relative" :title="F.NAME">
                                <span class="image-wrapper border border-round" :style="`background-color:${F.DATA}`">
                                        <span class="image-inner"></span>
                                    </span>
                                    <span class="input-checkbox" :class="F.SELECTED == 1 ? 'd-block' : 'd-none'">
                                        <i class="ti-check"></i>
                                    </span>
                                </label>
                            </li>
                        </ul>
                        <ul class="list-style-none d-flex flex-wrap filter-list-shape" :data-filter-search="'filter-search-f' + index" v-else-if="FILTER.VIEW == 'shape'">
                            <li class="filter-list-item" v-for="(F, subIndex) in FILTER.VALUES" :data-title="F.NAME">
                                <input type="checkbox" :id="'filter-' + FILTER.ID + F.ID" :checked="F.SELECTED == 1" class="form-control" @change="filter(index,subIndex)">
                                <label :for="'filter-' + FILTER.ID + F.ID" :id="'label-' + FILTER.ID + F.ID" class="filter-shape w-100 m-0" :title="F.NAME" :class="{'shape-checked' : F.SELECTED == 1}">
                                    <span class="image-wrapper border border-round bg-white">
                                        <span class="image-inner">
                                            <img :src="F.DATA" :alt="F.NAME" v-if="F.DATA">
                                        </span>
                                    </span>
                                    <p class="shape-name text-center">{{ F.NAME }}</p>
                                </label>
                            </li>
                        </ul>
                        <ul class="list-style-none filter-list" :data-filter-search="'filter-search-f' + index" v-else>
                            <li class="filter-list-item" v-for="(F, subIndex) in FILTER.VALUES" :data-title="F.NAME">
                                <input type="checkbox" :id="'filter-' + FILTER.ID + F.ID" :checked="F.SELECTED == 1" class="form-control" @change="filter(index,subIndex)">
                                <label :for="'filter-' + FILTER.ID + F.ID" :id="'label-' + FILTER.ID + F.ID" class="filter-item" :class="{'text-black' : F.SELECTED == 1}">
                                    <span class="input-checkbox">
                                        <i class="ti-check"></i>
                                    </span>
                                    {{ F.NAME }}
                                </label>
                            </li>
                        </ul>
                    </div>
                    <div class="col-12 filter-body filter-decimal-body accordion-body show" v-if="FILTER.TYPE == 2 && (FILTER.MAX != 0)">
                        <slider-range 
                            :id="'filter-decimal-slider' + FILTER.ID"
                            :params="FILTER.ID"
                            :min="FILTER.MIN" 
                            :max="FILTER.MAX" 
                            :start="[FILTER.MIN_SELECTED, FILTER.MAX_SELECTED]"
                            :decimal="true"
                        ></slider-range>
                    </div>
                </div>
            </section>
            <section class="col-12 py-1 filter-card single-option">
                <input type="checkbox" id="filter-stock" :checked="PARAMS.stock" class="form-control" @change='PARAMS.stock = !PARAMS.stock'>
                <label for="filter-stock" id="label-filter-stock" class="filter-item" :class="{'text-black' : PARAMS.stock}">
                    <span class="input-checkbox">
                        <i class="ti-check"></i>
                    </span>
                    {#stock#}
                </label>
            </section>
            <section class="col-12 py-1 filter-card single-option">
                <input type="checkbox" id="filter-discounted" :checked="PARAMS.discounted" class="form-control" @change='PARAMS.discounted = !PARAMS.discounted'>
                <label for="filter-discounted" id="label-filter-discounted" class="filter-item" :class="{'text-primary' : PARAMS.discounted}">
                    <span class="input-checkbox">
                        <i class="ti-check"></i>
                    </span>
                    {#discounted#}
                </label>
            </section>
            <section class="col-12 py-1 filter-card single-option">
                <input type="checkbox" id="filter-new" :checked="PARAMS.new" class="form-control" @change='PARAMS.new = !PARAMS.new'>
                <label for="filter-new" id="label-filter-new" class="filter-item" :class="{'text-primary' : PARAMS.new}">
                    <span class="input-checkbox">
                        <i class="ti-check"></i>
                    </span>
                    {#new#}
                </label>
            </section>
            <section class="col-12 filter-card" v-if="FILTERS.PRICE.MAX && FILTERS.PRICE.MAX > 0">
                <div class="row">
                    <h5 class="col-12 py-1 d-flex filter-title accordion-title active" data-toggle="accordion">
                        {#price#}
                        <span class="ml-auto">
                            <i class="ti-arrow-down"></i>
                            <i class="ti-arrow-up"></i>
                        </span>
                    </h5>
                    <div class="col-12 filter-body accordion-body mb-1 show">
                        <slider-range 
                            :id="'filter-price-slider'" 
                            :min="FILTERS.PRICE.MIN" 
                            :max="FILTERS.PRICE.MAX" 
                            :start="[FILTERS.PRICE.MIN_SELECTED, FILTERS.PRICE.MAX_SELECTED]"
                            :currency="FILTERS.TARGET_CURRENCY"
                        ></slider-range>
                    </div>
                </div>
            </section>
        </div>
        <button type="button" id="filter-button" class="w-100 btn btn-md btn-primary text-uppercase text-center" @click="run">{#filter_click#}</button>
    </div>
</div>
