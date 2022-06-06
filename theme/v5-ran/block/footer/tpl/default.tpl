<footer class="container-fluid">
    <div class="row">
        <div id="footer-top" class="w-100 bg-light border-top border-gray py-3">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-12 col-md-6 py-2">
                        <div class="mb-1 text-center text-md-left">
                            <div class="h5 fw-bold">{#newsletter#}</div>
                            <p class="m-0">{#newsletter_text#}</p>
                        </div>
                        <form id="newsletter-form-{$BLOCK.ID}" class="w-100" novalidate autocomplete="off">
                            <div class="w-100 popover-wrapper position-relative">
                                <input type="email" name="email" id="news_email-{$BLOCK.ID}" class="form-control" placeholder="{#enter_email#}" data-validate="required,email">
                                <button type="submit" id="news_email_btn-{$BLOCK.ID}" class="btn"><i class="ti-mail-o"></i></button>
                            </div>
                            {if $NEWSLETTER_KVKK_ACTIVE}
                                <div class="w-100 popover-wrapper position-relative">
                                    <input type="checkbox" name="kvkk" id="news_sub-kvkk-{$BLOCK.ID}" class="form-control" data-validate="required" value="1">
                                    <label for="news_sub-kvkk-{$BLOCK.ID}" id="label-news_sub-kvkk-{$BLOCK.ID}" class="m-0 fw-regular text-gray">
                                        <span class="input-checkbox">
                                            <i class="ti-check"></i>
                                        </span>
                                        <a href="{$KVKK_URL}" class="text-underline text-body popupwin" title="{#kvkk#}">{#kvkk#}</a>, {#accept#}
                                    </label>
                                </div>
                            {/if}
                        </form>
                    </div>
                    <div class="col-12 col-md-5 ml-auto py-2">
                        <div class="mb-1 text-center text-md-left">
                            <div class="h5 fw-bold">{#social_media#}</div>
                            <p class="m-0">{#social_text#}</p>
                        </div>
                        <ul id="footer-social-list" class="w-100 list-style-none text-center text-md-left">
                            <li class="d-inline-block mr-1">
                                <a href="#" class="bg-white border border-circle d-flex align-items-center justify-content-center text-body text-center">a</a>
                            </li>
                            <li class="d-inline-block mr-1">
                                <a href="#" class="bg-white border border-circle d-flex align-items-center justify-content-center text-body text-center">a</a>
                            </li>
                            <li class="d-inline-block">
                                <a href="#" class="bg-white border border-circle d-flex align-items-center justify-content-center text-body text-center">a</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <div id="footer-main" class="w-100 py-4 border-top border-bottom border-gray">
            <div class="container">
                <div class="row">
                    <nav id="footer-menu" class="col-12">
                        <ul class="row">
                            {foreach from=$MENU item=M}
                                <li class="col-12 col-md-3 menu-item my-1">
                                    <div class="menu-item-wrapper">
                                        <div class="d-flex align-items-center menu-item-title" data-toggle="accordion" data-platform="mobile">
                                            {$M.NAME}
                                            <span class="d-block d-md-none ml-auto">
                                                <i class="ti-plus"></i>
                                                <i class="ti-minus"></i>
                                            </span>
                                        </div>
                                        <ul class="clearfix menu-item-children my-1">
                                            {foreach from=$M.CHILDREN item=CHILD}
                                                <li class="w-100">
                                                    <a href="{$CHILD.URL}" class="menu-link"{if $CHILD.IS_TARGET_BLANK} target="_blank"{/if}>{$CHILD.NAME}</a>
                                                </li>
                                            {/foreach}
                                        </ul>
                                    </div>
                                </li>
                            {/foreach}
                            <li class="col-12 col-md-3 menu-item my-1">
                                <div class="menu-item-wrapper">
                                    <div class="d-flex align-items-center menu-item-title" data-toggle="accordion" data-platform="mobile">
                                        {#address_contact#}
                                        <span class="d-block d-md-none ml-auto">
                                            <i class="ti-plus"></i>
                                            <i class="ti-minus"></i>
                                        </span>
                                    </div>
                                    <ul class="clearfix menu-item-children my-1">
                                        <li class="w-100">
                                            <div class="w-100 menu-link mb-1">
                                                <div class="text-gray"><i class="ti-location mr-1"></i>{#address#}</div>
                                                <address>{$CONTACT_FIRM_ADDRESS}</address>
                                            </div>
                                            <div class="w-100 menu-link mb-1">
                                                <div class="text-gray"><i class="ti-phone mr-1"></i>{#phone_number#}</div>
                                                <a href="tel:{$CONTACT_TELEPHONE|replace:' ':''}" id="footer-phone-link{$BLOCK.ID}" class="menu-link">{$CONTACT_TELEPHONE}</a>
                                            </div>
                                            <div class="w-100 menu-link mb-1">
                                                <div class="text-gray"><i class="ti-mail mr-1"></i>{#email#}</div>
                                                <a href="mailto:{$CONTACT_EMAIL}" id="footer-mail-link{$BLOCK.ID}" class="menu-link">{$CONTACT_EMAIL}</a>
                                            </div>
                                        </li>
                                    </ul>
                                </div>
                            </li>
                        </ul>
                    </nav>
                </div>
            </div>
        </div>
        <div id="footer-card" class="w-100 py-1">
            <div class="container">
                <div class="row align-items-center justify-content-center">
                    <div class="col-6 col-md-auto py-1 d-flex align-items-center"><img src="/theme/{$THEME_FOLDER}/assets/footer/verified-by-visa.svg" width="172" height="32" alt="Verified by Visa"></div>
                    <div class="col-6 col-md-auto py-1 d-flex align-items-center"><img src="/theme/{$THEME_FOLDER}/assets/footer/256-bit-ssl.svg" width="172" height="32" alt="256 Bit Ssl"></div>
                    <div class="col-6 col-md-auto py-1 d-flex align-items-center"><img src="/theme/{$THEME_FOLDER}/assets/footer/master-securecode.svg" width="172" height="32" alt="Master Securecode"></div>
                    <div class="col-6 col-md-auto py-1 d-flex align-items-center"><img src="/theme/{$THEME_FOLDER}/assets/footer/verified-by-troy.svg" width="172" height="32" alt="Verified By Troy"></div>
                </div>
                <div class="row align-items-center justify-content-center">
                    <div class="col-3 col-md-auto py-1 d-flex align-items-center"><img src="/theme/{$THEME_FOLDER}/assets/footer/axess.svg" width="70" height="32" alt="Axess"></div>
                    <div class="col-3 col-md-auto py-1 d-flex align-items-center"><img src="/theme/{$THEME_FOLDER}/assets/footer/maximum.svg" width="70" height="32" alt="Maximum"></div>
                    <div class="col-3 col-md-auto py-1 d-flex align-items-center"><img src="/theme/{$THEME_FOLDER}/assets/footer/bonus.svg" width="70" height="32" alt="Bonus"></div>
                    <div class="col-3 col-md-auto py-1 d-flex align-items-center"><img src="/theme/{$THEME_FOLDER}/assets/footer/paraf.svg" width="70" height="32" alt="Paraf"></div>
                    <div class="col-3 col-md-auto py-1 d-flex align-items-center"><img src="/theme/{$THEME_FOLDER}/assets/footer/cardfinans.svg" width="70" height="32" alt="Card Finans"></div>
                    <div class="col-3 col-md-auto py-1 d-flex align-items-center"><img src="/theme/{$THEME_FOLDER}/assets/footer/visa.svg" width="70" height="32" alt="Visa"></div>
                    <div class="col-3 col-md-auto py-1 d-flex align-items-center"><img src="/theme/{$THEME_FOLDER}/assets/footer/master.svg" width="70" height="32" alt="Master"></div>
                    <div class="col-3 col-md-auto py-1 d-flex align-items-center"><img src="/theme/{$THEME_FOLDER}/assets/footer/troy.svg" width="70" height="32" alt="Troy"></div>
                </div>
            </div>
        </div>
        <div id="footer-copyright" class="w-100 text-center text-gray mb-2">
            ©2022 Tüm Hakkı Saklıdır. <b>v5 Ran</b>
        </div>
    </div>
</footer>