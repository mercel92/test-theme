<div class="col-12 mt-2 mb-3">
    <div class="row">
        {if $SETTING.INFO|replace:' ':'' != ''}
            <div class="col-12 col-lg-6 mb-1 order-2">
                {$SETTING.INFO}
            </div>
        {/if}
        <div class="col-12{if $SETTING.INFO|replace:' ':'' != ''} col-lg-6{/if} mb-1">
            <div class="w-100 h-100 py-3 px-2 border border-round">
                {if $SETTING.DISPLAY_TITLE}
                    <div class="w-100 mb-1 block-title text-primary border-bottom">
                        {$BLOCK.TITLE}
                    </div>
                {/if}
                <div class="col-12">
                    <div class="row">
                        <form id="supplier-form-{$BLOCK.ID}" action="/srv/service/supplier/register" method="POST"
                            novalidate autocomplete="off" class="w-100">
                            <div class="row">
                                <div class="col-12 col-md-6">
                                    <div class="w-100 mb-1">
                                        <label for="title-{$BLOCK.ID}">{#title#} *</label>
                                        <div class="w-100 popover-wrapper position-relative">
                                            <input type="text" name="title" placeholder="{#title#}" id="title-{$BLOCK.ID}" class="form-control form-control-md" data-validate="required">
                                        </div>
                                    </div>
                                    <div class="w-100 mb-1">
                                        <label for="username-{$BLOCK.ID}">{#username#} *</label>
                                        <div class="w-100 popover-wrapper position-relative">
                                            <input type="text" name="username" placeholder="{#username#}" id="username-{$BLOCK.ID}" class="form-control form-control-md" data-validate="required">
                                        </div>
                                    </div>
                                    <div class="w-100 mb-1">
                                        <label for="password-{$BLOCK.ID}">{#password#} *</label>
                                        <div class="w-100 popover-wrapper position-relative">
                                            <input type="password" name="password" placeholder="{#password#}" id="password-{$BLOCK.ID}" class="form-control form-control-md" data-validate="required">
                                        </div>
                                    </div>
                                    <div class="w-100 mb-1">
                                        <label for="email-{$BLOCK.ID}">{#email#} *</label>
                                        <div class="w-100 popover-wrapper position-relative">
                                            <input type="email" name="email" placeholder="{#email#}" id="email-{$BLOCK.ID}" class="form-control form-control-md" data-validate="required,email">
                                        </div>
                                    </div>
                                    <div class="w-100 mb-1">
                                        <label for="mobile_phone-{$BLOCK.ID}">{#mobile_phone#} *</label>
                                        <div class="w-100 popover-wrapper position-relative">
                                            <input type="tel" name="mobile_phone" placeholder="{#mobile_phone#}" id="mobile_phone-{$BLOCK.ID}" class="form-control form-control-md" data-flag-masked data-validate="required,phone">
                                        </div>
                                    </div>
                                    <div class="w-100 mb-1">
                                        <label for="home_phone-{$BLOCK.ID}">{#home_phone#} *</label>
                                        <div class="w-100 popover-wrapper position-relative">
                                            <input type="tel" name="home_phone" placeholder="{#home_phone#}" id="home_phone-{$BLOCK.ID}" class="form-control form-control-md" data-flag-masked data-validate="required,phone">
                                        </div>
                                    </div>
                                    <div class="w-100 mb-1">
                                        <label for="fax-{$BLOCK.ID}">{#fax#} *</label>
                                        <div class="w-100 popover-wrapper position-relative">
                                            <input type="text" name="fax" placeholder="{#fax#}" id="fax-{$BLOCK.ID}" class="form-control form-control-md" data-validate="required">
                                        </div>
                                    </div>
                                    <div class="w-100 mb-1">
                                        <label for="field1-{$BLOCK.ID}">{#field#} *</label>
                                        <div class="w-100 popover-wrapper position-relative">
                                            <input type="text" name="field1" placeholder="{#field#}" id="field1-{$BLOCK.ID}" class="form-control form-control-md" data-validate="required">
                                        </div>
                                    </div>
                                </div>
                                <div class="col-12 col-md-6">
                                    <div class="w-100 mb-1">
                                        <label for="tax_office-{$BLOCK.ID}">{#tax_office#} *</label>
                                        <div class="w-100 popover-wrapper position-relative">
                                            <input type="text" name="tax_office" placeholder="{#tax_office#}" id="tax_office-{$BLOCK.ID}" class="form-control form-control-md" data-validate="required">
                                        </div>
                                    </div>
                                    <div class="w-100 mb-1">
                                        <label for="tax_number-{$BLOCK.ID}">{#tax_number#} *</label>
                                        <div class="w-100 popover-wrapper position-relative">
                                            <input type="text" name="tax_number" placeholder="{#tax_number#}" id="tax_number-{$BLOCK.ID}" class="form-control form-control-md" data-validate="required">
                                        </div>
                                    </div>
                                    <div class="w-100 mb-1">
                                        <label for="authorized_person-{$BLOCK.ID}">{#authorized_person#} *</label>
                                        <div class="w-100 popover-wrapper position-relative">
                                            <input type="text" name="authorized_person" placeholder="{#authorized_person#}" id="authorized_person-{$BLOCK.ID}" class="form-control form-control-md" data-validate="required">
                                        </div>
                                    </div>
                                    <div class="w-100 mb-1">
                                        <label for="iban-{$BLOCK.ID}">{#iban#} *</label>
                                        <div class="w-100 popover-wrapper position-relative">
                                            <input type="text" name="iban" placeholder="{#iban#}" id="iban-{$BLOCK.ID}" class="form-control form-control-md" data-validate="required">
                                        </div>
                                    </div>
                                    <div class="w-100 mb-1">
                                        <label for="city-{$BLOCK.ID}">{#city#} {#choose#} *</label>
                                        <div class="w-100 popover-wrapper position-relative">
                                            <select name="city" id="city-{$BLOCK.ID}" class="form-control form-control-md" data-validate="required">
                                                <option value="">{#city#}</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="w-100 mb-1">
                                        <label for="town-{$BLOCK.ID}">{#town#} {#choose#} *</label>
                                        <div class="w-100 popover-wrapper position-relative">
                                            <select name="town" id="town-{$BLOCK.ID}" class="form-control form-control-md" data-validate="required">
                                                <option value="">{#town#}</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="w-100 mb-1">
                                        <label for="address-{$BLOCK.ID}">{#adress#} *</label>
                                        <div class="w-100 popover-wrapper position-relative">
                                            <textarea name="address" placeholder="{#adress#}" id="address-{$BLOCK.ID}" class="form-control form-control-md" data-validate="required"></textarea>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <button type="submit" id="supplier-form-btn-{$BLOCK.ID}" class="w-100 btn btn-primary text-uppercase">{#apply#}</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>