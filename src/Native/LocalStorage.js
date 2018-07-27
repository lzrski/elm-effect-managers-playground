/* eslint-disable */

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
          .then(JSON.stringify)
          .then(function(json) {
            localStorage.setItem(key, json)
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
          .then(function (value) {
            switch (value) {
              case null:
                return {
                  ctor: "Nothing"
                }
                break;
              default:
                return {
                  ctor: "Just",
                  _0: JSON.parse (value)
                }

            }

          })
          .then(scheduler.succeed)
          .catch(handleError)
          .then(callback)
      })
    }
  }
})()
