function AfterSearchBool2Int(data) {
    let temp = data;
    if (data?.data) {
        temp = data.data;
    }
    for (let item of temp) {
        for (let o in item) {
            if (typeof item[o] === 'boolean') {
                item[o] = Number(item[o])
            }
        }
    }
    return data
}



function cosToken() {
    const appid = Process('xiang.helper.EnvGet', 'COS_APPID')
    const bucket = Process('xiang.helper.EnvGet', 'COS_BUCKET')
    const secretId = Process('xiang.helper.EnvGet', 'COS_SECRETID')
    const secretKey = Process('xiang.helper.EnvGet', 'COS_SECRETKEY')
    const res = Process("plugins.cos.TempKeys", appid, bucket, secretId, secretKey)
    return res;
}

export function walkArr(arr, callback) {
    for (let item of arr) {
        callback(item)
        if (item.children) {
            walkArr(item.children, callback)
        }
    }
}

module.exports = {
    walkArr
}