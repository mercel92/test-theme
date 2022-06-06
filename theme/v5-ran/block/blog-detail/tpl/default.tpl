<div class="col-12">
    <div class="w-100 bg-light mb-2">
        <div class="row justify-content-center">
            <div class="col-12 col-md-10">
                <div class="d-flex align-items-center justify-content-center mb-2">
                    <img src="{if $B.IMAGE_URL != ''}{$B.IMAGE_URL}{else}{$B.IMAGE}{/if}" alt="{$B.TITLE}">
                </div>
                <div class="col-12">
                    <div class="row align-items-flex-end justify-content-between">
                        <div class="col-auto mb-1">
                            <h1 class="fw-bold blog-title m-0">{$B.TITLE}</h1>
                        </div>
                        <div class="col-auto mb-1">
                            <div class="blog-date d-flex align-items-center">
                                <i class="ti-calendar mr-1"></i> {$B.DAY}.{$B.MONTH}.{$B.YEAR}
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-12 blog-detail-text text-gray mb-2">{$B.TEXT}</div>
            </div>
        </div>
    </div>
</div>
<div class="col-12 mb-3 share-buttons">
    <div class="row align-items-center">
        <div class="pl-1 fw-medium text-content">{#share#} : </div>
        <div class="pl-1">
            <a href="https://www.facebook.com/sharer/sharer.php?u={$smarty.server.SCRIPT_URI}" class="border border-round facebook" target="_blank"><i class="ti-facebook"></i></a>
        </div>
        <div class="pl-1">
            <a href="https://twitter.com/share?url={$smarty.server.SCRIPT_URI}&text={$B.TITLE}" class="border border-round twitter" target="_blank"><i class="ti-twitter"></i></a>
        </div>
        <div class="pl-1">
            <a href="http://pinterest.com/pin/create/button/?url={$smarty.server.SCRIPT_URI}&media={$smarty.server.HTTP_HOST}/{$B.IMAGE}&description={$B.TITLE}" class="border border-round pinterest"
               target="_blank"><i class="ti-pinterest"></i></a>
        </div>
        <div class="pl-1">
            <a href="http://www.linkedin.com/shareArticle?url={$smarty.server.SCRIPT_URI}" class="border border-round linkedin" target="_blank"><i class="ti-linkedin"></i></a>
        </div>
        <div class="pl-1">
            <a href="http://reddit.com/submit?url={$smarty.server.SCRIPT_URI}&title={$B.TITLE}" class="border border-round reddit" target="_blank"><i class="ti-reddit"></i></a>
        </div>
        <div class="pl-1">
            <a href="https://wa.me/?text={$smarty.server.SCRIPT_URI} - {$B.TITLE}" class="border border-round whatsapp" target="_blank"><i class="ti-whatsapp"></i></a>
        </div>
    </div>
</div>