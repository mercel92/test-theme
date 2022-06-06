<div id="page-my-points" class="w-100" v-cloak>
    <div class="col-12" v-if="!LOADING">
        <div class="row">
            <div class="col-12 mb-1">
                <div class="d-flex align-items-flex-start justify-content-between">
                    <h1 class="d-flex align-items-center">
                        <i class="ti-database ti-20px d-flex align-items-center justify-content-center text-white member-menu-icon"></i>
                        {#block_title#}
                    </h1>
                    <a href="javascript:void(0);" onclick="window.history.back();" class="btn btn-light border border-light text-uppercase"><i class="ti-arrow-left"></i> {#back#}</a>
                </div>
                <div class="w-100 border-top mt-1"></div>
            </div>
            <div class="col-12 mb-1 d-flex flex-wrap align-items-center justify-content-between">
                <div class="point-description text-content w-100 w-auto">{#point_info#}.</div>
                <select class="form-control form-control-md w-100 w-auto" v-model="FILTER_ID">
                    <option value="0">{#all#}</option>
                    <option value="1">{#recommend_point#}</option>
                    <option value="2">{#order_point#}</option>
                    <option value="3">{#questionnaire_point#}</option>
                    <option value="4">{#comment_point#}</option>
                    <option value="5">{#member_point#}</option>
                    <option value="6">{#comment_do_point#}</option>
                </select>
            </div>
            <div class="col-12 mb-1">
                <div class="w-100 border border-light border-round point-table">
                    <div class="w-100 d-flex flex-wrap point-table-header">
                        <div class="col-2 py-1 border-right border-light fw-bold">{#date#}</div>
                        <div class="col-5 py-1 border-right border-light fw-bold">{#description#}</div>
                        <div class="col-2 py-1 border-right border-light fw-bold">{#win_point#}</div>
                        <div class="col-2 py-1 border-right border-light fw-bold">{#debt_point#}</div>
                        <div class="col-1 py-1 fw-bold"></div>
                    </div>
                    <div class="w-100 d-flex flex-wrap point-table-body border-top border-light" v-for="P in DATA.POINTS">
                        <div class="col-2 py-1 d-flex align-items-center border-right border-light">{{ timeConverter(P.DATE) }}</div>
                        <div class="col-5 py-1 d-flex align-items-center border-right border-light">{{ P.DESCRIPTION }}</div>
                        <div class="col-2 py-1 d-flex align-items-center border-right border-light">{{ P.CREDIT }}</div>
                        <div class="col-2 py-1 d-flex align-items-center border-right border-light">{{ P.DEBT }}</div>
                        <div class="col-1 py-1 d-flex align-items-center justify-content-center">
                            <a :href="'/srv/service/content-v5/sub-folder/' + BLOCK.PAGE_ID + '/' + BLOCK.PARENT_ID + '/order-detail/' + P.ORDER_ID" data-width="940" class="text-primary popupwin" v-if="P.TYPE == 'order_point' && P.ORDER_ID > 0">
                                <i class="ti-zoom-in"></i>
                            </a>
                        </div>
                    </div>
                </div>
                <div class="w-100 d-flex bg-light text-black" v-if="DATA.POINTS.length > 0">
                    <strong class="col-4 py-1">{#credit_point#} ({#total#})</strong>
                    <strong class="col-8 py-1">{{ DATA.TOTAL_CREDIT }}</strong>
                </div>
                <div class="w-100 d-flex bg-light text-black border-top border-light" v-if="DATA.POINTS.length > 0">
                    <strong class="col-4 py-1">{#debt_point#} ({#total#})</strong>
                    <strong class="col-8 py-1">{{ DATA.TOTAL_DEBT }}</strong>
                </div>
                <div class="w-100 py-1 d-flex justify-content-between page-my-points-paginator" v-if="DATA.TOTAL > DATA.LENGTH">
                    <button class="btn btn-dark px-2 btn-page-prev text-uppercase" v-if="DATA.START > 0" @click="paging(LENGTH, START - LENGTH)">{#prev#}</button>
                    <button class="btn btn-dark px-2 btn-page-next text-uppercase" v-if="(DATA.START + DATA.LENGTH) < DATA.TOTAL" @click="paging(LENGTH, START + LENGTH)">{#next#}</button>
                </div>
            </div>
        </div>
    </div>
</div>