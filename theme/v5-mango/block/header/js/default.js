window.headerMemberLoginFn = (result, options) => {
    popoverAlert.show(
        document.getElementById(`${options.prefix}${options.type || 'email'}`), 
        result.message, 
        2400, 
        `btn ${(result.status === true) ? 'btn-success' : 'btn-danger'} text-left`,
        false
    );

    if(result.status === true) {
        setTimeout(() => {
            window.location.href = result.page.url || '/';
        }, 2000);
    }
}

const AllCategories = {
    data() {
        return {
            CATEGORIES: [],
            LOAD : true,
        }
    },
    methods: {
        get(id = '', parentId = '') {
            const self = this;
            axios.get(`/srv/service/category/get/${id}`).then(response => {
                if (parentId != '') {
                    const findCat = Array.from(self.CATEGORIES).find(c => c.ID == parentId);
                    const findCat2 = Array.from(findCat.CHILDREN).find(c => c.ID == id);
                    findCat2['CHILDREN'] = response.data;
                } else if (id != '') {
                    const findCat = Array.from(self.CATEGORIES).find(c => c.ID == id);
                    findCat['CHILDREN'] = response.data;
                } else {
                    self.CATEGORIES = response.data;
                }
                self.LOAD = false;
            }).catch(error => console.warn(`Categories not loaded => ${error}`));
        },
    }
};

Vue.createApp(AllCategories).mount(`#menu-all-categories-${BLOCK.ID}`);

window[`headercart-cb-${BLOCK.ID}`] = () => {
    loadSubFolder({
        pageId: 30,
        blockParentId: 1054,
        subFolder: 'header-cart',
        success:  function(loadRes){
            let popupContent = T(`#header-cart-panel-${BLOCK.ID} .drawer-body`);
            popupContent.html(loadRes);
            evalScripts(popupContent[0].innerHTML);
        }
    });
}

window.onscroll = () => {
    if (document.body.scrollTop > T('header').height() || document.documentElement.scrollTop > T('header').height()) {
    T(`#scroll-to-up-${BLOCK.ID}`).show();
    } else { T(`#scroll-to-up-${BLOCK.ID}`).hide(); }
};
T(`#scroll-to-up-${BLOCK.ID}`).on('click', () => {
    scroll({ top: 0, behavior: "smooth" });
});

if (T('[data-search="live-search"]').length > 0) {
    const dynamicSearch = {
        data() {
            return {
                data : '',
                searchVal : '',
            }
        },
        mounted() {
            const self = this;
            const srv = T('#live-search')[0].dataset.licence == '1' ? '/srv/service/product/searchAll/' : '/srv/service/product/search/';

            var timer = null;
            T('#live-search').on('keyup', () => {
                clearTimeout(timer);
                if (self.searchVal.length >= 3) {
                    timer = setTimeout(() => {
                        axios.get(`${srv}${self.searchVal}`).then(response => {
                            self.data = response.data;
                        });
                    }, 250);
                } else {
                    self.data = '';
                }
            });

            document.addEventListener('click', e => {
                var Dom = e.target.nodeName == 'I' ? e.target.parentElement : e.target;
                const parentDom = Dom.closest('#search');
                if (parentDom == null) {
                    self.searchVal = '';
                    self.data = '';
                }
            });
            
        },
    }
    Vue.createApp(dynamicSearch).mount(`#search`);
}