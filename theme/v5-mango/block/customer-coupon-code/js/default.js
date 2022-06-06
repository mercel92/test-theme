const PageCouponCodes = {
    data() {
        return {
            endpoints: {
                get: '/srv/service/profile/get-coupon-list/'
            },
            DATA: {},
            RECORDS: {}
        }
    },
    methods: {
        load() {
            const self = this;
            axios.get(self.endpoints.get).then(response => {
                self.DATA = response.data;
                self.RECORDS = response.data.COUPON_LIST;
                setTimeout(() => initComponents(), 50);
            }).catch(error => `Get coupon codes error => ${error}`);
        },
        copyCode(code) {
            const elem = document.createElement('textarea');
            elem.value = code;
            document.body.appendChild(elem);
            elem.select();
            document.execCommand('copy');
            document.body.removeChild(elem);
        },
        filterActiveCoupons() {
            if (this.$refs.filterActiveCoupons.checked) {
                this.DATA.COUPON_LIST = Array.from(this.RECORDS).filter(coupon => coupon.IS_USED == 0);
            } else {
                this.DATA.COUPON_LIST = this.RECORDS;
            }
        }
    },
    mounted() {
        this.load();
    }
}

Vue.createApp(PageCouponCodes).mount('#page-my-coupon-codes');