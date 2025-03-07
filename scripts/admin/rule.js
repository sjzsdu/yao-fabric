const bools = ['blocks', 'visible_menu'];
function walkArr(arr, callback) {
    for (let item of arr) {
        callback(item)
        if (item.children) {
            walkArr(item.children, callback)
        }
    }
}


function BeforeSave(payload) {
    for (let field of bools) {
        if (payload[field]) {
            payload[field] = Boolean(Number(payload[field]));
        }
    }
    return payload;
}

function Tree(data) {
    console.log('menu.tree', data);
    const rules = Process('yao.rule.menus', ['sys', 'pro', 'crm'], false);
    walkArr(rules, rule => {
        rule.value = rule.rule;
        rule.key = rule.rule;
        rule.label = rule.name;
    })
    return rules;
}

function TreeSelect(data) {
    const arr = all(data);
    const narr = arr.map(element => {
        return { ...element, title: element.name, value: element.id }
    });
    const tree = Process('xiang.helper.ArrayTree', narr, { parent: 'parent_id' });
    return tree;
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
        },
        orders: [{column: 'order', option: 'desc'}]
    }
    return Process('models.admin.menu.Get', options);  
}