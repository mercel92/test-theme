<div id="login-popup-form">
    <form action="#" id="login-form" method="POST" class="col-12 py-1 bg-white" data-toggle="login-form" data-prefix="popup-" data-callback="ugMemberPopupLoginFn" novalidate>
        <ul id="popup-login-type" class="w-100 tab-nav list-style-none">
            <li data-type="email" class="active"><a href="#popup-login-width-email" data-toggle="tab">{#member_login#}</a></li>
            <li data-type="phone"><a href="#popup-login-with-phone" data-toggle="tab" v-if="SETTING.LICENCE_REGISTRATION_WITH_PHONE == 1">{#phone_login#}</a></li>
        </ul>
        <div class="col-12 px-0 mb-1 tab-content">
            <div id="popup-login-width-email" class="w-100 tab-pane active">
                <div class="w-100 popover-wrapper position-relative">
                    <input type="email" id="popup-email" name="email" class="form-control form-control-md" placeholder="{#enter_mail#}" data-toggle="placeholder">
                </div>
            </div>
            <div id="popup-login-with-phone" class="w-100 tab-pane" v-if="SETTING.LICENCE_REGISTRATION_WITH_PHONE == 1">
                <div class="w-100 popover-wrapper position-relative">
                    <input type="tel" id="popup-phone" name="phone" class="form-control form-control-md" placeholder="{#enter_phone_number#}" data-toggle="placeholder" data-flag-masked>
                </div>
            </div>
        </div>
        <div class="w-100 mb-1">
            <div class="w-100 popover-wrapper position-relative">
                <input type="password" id="popup-password" name="password" class="form-control form-control-md" placeholder="{#enter_password#}" data-toggle="placeholder">
            </div>
        </div>
        <div class="w-100 d-flex flex-wrap justify-content-between">
            <div class="mb-1">
                <input type="checkbox" id="popup-remember" name="popup-remember" class="form-control">
                <label class="d-flex align-items-center m-0 fw-regular" for="popup-remember">
                    <span class="input-checkbox">
                        <i class="ti-check"></i>
                    </span>
                    {#remember_me#}
                </label>
            </div>
            <div class="mb-1">
                <a href="/{url type='page' id='7'}" class="text-gray text-underline">{#forgot_password#}</a>
            </div>
        </div>
        <div class="w-100">
            <div class="row">
                <div class="col-12 col-md-6 mb-1">
                    <button type="submit" id="popup-submit-btn" class="w-100 btn btn-primary text-uppercase">{#login#}</button>
                </div>
                <div class="col-12 col-md-6 mb-1">
                    <a href="/{url type='page' id='6'}" class="w-100 btn btn-light text-uppercase">{#member_register#} <i class="ti-arrow-right"></i></a>
                </div>
                <div class="col-12" v-if="SETTING.FACEBOOK_LOGIN == 1 || SETTING.GOOGLE_LOGIN == 1 || SETTING.APPLE_LOGIN == 1">
                    <div class="row">
                        <div class="col-4 mb-1" v-if="SETTING.FACEBOOK_LOGIN == 1">
                            <a href="/srv/service/social/facebook/login" class="fb-login-btn">
                                <i class="ti-facebook"></i> {#connect_with#}
                            </a>
                        </div>
                        <div class="col-4 mb-1" v-if="SETTING.GOOGLE_LOGIN == 1">
                            <a id="signinGoogle" href="javascript:void(0)" class="google-login-btn">
                                <i class="ti-google"></i> {#connect_with#}
                            </a>
                        </div>
                        <div class="col-4 mb-1" v-if="SETTING.APPLE_LOGIN == 1">
                            <a href="/api/v1/authentication/social-login?type=apple&ajax=1" class="apple-login-btn">
                                <i class="ti-apple"></i> {#connect_with#}
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</div>

<script>
    let DATA = {};
    try {
        DATA = {$DATA};
    } catch (ex) {
        DATA = {}
    }

    const popupLogin = {
        data() {
            return {
                SETTING: DATA.SETTING,
            }
        },
        mounted() {
            setTimeout(() => {
                initComponents();
            }, 300);

            window['ugMemberPopupLoginFn'] = (result, options) => {
                popoverAlert.show(
                    document.getElementById(`${options.prefix}${options.type}`), 
                    result.message, 
                    3000, 
                    `btn ${(result.status === true) ? 'btn-success' : 'btn-danger'} text-left`,
                    false
                );
            
                if(result.status === true) {
                    setTimeout(() => {
                        window.location.reload();
                    }, 2000);
                }
            }
        }
    };
    Vue.createApp(popupLogin).mount('#login-popup-form');
</script>