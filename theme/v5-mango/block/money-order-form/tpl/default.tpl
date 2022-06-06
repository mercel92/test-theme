<div id="page-my-money-order" class="w-100" v-cloak>
    <div class="col-12">
        <div class="row" v-if="!LOADING">
            <div class="col-12 mb-1">
                <div class="d-flex align-items-flex-start justify-content-between">
                    <h1 class="d-flex align-items-center">
                        <i class="ti-dollar ti-20px text-white member-menu-icon d-flex align-items-center justify-content-center"></i>
                        {#block_title#}
                    </h1>
                    <a href="javascript:void(0);" onclick="window.history.back();" class="btn btn-light border border-light text-uppercase"><i class="ti-arrow-left"></i> {#back#}</a>
                </div>
                <div class="w-100 border-top mt-1"></div>
            </div>
            <div class="col-12">
                <div class="row mx-0">
                    <form class="col-12 p-0 mb-1 d-flex flex-wrap align-items-center border border-light border-round"
                        v-for="(ORDER, index) in DATA.ORDER_LIST" method="POST" action="#" novalidate autocomplete="off"
                        :ref="'MoneyOrder' + index">
                        <div class="col-6 col-md-2 py-1">
                            <div class="fw-medium mb-10">{#order_no#}</div>
                            <div>
                                <input type="hidden" name="order_id" :id="ORDER.ID" :value="ORDER.ORDER_NUMBER">
                                <strong>{{ ORDER.ORDER_NUMBER }}</strong>
                            </div>
                        </div>
                        <div class="col-6 col-md-2 py-1">
                            <div class="fw-medium mb-10">{#order_date#}</div>
                            <strong class="d-block">{{ ORDER.ORDER_CREATE_DATE }}</strong>
                        </div>
                        <div class="col-12 col-md-6">
                            <div class="row" v-if="ORDER.IS_NOTIFIED != '1'">
                                <div class="col-12 col-md-6 py-1">
                                    <div class="w-100 popover-wrapper position-relative">
                                        <input :id="'message' + index" type="text" name="message" placeholder="{#description_login#}" class="form-control form-control-md" data-validate="required">
                                    </div>
                                </div>
                                <div class="col-12 col-md-6 py-1">
                                    <div class="w-100 popover-wrapper position-relative">
                                        <select :id="'bank_id' + index" name="bank_id" class="form-control form-control-md" data-validate="required">
                                            <option value="">{#choose_bank#}</option>
                                            <option :value="BANK.ID" v-for="BANK in DATA.BANK_LIST">{{ BANK.NAME }}
                                            </option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-md-2 py-1">
                            <div class="btn btn-light w-100 border border-round" v-if="ORDER.IS_NOTIFIED == '1'">{#send_notify#}</div>
                            <a href="javascript:void(0)" class="btn btn-primary w-100" @click="sendForm('MoneyOrder' + index)" v-else>{#send#}</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>