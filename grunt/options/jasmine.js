module.exports = {
    all: {
        src: [ '<%= config.files.js.all %>' ],
        options: {
            specs: [ '<%= config.files.tests.js.all %>' ],
            vendor: [ '<%= config.files.tests.js.vendor %>' ],
            helpers: [ '<%= config.files.tests.js.helpers %>' ],

            junit: {
                path: '<%= config.artifacts.tests.jasmine.junit %>'
            },
            // template: require('grunt-template-jasmine-istanbul'),
            // templateOptions: {
            //     coverage: '<%= config.artifacts.tests.jasmine.coverage %>',

            //     // https://github.com/maenu/grunt-template-jasmine-istanbul#templateoptionsreport
            //     report: [
            //         {
            //             type: 'text-summary'
            //         },
            //         {
            //             type: 'html',
            //             options: {
            //                 dir: '<%= config.artifacts.tests.jasmine.report %>'
            //             }
            //         }
            //     ],

            //     // requirejs template configuration:
            //     template: require('grunt-template-jasmine-requirejs'),
            //     templateOptions: {
            //         // baseUrl: '.grunt/grunt-contrib-jasmine/src/main/js/'
            //     }
            // }
        }
    }
};
