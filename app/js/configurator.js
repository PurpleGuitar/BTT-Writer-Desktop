/**
 * ts.Configurator
 * settings manager that uses local storage by default, but can be overridden to use any storage provider.
 * Configurations are stored by key as stringified JSON (meta includes type, mutability, etc)
 */

;(function () {
    'use strict';

    let _ = require('lodash');
    let user_setting = require('../config/user-setting');

    function Configurator () {
        let storage = {};

        let getValue = function (key) {
            if (!key) { return key; }

            key = key.toLowerCase();
            let valueObj = JSON.parse(storage[key] || '{}');
            let metaObj = valueObj.meta || {'default': ''};

            return valueObj.value || metaObj.default;
        };

        let getMetaValue = function (key, metaKey) {
            if (!key) { return key; }
            
            key = key.toLowerCase();
            let valueObj = JSON.parse(storage[key] || '{}');

            return valueObj.meta[metaKey] || '';
        };

        let setValue = function (key, value, meta) {
            if (!key || !value) { return; }
            
            key = key.toLowerCase();
            value = typeof value === 'boolean' || typeof value === 'number' ? value : value.toString();

            if (getMetaValue(key, 'mutable') === false) { return; }

            let emptyStorageObj = {'value': value, 'meta': {'mutable': true, 'type': typeof value, 'default': ''}};
            let valueObj = storage[key] !== undefined ? JSON.parse(storage[key]) : emptyStorageObj;
            valueObj.value = value;
            valueObj.meta = _.merge(valueObj.meta, meta);

            storage[key] = JSON.stringify(valueObj);
        };

        let unsetValue = function (key) {
            if (!key) { return; }

            key = key.toLowerCase();

            if (getMetaValue(key, 'mutable') === false) { return; }

            if (typeof storage.removeItem === 'function') {
                storage.removeItem(key);
            } else {
                storage[key] = undefined;
            }
        };

        let setReadOnlyValue = function (key, value) {
            setValue(key, value, {'mutable': false});
        };

        let setDefaultValue = function (key, value) {
            setValue(key, value, {'default': value || ''});
        };

        let getKeys = function () {
            return Object.keys(storage);
        };

        // This is the returned object
        let configurator = {

            _storage: function() {
                return storage;
            },

            setStorage: function (storeObject) {
                storage = storeObject;
            },

            saveUserSetting: function(setting) {
                storage['user-setting'] = JSON.stringify(setting);
            },

            getUserSetting: function() {
                return JSON.parse(storage['user-setting']) || user_setting;
            },

            /**
             * Retreives a value
             * @param key
             * @returns {object}
             */
            getValue: function (key) {
                return getValue(key) || '';
            },

            /**
             * Adds a new value to the configurator
             * @param key the key used to retreive the value
             * @param value the value that will be stored
             * @param meta optional parameters to help specify how the value should be treated
             */
            setValue: function (key, value, meta) {
                setValue(key, value, meta);
            },

            /**
             * Loads a configuration object into the configurator
             * @param config a json object (usually loaded from a file)
             */
            loadConfig: function (config) {
                if (storage === undefined) {
                    throw 'Storage is undefined. Please call setStorage with a valid storage object';
                }

                for (let i = 0; i < config.length; i++) {
                    if (config[i].value !== undefined) {
                        if (config[i].meta.mutable) {
                            setDefaultValue(config[i].name, config[i].value);
                        } else {
                            setReadOnlyValue(config[i].name, config[i].value);
                        }
                    }
                }
            },

            /**
             * Destroys a value
             * @param key
             */
            unsetValue: function (key) {
                unsetValue(key);
            },

            /**
             * Clears all values in the configurator
             */
            purgeValues: function () {
                let keys = getKeys();
                for (let i = 0; i < keys.length; i++) {
                    unsetValue(keys[i]);
                }
            }

        };

        return configurator;
    }

    exports.Configurator = Configurator;
})();
