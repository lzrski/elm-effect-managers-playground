/* eslint-disable */

console.log("Initializing native LocalStorage module");

var _user$project$Native_LocalStorage = (function () {
  var scheduler = _elm_lang$core$Native_Scheduler

  var handleError = function (error) {
    return scheduler.fail(error.name + ": " + error.message)
  }
  return {
    store: function (value) {
      return scheduler.nativeBinding(function(callback) {
        Promise
          .resolve(value)
          .then(scheduler.succeed)
          .then(callback)
          .catch(handleError)
      })
    },

    retrive: scheduler.nativeBinding(function(callback) {
      Promise
        .resolve(42)
        .then(scheduler.succeed)
        .then(callback)
        .catch(handleError)
    })
  }
})()
