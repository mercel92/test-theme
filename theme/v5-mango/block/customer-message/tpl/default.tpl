<div id="page-my-messages" class="w-100 mb-2" v-cloak>
    <div class="col-12">
        <router-view></router-view>
    </div>
</div>

<template id="message-list">
    <div class="row">
        <div class="col-12 mb-1 bg-white position-sticky page-title-wrapper">
            <div class="row">
                <h1 class="col-12 col-md-auto pt-1 d-flex align-items-center">
                    <i class="ti-chat-alt ti-20px d-flex align-items-center justify-content-center text-white member-menu-icon"></i>
                    {#block_title#}
                </h1>
                <div class="col-12 col-md-auto ml-auto pt-1 d-flex align-items-center justify-content-between">
                    <router-link to="new" class="btn btn-primary px-2 mr-1 text-uppercase"><i class="ti-chat-alt"></i> {#new_message#} &plus;</router-link>
                    <a href="javascript:void(0);" onclick="window.history.back();" class="btn btn-light border border-light text-uppercase"><i class="ti-arrow-left"></i> {#back#}</a>
                </div>
            </div>
            <div class="w-100 border-top mt-1"></div>
        </div>
        <div class="col-12 message-list">
            <div class="row mx-0">
                <div class="col-12 mb-1 border border-light border-round message-item" v-for="(MSG, index) in DATA">
                    <div class="row align-items-center">
                        <router-link :to="'/detail/' + MSG.id" class="col-12 col-md py-1 text-body d-flex align-items-center">
                            <i class="ti-chat-alt text-primary"></i>
                            <div class="ml-1">
                                <strong>{{ MSG.subject }}</strong>
                                <span class="d-block">#{{ MSG.id }} <strong>{#department#} : </strong> {{ MSG.department }}</span>
                            </div>
                        </router-link>
                        <div class="col-auto col-md-3 py-1">
                            <strong class="d-none d-md-block">{#supplier_name#}</strong>
                            <div :data-id="MSG.supplierId">{{ MSG.supplierName }}</div>
                        </div>
                        <div class="col-auto col-md-2 py-1 px-0">
                            <strong class="d-none d-md-block">{#date#}</strong>
                            <div>{{ date(MSG.updateDate) }}</div>
                        </div>
                        <div class="ml-auto col-auto col-md-2 py-1 d-flex justify-content-flex-end">
                            <span class="btn btn-success py-1" v-if="MSG.status == 1">{#open#}</span>
                            <span class="btn btn-light py-1 border border-light" v-else>{#close#}</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<template id="message-detail">
    <div class="row" v-if="!LOADING">
        <div class="col-12 mb-1 pt-1 bg-white position-sticky page-title-wrapper">
            <div class="row">
                <h1 class="col-12 col-md-auto d-flex align-items-center">
                    <i class="ti-chat-alt ti-20px d-flex align-items-center justify-content-center text-white member-menu-icon"></i>
                    {{ MESSAGE.subject }}
                </h1>
                <div class="col-12 col-md-auto ml-auto d-flex align-items-center justify-content-between">
                    <div class="fw-bold mr-2">
                        {#date#}<br> {{ date(MESSAGE.updateDate) }}
                    </div>
                    <a href="javascript:void(0);" onclick="window.history.back();" class="btn btn-light border border-light text-uppercase"><i class="ti-arrow-left"></i> {#back#}</a>
                </div>
            </div>
            <div class="w-100 border-top mt-1"></div>
        </div>
        <div class="col-12 message-list">
            <div class="row mx-0">
               <div class="w-100 border border-2x bg-light border-round">
                    <div class="d-flex flex-wrap align-items-center bg-white border-round message-chat-header">
                        <div class="col-4 col-md py-1">
                            <strong class="d-none d-md-inline-block">{#message_number#} :</strong> {{ MESSAGE.id }}
                        </div>
                        <div class="col-4 col-md py-1">
                            <strong class="d-none d-md-inline-block">{#department#} :</strong> {{ MESSAGE.department }}
                        </div>
                        <div class="col-4 col-md py-1">
                            <strong class="d-none d-md-inline-block">{#supplier_name#} :</strong> {{ MESSAGE.supplierName }}
                        </div>
                        <div class="col-12 col-md py-1 d-flex justify-content-flex-end">
                            <button class="btn btn-black text-uppercase w-sm-auto w-100" @click="closeMsg(MESSAGE.id)" v-if="MESSAGE.status == 1">{#subject_close#}</button>
                            <button class="btn btn-black text-uppercase w-sm-auto w-100" v-else>{#close#}</button>
                        </div>
                    </div>
                    <div class="w-100 message-chat">
                        <div class="col-12 p-1 message-chat-list">
                            <div class="w-100 d-flex" v-for="(msg, mi) in DETAIL" :class="{ 'justify-content-flex-end': msg.isAdmin != '1' }">
                                <div class="col-12 col-sm-9 col-md-7 col-lg-5 p-1">
                                    <div class="w-100 border-round p-1 position-relative bg-white text-right message-chat-item" v-if="msg.isAdmin != '1'">
                                        <div class="d-flex align-items-center justify-content-flex-end flex-wrap"> 
                                            <span class="fs-12 mr-1">{{ date(msg.date) }}</span>
                                            <strong class="text-primary">{{ MESSAGE.customerName }}</strong>
                                        </div>
                                        <div class="text-gray" v-html="msg.message"></div>
                                    </div>
                                    <div class="w-100 border-round p-1 position-relative bg-secondary message-chat-item" v-else>
                                        <div class="d-flex align-items-center justify-content-flex-end flex-wrap flex-direction-row-reverse"> 
                                            <span class="fs-12 ml-1">{{ date(msg.date) }}</span>
                                            <strong class="text-gray">{{ MESSAGE.department }} {#answer#}</strong>
                                        </div>
                                        <div class="text-gray" v-html="msg.message"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-12 mt-1" v-if="MESSAGE.status == 1">
                            <form id="message-send" action="/api/v1/public/send-message/department/" method="POST" autocomplete="off" ref="sendMessageForm" @submit.prevent="sendMessage" class="w-100 popover-wrapper position-relative mb-1 message-send">
                                <input type="hidden" name="parentId" :value="MESSAGE.id">
                                <input type="hidden" name="subject" :value="MESSAGE.subject">
                                <input type="hidden" name="departmentId" :value="MESSAGE.departmentId">
                                <textarea name="message" :id="'message' + MESSAGE.id" class="w-100 form-control" placeholder="{#reply#}" data-validate="required"></textarea>
                                <button type="submit" class="btn btn-success text-uppercase message-chat-btn">{#send#} <i class="ml-1 ti-mail-o"></i></button>
                            </form>
                        </div>
                    </div>
               </div>
            </div>
        </div>
    </div>
</template>

<template id="new-message">
    <div class="row">
        <div class="col-12 mb-1 pt-1 bg-white page-title-wrapper">
            <div class="d-flex align-items-flex-start justify-content-between">
                <h1 class="d-flex align-items-center">
                    <i class="ti-chat-alt ti-20px d-flex align-items-center justify-content-center text-white member-menu-icon"></i>
                    {#new_message#}
                </h1>
                <div class="d-flex align-items-center">
                    <a href="javascript:void(0);" onclick="window.history.back();" class="btn btn-light border border-light text-uppercase"><i class="ti-arrow-left"></i> {#back#}</a>
                </div>
            </div>
            <div class="w-100 border-top mt-1"></div>
        </div>
        <form action="/api/v1/public/send-message/department" method="POST" autocomplete="off" ref="sendMessageForm" @submit.prevent="sendMessage" class="col-12 new-message-form">
            <div class="row">
                <div class="col-12 mb-1">
                    <div class="w-100 d-flex border">
                        <div class="w-50 w-md-25 p-1 fw-bold">{#fullname#}</div>
                        <div class="w-50 p-1 border-left">{{ MEMBER.FIRST_NAME }} {{ MEMBER.LAST_NAME }}</div>
                    </div>
                    <div class="w-100 d-flex border border-top-0">
                        <div class="w-50 w-md-25 p-1 fw-bold">{#your_email#}</div>
                        <div class="w-50 p-1 border-left">{{ MEMBER.MAIL }}</div>
                    </div>
                </div>
                <div class="col-12 mb-1" v-if="DEPARTMENT_LIST.length > 0">
                    <div class="w-100 popover-wrapper">
                        <select name="departmentId" class="form-control">
                            <option value="">{#select_department#}</option>
                            <option v-for="(D, index) in DEPARTMENT_LIST" :value="D.id" :selected="index == 0">{{ D.name }}</option>
                        </select>
                    </div>
                </div>
                <div class="col-12 mb-1">
                    <div class="w-100 popover-wrapper">
                        <input type="text" maxlength="100" name="subject" placeholder="{#subject#}" class="form-control" data-validate="required">
                    </div>
                </div>
                <div class="col-12 mb-1">
                    <div class="w-100 popover-wrapper">
                        <textarea name="message" class="form-control" placeholder="{#your_message#}" maxlength="255" data-validate="required"></textarea>
                    </div>
                </div>
                <div class="col-12 d-flex justify-content-flex-end mb-1">
                    <button type="submit" class="btn btn-primary w-100 w-sm-50 w-md-25 text-uppercase">{#send#}</button>
                </div>
            </div>
        </form>
    </div>
</template>