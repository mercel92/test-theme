<div id="product-comments" class="row" v-cloak>
    <div class="col-12" v-if="!LOADING">
        <div class="col-12 border border-round">
            <div class="row">
                <div class="col-12 col-sm-4 py-1 d-flex align-items-center justify-content-center">
                    <i class="ti-comment-multiple"></i>
                    <div class="comment-average">
                        <strong class="d-block text-primary">{#comments#} ({{ COMMENT_DATA.TOTAL }})</strong>
                        <span><strong class="text-primary">{{ rateTotalAverage }}/5</strong> {#average_point#}</span>
                    </div>
                </div>
                <div class="col-4 py-1 d-none d-md-flex align-items-center border-right">
                    <ul class="list-style-none star-average">
                        <li class="d-flex align-items-center" v-for="i in [...Array(5).keys()].slice().reverse()">
                            <strong>{{ i + 1 }}</strong>
                            <div class="stars">
                                <i class="ti-star" v-for="i in 5"></i>
                                <span class="stars-fill" :style="{'width': ((i + 1) * 20) + '%'}">
                                    <i class="ti-star" v-for="i in 5"></i>
                                </span>
                            </div>
                            <div class="position-relative bg-secondary border-round progress-bar">
                                <span class="bg-primary border-round position-absolute h-100 progress-bar-fill" :style="{ 'width': rateAverageByStar[i + 1] }"></span>
                            </div>
                            <span class="comment-count">{{ AVERAGE.data[i + 1] }}</span>
                        </li>
                    </ul>
                </div>
                <div class="col-12 col-sm-4 py-1 d-flex align-items-center justify-content-flex-end">
                    <button id="comment-do" type="button" class="btn btn-primary btn-md w-100 w-sm-auto" @click="reload(1)" v-if="COMMENT_DATA.IS_MEMBER_LOGGED_IN == 1">
                        <span class="px-2 text-uppercase">{#comment_do#}</span>
                    </button>
                    <a id="comment-do" href="/srv/service/content-v5/sub-folder/5/1006/popup-login" class="btn btn-primary btn-md w-100 w-sm-auto popupwin" v-else>
                        <span class="px-2 text-uppercase">{#comment_do#}</span>
                    </a>
                </div>
            </div>
        </div>
        <form :action="endpoints.saveComment + data.GET_PRODUCT" 
              method="post" autocomplete="off" class="col-12 py-1 border border-round mt-1" 
              ref="saveCommentForm" 
              @submit.prevent="sendForm"
              v-if="COMMENT_DATA.WRITE_COMMENT == 1">
            <input type="hidden" id="comment-prId" name="prId" :value="data.GET_PRODUCT">
            <div class="row">
                <div class="col-12 mb-1">
                    <div class="w-100 popover-wrapper position-relative">
                        <select id="comment-rate" name="rate" class="form-control form-control-md">
                            <option value="1">{#vote_worst#}</option>
                            <option value="2">{#vote_soso#}</option>
                            <option value="3">{#vote_good#}</option>
                            <option value="4">{#vote_great#}</option>
                            <option value="5" selected>{#vote_best#}</option>
                        </select>
                    </div>
                </div>
                <div class="col-12 mb-1">
                    <div class="w-100 popover-wrapper position-relative">
                        <input type="text" id="comment-title" name="title" class="form-control form-control-md" placeholder="{#comment_title#}" data-toggle="placeholder">
                    </div>
                </div>
                <div class="col-12 mb-1">
                    <label>{#comment_show_name#}</label>
                    <div class="w-100 popover-wrapper position-relative">
                        <div class="d-inline-block mr-1">
                            <input type="radio" id="displayNameNo" name="displayName" value="0" checked class="form-control">
                            <label for="displayNameNo">
                                <span class="input-radio">
                                    <i class="ti-check"></i>
                                </span>
                                {#text_no#}
                            </label>
                        </div>
                        <div class="d-inline-block">
                            <input type="radio" id="displayNameYes" name="displayName" value="1" class="form-control">
                            <label for="displayNameYes">
                                <span class="input-radio">
                                    <i class="ti-check"></i>
                                </span>
                                {#text_yes#}
                            </label>
                        </div>
                    </div>
                </div>
                <div class="col-12 mb-1">
                    <div class="w-100 popover-wrapper position-relative">
                        <textarea name="text" id="comment-message" class="form-control form-control-md" placeholder="{#comment#}" data-toggle="placeholder"></textarea>
                    </div>
                </div>
                <div class="col-12 d-flex justify-content-flex-end">
                    <button type="submit" id="comment-saved" class="col-12 col-md-4 col-xl-3 btn btn-primary text-uppercase">{#saved#}</button>
                </div>
            </div>
        </form>
        <div class="col-12 bg-light mb-1 mt-1" v-if="COMMENT_DATA.COMMENTS.length > 0">
            <div class="row">
                <div class="col-12 col-lg-2 col-md-3 py-1 d-flex align-items-center">
                    <select class="form-control border-0" id="comment-sort" v-model="sort" @change="reload()">
                        <option value="0">{#sort#}</option>
                        <option value="date,desc">{#date_desc#}</option>
                        <option value="date,asc">{#date_asc#}</option>
                        <option value="rate,desc">{#rate_desc#}</option>
                        <option value="rate,asc">{#rate_asc#}</option>
                    </select>
                </div>
                <div class="col-12 col-md-7 py-1 ml-auto">
                    <form class="form-search w-100 position-relative" @submit.prevent="reload()">
                        <input type="search" placeholder="{#enter_comment#}" id="comment-search" v-model="search" class="form-control form-control-md no-cancel" />
                        <button type="submit" id="comment-search-btn" class="btn btn-dark px-1 py-0">{#search#}</button>
                        <label class="search-icon ti-search text-gray text-center"></label>
                    </form>
                </div>
            </div>
        </div>
        <div class="col-12 py-1 px-0 fw-bold" v-if="COMMENT_DATA.COMMENT_DONE == 1">
            {#comment_done#}
        </div>
        <div class="col-12 py-1 px-0 fw-bold" v-if="COMMENT_DATA.COMMENT_VOTED == 1">
            {#comment_vote#}
        </div>
        <div class="col-12 py-1 px-0 fw-bold" v-if="COMMENT_DATA.NO_COMMENT == 1 && COMMENT_DATA.WRITE_COMMENT != 1">
            {#write_comment#}
            <a id="comment-click" href="/srv/service/content-v5/sub-folder/5/1006/popup-login" v-if="COMMENT_DATA.IS_MEMBER_LOGGED_IN == 0" :data-id="COMMENT_DATA.PRODUCT_ID" class="fw-bold text-success popupwin">{#comment_click#}</a>
            <a id="comment-click" href="javascript:void(0);" v-else class="fw-bold text-success" @click="reload(1)">{#comment_click#}</a>
        </div>
        <div class="col-12 py-1 comment-wrapper" id="product-comment-wrapper">
            <div class="row" v-if="COMMENT_DATA.COMMENTS.length > 0">
                <div v-for="COMMENT in COMMENT_DATA.COMMENTS" class="col-12 border border-bottom-0 border-right-0 border-light border-round mb-1 comment-item">
                    <div class="row">
                        <div class="col-12 col-lg-5 py-1 border-bottom border-right border-light d-flex align-items-center">
                            <div class="comment-avatar d-flex align-items-center justify-content-center border-circle">
                                {{ COMMENT.NAME.slice(0, 1) }}{{ COMMENT.SURNAME.slice(0, 1) }}
                            </div>
                            <div class="comment-info">
                                <div class="fw-bold user">{{ COMMENT.IS_NAME_DISPLAYED == "1" ? COMMENT.NAME : secret(COMMENT.NAME) }} {{ secret(COMMENT.SURNAME) }}</div>
                                <div class="fw-bold title">{{ COMMENT.TITLE }}</div>
                                <div class="description">{{ COMMENT.COMMENT }}</div>
                                <div class="d-flex" v-if="COMMENT.IS_PRODUCT_PURCHASED == 1">
                                    <div class="d-inline-flex bg-primary text-white border-round px-1 purchased">
                                        {#product_purchased#}
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-6 col-lg-4 py-1 border-bottom border-right border-light d-flex align-items-center">
                            <div class="comment-star">
                                <div class="rate"><strong>{{ COMMENT.RATE/20 }}</strong>/5</div>
                                <div class="fw-bold">{#comment_rate#}</div>
                                <div class="star-average">
                                    <div class="position-relative d-inline-flex text-gray stars">
                                        <i class="ti-star" v-for="i in 5"></i>
                                        <span class="position-absolute d-flex text-primary stars-fill" :style="{ 'width': COMMENT.RATE + '%' }">
                                            <i class="ti-star" v-for="i in 5"></i>
                                        </span>
                                    </div>
                                </div>
                                <div class="comment-date text-gray">{{ date(COMMENT.DATE, 'd.m.y | h:i') }}</div>
                            </div>
                        </div>
                        <div class="col-6 col-lg-3 py-1 border-bottom border-right border-light d-flex align-items-center justify-content-center vote-buttons">
                            <div class="w-100 yes-no-check">
                                <strong class="d-block mb-1 text-center">{#comment_vote_text#}</strong>
                                <div class="row mx-0 mb-1">
                                    <div class="col-6"><button type="button" id="comment-vote-yes" class="w-100 btn border-round btn-success text-uppercase" @click="vote(COMMENT.ID, 1)">{#text_yes#}</button></div>
                                    <div class="col-6"><button type="button" id="comment-vote-no" class="w-100 btn border-round btn-outline-gray text-uppercase" @click="vote(COMMENT.ID, 2)">{#text_no#}</button></div>
                                </div>
                                <div class="row mx-0 vote-buttons">
                                    <div class="col-6">
                                        <a href="javascript:void(0)" class="yes-btn d-block w-100 text-center text-uppercase fw-bold text-body">
                                            <i class="ti-thumbs-up d-block"></i>
                                            {#text_yes#}: {{ COMMENT.YES_VOTE }}
                                        </a>
                                    </div>
                                    <div class="col-6">
                                        <a href="javascript:void(0)" class="no-btn d-block w-100 text-center text-uppercase fw-bold text-body">
                                            <i class="ti-thumbs-down d-block"></i>
                                            {#text_no#}: {{ COMMENT.NO_VOTE }}
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-12 bg-light p-1 mb-1 d-flex justify-content-center align-items-center pagination"
                    v-if="COMMENT_DATA.TOTAL > COMMENT_DATA.META.LIMIT">
                    <a href="javascript:void(0);" id="comment-page" :class="{'selected': COMMENT_DATA.META.CURRENT_PAGE == PAGE}" v-for="PAGE in COMMENT_DATA.META.TOTAL_PAGE" @click="nextComment(PAGE)">{{ PAGE }}</a>
                </div>
            </div>
            <div class="w-100" v-if="COMMENT_DATA.COMMENTS.length == 0 && COMMENT_DATA.TOTAL != 0">
                {#not_found#}.
            </div>
        </div>
    </div>
</div>
<script>
    let DATA = {};
    try {
        DATA = JSON.parse(`{$DATA}`);
    } catch (ex) {
        DATA = {};
    }

    const ProductComments = {
        data() {
            return {
                data: DATA,
                endpoints: {
                    average: '/srv/service/product-detail/comment-average/',
                    comment: '/srv/service/product-detail/comments/',
                    saveComment: '/srv/service/product-detail/comment/',
                    voteComment: '/srv/service/product-detail/vote-comment/'
                },
                captcha: `/SecCode.php?${new Date().getTime()}`,
                LOADING: true,
                AVERAGE: [],
                COMMENT_DATA: [],
                sort: 0,
                search: '',
                page: '',
            }
        },
        computed: {
            rateTotalAverage() {
                let sum = 0;
                for(let key in this.AVERAGE.data) {
                    if(key.length > 0) {
                        sum += key * this.AVERAGE.data[key]
                    }
                }
                const generalAverage = sum / this.AVERAGE.total;
                return Number.isNaN(generalAverage) ? 0 : generalAverage.toFixed(1);
            },
            rateAverageByStar() {
                return {
                    1: this.AVERAGE.data[1] == 0 ? 0 : ((100 * this.AVERAGE.data[1]) / this.AVERAGE.total) + '%',
                    2: this.AVERAGE.data[2] == 0 ? 0 : ((100 * this.AVERAGE.data[2]) / this.AVERAGE.total) + '%',
                    3: this.AVERAGE.data[3] == 0 ? 0 : ((100 * this.AVERAGE.data[3]) / this.AVERAGE.total) + '%',
                    4: this.AVERAGE.data[4] == 0 ? 0 : ((100 * this.AVERAGE.data[4]) / this.AVERAGE.total) + '%',
                    5: this.AVERAGE.data[5] == 0 ? 0 : ((100 * this.AVERAGE.data[5]) / this.AVERAGE.total) + '%'
                }
            }
        },
        methods: {
            secret(string = '') {
                return string.slice(0, 1) + '' + string.substring(1).replace(/\S/g,'*');
            },
            reload(type = '') {
                const self = this;
                const params = [];

                if (self.page != '' && self.page != 1) params.push(`page=${self.page}`);
                if (self.search.trim() != '') params.push(`q=${self.search}`);
                if (self.sort != 0) {
                    const arr = self.sort.split(',');
                    params.push(`sort=${arr[0]}&dir=${arr[1]}`);
                }

                axios.get(`${this.endpoints.comment}${self.data.PRODUCT_ID}/${type}?${params.join('&')}`).then(response => {
                    self.COMMENT_DATA = response.data;
                }).catch(error => console.warn(`Comment reload (${type}) not working => ${error}`));
            },
            sendForm() {
                const self = this;
                const form = self.$refs.saveCommentForm;
                const formData = new FormData(form);
                formData.append('csrf_token', self.data.CSRF_TOKEN);

                axios.post(form.action, formData).then(response => {
                    const res = response.data;
                    if(res.status < 1) {
                        if (res.key == '') {
                            T.notify({
                                text: res.statusText,
                                duration: 3000,
                                className: 'danger'
                            });
                            return;
                        } else {
                            popoverAlert.show(
                                form.querySelector(`[name="${res.key}"]`), 
                                res.statusText,
                                3000,
                                `btn btn-danger no-radius text-left`
                            );
                            return;
                        }
                    }
                    self.reload(2);
                });
            },
            date(date, format) {
                return T.timeConverter(date, format);
            },
            vote(id, vote) {
                const self = this;
                axios.post(`${self.endpoints.voteComment}/${id}/${vote}`).then(response => {
                    const res = response.data;
                    if(res.status < 1) {
                        T.notify({
                            text: res.statusText,
                            duration: 3000,
                            className: 'danger'
                        });
                        return;
                    }
                    self.reload(3);
                });
            },
            nextComment(page) {
                const self = this;
                self.page = page;
                self.reload();
            },
        },
        mounted() {
            if(this.data.PRODUCT_ID) {
                const average  = axios.get(`${this.endpoints.average}/${this.data.PRODUCT_ID}`);
                const comments = axios.get(`${this.endpoints.comment}/${this.data.PRODUCT_ID}`);

                Promise.all([average, comments]).then(response => {
                    this.AVERAGE = response[0].data;
                    this.COMMENT_DATA = response[1].data;
                    this.LOADING = false;
                    setTimeout(() => { initComponents(); }, 250);
                }).catch(error => console.warn(`Product Comment Error => ${error}`));
            }
        }
    };

    Vue.createApp(ProductComments).mount('#product-comments');
</script>