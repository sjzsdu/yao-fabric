function Select(data) {
    return all(data);
}


function all(data) {
    const wheres = getWheres(data);
    const options = {
        wheres,
    }
    const arr = Process('models.crm.company.Get', options);
    return arr.map(element => {
        return { ...element, label: element.name, value: element.id }
    });
}


function getWheres(data) {
    console.log('hahaha', data);
    const wheres = [
        { column: 'deleted_at', op: 'eq', value: null }
    ]
    if (data?.excludes) {
        if (Array.isArray(data.excludes)) {
            data.excludes.forEach(value => {
                wheres.push({ column: 'id', op: 'ne', value })
            })
        } else {
            wheres.push({ column: 'id', op: 'ne', value: data.excludes })
        }
    }
    if (data.ids) {
        if (Array.isArray(data.ids)) {
            data.ids.forEach(value => {
                wheres.push({ column: 'id', op: 'eq', value })
            })
        } else {
            wheres.push({ column: 'id', op: 'eq', value: data.ids })
        }
    }
    return wheres;
}