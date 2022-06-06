<div id="photo-detail-content" class="col-12 position-relative slider-block-wrapper" v-cloak>
    <div class="mb-1">
        <h2 class="block-title no-line">{{ data.GALLERY.NAME }}</h2>
    </div>
    <div class="w-100 position-relative slider-block-wrapper bg-light mb-1" v-if="data.PHOTO.length > 0">
        <div id="slider-photo-detail" class="swiper-container">
            <div class="swiper-wrapper">
                <div class="w-100 swiper-slide image-wrapper ratio-4x3" v-for="P in data.PHOTO">
                    <span class="image-inner">
                        <img :src="P.IMAGE" :src="P.IMAGE">
                    </span>
                </div>
            </div>
        </div>
        <div id="swiper-prev-photo" class="swiper-button-prev outside"><i class="ti-arrow-left"></i></div>
        <div id="swiper-next-photo" class="swiper-button-next outside"><i class="ti-arrow-right"></i></div>
    </div>
    <div class="mb-1" v-if="data.CATEGORY.NAME">
        <a :href="data.CATEGORY.LINK" class="text-primary" v-html="data.CATEGORY.NAME"></a>
    </div>
    <div v-html="data.GALLERY.DESCRIPTION"></div>
</div>

<script>
    let DATA = {};
    try {
        DATA = {$DATA};
    } catch (ex) {
        DATA = {}
    }
    
    const photoDetail = {
        data() {
            return {
                data: DATA,
            }
        },
    };

    Vue.createApp(photoDetail).mount('#photo-detail-content');

    if (DATA.PHOTO.length > 0) {
        new Swiper('#slider-photo-detail', {
            spaceBetween: 0,
            navigation: {
                nextEl: '#swiper-next-photo',
                prevEl: '#swiper-prev-photo',
            },
        });
    }
</script>