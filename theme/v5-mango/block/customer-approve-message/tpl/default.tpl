<div class="col-12 mt-2 mb-3 d-flex justify-content-center">
    <div class="col-12 col-md-6 p-1 bg-white border border-light border-round">
        {if $SETTING.DISPLAY_TITLE}
            <div class="w-100 mb-1 block-title border-bottom">
                {$BLOCK.TITLE}
            </div>
        {/if}
        <div class="d-none">
            {$REGISTRATION_CODE}
        </div>
        <div class="text-content">
            {if $MEMBER_REGISTRATION==1}
                {if $APPROVAL_TYPE==0 || $APPROVAL_TYPE==4 }
                    {#dear#} <b>{$MEMBER.NAME} {$MEMBER.SURNAME}</b>, {#member_approval_type_1#}.
                {if $MEMBER.MAIL!=''}
                    <br>{#your_mail#}: <b>{$MEMBER.MAIL}</b>
                {else}
                <br>{#your_phone#}: <b>{$MEMBER.MOBILE_PHONE}</b>
                {/if}
                <br>{#member_approval_type_2#}.
                {else if $APPROVAL_TYPE==1}
                    {#dear#} <b>{$MEMBER.NAME} {$MEMBER.SURNAME}, <br/>{#member_approval_type_3#}.
                {else if $APPROVAL_TYPE==2}
                    {#member_approval_type_4#} {$SITE}
                {else if $APPROVAL_TYPE==3}
                    {#dear#} <b>{$MEMBER.NAME} {$MEMBER.SURNAME}</b>, <br/>{#member_approval_type_5#}.
                {/if}
            {/if}
            {if $VENDOR_REGISTRATION==1}
                {if $APPROVAL_TYPE==0}
                    {#dear#} <b>{$MEMBER.NAME} {$MEMBER.SURNAME}</b>, {#vendor_approval_type_1#}.<br>{#your_mail#}: <b>{$MEMBER.MAIL}</b><br>{#vendor_approval_type_2#}.
                {else if $APPROVAL_TYPE==1}
                    {#dear#} <b>{$MEMBER.NAME} {$MEMBER.SURNAME}</b>, <br/>{#vendor_approval_type_3#}.
                {else if $APPROVAL_TYPE==2}
                    {#vendor_approval_type_4#}
                {else if $APPROVAL_TYPE==3}
                    {#dear#} <b>{$MEMBER.NAME} {$MEMBER.SURNAME}</b>, <br/>{#vendor_approval_type_5#}.
                {/if}
            {/if}
        </div>
    </div>
</div>