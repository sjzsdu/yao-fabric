
function BeforeSearch(query, page, pagesize) {
    if (!query.wheres) {
        query.wheres = [];
    }
    const user = Process('session.Get', "user")
    console.log('before', user)
    if (user.data && user.department_ids) {
        if (user.data.includes('department')) {
            const wheres = user.department_ids.reduce((acc, item) => {
                acc.push( { column: 'department_id', op: 'eq', value: item, method: 'orwhere'})
                return acc;
            }, []);
            query.wheres.push({wheres})
        } else if (user.data.includes('self')) {
            query.wheres.push(
                { column: 'user_id', op: 'eq', value: user.id }
            )
        }
    }
    console.log('user', query);
    return [query, page, pagesize];
  }
  