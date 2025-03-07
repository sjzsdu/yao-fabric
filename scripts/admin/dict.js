function AfterSearch(result) {
    // if (result.data) {
    //     result.data.forEach(row => {
    //         if (row.items && row.items.length) {
    //             row.items = row.items.map(item => item.label)
    //         }
    //     })
    // }
    return result;
}


function Select(data) {
    const dicts =  Process('models.admin.dict.Get', {
        wheres: [
            { column: 'name', value: data.name },
        ]
    })
    if (!dicts || !dicts.length) {
        return []
    }
    const dict = dicts[0]
    return dict.items.map((item, index) => {
        return { ...item, label: item.label, value: item.label, selected: Boolean(item.status) }
    });
}