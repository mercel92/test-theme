<footer class="col-12">
    <div class="row">
        <div id="footer-top" class="col-12 py-4 bg-light">
            <div class="row">
                <div class="container">
                    <div class="row">
                        <div class="col-12 col-md-5">
                            <div class="h5 fw-extrabold text-center text-md-left">{#newsletter#}</div>
                            <p class="fw-light text-center text-md-left">{#newsletter_text#}</p>
                            <form id="newsletter-form-{$BLOCK.ID}" class="row" novalidate autocomplete="off">
                                <div class="col-8">
                                    <div class="w-100 popover-wrapper position-relative">
                                        <input type="email" name="email" id="news_email-{$BLOCK.ID}" class="form-control form-control-md" placeholder="{#enter_email#}" data-validate="required,email">
                                    </div>
                                </div>
                                <div class="col-4">
                                    <button type="submit" id="news_email_btn-{$BLOCK.ID}" class="d-flex align-items-center justify-content-center w-100 fs-12 btn btn-dark text-uppercase">{#register#}</button>
                                </div>
                                {if $NEWSLETTER_KVKK_ACTIVE}
                                    <div class="col-12 mt-1">
                                        <div class="w-100 popover-wrapper position-relative fs-12">
                                        <input type="checkbox" name="kvkk" id="news_sub-kvkk-{$BLOCK.ID}" class="form-control" data-validate="required" value="1">
                                        <label for="news_sub-kvkk-{$BLOCK.ID}" id="label-news_sub-kvkk-{$BLOCK.ID}">
                                            <span class="input-checkbox">
                                                <i class="ti-check"></i>
                                            </span>
                                            <a href="{$KVKK_URL}" class="text-underline text-body popupwin" title="{#kvkk#}">{#kvkk#}</a>, {#accept#}
                                        </label>
                                        </div>
                                    </div>
                                {/if}
                            </form>
                        </div>
                        <div id="footer-social" class="col-12 col-md-6 offset-md-1">
                            <div class="h5 fw-extrabold text-center text-md-left">{#social_media#}</div>
                            <p class="fw-light text-center text-md-left">{#social_text#}</p>
                            <ul id="footer-social-list" class="w-100 list-style-none text-center text-md-left">
                                <li class="d-inline-block mr-1">
                                    <a href="#" class="bg-dark border-circle d-flex align-items-center justify-content-center text-white text-center">a</a>
                                </li>
                                <li class="d-inline-block mr-1">
                                    <a href="#" class="bg-dark border-circle d-flex align-items-center justify-content-center text-white text-center">a</a>
                                </li>
                                <li class="d-inline-block">
                                    <a href="#" class="bg-dark border-circle d-flex align-items-center justify-content-center text-white text-center">a</a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="container">
            <div class="row py-4">
                <nav id="footer-menu" class="col-12">
                    <ul class="row">
                        {foreach from=$MENU item=M}
                            <li class="col-12 col-md-3 menu-item">
                                <div class="menu-item-wrapper">
                                    <div class="clearfix d-flex flex-wrap menu-title fw-bold mb-1" data-toggle="accordion" data-platform="mobile">
                                        {$M.NAME}
                                        <span class="d-block d-md-none ml-auto">
                                            <i class="ti-plus"></i>
                                            <i class="ti-minus"></i>
                                        </span>
                                    </div>
                                    <ul class="clearfix menu-children">
                                        {foreach from=$M.CHILDREN item=CHILD}
                                            <li class="w-100">
                                                <a href="{$CHILD.URL}" class="menu-link"{if $CHILD.IS_TARGET_BLANK} target="_blank"{/if}>{$CHILD.NAME}</a>
                                            </li>
                                        {/foreach}
                                    </ul>
                                </div>
                            </li>
                        {/foreach}
                        <li class="col-12 col-md-3 menu-item">
                            <div class="menu-item-wrapper">
                                <div class="d-flex flex-wrap menu-title fw-bold mb-1" data-toggle="accordion" data-platform="mobile">
                                    {#address_contact#}
                                    <span class="d-block d-md-none ml-auto">
                                        <i class="ti-plus"></i>
                                        <i class="ti-minus"></i>
                                    </span>
                                </div>
                                <ul class="clearfix menu-children">
                                    <li class="w-100">
                                        <div class="w-100 menu-link">
                                            <strong class="d-block text-black fs-12 mb-8"><i class="ti-location text-primary mr-1"></i>{#address#}</strong>
                                            <address>{$CONTACT_FIRM_ADDRESS}</address>
                                        </div>
                                        <div class="w-100 menu-link">
                                            <strong class="d-block text-black fs-12 mb-8"><i class="ti-phone text-primary mr-1"></i>{#phone_number#}</strong>
                                            <a href="tel:{$CONTACT_TELEPHONE|replace:' ':''}" id="footer-phone-link{$BLOCK.ID}" class="menu-link p-0">{$CONTACT_TELEPHONE}</a>
                                        </div>
                                        <div class="w-100 menu-link">
                                            <strong class="d-block text-black fs-12 mb-8"><i class="ti-mail text-primary mr-1"></i>{#email#}</strong>
                                            <a href="mailto:{$CONTACT_EMAIL}" id="footer-mail-link{$BLOCK.ID}" class="menu-link p-0">{$CONTACT_EMAIL}</a>
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
    <div class="row p-1 border-top border-bottom">
        <div id="footer-security" class="col-12">
            <div class="row align-items-center justify-content-center">
                <div class="p-1 d-flex align-items-center"><img src="/theme/{$THEME_FOLDER}/assest/footer/verified-by-visa.svg" width="172" height="32" alt="Verified by Visa"></div>
                <div class="p-1 d-flex align-items-center"><img src="/theme/{$THEME_FOLDER}/assest/footer/256-bit-ssl.svg" width="172" height="32" alt="256 Bit Ssl"></div>
                <div class="p-1 d-flex align-items-center"><img src="/theme/{$THEME_FOLDER}/assest/footer/master-securecode.svg" width="172" height="32" alt="Master Securecode"></div>
                <div class="p-1 d-flex align-items-center"><img src="/theme/{$THEME_FOLDER}/assest/footer/verified-by-troy.svg" width="172" height="32" alt="Verified By Troy"></div>
            </div>
        </div>
        <div id="footer-banks" class="col-12">
            <div class="row align-items-center justify-content-center">
                <div class="p-1 d-flex align-items-center"><img src="/theme/{$THEME_FOLDER}/assest/footer/axess.svg" width="70" height="32" alt="Axess"></div>
                <div class="p-1 d-flex align-items-center"><img src="/theme/{$THEME_FOLDER}/assest/footer/maximum.svg" width="70" height="32" alt="Maximum"></div>
                <div class="p-1 d-flex align-items-center"><img src="/theme/{$THEME_FOLDER}/assest/footer/bonus.svg" width="70" height="32" alt="Bonus"></div>
                <div class="p-1 d-flex align-items-center"><img src="/theme/{$THEME_FOLDER}/assest/footer/paraf.svg" width="70" height="32" alt="Paraf"></div>
                <div class="p-1 d-flex align-items-center"><img src="/theme/{$THEME_FOLDER}/assest/footer/cardfinans.svg" width="70" height="32" alt="Card Finans"></div>
                <div class="p-1 d-flex align-items-center"><img src="/theme/{$THEME_FOLDER}/assest/footer/visa.svg" width="70" height="32" alt="Visa"></div>
                <div class="p-1 d-flex align-items-center"><img src="/theme/{$THEME_FOLDER}/assest/footer/master.svg" width="70" height="32" alt="Master"></div>
                <div class="p-1 d-flex align-items-center"><img src="/theme/{$THEME_FOLDER}/assest/footer/troy.svg" width="70" height="32" alt="Troy"></div>
            </div>
        </div>
    </div>
</footer>