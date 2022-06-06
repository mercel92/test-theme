<div id="product-images-list" class="row" v-cloak>
    <div class="col-12" v-if="data.IMAGE_LIST.length > 0">
        <div class="row">
            <div class="col-6">
                <div class="col-12 pr-0 border-top border-left">
                    <div class="row">
                        <div class="col-6 col-md-4 border-bottom border-right" v-for="(image, index) in data.IMAGE_LIST">
                            <a href="javascript:void(0);" class="image-wrapper" @click="selectedImg = image">
                                <figure class="image-inner">
                                    <img :src="image.SMALL" :alt="image.TITLE + ' (' + (index + 1) + ')'" class="d-block">
                                </figure>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-6" v-if="selectedImg != ''">
                <img :src="selectedImg.BIG" :alt="selectedImg.TITLE" class="border">
            </div>
        </div>
    </div>
</div>
<script>
    let DATA = {};
    try {
        DATA = JSON.parse(`{$DATA}`);
    } catch (ex) {
        DATA = {};
    }

    const ImagesList = {
        data() {
            return {
                data: DATA,
                selectedImg: ''
            }
        },
        created() {
            if(this.data.IMAGE_LIST.length > 0) {
                this.selectedImg = this.data.IMAGE_LIST[0];
            }
        }
    };

    Vue.createApp(ImagesList).mount('#product-images-list');
</script>