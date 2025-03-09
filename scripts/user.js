function Login(payload) {
  log.Trace("[user] Login $s", payload.email);
  // 验证验证码
  const captcha = Process(
    "xiang.helper.CaptchaValidate",
    payload.captcha.id,
    payload.captcha.code
  );

  if (captcha !== true) {
    throw new Exception("验证码不正确!", 400);
  }
  let users = [];
  if (payload.email) {
    users = Process("models.admin.user.get", {
      wheres: [{ column: "email", value: payload.email }],
      limit: 1,
    });
  }
  if (payload.mobile) {
    users = Process("models.admin.user.get", {
      wheres: [{ column: "mobile", value: payload.mobile }],
      limit: 1,
    });
  }
  if (!users || !users.length) {
    throw new Exception("用户不存在", 400);
  }
  const user = users[0];
  // 验证密码
  const password_validate = Process(
    "xiang.helper.PasswordValidate",
    payload.password,
    user.password
  );
  if (password_validate !== true) {
    throw new Exception("密码不正确!", 400);
  }

  // 增加token等信息
  const session_id = payload.sid;
  const {data, rule_ids} = getMenuIds(user.role_ids);
  user.data = data;
  user.rule_ids = rule_ids;
  console.log('login user', user, payload)
  
  const jwt = Process(
    "xiang.helper.JWTMake",
    user.id,
    { user_name: user.name, department_ids: user.department_ids, role_ids: user.role_ids, rule_ids: rule_ids, data_ids: data },
    {
      timeout: 28800,
      sid: session_id,
    }
  );

  Process("session.set", "user", user, 28800, session_id);
  Process("session.set", "token", jwt.token, 28800, session_id);
  Process("session.set", "user_id", user.id, 28800, session_id);
  console.log('user login', user, rule_ids);
  delete user.password;
  return {
    sid: session_id,
    user,
    menus: getXgenMenus(rule_ids),
    token: jwt.token,
    expires_at: jwt.expires_at,
  };
}

function getXgenMenus(rule_ids) {
  const setting = Process('yao.rule.menus', ['sys'], true, rule_ids);
  const items = Process('yao.rule.menus', ['pro', 'crm'], true, rule_ids);
  return {
    items,
    setting
  }
}

function getMenuIds(role_ids) {
  const wheres = [
    { column: 'id', value: role_ids, op: 'in' },
    { column: 'deleted_at', op: 'eq', value: null },
    { column: 'status', value: '1'}
  ];
  const options = {
    wheres,
    select: ['rule_ids', 'data']
  }
  const roles = Process('models.admin.role.Get', options);

  const data = roles.reduce((acc, role) => {
    if (role?.rule_ids?.includes('*')) {
      acc['rule_ids'] = allMenuIds();
    } else {
      acc['rule_ids'] = [...(acc['rule_ids'] || []), ...(role.rule_ids || [])];
    }
    if (!acc['data']) {
      acc['data'] = [];
    }
    if (role.data) {
      acc['data'].push(role.data);
    }
    return acc;
  }, {});
  const rule_ids = data['rule_ids'].filter(item => typeof item !== 'number' && !!item);
  data['rule_ids'] = [...new Set(rule_ids || [])];
  data['data'] = [...new Set(data['data'] || [])];
  return data;
}

function allMenuIds() {
  const menuIds = Process('yao.rule.ruleKeys', options);  
  return menuIds;
}