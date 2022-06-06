<div id="page-my-addresses" class="w-100 mb-3" v-cloak>
    <div class="col-12">
        <router-view></router-view>
    </div>
</div>
<template id="address-list">
    <div class="row">
        <div class="col-12 mb-1">
            <div class="d-flex align-items-flex-start justify-content-between">
                <h1 class="d-flex align-items-center">
                    <i class="ti-location d-flex align-items-center justify-content-center text-white member-menu-icon"></i>
                    {#block_title#}
                </h1>
                <a href="javascript:void(0);" onclick="window.history.back();" class="btn btn-light border text-uppercase"><i class="ti-arrow-left"></i> {#back#}</a>
            </div>
            <div class="w-100 border-top mt-1"></div>
        </div>
        <div class="col-12 d-flex align-items-center justify-content-between">
            <div class="address-description text-content d-none d-md-block">{#description#}</div>
            <router-link to="edit" class="btn btn-dark add-address-btn"><i class="ti-location"></i> {#new_adress#} &plus;</router-link>
        </div>
        <div class="col-12 addresses-list">
            <div class="row">
                <div class="col-12 col-md-6 py-1 address-item" v-for="address in data">
                    <div class="w-100 h-100 border border-round">
                        <div class="address-title p-10px d-flex align-items-center justify-content-between border-bottom">
                            <div class="title">{{ address.title }} - {{ address.fullname }}</div>
                            <div class="address-btns">
                                <router-link :to="'/edit/' + address.id" class="btn btn-light border">
                                    <i class="ti-pencil"></i>
                                    <span class="d-none d-md-inline-block">{#edit#}</span>
                                </router-link>
                                <button type="button" class="btn btn-light border"
                                    :data-id="address.id"
                                    data-toggle="popconfirm"
                                    data-title="Silmek istediğinize emin misiniz ?"
                                    data-confirm="Evet"
                                    data-cancel="Hayır"
                                    data-icon="ti-trash-o text-primary"
                                    data-loading="true"
                                    data-callback="deleteAadress">
                                    <i class="ti-trash-o"></i>
                                    <span class="d-none d-md-inline-block">{#delete#}</span>
                                </button>
                            </div>
                        </div>
                        <div class="address-body">
                            <p>{{ address.address }} {{ address.district }} {{ address.postCode }} {{ address.town }} {{ address.city }} {{ address.country }}</p>
                            <p v-if="address.mobilePhone != ''">{{ address.mobilePhone }}</p>
                            <p v-if="address.homePhone != ''">{{ address.homePhone }}</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<template id="address-edit">
    <div class="w-100">
        <div v-if="loading" v-cloak></div>
        <div class="row" v-else>
            <div class="col-12 mb-1">
                <div class="d-flex align-items-flex-start justify-content-between">
                    <h1 class="d-flex align-items-center">
                        <i class="ti-location d-flex align-items-center justify-content-center text-white member-menu-icon"></i>
                        {{ ($route.params.id || 0) > 0 ? '{#edit_adress#}' : '{#add_adress#}' }}
                    </h1>
                    <a href="javascript:void(0);" @click="$router.go(-1)" class="btn btn-light border border-light text-uppercase"><i class="ti-arrow-left"></i> {#back#}</a>
                </div>
                <div class="w-100 border-top mt-1"></div>
            </div>
            <form :action="'/api/v1/public/address/' + $route.params.id" id="edit-address-form" class="col-12" method="post" autocomplete="off" novalidate ref="addressEditForm" @submit.prevent="saveForm">
                <div class="row" v-if="requirements.rules">
                    <div class="col-12 col-md-6 mb-1" v-if="requirements.configs && requirements.configs.showCustomerEmailAddress == true">
                        <div class="w-100 popover-wrapper position-relative">
                            <input type="email" placeholder="{#email#}" name="email" class="form-control form-control-md" :value="requirements.configs.CUSTOMER_EMAIL_ADDRESS">
                        </div>
                    </div>
                    <div class="col-12 col-md-6 mb-1" v-if="requirements.rules.is_company_active.show == 1">
                        <div class="w-100 popover-wrapper position-relative">
                            <select v-model="address.is_company_active" name="is_company_active" class="form-control form-control-md">
                                <option value="0">{#individual_address#}</option>
                                <option value="1" selected="selected">{#corporate_adress#}</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-12 col-md-6 mb-1" v-if="requirements.rules.title.show == 1 || requirements.rules.title.required == 1">
                        <div class="w-100 popover-wrapper position-relative">
                            <input type="text" placeholder="{#adress_title#}" name="title" class="form-control form-control-md"
                                   :required="requirements.rules.title.required == 1">
                        </div>
                    </div>
                    <div class="col-12 col-md-6 mb-1" v-if="requirements.rules.fullname.show == 1 || requirements.rules.fullname.required == 1">
                        <div class="w-100 popover-wrapper position-relative">
                            <input type="text" placeholder="{#fullname#}" name="fullname" class="form-control form-control-md"
                                   :required="requirements.rules.fullname.required == 1">
                        </div>
                    </div>
                    <div class="col-12 col-md-6 mb-1" v-if="address.is_company_active == '0' && (requirements.rules.identity_number.show == 1 || requirements.rules.identity_number.required == 1)">
                        <div class="w-100 position-relative">
                            <div class="w-100 popover-wrapper position-relative">
                                <input type="number" placeholder="{#identity_number#}" name="identity_number" class="form-control form-control-md no-arrows"
                                    :disabled="address.nationality == true"
                                    :required="requirements.rules.identity_number.required && address.nationality != true == 1">
                            </div>
                            <div class="h-100 d-flex align-items-center pr-1 position-absolute nationality-field-wrapper" v-if="requirements.rules.nationality.show == 1">
                                <input type="checkbox" name="nationality" id="nationality" class="form-control" :checked="address.nationality" :value="address.nationality == true ? '1' : '0'" v-model="address.nationality">
                                <label for="nationality" class="p-0 m-0">
                                    <span class="input-checkbox">
                                        <i class="ti-check"></i>
                                    </span>
                                    {#nationality#}
                                </label>
                            </div>
                        </div>
                    </div>
                    <div class="col-12 col-md-6 mb-1" v-if="address.is_company_active == '1' && (requirements.rules.company.show == 1 || requirements.rules.company.required == 1)">
                        <div class="w-100 popover-wrapper position-relative">
                            <input type="text" placeholder="{#company#}" name="company" class="form-control form-control-md"
                                   :required="requirements.rules.company.required == 1">
                        </div>
                    </div>
                    <div class="col-12 col-md-6 mb-1" v-if="address.is_company_active == '1' && (requirements.rules.tax_office.show == 1 || requirements.rules.tax_office.required == 1)">
                        <div class="w-100 popover-wrapper position-relative">
                            <input type="text" placeholder="{#tax_office#}" name="tax_office" class="form-control form-control-md"
                                   :required="requirements.rules.tax_office.required == 1">
                        </div>
                    </div>
                    <div class="col-12 col-md-6 mb-1" v-if="address.is_company_active == '1' && (requirements.rules.tax_number.show == 1 || requirements.rules.tax_number.required == 1)">
                        <div class="w-100 popover-wrapper position-relative">
                            <input type="number" placeholder="{#tax_number#}" name="tax_number" class="form-control form-control-md no-arrows"
                                   :required="requirements.rules.tax_number.required == 1">
                        </div>
                    </div>
                    <div class="col-12 col-md-6 mb-1 d-flex align-items-center" v-if="address.is_company_active == '1' && requirements.rules.has_e_invoice.show == 1">
                        <div class="w-100 popover-wrapper position-relative">
                            <input type="checkbox" name="has_e_invoice" id="has_e_invoice" class="form-control" value="1" :checked="address.has_e_invoice == 1">
                            <label for="has_e_invoice">
                                <span class="input-checkbox">
                                    <i class="ti-check"></i>
                                </span>
                                {#has_e_invoice#}
                            </label>
                        </div>
                    </div>
                    <div class="col-12 col-md-6 mb-1" v-if="requirements.rules.address.show == 1 || requirements.rules.address.required == 1">
                        <div class="w-100 popover-wrapper position-relative">
                            <textarea name="address" maxlength="requirements.rules.address.max_char_len" class="form-control form-control-sm"
                                      placeholder="{#adress#}"
                                      :required="requirements.rules.address.required == 1">{{ requirements.ADDRESS }}</textarea>
                        </div>
                    </div>
                    <div class="col-12 col-md-6 mb-1" v-if="requirements.rules.post_code.show == 1 || requirements.rules.post_code.required == 1">
                        <div class="w-100 popover-wrapper position-relative">
                            <input type="text" placeholder="{#post_code#}" name="post_code" class="form-control form-control-md no-arrows"
                                   :required="requirements.rules.post_code.required == 1">
                        </div>
                    </div>
                    <div class="col-12 col-md-6 mb-1 country-container" v-if="requirements.rules.country.show == 1 || requirements.rules.country.required == 1">
                        <div class="w-100 popover-wrapper position-relative">
                            <select id="country_code" name="country_code" placaholder="{#country#} {#choose#}" class="form-control form-control-md country-select">
                                <option value="">{#country#} {#choose#}</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-12 col-md-6 mb-1 state-container" v-if="requirements.rules.province.show == 1 || requirements.rules.province.required == 1">
                        <div class="w-100 popover-wrapper position-relative">
                            <div class="state-input-container">
                                <input type="text" placeholder="{#province#}" id="province" name="province" class="form-control form-control-md state-input">
                            </div>
                            <div class="state-select-container">
                                <select name="province_code" id="province_code" class="col-12 form-control form-control-md state-select" placeholder="{#province#} {#choose#}">
                                    <option value="">{#province#} {#choose#}</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="col-12 col-md-6 mb-1 city-container" v-if="requirements.rules.city.show == 1 || requirements.rules.city.required == 1">
                        <div class="w-100 popover-wrapper position-relative">
                            <div class="city-input-container">
                                <input type="text" placeholder="{#city#}" id="city" name="city" class="form-control form-control-md city-input">
                            </div>
                            <div class="city-select-container">
                                <select name="city_code" id="city_code" class="col-12 form-control form-control-md city-select" placeholder="{#city#} {#choose#}">
                                    <option value="">{#city#} {#choose#}</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="col-12 col-md-6 mb-1 town-container" v-if="requirements.rules.town.show == 1 || requirements.rules.town.required == 1">
                        <div class="w-100 popover-wrapper position-relative">
                            <div class="town-input-container">
                                <input type="text" placeholder="{#town#}" id="town" name="town" class="form-control form-control-md town-input">
                            </div>
                            <div class="town-select-container">
                                <select name="town_code" id="town_code" class="col-12 form-control form-control-md town-select" placeholder="{#town#} {#choose#}">
                                    <option value="">{#town#} {#choose#}</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="col-12 col-md-6 mb-1 district-container" v-if="requirements.rules.district.show == 1 || requirements.rules.district.required == 1">
                        <div class="w-100 popover-wrapper position-relative">
                            <div class="district-input-container">
                                <input type="text" placeholder="{#district#}" id="district" name="district" class="form-control form-control-md district-input">
                            </div>
                            <div class="district-select-container">
                                <select name="district_code" id="district_code" class="col-12 form-control form-control-md district-select" placeholder="{#district#} {#choose#}">
                                    <option value="">{#district#} {#choose#}</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="col-12 col-md-6 mb-1" v-if="requirements.rules.mobile_phone.show == 1 || requirements.rules.mobile_phone.required == 1">
                        <div class="w-100 popover-wrapper position-relative">
                            <input type="tel" name="mobile_phone" class="form-control form-control-md"
                                   placeholder="{#mobile_phone#}" 
                                   data-flag-masked
                                   :required="requirements.rules.mobile_phone.required == 1">
                        </div>
                    </div>
                    <div class="col-12 col-md-6 mb-1" v-if="requirements.rules.home_phone.show == 1 || requirements.rules.home_phone.required == 1">
                        <div class="w-100 popover-wrapper position-relative">
                            <input type="tel" name="home_phone" class="form-control form-control-md"
                                   placeholder="{#home_phone#}" 
                                   data-flag-masked
                                   :required="requirements.rules.home_phone.required == 1">
                        </div>
                    </div>
                    <div class="col-12 px-0">
                        <div class="w-100 w-md-50 px-1">
                            <button type="submit" class="btn btn-primary w-100 text-uppercase">{{ ($route.params.id || 0) > 0 ? '{#update#}' : '{#saved#}' }}</button>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</template>