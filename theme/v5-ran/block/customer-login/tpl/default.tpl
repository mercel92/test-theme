<div class="col-12">
    <div class="row mx-0 mb-1">
    {if $IS_ACTIVATION_SUCCESS == 1}
        activation_success
    {elseif $IS_ACTIVATION_FAIL == 1}
        activation_error
    {else}
        {if $IS_MEMBER_LOGGED_IN == 1}
            <div class="w-100 member-page-buttons">
                <div class="row">
                    <div class="col-12 col-md-3 col-lg-2">
                        <div class="w-100 pt-1 member-quick-menu">
                            <div class="col-12 bg-light position-relative member-avatar">
                                <a href="/{url type='page' id='10'}" class="edit-info-btn text-gray position-absolute d-none d-md-inline-flex align-items-center bg-white border border-light px-1">
                                    <i class="ti-pencil"></i> {#edit#}
                                </a>
                                <div class="row">
                                    <div class="col-9 py-1 col-md-12 text-body d-flex align-items-center">
                                        <i class="ti-user mr-1 mr-md-0 d-flex align-items-center justify-content-center text-gray"></i>
                                        <div class="d-inline-block d-md-block">
                                            <span class="d-block member-name">{$MEMBER.NAME} {$MEMBER.SURNAME}</span>
                                            <span class="d-block member-email text-primary">{$MEMBER.EMAIL}</span>
                                        </div>
                                    </div>
                                    <a href="javascript:void(0);" class="col-3 py-2 logout text-gray border-left border-light d-flex flex-wrap align-items-center justify-content-center d-md-none">
                                        <i class="ti-power-off ti-20px d-block w-100 text-center"></i> {#logout#}
                                    </a>
                                </div>
                            </div>
                            <ul class="col-12 d-flex flex-wrap border border-light border-top-0 list-style-none">
                                <li class="col-6 col-md-12">
                                    <a href="/{url type='page' id='10'}" class="w-100 py-1 d-flex align-items-center text-body">
                                        <i class="ti-user ti-20px mr-1 member-avatar-icon"></i>
                                        <span>{#personel_informations#}</span>
                                    </a>
                                </li>
                                {if $IS_MESSAGE_ACTIVE==1}
                                    <li class="col-6 col-md-12">
                                        <a href="/{url type='page' id='75'}" class="w-100 py-1 d-flex align-items-center text-body">
                                            <i class="ti-chat-alt ti-20px mr-1 member-avatar-icon"></i>
                                            <span>{#messages#}</span>
                                        </a>
                                    </li>
                                {/if}
                                <li class="col-6 col-md-12 d-none d-md-block">
                                    <a href="#" class="w-100 py-1 d-flex align-items-center text-body logout">
                                        <i class="ti-power-off ti-20px mr-1"></i>
                                        <span>{#logout#}</span>
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-12 col-md-9 col-lg-10">
                        <div class="row">
                            <div class="col-12 col-md-6 py-1 col-desktop-half">
                                <div class=" d-flex align-items-center w-100 h-100 bg-light">
                                    <form method="POST" autocomplete="off" action="/{url type='page' id='92'}" class="w-100 p-2 order-tracking">
                                        <input type="hidden" name="email" value="{$MEMBER.EMAIL}">
                                        <label for="order-tracking-input" class="fw-regular text-body d-none d-md-block order-tracking-input">
                                            <i class="ti-box"></i> {#order_entry#}
                                        </label>
                                        <div class="row">
                                            <div class="col-8 col-md-9 pr-0">
                                                <input type="text" class="form-control form-control-md" placeholder="{#order_number#} :" name="order" required id="order-tracking-input">
                                            </div>
                                            <div class="col-4 col-md-3 pl-0">
                                                <button type="submit" class="btn btn-dark w-100 h-100 text-uppercase p-0">{#search#}</button>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                            <div class="col-4 col-md-3 py-1 col-desktop-five">
                                <a href="/{url type='page' id='4'}"
                                    class="w-100 px-1 py-2 d-flex align-items-center justify-content-center border border-light text-gray member-menu-btn">
                                    <i class="ti-basket-outline ti-20px text-body member-menu-icon"></i>
                                    <strong>{#orders#}</strong>
                                </a>
                            </div>
                            <div class="col-4 col-md-3 py-1 col-desktop-five">
                                <a href="/{url type='page' id='35'}"
                                    class="w-100 px-1 py-2 d-flex align-items-center justify-content-center border border-light text-gray member-menu-btn">
                                    <i class="ti-heart-o ti-20px text-body member-menu-icon"></i>
                                    <strong>{#favorite#}</strong>
                                </a>
                            </div>
                            <div class="col-4 col-md-3 py-1 col-desktop-five">
                                <a href="/{url type='page' id='71'}"
                                    class="w-100 px-1 py-2 d-flex align-items-center justify-content-center border border-light text-gray member-menu-btn">
                                    <i class="ti-gift ti-20px text-body member-menu-icon"></i>
                                    <strong>{#gift_cards#}</strong>
                                </a>
                            </div>
                            <div class="col-4 col-md-3 py-1 col-desktop-five">
                                <a href="/{url type='page' id='85'}"
                                    class="w-100 px-1 py-2 d-flex align-items-center justify-content-center border border-light text-gray member-menu-btn">
                                    <i class="ti-location ti-20px text-body member-menu-icon"></i>
                                    <strong>{#your_addresses#}</strong>
                                </a>
                            </div>
                            {if $IS_COMMENT_POINTS_ACTIVE}
                                <div class="col-4 col-md-3 py-1 col-desktop-five">
                                    <a href="/{url type='page' id='70'}"
                                        class="w-100 px-1 py-2 d-flex align-items-center justify-content-center border border-light text-gray member-menu-btn">
                                        <i class="ti-database ti-20px text-body member-menu-icon"></i>
                                        <strong>{#my_points#}</strong>
                                    </a>
                                </div>
                            {/if}
                            <div class="col-4 col-md-3 py-1 col-desktop-five">
                                <a href="/{url type='page' id='87'}"
                                    class="w-100 px-1 py-2 d-flex align-items-center justify-content-center border border-light text-gray member-menu-btn">
                                    <i class="ti-bell ti-20px text-body member-menu-icon"></i>
                                    <strong>{#my_stock_alarm_list#}</strong>
                                </a>
                            </div>
                            <div class="col-4 col-md-3 py-1 col-desktop-five">
                                <a href="/{url type='page' id='80'}"
                                    class="w-100 px-1 py-2 d-flex align-items-center justify-content-center border border-light text-gray member-menu-btn">
                                    <i class="ti-dollar ti-20px text-body member-menu-icon"></i>
                                    <strong>{#referral_notice#}</strong>
                                </a>
                            </div>
                            <div class="col-4 col-md-3 py-1 col-desktop-five">
                                <a href="/{url type='page' id='86'}"
                                    class="w-100 px-1 py-2 d-flex align-items-center justify-content-center border border-light text-gray member-menu-btn">
                                    <i class="ti-bell-o ti-20px text-body member-menu-icon"></i>
                                    <strong>{#my_price_alarm_list#}</strong>
                                </a>
                            </div>
                            {if $IS_CURRENT_ACCOUNT_ACTIVE==1}
                                <div class="col-4 col-md-3 py-1 col-desktop-five">
                                    <a href="/{url type='page' id='90'}"
                                        class="w-100 px-1 py-2 d-flex align-items-center justify-content-center border border-light text-gray member-menu-btn">
                                        <i class="ti-credit-card-alt ti-20px text-body member-menu-icon"></i>
                                        <strong>{#payment_with_credit_card#}</strong>
                                    </a>
                                </div>
                                <div class="col-4 col-md-3 py-1 col-desktop-five">
                                    <a href="/{url type='page' id='29'}"
                                        class="w-100 px-1 py-2 d-flex align-items-center justify-content-center border border-light text-gray member-menu-btn">
                                        <i class="ti-clipboard ti-20px text-body member-menu-icon"></i>
                                        <strong>{#current_transactions_cari#}</strong>
                                    </a>
                                </div>
                            {/if}
                            {if $DISPLAY_DELETE_MEMBER == 1}
                                <div class="col-4 col-md-3 py-1 col-desktop-five">
                                    <a href="/srv/service/content-v5/sub-folder/{$PAGE_ID}/{$BLOCK.PARENT_ID}/cancel-me/" data-width="570"
                                        class="w-100 px-1 py-2 d-flex align-items-center justify-content-center popupwin border border-light text-gray member-menu-btn">
                                        <i class="ti-user-delete ti-20px text-body member-menu-icon"></i>
                                        <strong>{#member_cancel#}</strong>
                                    </a>
                                </div>
                            {/if}
                            {if $SUBSCRIBE === 1}
                                <div class="col-4 col-md-3 py-1 col-desktop-five">
                                    <a href="/{url type='page' id='123'}"
                                        class="w-100 px-1 py-2 d-flex align-items-center justify-content-center border border-light text-gray member-menu-btn">
                                        <i class="ti-calendar ti-20px text-body member-menu-icon"></i>
                                        <strong>{#my_subscription_products#}</strong>
                                    </a>
                                </div>
                            {/if}
                        </div>
                    </div>
                </div>
            </div>
        {else}
            <div class="col-12 col-md-8 col-lg-6 py-2 px-3 border border-light border-round mx-auto my-2">
                <div class="row">
                    <ul id="ug-login-tab" class="w-100 tab-nav list-style-none">
                        <li class="active"><a href="#login-form-{$BLOCK.ID}" data-toggle="tab">{#member_login#}</a></li>
                        {if $IS_LOGIN_WITHOUT_MEMBERSHIP_ACTIVE == 1}
                            <li>
                                <a href="#register-form-{$BLOCK.ID}" data-toggle="tab">
                                    {if $SHOW_CONTINUE_WITHOUT_MEMBERSHIP==1}{#sign_up#}{else}{#nonmember_shopping#}{/if}
                                </a>
                            </li>
                            {if $SHOW_CONTINUE_WITHOUT_MEMBERSHIP==1}
                                <li><a href="#membership-form-{$BLOCK.ID}" data-toggle="tab">{#continue_without_membership#}</a></li>
                            {/if}
                        {else}
                            <li><a href="/{url type='page' id='6'}">{#member_register#}</a></li>
                        {/if}
                    </ul>
                    <div class="col-12 px-0 mt-2 tab-content">
                        <form action="#" method="POST" id="login-form-{$BLOCK.ID}" class="w-100 tab-pane active" data-toggle="login-form" data-prefix="ug-" data-callback="ugMemberLoginFn" novalidate>
                            {if $PAGE_ID == 64} <input type="hidden" id="ug-redirect" name="redirect" value="order"> {/if}
                            {if $LICENCE_REGISTRATION_WITH_PHONE == 1}
                                <div class="row mb-2">
                                    <ul id="ug-login-type" class="w-100 d-flex tab-nav list-style-none">
                                        <li class="col-6 active" data-type="email">
                                            <a href="#login-with-email-{$BLOCK.ID}" data-toggle="tab" class="btn w-100 login-type-item">{#mail_login#}</a>
                                        </li>
                                        <li class="col-6" data-type="phone">
                                            <a href="#login-with-phone-{$BLOCK.ID}" data-toggle="tab" class="btn w-100 login-type-item">{#phone_login#}</a>
                                        </li>
                                    </ul>
                                </div>
                            {/if}
                            <div class="row">
                                <div class="col-12 mb-1 tab-content">
                                    <div id="login-with-email-{$BLOCK.ID}" class="w-100 tab-pane active">
                                        <div class="w-100 popover-wrapper position-relative">
                                            <input type="email" id="ug-email" name="email" class="form-control form-control-md" placeholder="{#enter_mail#}" data-toggle="placeholder">
                                        </div>
                                    </div>
                                    {if $LICENCE_REGISTRATION_WITH_PHONE == 1}
                                    <div id="login-with-phone-{$BLOCK.ID}" class="w-100 tab-pane">
                                        <div class="w-100 popover-wrapper position-relative">
                                            <input type="tel" id="ug-phone" name="phone" class="form-control form-control-md" placeholder="{#enter_phone_number#}" data-toggle="placeholder" data-flag-masked>
                                        </div>
                                    </div>
                                    {/if}
                                </div>
                                <div class="col-12 mb-1">
                                    <div class="w-100 popover-wrapper input-group">
                                        <input type="password" id="ug-password" name="password" class="form-control form-control-md" placeholder="{#enter_password#}">
                                        <div class="input-group-append no-animate">
                                            <i class="ti-eye-off text-gray" id="toggleVisiblePassword{$BLOCK.ID}"></i>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-12 d-flex flex-wrap justify-content-between">
                                    <input type="checkbox" id="ug-remember" name="ug-remember" class="form-control">
                                    <label for="ug-remember" class="mb-1 d-flex align-items-center fw-regular">
                                        <span class="input-checkbox">
                                            <i class="ti-check"></i>
                                        </span>
                                        {#remember_me#}
                                    </label>
                                    <a href="/{url type='page' id='7'}" class="text-gray mb-1">{#forgot_password#}</a>
                                </div>
                                <div class="col-12">
                                    <div class="row">
                                        <div class="col-12 col-md-6 mb-1">
                                            <button type="submit" id="ug-submit-btn" class="w-100 btn btn-primary text-uppercase">{#login#}</button>
                                        </div>
                                        {if $SETTING.FACEBOOK_LOGIN == 1 || $SETTING.GOOGLE_LOGIN == 1 || $SETTING.APPLE_LOGIN == 1}
                                            <div class="col-12">
                                                <div class="row">
                                                    {if $SETTING.FACEBOOK_LOGIN == 1}
                                                    <div class="col-4 mb-1">
                                                        <a href="/srv/service/social/facebook/login" class="fb-login-btn">
                                                            <i class="ti-facebook"></i> {#connect_with#}
                                                        </a>
                                                    </div>
                                                    {/if}
                                                    {if $SETTING.GOOGLE_LOGIN == 1}
                                                    <div class="col-4 mb-1">
                                                        <a id="signinGoogle" href="javascript:void(0)" class="google-login-btn">
                                                            <i class="ti-google"></i> {#connect_with#}
                                                        </a>
                                                    </div>
                                                    {/if}
                                                    {if $SETTING.APPLE_LOGIN == 1}
                                                    <div class="col-4 mb-1">
                                                        <a href="/api/v1/authentication/social-login?type=apple&ajax=1" class="apple-login-btn">
                                                            <i class="ti-apple"></i> {#connect_with#}
                                                        </a>
                                                    </div>
                                                    {/if}
                                                </div>
                                            </div>
                                        {/if}
                                    </div>
                                </div>
                            </div>
                        </form>
                        {if $IS_LOGIN_WITHOUT_MEMBERSHIP_ACTIVE == 1}
                            <div id="register-form-{$BLOCK.ID}" class="w-100 tab-pane">
                                <form action="/api/v1/authentication/register/quick" method="POST" novalidate class="w-100 d-flex flex-wrap">
                                    <div class="col-12 pl-0">
                                        <div class="row">
                                            <div class="col-12 col-md-6 mb-1 pr-0">
                                                <div class="w-100 popover-wrapper position-relative">
                                                    <input type="text" name="name" class="form-control form-control-md" placeholder="{#name#}" data-toggle="placeholder" data-validate="required">
                                                </div>
                                            </div>
                                            <div class="col-12 col-md-6 mb-1 pr-0">
                                                <div class="w-100 popover-wrapper position-relative">
                                                    <input type="text" name="surname" class="form-control form-control-md" placeholder="{#surname#}" data-toggle="placeholder" data-validate="required">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-12 px-0 mb-1">
                                        <div class="w-100 popover-wrapper position-relative">
                                            <input type="email" name="email" class="form-control form-control-md" placeholder="{#email#}" autocapitalize="off" data-toggle="placeholder" data-validate="required,email">
                                        </div>
                                    </div>
                                    {if $SHOW_CONTINUE_WITHOUT_MEMBERSHIP == 1}
                                        <div class="col-12 px-0 mb-1">
                                            <div class="w-100 popover-wrapper position-relative">
                                                <input type="password" name="password" class="form-control form-control-md" placeholder="{#password#}" data-toggle="placeholder" data-validate="required">
                                            </div>
                                        </div>
                                    {/if}
                                    <div class="col-12 px-0 mb-1">
                                        <div class="w-100 popover-wrapper position-relative">
                                            <input type="tel" name="mobile_phone" class="form-control form-control-md" placeholder="{#mobile_phone#}" data-toggle="placeholder" data-flag-masked>
                                        </div>
                                    </div>
                                    <div class="col-12 px-0 mb-1">
                                        <div class="w-100 popover-wrapper position-relative">
                                            <input type="checkbox" name="mail_notify" id="mail_notify_{$BLOCK.ID}" value="1" class="form-control">
                                            <label for="mail_notify_{$BLOCK.ID}" class="fw-regular">
                                                <span class="input-checkbox">
                                                    <i class="ti-check"></i>
                                                </span>
                                                <a href="{$EMAIL_CONTRACT_URL}" class="text-underline text-body popupwin">{#notify_only#}</a> {#mail_notify#}.
                                            </label>
                                        </div>
                                    </div>
                                    <div class="col-12 px-0 mb-1">
                                        <div class="w-100 popover-wrapper position-relative">
                                            <input type="checkbox" name="sms_notify" id="sms_notify_{$BLOCK.ID}" value="1" class="form-control">
                                            <label for="sms_notify_{$BLOCK.ID}" class="fw-regular">
                                                <span class="input-checkbox">
                                                    <i class="ti-check"></i>
                                                </span>
                                                <a href="{$SMS_CONTRACT_URL}" class="text-underline text-body popupwin">{#notify_only#}</a> {#sms_notify#}.
                                            </label>
                                        </div>
                                    </div>
                                    <div class="col-12 px-0 mb-1">
                                        <div class="w-100 popover-wrapper position-relative">
                                            <input type="checkbox" name="phone_notify" id="phone_notify_{$BLOCK.ID}" value="1" class="form-control">
                                            <label for="phone_notify_{$BLOCK.ID}" class="fw-regular">
                                                <span class="input-checkbox">
                                                    <i class="ti-check"></i>
                                                </span>
                                                <a href="{$PHONE_CONTRACT_URL}" class="text-underline text-body popupwin">{#notify_only#}</a> {#phone_notify#}.
                                            </label>
                                        </div>
                                    </div>
                                    {if $DISPLAY_PRIVACY}
                                        <div class="col-12 px-0 mb-1">
                                            <div class="w-100 popover-wrapper position-relative">
                                                <input type="checkbox" name="privacy" id="privacy_{$BLOCK.ID}" value="1" class="form-control">
                                                <label for="privacy_{$BLOCK.ID}" class="fw-regular">
                                                    <span class="input-checkbox">
                                                        <i class="ti-check"></i>
                                                    </span>
                                                    <a href="{$MEMBERSHIP_URL}" class="text-underline text-body popupwin">{#membership#}</a> {#accept#}.
                                                </label>
                                            </div>
                                        </div>
                                    {/if}
                                    {if $SETTING.DISPLAY_KVKK}
                                        <div class="col-12 px-0 mb-1">
                                            <div class="w-100 popover-wrapper position-relative">
                                                <input type="checkbox" name="kvkk" id="kvkk_{$BLOCK.ID}" value="1"
                                                    class="form-control">
                                                <label for="kvkk_{$BLOCK.ID}" class="fw-regular">
                                                    <span class="input-checkbox">
                                                        <i class="ti-check"></i>
                                                    </span>
                                                    <a href="{$KVKK_URL}" class="text-underline text-body popupwin">{#kvkk#}</a> {#accept#}.
                                                </label>
                                            </div>
                                            {if $IS_MEMBER_LOGGED_IN==1 && $IS_KVKK_EXPIRED == 1}
                                                <div class="w-100 pt-1">{#kvkk_agreement#}.</div>
                                            {/if}
                                        </div>
                                    {/if}
                                    <div class="col-12 px-0">
                                        <button type="submit" class="d-block btn btn-primary text-uppercase px-2">{#register#}</button>
                                    </div>
                                    <input type="hidden" name="quick" value="1">
                                </form>
                            </div>
                            {if $SHOW_CONTINUE_WITHOUT_MEMBERSHIP==1}
                                <div id="membership-form-{$BLOCK.ID}" class="w-100 tab-pane">
                                    <form action="/api/v1/authentication/login-nomembership" method="POST" novalidate class="w-100 d-flex flex-wrap">
                                        <div class="col-12 px-0 mb-1">
                                            <div class="w-100 popover-wrapper position-relative">
                                                <input type="email" id="without-email-{$BLOCK.ID}" name="email" class="form-control form-control-md" placeholder="{#email#}" autocapitalize="off" data-toggle="placeholder"  data-validate="required,email">
                                            </div>
                                        </div>
                                        <div class="col-12 px-0">
                                            <button type="submit" class="d-block btn btn-primary text-uppercase px-2">{#continue_without_membership#}</button>
                                        </div>
                                    </form>
                                </div>
                            {/if}
                        {/if}
                    </div>
                </div>
            </div>
            {/if}
        {/if}
    </div>
</div>