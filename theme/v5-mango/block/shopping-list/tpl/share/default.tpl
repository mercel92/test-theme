<div id="shopping-list-share" class="w-100" v-cloak>
    <div class="col-12">
        <div class="row">
            <div class="w-100 mb-1 block-title border-bottom">
                {#share#}
            </div>
            <div class="col-12">
                <div class="row">
                    <div class="w-100 popover-wrapper position-relative mb-1">
                        <input type="email" name="share-email" placeholder="{#email_adress#}" class="form-control form-control-md" data-toggle="placeholder"
                               v-model="email" data-validate="required, email">
                    </div>
                    <div class="w-100 popover-wrapper position-relative mb-1">
                        <input type="number" name="share-day" placeholder="{#days_number#}" class="form-control form-control-md no-arrows" 
                               data-toggle="placeholder" data-validate="required" min="1"
                               ref="dayInput"
                               v-model="day">
                    </div>
                    <div class="w-100 mb-1">
                        {#share_content#}
                    </div>
                    <div class="w-100 popover-wrapper position-relative mb-1">
                        <textarea id="share-content" name="share-content" class="form-control form-control-md" data-validate="required">
                            {{ data.SHARE_LINK }}
                        </textarea>
                    </div>
                    <div class="w-100">
                        <button type="button" @click="sendForm()" class="w-100 btn btn-primary" id="share-send-btn">{#message_send#}</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    let DATA = {};
    try {
        DATA = {$DATA};
    } catch (ex) {
        DATA = {}
    }

    const ShoppingListShare = {
        data() {
            return {
                data: DATA,
                email: '',
                day: 30
            }
        },
        methods: {
            sendForm() {
                const self = this,
                      service = `/srv/service/profile/share-shopping-link/${self.email}/${self.data.GET_P1}/${self.day}`;

                var data = new FormData();
                data.append('email', self.email);
                data.append('content', self.data.SHARE_LINK);

                T.buttonLock.dom = document.getElementById('share-send-btn');
                T.buttonLock.lock();

                axios.post(service, data).then(response => {
                    T.buttonLock.unlock();
                    T.notify({
                        text: response.data.statusText,
                        className: response.data.status == 0 ? 'danger' : 'success',
                        stopOnFocus : true,
                        duration: 2400,
                        iconClass : response.data.status == 0 ? 'ti-thumbs-down' : 'ti-thumbs-up',
                    });
                    if (response.data.status == 1) {
                        setTimeout(function(){ location.reload(); }, 1500);
                    }
                }).catch(error => `Get share error => ${error}`);
            }
        },
        watch: {
            'day'(value) {
                const self = this;
                if (value < 1) {
                    popoverAlert.show(
                        self.$refs.dayInput,
                        'Gün sayısı giriniz.',
                        3000,
                        `btn btn-danger no-radius text-left`,
                        false,
                    );
                    return;
                }

                axios.get(`/srv/service/profile/create-shopping-link/${self.data.GET_P1}/${value}`).then(response => {
                    self.data = response.data;
                }).catch(error => `Get share set error => ${error}`);
            }
        },
        mounted() {
            setTimeout(() => { initComponents(); }, 240);
        },
    };

    Vue.createApp(ShoppingListShare).mount('#shopping-list-share');
</script>