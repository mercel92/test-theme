<div class="col-12 position-relative d-flex">
    <a href="javascript:void(0);" onclick="window.history.back();" class="news-back-button btn btn-light text-uppercase fw-semibold text-content ml-auto">
        <i class="ti-arrow-left"></i> {#back#}
    </a>
</div>
<div class="w-100 d-flex align-items-center justify-content-center mb-3 mt-1">
    <div class="col-12 col-md-10">
        <div class="col-12 p-2 bg-light border-round">
            <div class="row">
                <div class="col-12 position-relative mb-1">
                    <div class="news-date text-content fw-bold d-flex align-items-center"><i class="ti-calendar"></i> {$NEWS.DATE}</div>
                    <h1 class="news-title fw-bold">{$NEWS.TITLE}</h1>
                </div>
                <div class="col-12 news-detail-text fw-medium mb-2">{$NEWS.TEXT}</div>
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
        <div class="pl-1 d-none">
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