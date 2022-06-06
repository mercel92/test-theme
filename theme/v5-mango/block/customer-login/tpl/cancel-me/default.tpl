<div id="cancel-me" class="col-12 py-3 pt-2 pb-1" v-cloak>
    <div class="w-100" v-if="display">
        <div class="block-title text-primary mb-2 border-bottom border-light">
            {#member_cancel#} !
        </div>
        <div class="pb-2 mb-2 border-bottom">
            {#cancel_question#}
        </div>
        <div class="row">
            <div class="col-12 col-sm-6 mb-1">
                <a href="javascript:void(0)" @click="cancel()" class="d-block text-uppercase btn btn-black">{#cancel_button#}</a>
            </div>
            <div class="col-12 col-sm-6 mb-1">
                <a href="#" class="d-block text-uppercase btn btn-success" data-action="destroy">{#give_up#} :)</a>
            </div>
        </div>
    </div>
    <div class="w-100" v-else>
        <div class="block-title text-primary mb-2 border-bottom border-light">
            {#cancel_completed#}
        </div>
        <div class="pb-2 mb-2 border-bottom">
            {#cancel_description#}
        </div>
        <div class="row">
            <div class="col-12 col-sm-6 mb-1">
                <a href="/" class="d-block text-uppercase btn btn-black">{#return_home#}</a>
            </div>
        </div>
    </div>
</div>

<script>
    const cancelMe = {
        data() {
            return {
                display : true
            }
        },
        methods: {
            cancel() {
                const self = this;
                axios.post('/srv/service/customer/cancel-me').then(response => {
                    const res = response.data;
                    if (res.success) {
                        self.display = false;
                    } else {
                        alert('Bir hata oluştu');
                    }
                });
            },
        },
    };
    Vue.createApp(cancelMe).mount('#cancel-me');
</script>