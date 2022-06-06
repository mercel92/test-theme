<div class="col-12 mb-3">
    {if $SETTING.DISPLAY_TITLE}
        <div class="block-title no-line">{$BLOCK.TITLE}</div>
    {/if}
    <div class="col-12">
        <div class="row">
            <p class="w-100 m-0 text-gray">{#enter_info#}</p>
            <form id="contact-form-{$BLOCK.ID}" action="/srv/service/guest-v5/send-contact-message/{$BLOCK.ID}" method="POST" novalidate autocomplete="off" class="col-12 mt-1">
                {if $DEPARTMENT_LIST|@count > 0}
                    <div class="row mb-1 popover-wrapper position-relative">
                        <select tabindex="0" name="department" id="contactform-departman-{$BLOCK.ID}" class="form-control form-control-md" data-validate="required">
                            <option value="">{#department#}</option>
                            {foreach from=$DEPARTMENT_LIST item=D}
                                <option value="{$D.ID}">{$D.NAME}</option>
                            {/foreach}
                        </select>
                    </div>
                {/if}
                <div class="row">
                    <div class="col-12 pl-0">
                        <div class="row">
                            <div class="col-12 col-md-6 pr-0 mb-1">
                                <div class="w-100 popover-wrapper position-relative">
                                    <input type="text" name="firstname" id="contactform-firstname-{$BLOCK.ID}" placeholder="{#name#}" class="form-control form-control-md" data-toggle="placeholder"{if $SETTING.IS_REQUIRED_FIRSTNAME} data-validate="required"{/if} autofocus>
                                </div>
                            </div>
                            <div class="col-12 col-md-6 pr-0 mb-1">
                                <div class="w-100 popover-wrapper position-relative">
                                    <input type="text" name="lastname" id="contactform-lastname-{$BLOCK.ID}" placeholder="{#surname#}" class="form-control form-control-md" data-toggle="placeholder"{if $SETTING.IS_REQUIRED_LASTNAME} data-validate="required"{/if}>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row mb-1 popover-wrapper position-relative">
                    <input type="email" name="email" id="contactform-email-{$BLOCK.ID}" placeholder="{#email#}" class="form-control form-control-md" data-toggle="placeholder"{if $SETTING.IS_REQUIRED_EMAIL} data-validate="required,email"{/if}>
                </div>
                <div class="row mb-1 popover-wrapper position-relative">
                    <input type="tel" name="phone" id="contactform-phone-{$BLOCK.ID}" placeholder="{#phone#}" class="form-control form-control-md" data-flag-masked data-toggle="placeholder"{if $SETTING.IS_REQUIRED_PHONE} data-validate="required,phone"{/if}>
                </div>
                <div class="row mb-1 popover-wrapper position-relative">
                    <textarea name="message" id="contactform-message-{$BLOCK.ID}" placeholder="{#message#}" class="form-control form-control-md" data-toggle="placeholder"{if $SETTING.IS_REQUIRED_MESSAGE} data-validate="required"{/if}></textarea>
                </div>
                {if $SETTING.DISPLAY_SECURITY_CODE}
                    <div class="row mb-1 input-group popover-wrapper position-relative">
                        <div class="input-group-prepend captcha-img">
                            <img src="/SecCode.php" id="contactform-captcha-{$BLOCK.ID}" alt="Sec Code"/>
                        </div>
                        <input type="text" name="seccode" id="contactform-seccode-{$BLOCK.ID}" class="form-control form-control-md" placeholder="{#security_code#}">
                        <div id="reload-captcha-{$BLOCK.ID}" class="input-group-append">
                            <i class="ti-cw text-primary"></i>
                        </div>
                    </div>
                {/if}
                {if $SETTING.DISPLAY_PRIVACY_POLICY}
                    <div class="row mb-1 popover-wrapper position-relative">
                        <input type="checkbox" name="privacy" id="contactform-privacy-{$BLOCK.ID}" class="form-control" value="1" data-validate="required">
                        <label for="contactform-privacy-{$BLOCK.ID}" class="fw-regular">
                            <span class="input-checkbox">
                                <i class="ti-check"></i>
                            </span>
                            <a href="/srv/service/content-v5/fixed-page-content/2" class="text-underline text-body popupwin" data-property="CONTENT" title="{#privacy_policy#}">{#privacy_policy#}</a>
                            &nbsp;{#read_and_accept#}
                        </label>
                    </div>
                {/if}
                <div class="row">
                    <div class="w-100 mb-1">
                        <button type="submit" id="contactform-sendbtn-{$BLOCK.ID}" class="w-100 btn btn-md btn-primary">{#submit#}</button>
                    </div>
                    <div class="w-100 text-center">
                        <button type="reset" id="contactform-resetbtn-{$BLOCK.ID}" class="btn text-link p-0">{#reset#}</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>