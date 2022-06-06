<div id="video-detail-content" class="col-12" v-cloak>
    <h2 class="block-title no-line mb-1" v-html="data.VIDEO.TITLE"></h2>
    <div class="mb-1">
        <div class="w-100 video-embed position-relative" v-html="data.VIDEO.Embed"></div>
    </div>
    <div class="mb-1">
        <a :href="'/' + data.CATEGORY.SEO_LINK" class="text-content text-primary fw-semibold">{{ data.CATEGORY.NAME }}</a>
    </div>
    <div v-html="data.VIDEO.DESCRIPTION"></div>
</div>

<script>
    let DATA = {};
    try {
        DATA = {$DATA};
    } catch (ex) {
        DATA = {}
    }

    const videoDetail = {
        data() {
            return {
                data: DATA,
            }
        },
    };

    Vue.createApp(videoDetail).mount('#video-detail-content');
</script>