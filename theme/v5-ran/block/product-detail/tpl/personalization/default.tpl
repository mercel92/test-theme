<div id="personalization" v-cloak>
    <form id="personalization-form" class="row" autocomplete="off" v-if="data">
        <div class="col-12" v-for="(p, index) in data.data">

            <!-- input text -->
            <div class="w-100 mb-1" v-if='p.tip.indexOf("\"text\"") > -1'>
                <label :for="p.id" v-if="p.baslik || p.fiyatAciklama">
                    {{ p.baslik }} <span class="fw-bold text-primary" v-if="p.fiyatAciklama"> ({{ p.fiyatAciklama }})</span>
                </label>
                <div class="w-100 popover-wrapper position-relative mb-1">
                    <input class="personalization-item form-control form-control-md"
                    type="text"
                    :name="'element_' + index"
                    :id="p.id"
                    :placeholder="p.varsayilan"
                    :minlength="p.min"
                    :maxlength="p.max"
                    @keyup="keyup($event)">
                </div>
            </div>
            <!-- input text -->

            <!-- select -->
            <div class="w-100" v-if="p.tip == 'select'">
                <label :for="p.id" v-if="p.baslik || p.fiyatAciklama">
                    {{ p.baslik }} <span class="fw-bold text-primary" v-if="p.fiyatAciklama"> ({{ p.fiyatAciklama }})</span>
                </label>
                <div class="w-100 popover-wrapper position-relative mb-1">
                    <select class="personalization-item form-control form-control-md"
                    :name="'element_' + index"
                    :id="p.id"
                    @change="change($event)">
                        <option value="" v-if="p.varsayilan"> {{ p.varsayilan }} </option>
                        <option value="" v-else> {#choose#} </option>
                        <option :value="opt.secenek" v-for="opt in p.secenekler">
                            {{ opt.secenek }}
                        <option>
                    </select>
                </div>
            </div>
            <!-- select -->

            <!-- textarea -->
            <div class="w-100 mb-1" v-if="p.tip == 'textarea'">
                <label :for="p.id" v-if="p.baslik || p.fiyatAciklama">
                    {{ p.baslik }} <span class="fw-bold text-primary" v-if="p.fiyatAciklama"> ({{ p.fiyatAciklama }})</span>
                </label>
                <div class="w-100 popover-wrapper position-relative mb-1">
                    <textarea class="personalization-item form-control form-control-md"
                    :name="'element_' + index"
                    :id="p.id"
                    :placeholder="p.varsayilan"
                    :minlength="p.min"
                    :maxlength="p.max"
                    @keyup="keyup($event)">
                    </textarea>
                </div>
            </div>
            <!-- textarea -->

            <!-- çoklu secenek kutusu -->
            <div class="w-100" v-if="p.tip == 'double_select'">
                <label v-if="p.baslik || p.fiyatAciklama">
                    {{ p.baslik }} <span class="fw-bold text-primary" v-if="p.fiyatAciklama"> ({{ p.fiyatAciklama }})</span>
                </label>
                <div class="w-100 popover-wrapper position-relative hidden-popover">
                    <input type="hidden" :name="'element_' + index" :id="p.id" :placeholder="p.varsayilan">
                </div>
                <div class="row">
                    <div class="col-4 col-lg-3" v-for="select in dataSplit(p.secenekler)">
                        <div class="w-100 popover-wrapper position-relative mb-1">
                            <select class="personalization-item form-control form-control-md"
                            :id="select.id"
                            @change="doubleChange(p.id, p.secenekler)">
                                <option value="" v-if="select.varsayilan"> {{ select.varsayilan }} </option>
                                <option value="" v-else> {#choose#} </option>
                                <option :value="opt" v-for="opt in select.secenek">
                                    {{ opt }}
                                <option>
                            </select>
                        </div>
                    </div>
                </div>
            </div>
            <!-- çoklu seçenek kutusu -->

            <!-- resimli secenek kutusu -->
            <div class="w-100 mb-1 personalization-dropdown" v-if="p.tip == 'imagebox'">
                <label v-if="p.baslik || p.fiyatAciklama">
                    {{ p.baslik }} <span class="fw-bold text-primary" v-if="p.fiyatAciklama"> ({{ p.fiyatAciklama }})</span>
                </label>
                <div class="w-100 popover-wrapper position-relative">
                    <input type="hidden" :name="'element_' + index" :id="p.id" :placeholder="p.varsayilan">
                </div>
                <div class="w-100 dropdown">
                    <a href="javascript:void(0)" class="dropdown-title d-flex align-items-center border border-round text-body ti-arrow-down"
                    :data-id="p.id"
                    data-toggle="dropdown"
                    data-callback="imageboxChange">
                        <span v-if="p.dropdown" class="d-flex align-items-center h-100">
                            <span class="dropdown-image d-flex align-items-center" v-if="p.dropdown.resim">
                                <img :src="p.dropdown.resim" class="border-round">
                            </span>
                            {{ p.dropdown.secenek }}
                        </span>
                        <span v-else>{{ p.varsayilan ? p.varsayilan : '{#choose#}' }}</span>
                    </a>
                    <div class="dropdown-menu border border-round" :id="'dropdown-menu-' + p.id">
                        <a href="javascript:void(0)" class="d-flex align-items-center text-body dropdown-item border-bottom" 
                        v-if="p.dropdown"> 
                            <i class="mr-1 ti-close"></i> {#cancel_selection#}
                        </a>
                        <a href="javascript:void(0)" :id="imagebox.id" class="d-flex align-items-center text-body dropdown-item"
                        :class="{ 'border-bottom' : index != p.secenekler.length - 1 }" 
                        v-for="(imagebox, index) in p.secenekler">
                            <span class="dropdown-image d-flex align-items-center" v-if="imagebox.resim">
                                <img :src="imagebox.resim" class="border-round">
                            </span>
                            {{ imagebox.secenek }}
                        </a>
                    </div>
                </div>
            </div>
            <!-- resimli secenek kutusu -->

            <!-- editor -->
            <div class="w-100 mb-1" v-if="p.tip == 'editor'">
                <label :for="p.id" v-if="p.baslik || p.fiyatAciklama">
                    {{ p.baslik }} <span class="fw-bold text-primary" v-if="p.fiyatAciklama"> ({{ p.fiyatAciklama }})</span>
                </label>
                <div class="w-100 popover-wrapper position-relative mb-1">
                    <select class="personalization-item form-control form-control-md"
                    :id="p.id"
                    :name="'element_' + index"
                    @change="editorChange($event, p.secenekler, p.id)">
                        <option value="" v-if="p.varsayilan"> {{ p.varsayilan }} </option>
                        <option value="" v-else> {#choose#} </option>
                        <option :value="opt.secenek" v-for="opt in p.secenekler">
                            {{ opt.secenek }}
                        <option>
                    </select>
                </div>
                <div class="w-100" :id="'editor-html' + p.id"></div>
            </div>
            <!-- editor -->

            <!-- onay kutusu -->
            <!-- checkbox -->
            <div class="w-100 mb-1" v-if='p.tip.indexOf("\"checkbox\"") > -1 && p.group == ""'>
                <div class="w-100 popover-wrapper position-relative">
                    <input type="checkbox" :id="p.id" class="form-control" value="" @change="change($event)">
                    <label :for="p.id" class="m-0 d-flex align-items-center">
                        <span class="input-checkbox"><i class="ti-check"></i></span>
                        <span>{{ p.baslik }} <span class="fw-bold text-primary" v-if="p.fiyatAciklama"> ({{ p.fiyatAciklama }})</span></span>
                    </label>
                </div>
            </div>
            <!-- radio -->
            <div class="w-100 mb-1" v-if='p.tip.indexOf("\"checkbox\"") > -1 && p.group != ""'>
                <div class="w-100 popover-wrapper position-relative">
                    <input type="radio" :name="p.group" :id="p.id" class="form-control" value="" @change="change($event)" @click="radioCancel($event)">
                    <label :for="p.id" class="m-0 d-flex align-items-center">
                        <span class="input-radio"><i class="ti-check"></i></span>
                        <span>{{ p.baslik }} <span class="fw-bold text-primary" v-if="p.fiyatAciklama"> ({{ p.fiyatAciklama }})</span></span>
                    </label>
                </div>
            </div>
            <!-- onay kutusu -->

            <!-- sadece yazi -->
            <div class="w-100 personalization-text mb-1" v-if="p.tip == 'label'">
                <div v-html="p.baslik"></div>
            </div>
            <!-- sadece yazi -->

            <!-- sadece resim -->
            <div class="w-100 d-flex align-items-center mb-1" v-if="p.tip == 'onlyImage'">
                <a href="javascript:void(0)" class="d-flex align-items-center position-relative border-round personalization-image"
                @click="popupImg(p.baslik)">
                    <img class="border-round" :src="p.baslik">
                    <span class="text-center text-body text-underline fw-bold">{#click_to_zoom#}</span>
                </a>
            </div>
            <!-- sadece resim -->

            <!-- input fiyat çarpani -->
            <div class="w-100" v-if="p.tip == 'price_multiplier'">
                <label :for="p.id" v-if="p.baslik || p.fiyatAciklama">
                    {{ p.baslik }} <span class="fw-bold text-primary" v-if="p.fiyatAciklama"> ({{ p.fiyatAciklama }})</span>
                </label>
                <div class="w-100 popover-wrapper position-relative hidden-popover">
                    <input type="hidden" :name="'element_' + index" :id="p.id" :placeholder="p.varsayilan">
                </div>
                <div class="row">
                    <div class="col-6 col-sm-4" v-for="input in p.secenekler">
                        <div class="w-100 popover-wrapper position-relative mb-1">
                            <input class="personalization-item form-control form-control-md no-arrows"
                            type="number"
                            pattern="\d*"
                            :name="input.secenek"
                            :placeholder="input.secenek"
                            :id="input.id"
                            :minlength="p.min"
                            :maxlength="p.max"
                            @keyup="priceMultiKeyup(p.id, p.secenekler)">
                        </div>
                    </div>
                </div>
            </div>
            <!-- input fiyat çarpanı -->

            <!-- select fiyat çarpani -->
            <div class="w-100" v-if="p.tip == 'price_multiplier_select'">
                <label :for="p.id" v-if="p.baslik || p.fiyatAciklama">
                    {{ p.baslik }} <span class="fw-bold text-primary" v-if="p.fiyatAciklama"> ({{ p.fiyatAciklama }})</span>
                </label>
                <div class="w-100 popover-wrapper position-relative mb-1">
                    <select class="personalization-item form-control form-control-md"
                    :name="'element_' + index"
                    :id="p.id"
                    @change="change($event)">
                        <option value="" data-value="" v-if="p.varsayilan"> {{ p.varsayilan }} </option>
                        <option value="" data-value="" v-else> {#choose#} </option>
                        <option :data-value="opt.value" :selected="opt.selected" v-for="opt in p.secenekler">
                            {{ opt.secenek }}
                        <option>
                    </select>
                </div>
            </div>
            <!-- select fiyat çarpani -->

            <!-- resim uzerine yazi -->
            <div class="w-100" v-if="p.tip == 'product_image_text'">
                <label :for="p.id" v-if="p.baslik || p.fiyatAciklama">
                    {{ p.baslik }} <span class="fw-bold text-primary" v-if="p.fiyatAciklama"> ({{ p.fiyatAciklama }})</span>
                </label>
                <div class="w-100 popover-wrapper position-relative hidden-popover">
                    <input type="hidden" :name="'element_' + index" :id="p.id" :placeholder="p.varsayilan">
                </div>
                <div class="row">
                    <div class="col-6" v-for="input in p.secenekler">
                        <div class="w-100 popover-wrapper position-relative mb-1">
                            <input class="personalization-item form-control form-control-md"
                            type="text"
                            :name="input.secenek"
                            :placeholder="input.placeholder"
                            :id="input.id"
                            :maxlength="input.max"
                            @focus="focusImgText(input.image_id)"
                            @keyup="keyupImgText(input.image_id, p.id, p.secenekler)">
                        </div>
                    </div>
                </div>
            </div>
            <!-- resim uzerine yazi -->

            <!-- urun paketi -->
            <div class="w-100 mb-1" v-if="p.tip == 'package'">
                <label :for="p.id" v-if="p.baslik || p.fiyatAciklama">
                    {{ p.baslik }} <span class="fw-bold text-primary" v-if="p.fiyatAciklama"> ({{ p.fiyatAciklama }})</span>
                </label>
                <div class="w-100 popover-wrapper position-relative hidden-popover">
                    <input type="hidden" :name="'element_' + index" :id="p.id" :placeholder="p.varsayilan">
                </div>
                <div class="w-100 personalization-package-list border border-round">
                    <div class="col-12 personalization-package-head">
                        <div class="row align-items-center border-bottom">
                            <div class="col py-1 fw-bold">
                                {#product_name_and_price#}
                            </div>
                            <div class="col-3 py-1 fw-bold text-center">
                                {#count#}
                            </div>
                            <div class="col-3 py-1 text-right fw-bold">
                                {#total_price#}
                            </div>
                        </div>
                    </div>
                    <div class="col-12 personalization-package-item" v-for="product in p.secenekler">
                        <div class="row align-items-center">
                            <div class="col py-1">
                                <div class="mb-8">{{ product.secenek }}</div>
                                <div class="fw-bold"><span>{{ vat(product.fiyat, product.vat) }}</span> {{ product.currency }}</div>
                            </div>
                            <div class="col-3 py-1">
                                <div class="w-100 qty"
                                :data-id="p.id" :data-productid="product.id"
                                data-toggle="qty"
                                data-callback="packageQty">
                                    <span class="ti-minus"></span>
                                    <span class="ti-plus"></span>
                                    <input type="number" class="form-control no-arrows text-center"
                                    :id="'count' + product.product_id"
                                    :name="'count' + product.product_id"
                                    :min="product.min" :max="product.max" :value="product.count">
                                </div>
                            </div>
                            <div class="col-3 py-1 text-right">
                                <div :id="'total' + product.id" class="fw-bold text-primary"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- urun paketi -->

            <!-- resim yükleme -->
            <div class="w-100" v-if="p.tip == 'image_upload'">
                <div class="mb-8 fw-semibold" v-if="p.baslik">
                    {{ p.baslik }} <span class="fw-bold text-primary" v-if="p.fiyatAciklama"> ({{ p.fiyatAciklama }})</span>
                </div>
                <div class="w-100 popover-wrapper position-relative hidden-popover">
                    <input type="hidden" :name="'element_' + index" :id="p.id">
                </div>
                <div class="w-100 popover-wrapper position-relative hidden-popover mb-1">
                    <input type="file" :id="'img-'+p.id" class="form-control" :data-max="p.max_file_count" :data-min="p.min_file_count" multiple @change="handleFiles($event, p)">
                    <label :for="'img-'+p.id" class="form-control form-control-md d-flex align-items-center justify-content-between text-content">
                        <div class="images-upload-list" v-if="p.files && p.files.length > 0">
                            <span v-for="f in p.files">{{ f.name }}</span>
                        </div>
                        <div v-else>{#select_picture#}</div>
                        <i class="ti-picture text-primary"></i>
                    </label>
                </div>
                <div class="w-100 image-upload-list" v-if="p.files && p.files.length > 0">
                    <div class="row">
                        <div class="col-3 mb-1" v-for="f in p.files">
                            <div class="w-100 position-relative">
                                <a href="javascript:void(0)" class="d-flex align-items-center position-relative border-round image-upload-item"
                                    @click="popupImg('data:image/jpeg;base64,' + f.src)">
                                        <img class="border-round" :src="'data:image/jpeg;base64,' + f.src">
                                        <span class="text-center text-body text-underline fw-bold">{#click_to_zoom#}</span>
                                </a>
                            </div>
                        </div>
                        <div class="w-100">
                            <div class="col-3 mb-1">
                                <button :id="'imgUpload' + p.id" type="button" :data-name="'element_' + index" class="btn btn-primary text-center w-100" @click="imgUpload($event, p.files, p.id)">{#upload#}</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- resim yükleme -->
            
        </div>
    </form>
</div>