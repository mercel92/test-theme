<div class="col-12 mt-2 mb-3">
    <div class="row">
        {if $SETTING.INFO|replace:' ':'' != ''}
            <div class="col-12 col-lg-6 mb-1 order-2">
                <div class="w-100 h-100">
                    {$SETTING.INFO}
                </div>
            </div>
        {/if}
        <div class="col-12 {if $SETTING.INFO|replace:' ':'' != ''} col-lg-6{/if} mb-1">
            <div class="w-100 h-100 p-2 border border-round">
				{if $SETTING.DISPLAY_TITLE==1}
                <h1 class="w-100 mb-1 block-title text-primary border-bottom">
                    {#order_by_phone#}
                </h1>
				{/if}
                <div class="col-12">
                    <div class="row">
                        <form id="{$BLOCK.ID}" action="/srv/service/guest/order-by-telephone" method="POST" novalidate autocomplete="off" class="w-100">
                            <div class="row">
                                <div class="col-12 col-md-6">
                                    <div class="w-100 mb-1">
                                        <label for="fullname-{$BLOCK.ID}">{#fullname#} *</label>
                                        <div class="w-100 popover-wrapper position-relative">
                                            <input type="text" name="fullname" id="fullname-{$BLOCK.ID}" placeholder="{#fullname#}" class="form-control form-control-md" data-validate="required">
                                        </div>
                                    </div>
                                    <div class="w-100 mb-1">
                                        <label for="email-{$BLOCK.ID}">{#email#} *</label>
                                        <div class="w-100 popover-wrapper position-relative">
                                            <input type="email" name="email" id="email-{$BLOCK.ID}" placeholder="{#email#}" class="form-control form-control-md" data-validate="required,email">
                                        </div>
                                    </div>
                                    <div class="w-100 mb-1">
                                        <label for="phone-{$BLOCK.ID}">{#phone#} *</label>
                                        <div class="w-100 popover-wrapper position-relative">
                                            <input type="tel" name="phone" id="phone-{$BLOCK.ID}" placeholder="{#phone#}" class="form-control form-control-md" data-flag-masked data-validate="required,phone">
                                        </div>
                                    </div>
                                    <div class="w-100 mb-1">
                                        <label for="business_phone-{$BLOCK.ID}">{#home_buisness_phone#}</label>
                                        <div class="w-100 popover-wrapper position-relative">
                                            <input type="tel" name="business_phone" id="business_phone-{$BLOCK.ID}" placeholder="{#home_buisness_phone#}" class="form-control form-control-md" data-flag-masked>
                                        </div>
                                    </div>
                                    <div class="w-100 mb-1">
                                        <label for="date-{$BLOCK.ID}">{#call_day#} *</label>
                                        <div class="w-100 popover-wrapper position-relative">
                                            <input type="text" name="date" id="date-{$BLOCK.ID}" placeholder="{#call_day#}" class="form-control form-control-md" data-validate="required">
                                        </div>
                                    </div>
                                </div>
                                <div class="col-12 col-md-6">
                                    <div class="w-100 mb-1">
                                        <label for="hour-{$BLOCK.ID}">{#choose_hour#} *</label>
                                        <div class="w-100 popover-wrapper position-relative">
                                            <select id="hour-{$BLOCK.ID}" class="form-control form-control-md" data-validate="required" disabled>
                                                <option value="">{#choose_hour#}</option>
                                                <option value="09:00 - 10:00">09:00 - 10:00</option>
                                                <option value="10:00 - 11:00">10:00 - 11:00</option>
                                                <option value="11:00 - 12:00">11:00 - 12:00</option>
                                                <option value="12:00 - 13:00">12:00 - 13:00</option>
                                                <option value="13:00 - 14:00">13:00 - 14:00</option>
                                                <option value="14:00 - 15:00">14:00 - 15:00</option>
                                                <option value="15:00 - 16:00">15:00 - 16:00</option>
                                                <option value="16:00 - 17:00">16:00 - 17:00</option>
                                                <option value="17:00 - 18:00">17:00 - 18:00</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="w-100 mb-1">
                                        <label for="product_name-{$BLOCK.ID}">{#product_of_interest#} *</label>
                                        <div class="w-100 popover-wrapper position-relative">
                                            <textarea name="product_name" id="product_name-{$BLOCK.ID}" placeholder="{#product_of_interest#}" class="form-control form-control-md" data-validate="required"></textarea>
                                        </div>
                                    </div>
                                    <div class="w-100 mb-1">
                                        <label for="information-{$BLOCK.ID}">{#get_information#}</label>
                                        <div class="w-100 popover-wrapper position-relative">
                                            <textarea name="information" id="information-{$BLOCK.ID}" placeholder="{#get_information#}" class="form-control form-control-md"></textarea>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <div class="w-100 input-group popover-wrapper position-relative mb-1">
                                        <div class="input-group-prepend">
                                            <img src="/SecCode.php" id="captcha-{$BLOCK.ID}" alt="Sec Code">
                                        </div>
                                        <input type="text" name="captcha" id="seccode-{$BLOCK.ID}" class="form-control form-control-md" placeholder="{#security_code#}">
                                        <div id="reload-captcha-{$BLOCK.ID}" class="input-group-append">
                                            <i class="ti-cw text-primary"></i>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <div class="row">
                                        <div class="col-12">
                                            <button type="submit" id="send-{$BLOCK.ID}" class="w-100 btn btn-primary">{#apply#}</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>