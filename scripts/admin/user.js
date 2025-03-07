function Select(data) {
    return all(data);
}

// user 表更新后，同样更新对应的部门表，似乎这个功能不需要了
function AfterSave(result) {
    console.log('yayay', result);
    const user = Process('models.admin.user.Find', result)
    const { department_ids, id, role_ids } = user;
    UpdateDepartment(id, department_ids);
    return result;
}

function BeforeSave(payload) {
    console.log('beforesave', payload);
    // const { department_ids, id, role_ids } = payload;
    // UpdateDepartment(id, department_ids);
    return [payload]
}


function UpdateDepartment(user_id, department_ids) {
    Process('models.admin.user_department.DestroyWhere', {
        wheres: [
            {column: 'user_id', value: user_id }
        ]
    })

    Process('models.admin.user_department.EachSave', 
        department_ids.map(department_id => ({user_id, department_id}))
    );
}


function Search(data) {
    const {page, size, name, select} = data
    const res = Process('models.admin.user.Get', 
        {
            wheres: [
                { column: 'type', op: 'eq', value: 'staff' },
                { column: 'name', op: 'like', value: '%'+name+'%' },
            ],
            select,
        },
        page,
        size
    )
    if(res.data) {
        res.data.forEach(item => {
            item.label = item.name
            item.value = item.id
        })
    }
    return res
}

function all(data) {
    const wheres = getWheres(data);
    wheres.push( { column: 'status', op: 'eq', value: 'enabled' })
    wheres.push( { column: 'type', op: 'eq', value: 'staff' })
    const options = {
        wheres,
    }
    const arr = Process('models.admin.user.Get', options);
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