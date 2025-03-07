
function AfterSearch(result) {
    return result;
}

function AfterFind(result) {
    if (result && result.rule_ids && result.rule_ids.includes('*')) {
        result.rule_ids = getMenuIds();
        result.allMenu = true;
    }
    return result;
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


function getMenuIds(data) {
    const wheres = getWheres(data);
    const options = {
        wheres,
        select: ['id']
    }
    const menuIds = Process('models.admin.menu.Get', options);  
    return menuIds.map(item => item.id);
}

function all(data) {
    const wheres = getWheres(data);
    const options = {
        wheres,
        withs: {}
    }
    return Process('models.admin.role.Get', options);  
}