<div class="w-100 d-flex align-items-center justify-content-center my-3">
    <div class="col-12 col-md-6 col-sm-8">
        <div class="w-100 py-2 px-3 border border-round">
            {if $IS_EMAIL_LINK_PAGE}
                {if $ERROR_LINK}
                    <div>{#link_error_message#}</div>
                {/if}
                {if $IS_LINK_INACTIVE}
                    <div>{#link_is_expired#|replace:'%LINK_PASSWORD%':$PAGE_LINK.MEMBER_PASSWORD_REMINDER}</div>
                {/if}
            {else}
                {if $IS_RESETTOKEN_VALID}
                    <div class="w-100 mb-1 text-uppercase block-title border-bottom">{#change_password#}</div>
                    <form action="/srv/service/customer-v5/reset-password/" id="forgot-reset_password-{$BLOCK.ID}" method="POST" class="w-100" novalidate autocomplete="off">
                        <div class="w-100 popover-wrapper position-relative mb-1">
                            <input type="password" id="password_new-{$BLOCK.ID}" data-title="{#new_password#}" name="password_new" placeholder="{#new_password#}" class="form-control form-control-md" data-toggle="placeholder" data-validate="required">
                        </div>
                        <div class="w-100 popover-wrapper position-relative mb-1">
                            <input type="password" id="password_new_again-{$BLOCK.ID}" data-title="{#repeat_new_password#}" name="password_new_again" placeholder="{#repeat_new_password#}" class="form-control form-control-md" data-toggle="placeholder" data-validate="required">
                        </div>
                        <div class="col-12">
                            <div class="row">
                                <button type="submit" id="forgot-reset_btn-{$BLOCK.ID}" class="btn btn-primary text-uppercase px-2">{#update#}</button>
                            </div>
                        </div>
                    </form>
                    <input type="hidden" name="resetToken" id="reset-token-{$BLOCK.ID}" value="{$RESET_TOKEN}"/> 
                {else}
                    <div class="w-100 mb-1 text-uppercase block-title border-bottom">{#forgot_password#}</div>
                    <form action="/srv/service/customer-v5/forgot-password/" id="forgot-password-{$BLOCK.ID}" method="POST" class="w-100" novalidate autocomplete="off">
                        {if $LICENCE_REGISTRATION_WITH_PHONE == 1}
                            <ul id="forgot-type-{$BLOCK.ID}" class="w-100 tab-nav list-style-none">
                                <li data-type="email" class="active"><a href="#forgot-with-mail-{$BLOCK.ID}" data-toggle="tab">{#with_mail#}</a></li>
                                <li data-type="phone"><a href="#forgot-with-phone-{$BLOCK.ID}" data-toggle="tab">{#with_phone#} </a></li>
                            </ul>
                        {/if}
                        <div class="col-12 px-0 mb-1 tab-content">
                            <div id="forgot-with-mail-{$BLOCK.ID}" class="w-100 tab-pane active">
                                <div class="w-100 popover-wrapper position-relative">
                                    <input type="email" id="email-{$BLOCK.ID}" name="forgot-email" class="form-control form-control-md" placeholder="{#enter_email#}" data-toggle="placeholder" {if $LICENCE_REGISTRATION_WITH_PHONE != 1}data-validate="required,email"{/if}>
                                </div>
                            </div>
                            {if $LICENCE_REGISTRATION_WITH_PHONE == 1}
                            <div id="forgot-with-phone-{$BLOCK.ID}" class="w-100 tab-pane">
                                <div class="w-100 popover-wrapper position-relative">
                                    <input type="tel" id="phone-{$BLOCK.ID}" name="forgot-phone" class="form-control form-control-md" data-flag-masked placeholder="{#enter_phone#}" data-toggle="placeholder">
                                </div>
                            </div>
                            {/if}
                        </div>
                        {if !$CAPTCHA_COUNTER < $SETTING.CAPTCHA_LIMIT}
                            <div class="w-100 input-group popover-wrapper position-relative mb-1">
                                <div class="input-group-prepend">
                                    <img src="/SecCode.php" id="forgot-security-code-img-{$BLOCK.ID}"/>
                                </div>
                                <input type="text" id="forgot-security_code-{$BLOCK.ID}" name="security_code" class="form-control form-control-md" placeholder="{#security_code#}">
                                <div id="forgot-captcha-code-{$BLOCK.ID}" class="input-group-append">
                                    <i class="ti-cw text-primary"></i>
                                </div>
                            </div>
                        {/if}
                        <div class="col-12">
                            <div class="row">
                                <button type="submit" id="forgot-password_btn-{$BLOCK.ID}" class="btn btn-primary text-uppercase px-2">{#password_remind#}</button>
                            </div>
                        </div>
                    </form>
                {/if}
            {/if}
            <input type="hidden" id="is-forgot-https-{$BLOCK.ID}" value="{$IS_HTTPS_ACTIVE}"/>
        </div>
    </div>
</div>