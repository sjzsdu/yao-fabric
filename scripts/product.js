/**
 * 面料分类下拉选项
 * @param {*} query
 * @returns
 */
function GetCategorySelect(query) {
  var wheres = [{ ":deleted_at": "删除", "=": null }];
  if (query && query.id) {
    var exists = Process("models.product.category.find", query.id, {});
    if (exists && exists.id) {
      wheres.push({ ":id": "主键", "<>": query.id });
      wheres.push({ ":parent_id": "父级", "=": exists.parent_id });
    }
  }
  var query = new Query();
  var res = query.Get({
    select: ["id as value", "name as label"],
    wheres: wheres,
    from: "fabric_category",
  });
  return res;
}

/**
 * 面料分类树形列表结构
 * @param {*} data
 * @returns
 */
function CategoryTree(data) {
  var wheres = data.wheres;
  var pu = {};
  for (var i in wheres) {
    if (wheres[i].column == "name") {
      pu = {
        ":fabric_category.name": "名称",
        like: "%" + wheres[i].value + "%",
      };
    }
  }
  var search = [{ ":fabric_category.deleted_at": "删除", "=": null }];
  if (pu && pu != null) {
    search.push(pu);
  }

  var query = new Query();
  var cate = query.Get({
    debug: true,
    select: [
      "fabric_category.id",
      "fabric_category.name",
      "fabric_category.description",
      "fabric_category.order",
      "fabric_category.parent_id",
      "parent.name as parent_name",
    ],
    wheres: search,
    from: "fabric_category",
    joins: [
      {
        left: true,
        from: "fabric_category as parent",
        key: "parent.id",
        foreign: "fabric_category.parent_id",
      },
    ],
    limit: 1000,
  });
  res = Process("xiang.helper.ArrayTree", cate, {
    parent: "parent_id",
    empty: null,
  });
  var data = {
    data: res,
  };
  return data;
}