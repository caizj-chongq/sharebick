var codeMap = {
    0: '操作成功!',
    2: '操作失败!',
    401: '对不起，您没有操作权限!'
};

const alertSuccessMsg = function (state, jurl) {
    if (state in codeMap) {
        alert(codeMap[state]);
    }
    window.location.href = jurl;
};

const alertErrMsg = function (state, msg) {
  if (state in codeMap) {
      alert(codeMap[state]);
  } else if (state === 400) {
      alert(msg);
  } else {
      alert(codeMap["2"]);
  }
};
