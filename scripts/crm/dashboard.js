function Data(query) {
    let wheres = [];
    if (query["range[]"]) {
        wheres = [
            { field: "created_at", op: ">=", value: query["range[]"][0] },
            { field: "created_at", op: "<=", value: query["range[]"][1] },
        ]
    }
    const res = {
        '公司数量': queryCount('company', wheres),
        '联系人数量': queryCount('company', wheres),
        '公海数量': queryCount('company', [...wheres, 
            { wheres: [
                { field: "user_id", op: "null" },
                { or: true, field: "user_id", '=': 0 }
                ]
            }]),
        '跟进次数': queryCount('company', wheres),
        '近期新增公司趋势': queryDistribute('company', wheres),
        '近期跟进趋势': queryDistribute('follow', wheres),
        '按员工': queryCategory('company', [...wheres]).map(item => {
            if (!item['类别']) {
                item['类别'] = '公海';
            }
            return item;
        }),
        '按地区': queryArea('company', [...wheres])
    }
    return res;
}

function queryCount(from, wheres) {
    var query = new Query();
    const result =  query.Get({
        select: [":COUNT(id) as 数量"],
        from,
        wheres
    });
    return result[0]['数量'];
}

function queryDistribute(from, wheres) {
    var query = new Query();
    const result =  query.Get({
        select: [":COUNT(id) as 数量", ":DATE(created_at) as 日期"],
        from,
        wheres,
        limit: 10,
        orders: '日期',
        groups: '日期',
    });
    return result.map(item => ({...item, '日期': item['日期'].substring(0, 10)}))
}

function queryCategory(from, wheres) {
    var query = new Query();
    const result =  query.Get({
        select: [`:COUNT(${from}.id) as 数量`, "user.name as 类别"],
        from,
        wheres,
        orders: '数量',
        groups: '类别',
        joins: [
            {
              left: true,
              from: "admin_user as user",
              key: "user.id",
              foreign: `${from}.user_id`,
            },
        ],
    });
    return result
}

function queryArea(from, wheres) {
    var query = new Query();
    const result =  query.Get({
        select: [`:COUNT(id) as 数量`, ":JSON_EXTRACT(area, '$[0]') as 类别"],
        from,
        wheres,
        orders: '数量',
        groups: '类别'
    });
    return result
}