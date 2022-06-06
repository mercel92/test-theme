const PageCP = {
    data() {
        return {
            endpoints: {
                get: '/srv/service/profile/get-current-payment-list'
            },
            DATA: {},
            CURRENT_MOVEMENTS : []
        }
    },
    methods: {
        date(date) {
            return T.timeConverter(date, 'd.m.y')
        },
        format(p) {
            return T.format(p);
        },
        load(start_date, end_date) {
            const self = this;
            axios.get(self.endpoints.get).then(response => {
                self.DATA = response.data;
                if (start_date == undefined && end_date == undefined) {
                    self.CURRENT_MOVEMENTS = response.data.CURRENT_MOVEMENTS;
                    return;
                } else {
                    const one_date = new Date(start_date),
                          two_date = new Date(end_date);
                    self.CURRENT_MOVEMENTS = [];
                    Array.from(response.data.CURRENT_MOVEMENTS).forEach(e => {
                        const repDate = T.timeConverter(e.TIMESTAMP, 'y-m-d'),
                              eDate = new Date(repDate);
                        if (eDate >= one_date && eDate <= two_date) {
                            self.CURRENT_MOVEMENTS.push(e);
                        }
                    });
                }
            }).catch(error => `Get member current payment error => ${error}`);
        },
        dateFiltre() {
            const self = this,
                        start_date = document.getElementById('first-date').value.split('.');
                        end_date = document.getElementById('last-date').value.split('.');
            self.load(`${start_date[2]}-${start_date[1]}-${start_date[0]}`, `${end_date[2]}-${end_date[1]}-${end_date[0]}`);
        },
    },
    mounted() {
        this.load();

        flatpickr(document.getElementById('first-date'), {
            dateFormat: 'd.m.Y',
            defaultDate : 'today',
            "disable": [
                function(date) {
                    return
                }
            ],
            onChange : (selectedDates, dateStr, instance) => {
                two_date.set('minDate', dateStr);
                two_date.open();
            }
        });
        const two_date = flatpickr(document.getElementById('last-date'), {
            dateFormat: 'd.m.Y',
            defaultDate : 'today',
            "disable": [
                function(date) {
                    return
                }
            ],
        });
    }
}

Vue.createApp(PageCP).mount('#page-my-cp');