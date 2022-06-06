<div id="complete-campaign-form p-1" v-cloak>
    <div class="block-title mb-1">
        {#campaing#}
    </div>
    <div class="mb-1">
        {#special_campaings#} <a :href="link" class="text-primary">{#click#}</a>
    </div>
    <div class="row">
        <div class="col-6">
            <button type="button" class="btn btn-success w-100" @click="ready()">{#review#}</button>
        </div>
        <div class="col-6">
            <button type="button" class="btn btn-black w-100" @click="cancel()">{#dont_campaing#}</button>
        </div>
    </div>
</div>

<script>
    window['completeCampaingForm'] = {
        data() {
            return {
                link: '',
            }
        },
        methods: {
            init(result) {
                const self = this;
                const cmp = result.completedCampaigns;
                if(typeof cmp == "undefined"){
                    vm.$router.push('/approve');
                    self.link = "";
                    T('.t-modal-backdrop').trigger('click');
                }
                else {
                    self.link = cmp.campaignChooseLink;
                }
            },
            cancel() {
                T('.t-modal-backdrop').trigger('click');
            },
            ready() {
                const self = this;
                window.location.href = self.link;
                return false;
            },
        },
    }

    Vue.creatApp(completeCampaingForm).mount('#complete-campaign-form');
</script>