T(`.set-campaing-${BLOCK.ID}`).on('click', e => {
    const id = e.target.dataset.id;
    const group = e.target.dataset.group;

    axios.get('/conn/CampaignV2/Campaign/selectCampaign/' + group + '/' + id).then(function (res) {
        const result = res.data;
        T.notify({
            text: res.data.statusText,
            className: result.status == 0 ? 'danger' : 'success',
            stopOnFocus : true,
            duration: 2400,
            iconClass : result.status == 0 ? 'ti-thumbs-down' : 'ti-thumbs-up',
        });
    });
});