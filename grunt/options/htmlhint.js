module.exports = function (grunt, config) {
    var options, read, JSON5;

    JSON5 = require('json5');
    read = grunt.file.read;

    // leaving csslint out because there should NEVER be a reason to leave css
    // in your html. js is a different story, since a little initialization is
    // sometimes done in the page
    options = JSON5.parse(read(config.files.configuration.htmlhint));
    options.jshint = JSON5.parse(read(config.files.configuration.jshint));

    // dafuq? getting "Bad option: 'globals'." errer with it
    options.jshint && delete options.jshint.globals;

    // no reporter option yet :(
    // https://github.com/yaniswang/HTMLHint/blob/master/TODO.md
    return {
        options: options,
        all: {
            src: [ config.files.views.all ],
        }
    };
};
