var exec = require('cordova/exec');

exports.initialize = function initialize(param, onSuccess, onFail) {
  return exec(onSuccess, onFail, 'LineLogin', 'initialize', [param]);
}

exports.login = function login(param, onSuccess, onFail) {
  return exec(onSuccess, onFail, 'LineLogin', 'login', [param]);
}
