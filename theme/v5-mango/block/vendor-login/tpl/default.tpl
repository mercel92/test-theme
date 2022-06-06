<div class="col-12">
    <div class="row mb-1 mx-0">
        {if $IS_VENDOR_LOGIN!=true}
            <div class="w-100 member-page-buttons">
                <div class="row">
                    <div class="col-12 col-md-3 col-lg-2">
                        <div class="w-100 pt-1 member-quick-menu">
                            <div class="col-12 bg-light position-relative member-avatar">
                                <a href="/{url type='page' id='10'}" class="edit-info-btn text-content position-absolute d-none d-md-inline-flex align-items-center bg-white border border-light border-round px-1">
                                    <i class="ti-pencil"></i> {#edit#}
                                </a>
                                <div class="row">
                                    <div class="col-9 py-1 col-md-12 text-gray d-flex align-items-center">
                                        <i class="ti-user d-flex align-items-center justify-content-center text-white"></i>
                                        <div class="d-inline-block d-md-block">
                                            <strong class="d-block member-name">{$MEMBER.NAME} {$MEMBER.SURNAME}</strong>
                                            <span class="d-block member-email text-primary">{$MEMBER.EMAIL}</span>
                                        </div>
                                    </div>
                                    <a href="javascript:void(0);" class="col-3 py-2 logout text-gray border-left border-light d-flex flex-wrap align-items-center justify-content-center d-md-none text-uppercase">
                                        <i class="ti-power-off ti-20px d-block w-100 text-center"></i> Çıkış
                                    </a>
                                </div>
                            </div>
                            <ul class="col-12 d-flex flex-wrap border border-light border-top-0 list-style-none">
                                <li class="col-6 col-md-12">
                                    <a href="/{url type='page' id='10'}" class="w-100 py-1 d-flex align-items-center text-content text-uppercase">
                                        <i class="ti-user ti-20px text-white member-menu-icon"></i>
                                        <strong>{#personel_informations#}</strong>
                                    </a>
                                </li>
                                {if $IS_MESSAGE_ACTIVE==1}
                                    <li class="col-6 col-md-12">
                                        <a href="/{url type='page' id='75'}" class="w-100 py-1 d-flex align-items-center text-content text-uppercase">
                                            <i class="ti-chat-alt ti-20px text-white member-menu-icon"></i>
                                            <strong>{#messages#}</strong>
                                        </a>
                                    </li>
                                {/if}
                                <li class="col-6 col-md-12 d-none d-md-block">
                                    <a href="#" class="w-100 py-1 d-flex align-items-center justify-content-center text-content text-uppercase logout">
                                        <i class="ti-power-off ti-20px mr-1"></i>
                                        <strong>{#logout#}</strong>
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-12 col-md-9 col-lg-10">
                        <div class="row">
                            <div class="col-12 col-md-6 py-1 col-desktop-half">
                                <div class=" d-flex align-items-center w-100 h-100 bg-light">
                                    <form method="POST" autocomplete="off" action="/{url type='page' id='92'}" class="w-100 px-1 order-tracking">
                                        <input type="hidden" name="email" value="{$MEMBER.EMAIL}">
                                        <label for="order-tracking-input" class="fw-bold text-body d-none d-md-block">
                                            <i class="ti-box"></i> {#order_entry#}
                                        </label>
                                        <div class="row">
                                            <div class="col-8 col-md-9 pr-0">
                                                <input type="text" class="form-control form-control-md" placeholder="{#order_number#} :" name="order" required id="order-tracking-input">
                                            </div>
                                            <div class="col-4 col-md-3 pl-0">
                                                <button type="submit" class="btn btn-dark w-100 text-uppercase">{#search#}</button>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                            <div class="col-4 col-md-3 py-1 col-desktop-five">
                                <a href="/{url type='page' id='4'}"
                                    class="w-100 px-1 py-2 d-flex align-items-center justify-content-center border border-light border-round text-uppercase text-content member-menu-btn">
                                    <i class="ti-basket-outline ti-20px text-white member-menu-icon"></i>
                                    <strong>{#orders#}</strong>
                                </a>
                            </div>
                            <div class="col-4 col-md-3 py-1 col-desktop-five">
                                <a href="/{url type='page' id='35'}"
                                    class="w-100 px-1 py-2 d-flex align-items-center justify-content-center border border-light border-round text-uppercase text-content member-menu-btn">
                                    <i class="ti-heart-o ti-20px text-white member-menu-icon"></i>
                                    <strong>{#favorite#}</strong>
                                </a>
                            </div>
                            <div class="col-4 col-md-3 py-1 col-desktop-five">
                                <a href="/{url type='page' id='71'}"
                                    class="w-100 px-1 py-2 d-flex align-items-center justify-content-center border border-light border-round text-uppercase text-content member-menu-btn">
                                    <i class="ti-gift ti-20px text-white member-menu-icon"></i>
                                    <strong>{#gift_cards#}</strong>
                                </a>
                            </div>
                            <div class="col-4 col-md-3 py-1 col-desktop-five">
                                <a href="/{url type='page' id='85'}"
                                    class="w-100 px-1 py-2 d-flex align-items-center justify-content-center border border-light border-round text-uppercase text-content member-menu-btn">
                                    <i class="ti-location ti-20px text-white member-menu-icon"></i>
                                    <strong>{#your_addresses#}</strong>
                                </a>
                            </div>
                            {if $IS_COMMENT_POINTS_ACTIVE}
                                <div class="col-4 col-md-3 py-1 col-desktop-five">
                                    <a href="/{url type='page' id='70'}"
                                        class="w-100 px-1 py-2 d-flex align-items-center justify-content-center border border-light border-round text-uppercase text-content member-menu-btn">
                                        <i class="ti-database ti-20px text-white member-menu-icon"></i>
                                        <strong>{#my_points#}</strong>
                                    </a>
                                </div>
                            {/if}
                            <div class="col-4 col-md-3 py-1 col-desktop-five">
                                <a href="/{url type='page' id='87'}"
                                    class="w-100 px-1 py-2 d-flex align-items-center justify-content-center border border-light border-round text-uppercase text-content member-menu-btn">
                                    <i class="ti-bell ti-20px text-white member-menu-icon"></i>
                                    <strong>{#my_stock_alarm_list#}</strong>
                                </a>
                            </div>
                            <div class="col-4 col-md-3 py-1 col-desktop-five">
                                <a href="/{url type='page' id='80'}"
                                    class="w-100 px-1 py-2 d-flex align-items-center justify-content-center border border-light border-round text-uppercase text-content member-menu-btn">
                                    <i class="ti-dollar ti-20px text-white member-menu-icon"></i>
                                    <strong>{#referral_notice#}</strong>
                                </a>
                            </div>
                            <div class="col-4 col-md-3 py-1 col-desktop-five">
                                <a href="/{url type='page' id='86'}"
                                    class="w-100 px-1 py-2 d-flex align-items-center justify-content-center border border-light border-round text-uppercase text-content member-menu-btn">
                                    <i class="ti-bell-o ti-20px text-white member-menu-icon"></i>
                                    <strong>{#my_price_alarm_list#}</strong>
                                </a>
                            </div>
                            {if $IS_CURRENT_ACCOUNT_ACTIVE==1}
                                <div class="col-4 col-md-3 py-1 col-desktop-five">
                                    <a href="/{url type='page' id='90'}"
                                        class="w-100 px-1 py-2 d-flex align-items-center justify-content-center border border-light border-round text-uppercase text-content member-menu-btn">
                                        <i class="ti-credit-card-alt ti-20px text-white member-menu-icon"></i>
                                        <strong>{#payment_with_credit_card#}</strong>
                                    </a>
                                </div>
                                <div class="col-4 col-md-3 py-1 col-desktop-five">
                                    <a href="/{url type='page' id='29'}"
                                        class="w-100 px-1 py-2 d-flex align-items-center justify-content-center border border-light border-round text-uppercase text-content member-menu-btn">
                                        <i class="ti-clipboard ti-20px text-white member-menu-icon"></i>
                                        <strong>{#current_transactions_cari#}</strong>
                                    </a>
                                </div>
                            {/if}
                            {if $DISPLAY_DELETE_MEMBER == 1}
                                <div class="col-4 col-md-3 py-1 col-desktop-five">
                                    <a href="/srv/service/content-v5/sub-folder/{$PAGE_ID}/{$BLOCK.PARENT_ID}/cancel-me/" data-width="570"
                                        class="w-100 px-1 py-2 d-flex align-items-center justify-content-center border border-light border-round text-uppercase text-content popupwin member-menu-btn">
                                        <i class="ti-user-delete ti-20px text-white member-menu-icon"></i>
                                        <strong>{#member_cancel#}</strong>
                                    </a>
                                </div>
                            {/if}
                            {if $SUBSCRIBE === 1}
                                <div class="col-4 col-md-3 py-1 col-desktop-five">
                                    <a href="/{url type='page' id='123'}"
                                        class="w-100 px-1 py-2 d-flex align-items-center justify-content-center border border-light border-round text-uppercase text-content member-menu-btn">
                                        <i class="ti-calendar ti-20px text-white member-menu-icon"></i>
                                        <strong>{#my_subscription_products#}</strong>
                                    </a>
                                </div>
                            {/if}
                        </div>
                    </div>
                </div>
            </div>
        {elseif $IS_VENDOR_MESSAGE_ACTIVE==true}
            {#vendor_is_not_active#}
        {else}
            <div class="col-12 col-md-8 col-lg-6 py-2 px-3 border border-light border-round mx-auto">
                <div class="row">
                    <form action="#" id="vendor-form" method="POST" class="col-12" data-toggle="login-form" data-prefix="vendor-" data-vendor="1" data-callback="ugMemberLoginFn" novalidate>
                        <div class="row">
                            <div class="w-100 mb-2 block-title border-bottom text-uppercase text-primary">
                                {#vendor_login#}
                            </div>
                            <div class="col-12 px-0 mb-1">
                                <div class="w-100 popover-wrapper position-relative">
                                    <input type="email" id="vendor-email" name="vendor-email" class="form-control form-control-md" placeholder="{#enter_mail#}" data-toggle="placeholder" data-validate="required,email">
                                </div>
                            </div>
                            <div class="col-12 px-0 mb-1">
                                <div class="w-100 popover-wrapper input-group">
                                    <input type="password" id="vendor-password" name="vendor-password" class="form-control form-control-md" placeholder="{#enter_password#}">
                                    <div class="input-group-append no-animate">
                                        <i class="ti-eye-off text-light" id="toggleVisiblePassword{$BLOCK.ID}"></i>
                                    </div>
                                </div>
                            </div>
                            <div class="col-12 px-0 d-flex flex-wrap justify-content-between">
                                <input type="checkbox" id="vendor-remember" name="vendor-remember" class="form-control">
                                <label for="vendor-remember" class="mb-1 d-flex align-items-center">
                                    <span class="input-checkbox">
                                        <i class="ti-check"></i>
                                    </span>
                                    {#remember_me#}
                                </label>
                                <a href="/{url type='page' id='7'}" class="text-body mb-1">{#forgot_password#}</a>
                            </div>
                            <div class="col-12 px-0">
                                <div class="row">
                                    <div class="col-12 col-md-6 mb-1">
                                        <button type="submit" id="vendor-login-btn" class="w-100 btn btn-primary text-uppercase">{#login#}</button>
                                    </div>
                                    <div class="col-12 col-md-6 mb-1">
                                        <a href="/{url type='page' id='22'}" id="vendor-application-btn" class="w-100 btn btn-dark text-uppercase">{#application#}</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        {/if}
    </div>
</div>