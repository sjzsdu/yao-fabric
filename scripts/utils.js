function getWheres(data) {
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
    return wheres;
}

module.exports = {
    getWheres
}