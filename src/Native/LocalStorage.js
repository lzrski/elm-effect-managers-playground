/* eslint-disable */

console.log("Initializing native LocalStorage module");

var _user$project$Native_LocalStorage = (function () {
  var scheduler = _elm_lang$core$Native_Scheduler

  var handleError = function (error) {
    return scheduler.fail(error.name + ": " + error.message)
  }
  return {
    store: F2(function (key, value) {
      return scheduler.nativeBinding(function(callback) {
        Promise
          .resolve(value)
          .then(function(value) {
            localStorage.setItem(key, value)
            return value
          })
          .then(scheduler.succeed)
          .catch(handleError)
          .then(callback)
      })
    }),

    retrive: function (key) {
      return scheduler.nativeBinding(function(callback) {
        Promise
          .resolve(localStorage.getItem(key))
          .then(scheduler.succeed)
          .catch(handleError)
          .then(callback)
      })
    }
  }
})()
