<div class="col-12 mb-1 pt-1 customer-menu">
    <div class="col-12 bg-light position-relative customer-avatar">
        <a href="/{url type='page' id='10'}" class="edit-info-btn text-content position-absolute d-none d-md-inline-flex align-items-center bg-white border border-light border-round px-1">
            <i class="ti-pencil"></i> {#edit#}
        </a>
        <div class="row">
            <div class="col-9 py-1 col-md-12 text-gray d-flex align-items-center">
                <i class="ti-user d-flex align-items-center justify-content-center text-white"></i>
                <div class="d-inline-block d-md-block">
                    <strong class="d-block customer-name">{$CUSTOMER.FIRSTNAME} {$CUSTOMER.LASTNAME}</strong>
                    <span class="d-block customer-email text-primary">{$CUSTOMER.EMAIL}</span>
                </div>
            </div>
            <a href="javascript:void(0);" class="col-3 py-2 logout text-gray border-left border-light d-flex flex-wrap align-items-center justify-content-center d-md-none">
                <i class="ti-power-off d-block w-100 text-center"></i>
                {#logout#}
            </a>
        </div>
    </div>
    <ul class="col-12 d-flex flex-wrap border border-light border-top-0 list-style-none">
        <li class="col-6 col-md-12">
            <a href="/{url type='page' id='10'}" class="w-100 py-1 d-flex align-items-center text-content text-uppercase">
                <i class="ti-user ti-20px text-white customer-menu-icon"></i>
                <strong>{#personel_informations#}</strong>
            </a>
        </li>
        <li class="col-6 col-md-12">
            <a href="/{url type='page' id='75'}" class="w-100 py-1 d-flex align-items-center text-content text-uppercase">
                <i class="ti-chat-alt ti-20px text-white customer-menu-icon"></i>
                <strong>{#messages#}</strong>
            </a>
        </li>
        <li class="col-6 col-md-12 d-none d-md-block">
            <a href="#" class="w-100 py-1 d-flex align-items-center justify-content-center text-content text-uppercase logout">
                <i class="ti-power-off ti-20px mr-1"></i>
                <strong>{#logout#}</strong>
            </a>
        </li>
    </ul>
</div>