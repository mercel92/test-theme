const Personalization = Vue.createApp({
    data() {
        return {
            endpoints: {
                get: '/srv/service/personalization/get/',
                uploadImg : '/conn/product/Personalization/sendImage/',
            },
            product: T('#product-personalization-wrapper')[0].dataset.id,
            variant: T('#product-personalization-wrapper')[0].dataset.sub,
            form: T('#product-personalization-wrapper')[0].dataset.form,
            data: {},
            validateStatus : false,
            formData : {},
        }
    },
    methods: {
        format(p) {
            return T.format(p);
        },
        vat(p, vat) {
            return T.vat(p, vat);
        },
        load() {
            const self = this;
            axios.get(`${self.endpoints.get}${self.form}/${self.variant}/${self.product}`).then(response => {
                self.data = response.data;
                setTimeout(() => {
                    Array.from(T('.personalization-package-list .qty')).forEach(qty => {
                        const value = qty.querySelector('input').value;
                        self.packageQty(value, 0, qty);
                    });
                    self.price();
                    initComponents();
                }, 150);
            }).catch(error => console.warn(`Error personalizatiıon => ${error}`));
        },
        keyup(event) {
            const self = this,
                  element = event.target;

            self.checkValidity(element.id);
            self.price(element);
        },
        change(event) {
            const self = this,
                  element = event.target;

            if (element.type == 'checkbox') element.value = element.checked == true ? 1 : '';
            if (element.type == 'radio') {
                const groups = T(`[name="${element.name}"]`);
                Array.from(groups).forEach(el => {
                    el.value = 0;
                });
                element.value = 1;
            }

            self.checkValidity(element.id);
            self.price(element);
        },
        radioCancel(event) {
            const self = this,
                  element = event.target;
            if (element.value == 1) {
                element.value = 0;
                element.checked = false;
            }
            self.checkValidity(element.id);
            self.price(element);
        },
        focusImgText(imgId) {
            T(`.sub-product-list [data-id="${imgId}"]`).trigger('click');
        },
        keyupImgText(imgId, inputId, data) {
            const self = this,
                  element = T(`#${inputId}`)[0],
                  image = T(`.product-detail-images [data-id="${imgId}"]`),
                  value = {};

            Array.from(data).forEach(el => {
                const val = T(`#${el.id}`)[0].value || '',
                      name = T(`#${el.id}`)[0].name,
                      imgElement = T(`#img${el.id}`);

                if (val.trim() != '') {
                    value[name] = val;
                    if (imgElement.length > 0) {
                        T(imgElement)[0].innerHTML = val;
                    } else {
                        const text = document.createElement('div');
                            text.innerHTML = val;
                            text.className = el.cls;
                            text.classList.add('personalization-product-image-text');
                            text.style = el.style;
                            text.id = 'img' + el.id;
                        image.length > 0 ? T(image)[0].append(text) : T('.product-detail-images')[0].append(text);
                    }
                } else {
                    if (imgElement.length > 0) T(imgElement)[0].remove();
                }
            });

            element.value = Object.keys(value).length > 0 ? JSON.stringify(value) : '';

            self.checkValidity(inputId);
            self.price(element);
        },
        doubleChange(inputId, data) {
            const self = this,
                  element = T(`#${inputId}`)[0],
                  value = [];
            Array.from(data).forEach(el => {
                if (T(`#${el.id}`)[0].value.trim() != '') {
                    value.push(T(`#${el.id}`)[0].value);
                }
            });
            element.value = value.join('-');
            self.checkValidity(inputId);
            self.price(element);
        },
        imageboxChange(el, event) {
            const self = this,
                  inputId = el.dataset.id,
                  eventId = event.id;
            const element = T(`#${inputId}`)[0];

            if (!event.closest(`#dropdown-menu-${inputId}`)) return;

            const data = Array.from(self.data.data).find(x => x.id == inputId);
            if (eventId) {
                const optData = Array.from(data.secenekler).find(x => x.id == eventId);
                element.value = optData.secenek;
                data['dropdown'] = optData;
            } else {
                delete data.dropdown;
                element.value = '';
            }

            self.checkValidity(inputId);
            self.price(element);
        },
        editorChange(event, data, id) {
            const self = this,
                  element = event.target;

            const select = Array.from(data).find(x => x.secenek == element.value);
            T(`#editor-html${id}`).html(select ? select.icerik : '');

            self.checkValidity(id);
            self.price(element);
        },
        packageQty(value, oldVal, qty) {
            const self = this,
                  inputId = qty.dataset.id,
                  dataId = qty.dataset.productid,
                  element = T(`#${inputId}`)[0],
                  arrValue = [];

            const package = Array.from(self.data.data).find(x => x.id == inputId);
            package.secenekler.forEach(el => {
                const count = T(`#count${el.product_id}`)[0].value;
                if (count > 0) {
                    const arr = {
                        "count": count, 
                        "product_id": el.product_id
                    };
                    arrValue.push(arr);
                }
            });
            element.value = JSON.stringify(arrValue);

            const data = Array.from(package.secenekler).find(x => x.id == dataId);
            let total = 0;
            total += data.fiyat * parseFloat(value);
            T(`#total${dataId}`).text(self.vat(total, data.vat) + ' ' + data.currency);

            self.checkValidity(inputId);
            self.price(element);
        },
        priceMultiKeyup(inputId, data) {
            const self = this,
                  element = T(`#${inputId}`)[0],
                  value = {};

            let status = 1;
            Array.from(data).forEach(el => {
                const val = parseFloat(T(`#${el.id}`)[0].value.trim()) || 0,
                      name = T(`#${el.id}`)[0].name;
                val == '' ? status = 0 : value[name] = val;
            });
            element.value = status == 1 ? JSON.stringify(value) : '';

            self.checkValidity(inputId);
            self.price(element);
        },
        getBase64Image(img) {
            const canvas = document.createElement("canvas");
            canvas.width = img.width;
            canvas.height = img.height;
            var ctx = canvas.getContext("2d");
            ctx.drawImage(img, 0, 0);
            const dataURL = canvas.toDataURL("image/jpg");
            return dataURL.replace(/^data:image\/(png|jpg);base64,/, "");
        },
        handleFiles(event, data) {
            const self = this;
                  element = event.target,
                  data['files'] = [];

            const eventFiles = element.files;
            if (eventFiles.length > element.dataset.max) {
                T.modal({
                    html: `{#most#} ${element.dataset.max} {#upload_picture#}`,
                    width: '580px'
                });
                return;
            } else if (eventFiles.length < element.dataset.min) {
                T.modal({
                    html: `{#least#} ${element.dataset.min} {#upload_picture#}`,
                    width: '580px'
                });
                return;
            }
            for(let i=0; i<eventFiles.length; i++) {
                setTimeout(() => {
                    const img = document.createElement('img');
                    img.src = URL.createObjectURL(eventFiles[i]);
                    img.onload = () => {
                        data['files'].push(eventFiles[i]);
                        data.files[i].src = self.getBase64Image(img);
                    };
                }, (i * 200));
            }
        },
        imgUpload(event, files, id) {
            const self = this,
                  formData = new FormData(),
                  file_names = [],
                  name = event.target.dataset.name,
                  element = T(`#${id}`)[0];

            T.buttonLock.dom = event.target;
            T.buttonLock.lock();

            for (let i=0; i<files.length; i++) {
                const file = files[i];
                file_names.push(file.name);
                formData.append("file" + i, file);
                formData.append("input_name", name);
            }

            formData.append('url', document.URL);
            
            axios.post(`${self.endpoints.uploadImg}${self.product}`, formData).then(response => {
                const result = response.data;
                if (result.status == 1) {
                    if (typeof result.images !== 'undefined' && result.images.length > 0) {
                        element.value = result.images.join(' - ');
                    } else {
                        element.value = file_names.join(' - ');
                    }
                    T.notify({
                        text: result.images.length || file_names.length > 1 ? '{#pictures_upload_success#}' : '{#picture_upload_success#}',
                        className: 'success',
                        stopOnFocus : true,
                        duration: 3000,
                        iconClass :'ti-thumbs-up',
                    });
                    if (typeof PersonalizationUploadCallback == 'function') {
                        PersonalizationUploadCallback(result, element);
                    }
                    self.checkValidity(id);
                    self.price(element);
                } else {
                    T.modal({
                        html: `{#img_error_${result.status}#}`,
                        width: '580px'
                    });
                }
                T.buttonLock.unlock();
            });
        },
        price(el = null) {
            const self = this;

            if (el != null) {
                const data = Array.from(self.data.data).find(x => x.id == el.id);
                if (data.fiyat == 0 && data.secenekler.length == 0) return;
            }

            const elementPrice = T('.product-price')[0] || T('.product-price-not-vat')[0] || null,
                elementNotDiscounted = T('.product-price-not-discounted')[0] || T('.product-price-not-discounted-not-vat')[0] || null,
                productVat = PRODUCT_DATA && PRODUCT_DATA[0] ? (PRODUCT_DATA[0].vat || 0) : 0;

            if (elementPrice == null) return;

            const price = elementPrice.dataset.price || elementPrice.innerText || 0;
            let parsePrice = SEP_THO === ',' ? parseFloat(price.replace(',', '')) : SEP_DEC == "," ? parseFloat(price.replace('.', '').replace(',', '.')) : parseFloat(price);
            elementPrice.dataset.price = price;

            const notDiscounted = elementNotDiscounted != null ? elementNotDiscounted.dataset.price || elementNotDiscounted.innerText || 0 : null;
            let parseNotDiscounted = notDiscounted != null ? SEP_THO === ',' ? parseFloat(notDiscounted.replace(',', '')) : SEP_DEC == "," ? parseFloat(notDiscounted.replace('.', '').replace(',', '.')) : parseFloat(notDiscounted) : null;
            if (elementNotDiscounted != null) elementNotDiscounted.dataset.price = notDiscounted;

            let addPrice = 0.0;
            Array.from(self.data.data).forEach(el => {
                const element = T(`#${el.id}`)[0],
                    elementVat = el.kdvDahil == 1,
                    type = el.tip;

                if (!element) return;

                if ((type.indexOf("\"text\"") > -1 || type == 'textarea' || type == 'select' || type == 'double_select' || type == 'product_image_text' || type == 'image_upload') && element.value.trim() !== '') {
                    addPrice += elementVat ? el.fiyat / (1 + productVat / 100) : el.fiyat;
                } else if ((type.indexOf("\"checkbox\"") > -1)) {
                    addPrice += element.value == 0 || element.value == '' ? 0 : elementVat ? el.fiyat / (1 + productVat / 100) : el.fiyat;
                } else if (type == 'price_multiplier') {
                    let multiply = parseFloat(el.varsayilan);
                    multiply = multiply > 0.0 ? multiply : 1;
                    if (element.value.trim() !== '') {
                        const data = JSON.parse(element.value);
                        for (var i in data) {
                            multiply = data[i] * multiply;
                        }
                    }
                    parsePrice = multiply * parsePrice;
                    parseNotDiscounted = multiply * parseNotDiscounted;
                } else if (type == 'price_multiplier_select') {
                    let multiply = 1;
                    const val = element.options[element.selectedIndex].dataset.value;
                    if (val.trim() !== '') {
                        multiply = parseFloat(val) * multiply;
                    }
                    parsePrice = multiply * parsePrice;
                    parseNotDiscounted = multiply * parseNotDiscounted;
                } else if (type == 'package') {
                    Array.from(el.secenekler).forEach(product => {
                        const count = T(`#count${product.product_id}`)[0].value;
                        let total = product.fiyat * parseFloat(count);
                        addPrice += total * (100 + parseInt(product.vat)) / 100;
                    });
                } else if (type == 'select' || type == 'imagebox') {
                    Array.from(el.secenekler).forEach(opt => {
                        if (opt.secenek.replace(/[\"\{#\}]/ig, '') == element.value.replace(/[\"\{#\}]/ig, '')) {
                            addPrice += opt.fiyat > 0 ? (elementVat ? opt.fiyat / (1 + productVat / 100) : opt.fiyat) : 0;
                        }
                    });
                }
            });

            elementPrice.innerText = self.format((addPrice * (1 + productVat / 100)) + parsePrice);
            if (elementNotDiscounted != null) elementNotDiscounted.innerText = self.format((addPrice * (1 + productVat / 100)) + parseNotDiscounted);

            return true;

        },
        checkValidity(el) {
            const self = this;

            let element;
            if (typeof el == 'string') {
                element = T(`#${el}`)[0];
                el = Array.from(self.data.data).find(x => x.id == el);
                self.error(0, element);
                if (el.regex && el.regex != '' && self.regex(element, el.regex) == false) {
                    return false;
                }
            } else if (typeof el == 'object') {
                element = T(`#${el.id}`)[0];
            }

            if (!element) return;

            const value = element.value.trim().length;
            if (el.regex && el.regex != '' && value > 0 && self.regex(element, el.regex) == false) {
                return false;
            } else if (el.zorunlu == '1' && value == 0) {
                self.error(1, element, 'Bu alan zorunludur');
                return false;
            } else if (el.min != '' && value > 0 && value < el.min) {
                self.error(1, element, `{#min#} ${el.min} {#enter_character#}`);
                return false;
            } else if (el.max != '' && value > el.max) {
                self.error(1, element, `{#max#} ${el.max} {#enter_character#}`);
                return false;
            } else {
                self.error(0, element);
                return true;
            }

        },
        validate() {
            const self = this,
                  data = [];

            self.validateStatus = true;
            Array.from(self.data.data).forEach(el => {       
                const form = {
                    baslik : el.baslik || '',
                    value : T(`#${el.id}`).length > 0 ? T(`#${el.id}`)[0].value : el.baslik,
                    active : 1
                };
                data.push(form);
                if (self.checkValidity(el) == false) {
                    self.validateStatus = false;
                }
            });

            if (self.validateStatus == true) {
                self.formData = {
                    ['formData[form_id]'] : self.form,
                    ['formData[product_id]'] : self.product,
                    ['formData[sub_product_id]'] : self.variant,
                    ['formData[data]'] : JSON.stringify(data)
                }
            }
        },
        regex(element, regex) {
            const self = this,
                  rgx = new RegExp(regex, 'ig');

            if (rgx.test(element.value.trim()) === false) {
                self.error(1, element, '{#error_enter#}');
                return false;
            } else {
                self.error(0, element);
            }
        },
        error(error = null, element = null, msg = null) {
            if (error == 0) {
                if (element == null) return;
                const item = element.closest('.popover-wrapper').querySelector('.popover-item');
                if (item == null) return;
                popoverAlert.hide(item, ['btn', 'btn-outline-danger', 'text-left']);
                return;
            } else if (error == 1) {
                popoverAlert.show(
                    T(`#${element.id}`)[0], msg, false, `btn btn-danger text-left`, true, 'inline'
                );
            }
        },
        dataSplit(data) {
            Array.from(data).forEach(el => {
                if (typeof el.secenek == 'string') {
                   el.secenek = el.secenek.split("-");
                }
            });
            return data;
        },
        popupImg(img) {
            T.modal({
                html : `<div class="d-flex align-items-center justify-content-center">
                           <img class="border-round" src="${img}"> 
                        </div>`,
                width : 'auto'
            });
        }
    },
    mounted() {
        this.load();
        window[`imageboxChange`] = (element, eventTarget) => {
            this.imageboxChange(element, eventTarget);
        };
        window[`packageQty`] = (value, oldVal, qty) => {
            this.packageQty(value, oldVal, qty);
        };
    }
});

window['PERSONALIZATION'] = Personalization.mount('#personalization');