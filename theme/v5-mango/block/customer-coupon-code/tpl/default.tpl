<div id="page-my-coupon-codes" class="w-100" v-cloak>
    <div class="col-12">
        <div class="row">
            <div class="col-12 mb-1">
                <div class="d-flex align-items-flex-start justify-content-between">
                    <h1 class="d-flex align-items-center">
                        <i class="ti-gift d-flex align-items-center justify-content-center text-white member-menu-icon"></i>
                        {#block_title#}
                    </h1>
                    <a href="javascript:void(0);" onclick="window.history.back();" class="btn btn-light border border-light text-uppercase"><i class="ti-arrow-left"></i> {#back#}</a>
                </div>
                <div class="w-100 border-top mt-1"></div>
            </div>
            <div class="col-12 mb-1 d-flex justify-content-flex-end">
                <input type="checkbox" id="get-activated-coupons" class="form-control" ref="filterActiveCoupons" @change="filterActiveCoupons">
                <label for="get-activated-coupons" class="btn btn-light border border-light mb-0 fw-semibold d-flex align-items-center">
                    <span class="input-checkbox">
                        <i class="ti-check"></i>
                    </span>
                    {#only_active#}
                </label>
            </div>
            <div class="col-12 coupon-codes-list">
                <div class="row">
                    <div class="col-12 col-lg-6 mb-1 coupon-item" v-for="(COUPON, index) in DATA.COUPON_LIST">
                        <div class="w-100 border border-round" :class="{ 'passive text-light' : COUPON.IS_USED == 0 }">
                            <div class="coupon-title p-10px fw-bold" :class="{ 'text-primary' : COUPON.IS_USED == 0 }">{{ COUPON.APPLICATION_AREA }} - <span :class="{ 'text-success' : COUPON.IS_USED == 0 }">{#active#}</span></div>
                            <div class="coupon-info border-top d-flex flex-wrap text-gray">
                                <div class="w-100 w-md-50 p-1 p-10px accordion-title" data-toggle="accordion" data-mobile="true" :data-target="'#coupon-detail-' + (index + 1)">
                                    <div v-if="COUPON.IS_USED != 0">{#code_used#}</div>
                                    <div v-else class="d-flex align-items-center code-clone">
                                        <strong class="text-black">{#code#}</strong>
                                        <span>{{ COUPON.CODE }}</span>
                                        <a href="javascript:void(0);" class="ti-copy text-gray" @click="copyCode(COUPON.CODE)"></a>
                                    </div>
                                    <div class="icon-wrapper d-md-none">
                                        <i class="ti-arrow-up text-primary"></i>
                                        <i class="ti-arrow-down text-black"></i>
                                    </div>
                                </div>
                                <div class="w-50 p-1 border-left p-10px d-none d-md-block">
                                    <div class="coupon-start-date"><strong :class="{ 'text-black' : COUPON.IS_USED == 0 }">{#start_date#}</strong> {{ COUPON.START_DATE }}</div>
                                    <div class="coupon-end-date"><strong :class="{ 'text-black' : COUPON.IS_USED == 0 }">{#finish_date#}</strong> {{ COUPON.FINISH_DATE }}</div>
                                </div>
                            </div>
                            <div :id="'coupon-detail-' + (index + 1)" class="accordion-body">
                                <div class="coupon-date-info d-flex d-md-none border-top">
                                    <div class="w-50 p-10px coupon-start-date"><strong :class="{ 'text-black' : COUPON.IS_USED == 0 }">{#start_date#}</strong> {{ COUPON.START_DATE }}</div>
                                    <div class="w-50 p-10px coupon-end-date border-left"><strong :class="{ 'text-black' : COUPON.IS_USED == 0 }">{#finish_date#}</strong> {{ COUPON.FINISH_DATE }}</div>
                                </div>
                                <div class="coupon-description p-10px border-top">{{ COUPON.DESCRIPTION }}</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>