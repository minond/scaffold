/**
 * no need to edit this file. configured by config/build.yml
 * @link http://www.thomasboyt.com/2013/09/01/maintainable-grunt.html
 */
module.exports = function (grunt) {
    'use strict';

    var _, glob, config, tasks, task, definition;

    _ = require('lodash');
    _.defaults = require('merge-defaults');
    glob = require('glob');

    // if you just want the defaults: vendor/minond/scaffold/config/build.yml
    config = grunt.file.readYAML('config/build.yml'),
    tasks = { config: config };

    // configs
    _(config.imports).each(function (file) {
        config = _.defaults(config, grunt.file.readYAML(file));
    });

    // options
    _(config.options).each(function (path) {
        glob.sync('*.js', { cwd: path }).forEach(function (option) {
            task = option.replace(/\.js$/,'');
            definition = require(path + option);
            tasks[ task ] = _.isFunction(definition) ?
                definition(grunt, config) : definition;
        });
    });

    grunt.initConfig(tasks);
    require('load-grunt-tasks')(grunt);

    // tasks
    _(config.aliases).forOwn(function (tasks, alias) {
        grunt.registerTask(alias, tasks);
    });
};
