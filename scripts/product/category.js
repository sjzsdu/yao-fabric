function TreeSelect(data) {
    const arr = all(data);
    const narr = arr.map(element => {
        return { ...element, title: element.name, value: element.id }
    });
    const tree = Process('xiang.helper.ArrayTree', narr, { parent: 'parent_id' });
    return tree;
}

function TreeTable(data) {
    return { data: TreeSelect(data) };
}


function Select(data) {
    const arr =  all(data);
    return arr.map(element => {
        return { ...element, label: element.name, value: element.id }
    });
}

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

function all(data) {
    const wheres = getWheres(data);
    const options = {
        wheres,
        withs: { 
            parent: {
                query: { select: ['id', 'name']}
            }
        }
    }
    return Process('models.product.category.Get', options);  
}