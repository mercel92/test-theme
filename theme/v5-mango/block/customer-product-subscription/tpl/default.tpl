<div id="page-my-subscription" class="w-100 mb-2" v-cloak>
    <router-view></router-view>
</div>

<template id="subscribe-list">
    <div class="col-12 page-title-wrapper">
        <div class="d-flex align-items-flex-start justify-content-between mb-1 py-1 bg-white border-bottom border-light">
            <h1 class="d-flex align-items-center">
                <i class="ti-calendar ti-20px d-flex align-items-center justify-content-center text-white member-menu-icon"></i>
                {#block_title#}
            </h1>
            <div class="d-flex align-items-center">
                <a href="javascript:void(0);" onclick="window.history.back();" class="btn btn-light border border-light text-uppercase"><i class="ti-arrow-left"></i> {#back#}</a>
            </div>
        </div>
    </div>
    <div class="col-12 subs-list" v-if="DATA.LIST && DATA.LIST != ''">
        <div class="col-12 border border-light mb-1 subs-item" v-for="(subs, index) in DATA.LIST">
            <div class="row align-items-center">
                <div class="col-2 col-sm-1 py-1">
                    <img :src="'/Data/K/' + subs.image" :alt="subs.product_name">
                </div>
                <div class="col-10 col-sm py-1 text-gray">
                    <div v-html="subs.product_name"></div>
                    <div class="mt-8" v-if="subs.subproduct_type1 != 0 || subs.subproduct_type2 != 0">
                        {{ subs.subproduct_type1 }} <span v-if="subs.subproduct_type2 != 0">-</span> {{ subs.subproduct_type2 }}
                    </div>
                </div>
                <div class="col-6 col-sm-3 py-1">
                    <div class="row">
                        <div class="col-6">
                            <div class="fw-bold">{#frequency#}</div>
                            <div class="mt-8">{{ subs.frequency }}</div>
                        </div>
                        <div class="col-6">
                            <div class="fw-bold">{#last_transaction_date#}</div>
                            <div class="mt-8">{{ date(subs.last_transaction_date) }}</div>
                        </div>
                    </div>
                </div>
                <div class="col-4 col-sm-3 col-md-2 py-1 ml-auto">
                    <router-link :to="'/detail/' + subs.id" type="button" class="btn btn-primary fw-bold w-100">{#subscrive_calendar#}</router-link>
                </div>
                <div class="col-auto px-1">
                    <button type="button" class="btn p-0" @click="cancel(subs.id)"><i class="ti-trash-o"></i></button>
                </div>
            </div>
        </div>
    </div>
    <div class="col-12 subs-list-not" v-else>
        <div v-html="DATA.statusText ? DATA.statusText : '{#not_have_subscription_product#}.'"></div>
    </div>
</template>

<template id="subscribe-detail">
    <div class="col-12 page-title-wrapper">
        <div class="d-flex align-items-flex-start justify-content-between mb-1 py-1 bg-white border-bottom border-light">
            <div class="d-flex align-items-center">
                <i class="ti-calendar ti-20px d-flex align-items-center justify-content-center text-white member-menu-icon"></i>
                <div>
                    <h1>{#block_title#}</h1>
                    <small class="text-gray">
                        {{ SUBS.product_name }}
                        <span v-if="SUBS.subproduct_type1 != 0 || SUBS.subproduct_type2 != 0">{{ SUBS.subproduct_type1 }} <span v-if="SUBS.subproduct_type2 != 0">-</span> {{ SUBS.subproduct_type2 }}</span>
                    </small>
                </div>
            </div>
            <div class="d-flex align-items-center">
                <a href="javascript:void(0);" onclick="window.history.back();" class="btn btn-light border border-light text-uppercase"><i class="ti-arrow-left"></i> {#back#}</a>
            </div>
        </div>
    </div>
    <div class="col-12">
        <div class="border border-light border-round subs-detail-list">
            <div class="col-12 subs-detail-head">
                <div class="row">
                    <div class="col-auto px-1 py-1 fw-bold border-right d-flex align-items-center">#</div>
                    <div class="col-2 py-1 fw-bold border-right d-none d-sm-flex align-items-center">{#last_transaction_date#}</div>
                    <div class="col-2 py-1 fw-bold border-right d-none d-sm-flex align-items-center">{#error_message#}</div>
                    <div class="col-3 col-sm-2 py-1 fw-bold border-right d-flex align-items-center">{#next_transaction_date#}</div>
                    <div class="col py-1 fw-bold border-right d-flex align-items-center">{#result#}</div>
                    <div class="col-3 col-sm-2 py-1 fw-bold d-flex align-items-center">{#order_number#}</div>
                </div>
            </div>
            <div class="col-12 border-top border-light subs-detail-item" v-for="(D, index) in DETAIL">
                <div class="row">
                    <div class="col-auto px-1 border-right d-flex align-items-center">
                        {{ index + 1 }}
                    </div>
                    <div class="col-2 py-1 border-right d-none d-sm-flex align-items-center">
                        {{ date(D.last_transaction_date == 0 ? D.create_date : D.last_transaction_date) }}
                    </div>
                    <div class="col-2 py-1 border-right d-none d-sm-flex align-items-center">
                        {{ D.last_transaction_error }}
                    </div>
                    <div class="col-3 col-sm-2 py-1 border-right d-flex align-items-center">
                        {{ date(D.estimated_date) }}
                    </div>
                    <div class="col py-1 border-right d-flex align-items-center">
                        {{ D.approved == '1' ? '{#approved#}' : '{#not_approved#}' }}
                    </div>
                    <div class="col-3 col-sm-2 py-1 d-flex align-items-center">
                        <span v-if="D.order">{{ D.order.order_number }}</span>
                    </div>
                </div>
            </div>
        </div>
    </div>

</template>