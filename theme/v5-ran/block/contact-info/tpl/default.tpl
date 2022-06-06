<div class="col-12 mb-2">
    <div class="w-100">
        {if $SETTING.DISPLAY_TITLE}
            <div class="w-100 mb-1 block-title no-line">{$BLOCK.TITLE}</div>
        {/if}
        {if $ILETISIM_AYAR_KONTROL == 1}
            {if $ILETISIM_KONTROL != ""}
                <div class="w-100 p-1 border border-round">
                    {$ILETISIM}
                </div>
            {/if}
        {else}
            <div class="w-100 px-1 border border-bottom-0 border-round text-body contact-info">
                <div class="row">
                    {if $SETTING.FIRM_NAME != ''}
                        <div class="col-12 border-bottom">
                            <div class="row">
                                <div class="col-4 p-1">{#firm_name#}</div>
                                <div class="col-8 p-1 border-left text-gray">{$SETTING.FIRM_NAME}</div>
                            </div>
                        </div>
                    {/if}
                    {if $SETTING.FIRM_CITY != ''}
                        <div class="col-12 border-bottom">
                            <div class="row">
                                <div class="col-4 p-1">{#address#}</div>
                                <div class="col-8 p-1 border-left text-gray">{$SETTING.FIRM_TOWN} / {$SETTING.FIRM_CITY} / {$SETTING.FIRM_COUNTRY}</div>
                            </div>
                        </div>
                    {/if}
                    {if $SETTING.FIRM_PHONE != ''}
                        <div class="col-12 border-bottom">
                            <div class="row">
                                <div class="col-4 p-1">{#phone#}</div>
                                <div class="col-8 p-1 border-left text-gray"><a class="text-primary" href="tel:{$SETTING.FIRM_PHONE|replace:' ':''}">{$SETTING.FIRM_PHONE}</a></div>
                            </div>
                        </div>
                    {/if}
                    {if $SETTING.FIRM_FAX != ''}
                        <div class="col-12 border-bottom">
                            <div class="row">
                                <div class="col-4 p-1">{#fax#}</div>
                                <div class="col-8 p-1 border-left text-gray">{$SETTING.FIRM_FAX}</div>
                            </div>
                        </div>
                    {/if}
                    {if $SETTING.FIRM_ADDRESS != ''}
                        <div class="col-12 border-bottom">
                            <div class="row">
                                <div class="col-4 p-1">{#firm_address#}</div>
                                <div class="col-8 p-1 border-left text-gray">{$SETTING.FIRM_ADDRESS}</div>
                            </div>
                        </div>
                    {/if}
                    {if $SETTING.FIRM_EMAIL != ''}
                        <div class="col-12 border-bottom">
                            <div class="row">
                                <div class="col-4 p-1">{#email#}</div>
                                <div class="col-8 p-1 border-left text-gray"><a class="text-primary" href="mailto:{$SETTING.FIRM_EMAIL}">{$SETTING.FIRM_EMAIL}</a></div>
                            </div>
                        </div>
                    {/if}
                    {if $SETTING.FIRM_TAX_OFFICE != ''}
                        <div class="col-12 border-bottom">
                            <div class="row">
                                <div class="col-4 p-1">{#firm_tax_office#}</div>
                                <div class="col-8 p-1 border-left text-gray">{$SETTING.FIRM_TAX_OFFICE}</div>
                            </div>
                        </div>
                    {/if}
                    {if $SETTING.FIRM_TAX_NUMBER != ''}
                        <div class="col-12 border-bottom">
                            <div class="row">
                                <div class="col-4 p-1">{#firm_tax_number#}</div>
                                <div class="col-8 p-1 border-left text-gray">{$SETTING.FIRM_TAX_NUMBER}</div>
                            </div>
                        </div>
                    {/if}
                    {if $SETTING.FIRM_TRADE_REGISTER_NUMBER != ''}
                        <div class="col-12 border-bottom">
                            <div class="row">
                                <div class="col-4 p-1">{#register_number#}</div>
                                <div class="col-8 p-1 border-left text-gray">{$SETTING.FIRM_TRADE_REGISTER_NUMBER}</div>
                            </div>
                        </div>
                    {/if}
                    {if $SETTING.FIRM_MERNIS_NO != ''}
                        <div class="col-12 border-bottom">
                            <div class="row">
                                <div class="col-4 p-1">{#mernis_no#}</div>
                                <div class="col-8 p-1 border-left text-gray">{$SETTING.FIRM_MERNIS_NO}</div>
                            </div>
                        </div>
                    {/if}
                    {if $SETTING.FIRM_KEP_ADDRESS != ''}
                        <div class="col-12 border-bottom">
                            <div class="row">
                                <div class="col-4 p-1">{#kep_address#}</div>
                                <div class="col-8 p-1 border-left text-gray">{$SETTING.FIRM_KEP_ADDRESS}</div>
                            </div>
                        </div>
                    {/if}
                    {if $SETTING.FIRM_FACEBOOK != ''}
                        <div class="col-12 border-bottom">
                            <div class="row">
                                <div class="col-4 p-1">{#facebook#}</div>
                                <div class="col-8 p-1 border-left text-gray"><a class="text-primary" target="_blank" href="{$SETTING.FIRM_FACEBOOK}">{$SETTING.FIRM_FACEBOOK}</a></div>
                            </div>
                        </div>
                    {/if}
                    {if $SETTING.FIRM_TWITTER != ''}
                        <div class="col-12 border-bottom">
                            <div class="row">
                                <div class="col-4 p-1">{#twitter#}</div>
                                <div class="col-8 p-1 border-left text-gray"><a class="text-primary" target="_blank" href="{$SETTING.FIRM_TWITTER}">{$SETTING.FIRM_TWITTER}</a></div>
                            </div>
                        </div>
                    {/if}
                    {if $SETTING.FIRM_PINTEREST != ''}
                        <div class="col-12 border-bottom">
                            <div class="row">
                                <div class="col-4 p-1">{#pinterest#}</div>
                                <div class="col-8 p-1 border-left text-gray"><a class="text-primary" target="_blank" href="{$SETTING.FIRM_PINTEREST}">{$SETTING.FIRM_PINTEREST}</a></div>
                            </div>
                        </div>
                    {/if}
                    {if $SETTING.FIRM_INSTAGRAM != ''}
                        <div class="col-12 border-bottom">
                            <div class="row">
                                <div class="col-4 p-1">{#instagram#}</div>
                                <div class="col-8 p-1 border-left text-gray"><a class="text-primary" target="_blank" href="{$SETTING.FIRM_INSTAGRAM}">{$SETTING.FIRM_INSTAGRAM}</a></div>
                            </div>
                        </div>
                    {/if}
                    {if $SETTING.FIRM_YOUTUBE != ''}
                        <div class="col-12 border-bottom">
                            <div class="row">
                                <div class="col-4 p-1">{#youtube#}</div>
                                <div class="col-8 p-1 border-left text-gray"><a class="text-primary" target="_blank" href="{$SETTING.FIRM_YOUTUBE}">{$SETTING.FIRM_YOUTUBE}</a></div>
                            </div>
                        </div>
                    {/if}
                    {if $SETTING.FIRM_WHATSAPP != ''}
                        <div class="col-12 border-bottom">
                            <div class="row">
                                <div class="col-4 p-1">{#whatsapp#}</div>
                                <div class="col-8 p-1 border-left text-gray"><a class="text-primary" target="_blank" href="https://wa.me/{$SETTING.FIRM_WHATSAPP}">{$SETTING.FIRM_WHATSAPP}</a></div>
                            </div>
                        </div>
                    {/if}
                    <div class="col-12 border-bottom">
                        <div class="row">
                            <div class="col-4 p-1">{#money_order#}</div>
                            <div class="col-8 p-1 border-left text-gray">
                                {#for_payment#} <a href="/{url type='page' id='80'}" class="text-primary text-underline">{#clik#}</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        {/if}
    </div>
    <div class="row mt-1">
        <div class="col-6 col-md-3 py-1">
            <a href="/{url type='page' id='68'}" class="w-100 d-block py-2 px-1 border text-gray contact-link-btn">
                <i class="ti-store"></i>
                <strong>{#store#}</strong>
            </a>
        </div>
        <div class="col-6 col-md-3 py-1">
            <a href="/{url type='page' id='84'}" class="w-100 d-block py-2 px-1 border text-gray contact-link-btn">
                <i class="ti-help"></i>
                <strong>{#questions#}</strong>
            </a>
        </div>
        <div class="col-6 col-md-3 py-1">
            <a href="/{url type='page' id='15'}" class="w-100 d-block py-2 px-1 border text-gray contact-link-btn">
                <i class="ti-lifebuoy"></i>
                <strong>{#customer_service#}</strong>
            </a>
        </div>
        <div class="col-6 col-md-3 py-1">
            <a href="/{url type='page' id='92'}" class="w-100 d-block py-2 px-1 border text-gray contact-link-btn">
                <i class="ti-order-follow-up"></i>
                <strong>{#order_tracking#}</strong>
            </a>
        </div>
    </div>
</div>