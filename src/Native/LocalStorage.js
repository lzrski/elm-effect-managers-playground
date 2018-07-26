/* eslint-disable */

var _user$project$Native_LocalStorage = (function () {
  var scheduler = _elm_lang$core$Native_Scheduler

  return {
    store: function (value) {
      console.log("Native store!", value)
      return scheduler.nativeBinding(function(callback) {
        Promise
          .resolve(value)
          .then(scheduler.succeed)
          .catch(scheduler.fail)
          .then(callback)
      })
    }
  }
})()
