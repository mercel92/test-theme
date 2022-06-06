<div id="member-register" class="w-100" v-cloak>
    <div class="col-12 my-1" v-if="!LOADING">
        <div class="row">
            <div class="col-12 col-md-6 mb-2" :class="{ 'mx-auto' : IS_MEMBER_LOGGED_IN !== true }">
                <form action="#" method="POST" enctype="multipart/form-data" autocomplete="off" class="w-100 py-1 bg-white border border-light border-round"
                    :id="'member-register-form' + BLOCK.ID" ref="memberRegister" @submit.prevent="saveForm" novalidate>
                    <div class="col-12" v-if="IS_MEMBER_LOGGED_IN !== true">
                        <ul id="ug-login-tab" class="w-100 tab-nav list-style-none">
                            <li class="active"><a href="javascript:void(0)">{#member_register#}</a></li>
                            <li><a href="/{url type='page' id='5'}">{#member_login#}</a></li>
                        </ul>
                    </div>
                    <div class="col-12 mb-1" v-for="(FIELD, index) in FORM_FIELDS.block">
                        <div class="w-100 border-bottom position-relative fw-bold text-body section-title" 
                            v-if="FIELD.key == 'cat1' && IS_MEMBER_LOGGED_IN === true">
                            {{ FIELD.field }}
                        </div>
                        <div class="w-100 popover-wrapper position-relative" v-if="['name', 'surname', 'company', 'tax_office', 'WSCariKodu'].includes(FIELD.key)">
                            <input type="text"
                                :placeholder="FIELD.field"
                                :name="FIELD.key"
                                :id="FIELD.key"
                                class="form-control form-control-md"
                                data-toggle="placeholder"
                                :data-validate="FIELD.isRequired == 1 ? 'required' : ''">
                        </div>
                        <div class="w-100 popover-wrapper position-relative" v-else-if="FIELD.key == 'identity_number'">
                            <div class="w-100">
                                <input type="number"
                                    pattern="\d*"
                                    :placeholder="FIELD.field" 
                                    :name="FIELD.key" 
                                    :id="FIELD.key" 
                                    class="form-control form-control-md no-arrows"
                                    data-toggle="placeholder"
                                    :disabled="DETAIL_INFO.nationality == true"
                                    :data-validate="FIELD.isRequired == 1 && DETAIL_INFO.nationality != true ? 'required' : ''">
                            </div>
                            <div class="h-100 d-flex align-items-center pr-1 position-absolute nationality-field-wrapper" v-if="FORM_FIELDS.block.find(x => x.key == 'nationality')">
                                <input type="checkbox" :value="DETAIL_INFO.nationality == true ? '1' : '0'" :checked="DETAIL_INFO.nationality == true" name="nationality" id="nationality" class="form-control" v-model="DETAIL_INFO.nationality">
                                <label for="nationality" class="p-0 m-0" id="label-nationality">
                                    <span class="input-checkbox">
                                        <i class="ti-check"></i>
                                    </span>
                                    {#foreign_citizen#}
                                </label>
                            </div>
                        </div>
                        <div class="w-100 popover-wrapper position-relative" v-else-if="['tax_number', 'post_code'].includes(FIELD.key)">
                            <input type="text"
                                :placeholder="FIELD.field" 
                                :name="FIELD.key" 
                                :id="FIELD.key" 
                                class="form-control form-control-md no-arrows"
                                data-toggle="placeholder"
                                :data-validate="FIELD.isRequired == 1 ? 'required' : ''">
                        </div>
                        <div class="w-100 popover-wrapper position-relative" v-else-if="FIELD.key == 'representative'">
                            <select :name="FIELD.key" :id="FIELD.key" class="form-control form-control-md"
                                    :data-validate="FIELD.isRequired == 1 ? 'required' : ''" v-model="DETAIL_INFO.representative_id">
                                <option value="">{#representative#}</option>
                                <option v-for="R in FORM_FIELDS.representatives" :value="R.id">{{ R.name }}</option>
                            </select>
                        </div>
                        <div class="w-100 popover-wrapper position-relative" v-else-if="FIELD.key == 'address'">
                            <textarea :name="FIELD.key" :id="FIELD.key" class="form-control form-control-md" :placeholder="FIELD.field"></textarea>
                        </div>
                        <div class="w-100 popover-wrapper position-relative" v-else-if="FIELD.key == 'country_code'">
                            <select :name="FIELD.key" :id="FIELD.key" class="form-control form-control-md"
                                    :data-validate="FIELD.isRequired == 1 ? 'required' : ''">
                                <option value="">{#country#}</option>
                            </select>
                        </div>
                        <div class="w-100 popover-wrapper position-relative" v-else-if="FIELD.key == 'city_code'">
                            <div class="city-input-container">
                                <input type="text" :placeholder="FIELD.field" data-toggle="placeholder" name="city" id="city" class="form-control form-control-md">
                            </div>
                            <div class="city-select-container d-none">
                                <select :name="FIELD.key" :id="FIELD.key" class="form-control form-control-md">
                                    <option value="">{#province#}</option>
                                </select>
                            </div>
                        </div>
                        <div class="w-100 popover-wrapper position-relative" v-else-if="FIELD.key == 'town_code'">
                            <div class="town-input-container">
                                <input type="text" :placeholder="FIELD.field" data-toggle="placeholder" name="town" id="town" class="form-control form-control-md">
                            </div>
                            <div class="town-select-container d-none">
                                <select :name="FIELD.key" :id="FIELD.key" class="form-control form-control-md">
                                    <option value="">{#town#}</option>
                                </select>
                            </div>
                        </div>
                        <div class="w-100 popover-wrapper position-relative" v-else-if="FIELD.key == 'district'">
                            <div class="district-input-container">
                                <input type="text" :placeholder="FIELD.field" data-toggle="placeholder" name="district" id="district" class="form-control form-control-md">
                            </div>
                            <div class="district-select-container d-none">
                                <select :name="FIELD.key + '_code'" :id="FIELD.key + '_code'" class="form-control form-control-md">
                                    <option value="">{#district#}</option>
                                </select>
                            </div>
                        </div>
                        <div class="w-100 d-flex flex-wrap popover-wrapper position-relative" v-else-if="FIELD.key == 'birthdate'">
                            <input type="hidden" name="day" v-model="parse_birthdate[0]">
                            <input type="hidden" name="month" v-model="parse_birthdate[1]">
                            <input type="hidden" name="year" v-model="parse_birthdate[2]">
                            <input type="date" :name="FIELD.key" v-model="birthdate" class="form-control form-control-md flatpickr" 
                                   :placeholder="'{#birthday#}'" data-toggle="placeholder"
                                   :data-validate="FIELD.isRequired == 1 ? 'required' : ''">
                        </div>
                        <div class="w-100 popover-wrapper position-relative" v-else-if="FIELD.key == 'gender'">
                            <select :name="FIELD.key" :id="FIELD.key" class="form-control form-control-md"
                                    :data-validate="FIELD.isRequired == 1 ? 'required' : ''" v-model="DETAIL_INFO.gender">
                                <option value="2">{{ FIELD.field }}</option>
                                <option value="1">{#male#}</option>
                                <option value="0">{#female#}</option>
                            </select>
                        </div>
                        <div class="w-100 popover-wrapper position-relative" v-else-if="['home_phone', 'office_phone', 'mobile_phone'].includes(FIELD.key)">
                            <input type="tel" 
                                :placeholder="FIELD.field" 
                                :name="FIELD.key"
                                :id="FIELD.key"
                                class="form-control form-control-md no-arrows" 
                                data-toggle="placeholder"
                                data-flag-masked
                                :data-validate="FIELD.isRequired == 1 ? 'required' : ''">
                        </div>
                        <div class="w-100 popover-wrapper position-relative" v-else-if="FIELD.key == 'email'">
                            <input type="email" :name="FIELD.key" :id="FIELD.key" class="form-control form-control-md" 
                                data-toggle="placeholder" :placeholder="FIELD.field" :data-validate="FIELD.isRequired == 1 ? 'required,email' : ''">
                        </div>
                        <div class="w-100" v-else-if="FIELD.key == 'password'">
                            <div class="w-100 mb-1 popover-wrapper position-relative" v-if="IS_MEMBER_LOGGED_IN !== true">
                                <input type="password" :name="FIELD.key" :id="FIELD.key" class="form-control form-control-md" 
                                    data-toggle="placeholder"
                                    :placeholder="FIELD.field" :data-validate="FIELD.isRequired == 1 ? 'required' : ''">
                            </div>
                            <div class="w-100 popover-wrapper position-relative" v-if="IS_MEMBER_LOGGED_IN !== true">
                                <input type="password" name="password_again" id="password_again" class="form-control form-control-md" 
                                    :placeholder="FIELD.field + ' {#repeat#}'" data-toggle="placeholder"
                                    :data-validate="FIELD.isRequired == 1 ? 'required' : ''">
                            </div>
                        </div>
                        <div class="w-100 popover-wrapper position-relative" v-else-if="FIELD.key.substring(0, 5) == 'file_'">
                            <input type="file" :name="FIELD.key" :id="FIELD.key" class="form-control" data-toggle="input-file">
                            <label :for="FIELD.key" :id="'label-' + FIELD.key" class="form-control form-control-md d-flex align-items-center justify-content-between text-content">
                                <span>{#file#}</span>
                                <i class="ti-picture text-primary"></i>
                            </label>
                        </div>
                        <div class="w-100 popover-wrapper position-relative" v-else-if="FIELD.key == 'INPUT' && FIELD.key.indexOf('cat') > -1">
                            <input type="text" :name="FIELD.key" :id="FIELD.key" class="form-control form-control-md" 
                                data-toggle="placeholder"
                                :placeholder="FIELD.field" :data-validate="FIELD.isRequired == 1 ? 'required' : ''">
                        </div>
                        <div class="w-100 popover-wrapper position-relative" v-else-if="FIELD.key == 'TEXTAREA'">
                            <textarea :name="FIELD.key" :id="FIELD.key" class="form-control form-control-md" 
                                    :placeholder="FIELD.field" 
                                    data-toggle="placeholder"
                                    :data-validate="FIELD.isRequired == 1 ? 'required' : ''"></textarea>
                        </div>
                        <div class="w-100 popover-wrapper position-relative" v-else-if="FIELD.type == 'RADIO'">
                            <label>{{ FIELD.field }}</label>
                            <div class="clearfix radio-button-group d-flex align-items-center flex-wrap">
                                <div class="group-item" :class="{ 'mr-1' : index + 1 < FIELD.options.length }" v-for="(OPT, index) in FIELD.options">
                                    <input type="radio" :name="FIELD.key" :id="FIELD.key + '_' + index" :value="OPT" class="form-control">
                                    <label :for="FIELD.key + '_' + index" :id="'label' + FIELD.key + '_' + index">
                                        <span class="input-radio">
                                            <i class="ti-check"></i>
                                        </span>
                                        {{ OPT }}
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="w-100 popover-wrapper position-relative" v-else-if="FIELD.type == 'CHECK_BOX'">
                            <label>{{ FIELD.field }}</label>
                            <div class="clearfix checkbox-button-group d-flex align-items-center flex-wrap">
                                <div class="group-item" :class="{ 'mr-1' : index + 1 < FIELD.options.length }" v-for="(OPT, index) in FIELD.options">
                                    <input type="checkbox" :name="FIELD.key + '[]'" :id="FIELD.key + '_' + index" :value="OPT" class="form-control">
                                    <label :for="FIELD.key + '_' + index" :id="'label' + FIELD.key + '_' + index">
                                        <span class="input-checkbox">
                                            <i class="ti-check"></i>
                                        </span>
                                        {{ OPT }}
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="w-100 popover-wrapper position-relative" v-else-if="FIELD.type == 'SELECT_BOX'">
                            <select :name="FIELD.key" :id="FIELD.key" class="form-control form-control-md"
                                    :data-validate="FIELD.isRequired == 1 ? 'required' : ''">
                                <option value="">{{ FIELD.field }}</option>
                                <option :value="OPT" v-for="(OPT, index) in FIELD.options">{{ OPT }}</option>
                            </select>
                        </div>
                        <input type="hidden" :name="FIELD.key" :id="FIELD.key" :value="FIELD.field" v-else-if="FIELD.key == 'NOTE'">
                        <div class="w-100" v-else-if="FIELD.key == 'security_code' && IS_MEMBER_LOGGED_IN === false">
                            <div class="w-100 input-group popover-wrapper position-relative">
                                <div class="input-group-prepend border-0">
                                    <img :src="captcha" id="registerCaptcha" alt="captcha">
                                </div>
                                <input type="text" name="security_code" class="form-control form-control-md" placeholder="{#security_code#}">
                                <div class="input-group-append" @click="refreshCode">
                                    <i class="ti-cw text-primary"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="w-100" v-if="IS_MEMBER_LOGGED_IN === false">
                        <div class="col-12 mb-1">
                            <div class="w-100 popover-wrapper position-relative">
                                <input type="checkbox" name="mail_notify" :id="'mail_notify_' + BLOCK.ID" value="1" class="form-control" :checked="FORM_FIELDS.account.isCheckedMail == '1'">
                                <label :for="'mail_notify_' + BLOCK.ID" :id="'label_mail_notify_' + BLOCK.ID">
                                    <span class="input-checkbox">
                                        <i class="ti-check"></i>
                                    </span>
                                    {#send_info#} <a :href="FORM_FIELDS.pageData.emailContactUrl" class="text-underline text-body popupwin">{#email#}</a> {#get#}
                                </label>
                            </div>
                        </div>
                        <div class="col-12 mb-1">
                            <div class="w-100 popover-wrapper position-relative">
                                <input type="checkbox" name="sms_notify" :id="'sms_notify_' + BLOCK.ID" value="1" class="form-control" :checked="FORM_FIELDS.account.isCheckedSms == '1'">
                                <label :for="'sms_notify_' + BLOCK.ID" :id="'label_sms_notify_' + BLOCK.ID">
                                    <span class="input-checkbox">
                                        <i class="ti-check"></i>
                                    </span>
                                    {#send_info#} <a :href="FORM_FIELDS.pageData.smsContactUrl" class="text-underline text-body popupwin">sms</a> {#get#}
                                </label>
                            </div>
                        </div>
                        <div class="col-12 mb-1">
                            <div class="w-100 popover-wrapper position-relative">
                                <input type="checkbox" name="phone_notify" :id="'phone_notify_' + BLOCK.ID" value="1" class="form-control" :checked="FORM_FIELDS.account.isCheckedPhone == '1'">
                                <label :for="'phone_notify_' + BLOCK.ID" :id="'label_phone_notify_' + BLOCK.ID">
                                    <span class="input-checkbox">
                                        <i class="ti-check"></i>
                                    </span>
                                    {#send_info#} <a :href="FORM_FIELDS.pageData.phoneContactUrl" class="text-underline text-body popupwin">{#call#}</a> {#get#}
                                </label>
                            </div>
                        </div>
                        <div class="col-12 mb-1" v-if="FORM_FIELDS.pageData.displayPrivacy">
                            <div class="w-100 popover-wrapper position-relative">
                                <input type="checkbox" name="privacy" :id="'privacy_' + BLOCK.ID" value="1" class="form-control">
                                <label :for="'privacy_' + BLOCK.ID" :id="'label_privacy_' + BLOCK.ID">
                                    <span class="input-checkbox">
                                        <i class="ti-check"></i>
                                    </span>
                                    <a :href="FORM_FIELDS.pageData.membershipUrl" class="text-underline text-body popupwin">{#membership#}</a> {#accept#}.
                                </label>
                            </div>
                        </div>
                        <div class="col-12 mb-1" v-if="FORM_FIELDS.pageData.displayKvkk">
                            <div class="w-100 popover-wrapper position-relative">
                                <input type="checkbox" name="kvkk" :id="'kvkk_' + BLOCK.ID" value="1" class="form-control" :checked="DETAIL_INFO.kvkk == '1'">
                                <label :for="'kvkk_' + BLOCK.ID" :id="'label_kvkk_' + BLOCK.ID">
                                    <span class="input-checkbox">
                                        <i class="ti-check"></i>
                                    </span>
                                    <a :href="FORM_FIELDS.pageData.kvkkUrl" class="text-underline text-body popupwin">{#kvkk#}</a> {#accept#}.
                                </label>
                            </div>
                        </div>
                    </div>
                    <div class="w-100" v-else>
                        <input type="hidden" name="mail_notify" v-model="FORM_FIELDS.account.isCheckedMail">
                        <input type="hidden" name="sms_notify" v-model="FORM_FIELDS.account.isCheckedSms">
                        <input type="hidden" name="phone_notify" v-model="FORM_FIELDS.account.isCheckedPhone">
                        <input type="hidden" name="kvkk" v-model="DETAIL_INFO.kvkk">
                    </div>
                    <div class="col-12 mb-1" v-if="IS_MEMBER_LOGGED_IN === true">
                        <button type="submit" :id="'register-form-btn-' + BLOCK.ID" class="btn btn-primary w-100">{#update#}</button>
                    </div>
                    <div class="col-12" v-else>
                        <div class="row">
                            <div class="col-12 mb-1">
                                <button type="submit" :id="'register-form-btn-' + BLOCK.ID" class="btn btn-primary w-100">{#register#}</button>
                            </div>
                            <div class="col-12 mb-1 text-center fw-bold"
                                 v-if="FORM_FIELDS.social.displayFacebook == 1 || FORM_FIELDS.social.displayGoogle == 1 || FORM_FIELDS.social.displayApple == 1">
                                veya
                            </div>
                            <div class="col-4 mb-1" v-if="FORM_FIELDS.social.displayFacebook == 1">
                                <a href="/srv/service/social/facebook/login" class="btn fb-register-btn w-100"><i class="ti-facebook mr-1"></i>{#register#}</a>
                            </div>
                            <div class="col-4 mb-1" v-if="FORM_FIELDS.social.displayGoogle == 1">
                                <a id="signinGoogle" href="javascript:void(0)" class="btn google-register-btn w-100"><i class="ti-google mr-1"></i>{#register#}</a>
                            </div>
                            <div class="col-4 mb-1" v-if="FORM_FIELDS.social.displayApple == 1">
                                <a href="/api/v1/authentication/social-login?type=apple&ajax=1" class="btn apple-register-btn w-100"><i class="ti-apple mr-1"></i>{#register#}</a>
                            </div>
                        </div>
                    </div>
                    <div class="col-12" v-html="FORM_FIELDS.pageData.privacyMessage"></div>
                </form>
            </div>
            <div class="col-12 col-md-6" v-if="IS_MEMBER_LOGGED_IN === true">
                <form action="#" method="POST" enctype="multipart/form-data" autocomplete="off" class="w-100 py-1 bg-white border border-light border-round"
                      :id="'member-updpass-form' + BLOCK.ID"
                      ref="memberUpdpass" @submit.prevent="updatePassword" novalidate>
                    <div class="col-12 mb-1">
                        <div class="w-100 border-bottom position-relative fw-bold text-body section-title">{#password_info#}</div>
                    </div>
                    <div class="col-12 mb-1">
                        <div class="w-100 mb-1 popover-wrapper input-group">
                            <input type="password" name="password_old" class="form-control form-control-md" placeholder="{#current_password#}" :data-validate="'required,min:6'">
                            <div class="input-group-append no-animate">
                                <i class="ti-eye-off text-light" @click="toggleVisiblePassword($event)"></i>
                            </div>
                        </div>
                    </div>
                    <div class="col-12 mb-1">
                        <div class="w-100 popover-wrapper input-group">
                            <input type="password" name="password_new" class="form-control form-control-md" placeholder="{#new_password#}" :data-validate="'required,min:6'">
                            <div class="input-group-append no-animate">
                                <i class="ti-eye-off text-light" @click="toggleVisiblePassword($event)"></i>
                            </div>
                        </div>
                    </div>
                    <div class="col-12 mb-1">
                        <div class="w-100 popover-wrapper input-group">
                            <input type="password" name="password_new_again" class="form-control form-control-md" placeholder="{#again_new_password#}" :data-validate="'required,min:6'">
                            <div class="input-group-append no-animate">
                                <i class="ti-eye-off text-light" @click="toggleVisiblePassword($event)"></i>
                            </div>
                        </div>
                    </div>
                    <div class="col-12 mb-1">
                        <button type="submit" :id="'updpass-form-btn-' + BLOCK.ID" class="btn btn-primary w-100">{#update#}</button>
                    </div>
                </form>
                <div class="w-100 mt-2">
                    <div class="w-100 py-1 bg-white border border-light border-round">
                        <div class="col-12 mb-1">
                            <div class="w-100 border-bottom position-relative fw-bold text-body section-title">{#agreement_setting#}</div>
                        </div>
                        <div class="col-12 mb-1">
                            <div class="w-100 popover-wrapper position-relative">
                                <input type="checkbox" name="mail_notify" :id="'mail_notify_' + BLOCK.ID" value="1" class="form-control" 
                                    :checked="FORM_FIELDS.account.isCheckedMail == '1'"
                                    @change="FORM_FIELDS.account.isCheckedMail = FORM_FIELDS.account.isCheckedMail == '1' ? '0' : '1'">
                                <label :for="'mail_notify_' + BLOCK.ID" :id="'label_mail_notify_' + BLOCK.ID">
                                    <span class="input-checkbox">
                                        <i class="ti-check"></i>
                                    </span>
                                    {#send_info#} <a :href="FORM_FIELDS.pageData.emailContactUrl" class="text-underline text-body popupwin">{#email#}</a> {#get#}
                                </label>
                            </div>
                        </div>
                        <div class="col-12 mb-1">
                            <div class="w-100 popover-wrapper position-relative">
                                <input type="checkbox" name="sms_notify" :id="'sms_notify_' + BLOCK.ID" value="1" class="form-control"
                                :checked="FORM_FIELDS.account.isCheckedSms == '1'"
                                @change="FORM_FIELDS.account.isCheckedSms = FORM_FIELDS.account.isCheckedSms == '1' ? '0' : '1'">
                                <label :for="'sms_notify_' + BLOCK.ID" :id="'label_sms_notify_' + BLOCK.ID">
                                    <span class="input-checkbox">
                                        <i class="ti-check"></i>
                                    </span>
                                    {#send_info#} <a :href="FORM_FIELDS.pageData.smsContactUrl" class="text-underline text-body popupwin">sms</a> {#get#}
                                </label>
                            </div>
                        </div>
                        <div class="col-12 mb-1">
                            <div class="w-100 popover-wrapper position-relative">
                                <input type="checkbox" name="phone_notify" :id="'phone_notify_' + BLOCK.ID" value="1" class="form-control" 
                                :checked="FORM_FIELDS.account.isCheckedPhone == '1'"
                                @change="FORM_FIELDS.account.isCheckedPhone = FORM_FIELDS.account.isCheckedPhone == '1' ? '0' : '1'">
                                <label :for="'phone_notify_' + BLOCK.ID" :id="'label_phone_notify_' + BLOCK.ID">
                                    <span class="input-checkbox">
                                        <i class="ti-check"></i>
                                    </span>
                                    {#send_info#} <a :href="FORM_FIELDS.pageData.phoneContactUrl" class="text-underline text-body popupwin">{#call#}</a> {#get#}
                                </label>
                            </div>
                        </div>
                        <div class="col-12 mb-1" v-if="FORM_FIELDS.pageData.displayPrivacy">
                            <div class="w-100 popover-wrapper position-relative">
                                <input type="checkbox" name="privacy" :id="'privacy_' + BLOCK.ID" value="1" class="form-control" :checked="FORM_FIELDS.pageData.displayPrivacy == true">
                                <label :for="'privacy_' + BLOCK.ID" :id="'label_privacy_' + BLOCK.ID">
                                    <span class="input-checkbox">
                                        <i class="ti-check"></i>
                                    </span>
                                    <a :href="FORM_FIELDS.pageData.membershipUrl" class="text-underline text-body popupwin">{#membership#}</a> {#accept#}
                                </label>
                            </div>
                        </div>
                        <div class="col-12 mb-1" v-if="FORM_FIELDS.pageData.displayKvkk">
                            <div class="w-100 popover-wrapper position-relative">
                                <input type="checkbox" name="kvkk" :id="'kvkk_' + BLOCK.ID" value="1" class="form-control" :checked="DETAIL_INFO.kvkk == '1'"
                                disabled v-if="DETAIL_INFO.kvkk">
                                <input type="checkbox" name="kvkk" :id="'kvkk_' + BLOCK.ID" value="1" class="form-control" :checked="DETAIL_INFO.kvkk == '1'"
                                @change="DETAIL_INFO.kvkk = DETAIL_INFO.kvkk == '1' ? '0' : '1'" v-else>
                                <label :for="'kvkk_' + BLOCK.ID" :id="'label_kvkk_' + BLOCK.ID">
                                    <span class="input-checkbox">
                                        <i class="ti-check"></i>
                                    </span>
                                    <a :href="FORM_FIELDS.pageData.kvkkUrl" class="text-underline text-body popupwin">{#kvkk#}</a> {#accept#}
                                </label>
                                <div v-if="IS_MEMBER_LOGGED_IN === true && FORM_FIELDS.account.isKvkkExpired == 1" class="p-1 bg-warning text-body">
                                    {#kvkk_agreement#}
                                </div>
                            </div>
                        </div>
                        <div class="col-12 mb-1">
                            <button type="button" class="btn btn-primary w-100" @click="saveForm($event)">{#update#}</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>