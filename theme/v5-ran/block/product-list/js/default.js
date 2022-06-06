const dynamicallyLoad = T(`#is-auto-load-active-${BLOCK.ID}${BLOCK.PARENT_ID}`);
if (dynamicallyLoad.length == 1) {
    productLoader({
        blockId: BLOCK.ID,
        page: 2
    });
}