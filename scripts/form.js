function BeforeSave(payload) {
    const user = Process('session.Get', "user")
    if (!payload.user_id) {
        payload.user_id = user.id
    }
    if (!payload.department_id && user.department_ids && user.department_ids.length) {
        payload.department_id = user.department_ids[0]
    }
    return [payload];
}


function Setting(ddd) {
    console.log('asdf', ddd);
}