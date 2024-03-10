var curry  = require('light-curry'),
    delvec = require('delvec');

var Wheeljack = function(object) {
  this.object = object;
};

Wheeljack.prototype = {

  get: function(key) {
    return delvec(this.object, key);
  },

  getOr: function() {
    args = [].slice.call(arguments);
    args.unshift(this.object);

    return curry(function(object, alternate, key) {
      return delvec.or(alternate, key, object);
    }).apply(this, args);
  },

  set: function(key, value, object) {
    var steps, key, keys;

    if (arguments.length === 2) {
      object = this.object;
    }

    steps = key.split('.');
    key   = steps[0];
    keys  = steps.slice(1);

    if (steps.length === 1) {
      object[key] = value;
      return object;
    } else {
      if (typeof delvec(object, key) !== 'object') {
        object[key] = {};
      }
      return this.set(keys.join('.'), value, object[key]);
    }
  },

  swap: function(object) {
    this.object = object;
  }
};

module.exports = Wheeljack;
