<div id="page-my-cp" class="w-100 mb-2" v-cloak>
    <div class="col-12">
        <div class="row">
            <div class="col-12">
                <div class="w-100 mb-1 pt-1 bg-white position-sticky page-title-wrapper border-bottom">
                    <div class="d-flex align-items-flex-start justify-content-between">
                        <h1 class="d-flex align-items-center">
                            <i class="ti-clipboard d-flex align-items-center justify-content-center text-white member-menu-icon"></i>
                            {#block_title#}
                        </h1>
                        <div class="d-flex align-items-center">
                            <a href="javascript:void(0);" onclick="window.history.back();" class="btn btn-light border text-uppercase"><i class="ti-arrow-left"></i> {#back#}</a>
                        </div>
                    </div>
                    <div class="w-100 border-top mt-1"></div>
                </div>
            </div>
            <div class="col-12">{#dear#} “{{ DATA.FULLNAME }}” {#current_payment_info#}.</div>
            <div class="col-12">
                <div class="row align-items-flex-end">
                    <div class="col-12 col-lg-7">
                        <div class="row align-items-flex-end">
                            <div class="col-6 col-md-4 py-1">
                                <label for="first-date">{#start_date#}</label>
                                <div class="w-100 popover-wrapper position-relative">
                                    <input type="text" name="first-date" id="first-date" class="form-control form-control-md">
                                </div>
                            </div>
                            <div class="col-6 col-md-4 py-1">
                                <label for="last-date">{#finish_date#}</label>
                                <div class="w-100 popover-wrapper position-relative">
                                    <input type="text" name="last-date" id="last-date" class="form-control form-control-md">
                                </div>
                            </div>
                            <div class="col-12 col-md-4 py-1">
                                <a href="javascript:void(0);" @click="dateFiltre()" class="w-100 btn btn-primary text-uppercase position-relative date-filtre">
                                    {#filter#} <i class="ml-1 ti-arrow-right"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="col-12 col-lg-4 py-1 ml-auto">
                        <a href="/{url type='page' id='90'}" class="w-100 btn btn-success text-uppercase">
                            {#payment_with_credit_card#}
                        </a>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-12 cp-list">
            <div class="row">
                <div class="w-100 border border-top-0 border-round cp-table" v-if="CURRENT_MOVEMENTS.length > 0">
                    <div class="w-100 d-flex cp-table-header border-top">
                        <div class="p-1 border-right fw-bold">#</div>
                        <div class="col-1 py-1 border-right fw-bold">{#date#}</div>
                        <div class="col-1 py-1 border-right fw-bold">{#order_no#}</div>
                        <div class="col py-1 border-right fw-bold">{#description#}</div>
                        <div class="col-1 py-1 border-right fw-bold">{#debt#}</div>
                        <div class="col-1 py-1 border-right fw-bold">{#credit#}</div>
                        <div class="col-1 py-1 border-right fw-bold">{#payment_method#}</div>
                        <div class="col-1 py-1 fw-bold"></div>
                    </div>
                    <div class="w-100 d-flex cp-table-body border-top" v-for="(CP, index) in CURRENT_MOVEMENTS">
                        <div class="p-1 border-right">{{ index + 1 }}</div>
                        <div class="col-1 py-1 border-right cp-date">{{ date(CP.TIMESTAMP) }}</div>
                        <div class="col-1 py-1 border-right">{{ CP.ORDER_NUMBER }}</div>
                        <div class="col py-1 border-right">{{ CP.DESCRIPTION }}</div>
                        <div class="col-1 py-1 border-right">{{ format(CP.DEBT) }} {{ CP.CURRENCY }}</div>
                        <div class="col-1 py-1 border-right">{{ format(CP.CREDIT) }} {{ CP.CURRENCY }}</div>
                        <div class="col-1 py-1 border-right">{{ CP.PAYMENT_METHOD }}</div>
                        <div class="col-1 py-1">
                            <a :href="CP.PRINT_URL" target="_blank" class="text-body d-flex align-items-center justify-conten-center">
                                <i class="ti-print"></i> <span>{#print_receipt#}</span>
                            </a>
                        </div>
                    </div>
                    <div class="w-100 d-flex cp-table-footer border-top">
                        <div class="col-2 py-1">
                            <strong>{#total#}</strong>
                            <div class="w-100">{{ CURRENT_MOVEMENTS.length }} {#record#}</div>
                        </div>
                        <div class="col-1 py-1 pl-0 ml-auto">
                            <strong>{#total#} {#debt#}</strong>
                            <div class="w-100">{{ format(DATA.TOTAL_DEBT) }} {{ DATA.TOTAL_CURRENCY }}</div>
                        </div>
                        <div class="col-1 py-1 pl-0">
                            <strong>{#total#} {#credit#}</strong>
                            <div class="w-100">{{ format(DATA.TOTAL_CREDIT) }} {{ DATA.TOTAL_CURRENCY }}</div>
                        </div>
                        <div class="col-2 py-1 pl-0">
                            <strong>{#balance#}</strong>
                            <div class="w-100">{{ format(DATA.BALANCE) }} {{ DATA.TOTAL_CURRENCY }} {{ DATA.BALANCE_TEXT }}</div>
                        </div>
                    </div>
                </div>
                <div class="col-12 p-1 border border-round cp-table" v-else>
                    {#no_result#}
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-12 col-lg-4 py-1 ml-auto">
                <a href="/{url type='page' id='90'}" class="w-100 btn btn-success text-uppercase">
                    {#payment_with_credit_card#}
                </a>
            </div>
        </div>
    </div>
</div>