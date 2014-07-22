module.exports = function(config){
  config.set({

    basePath : '../',

    files : [
      'test/unit/unitSpec.bundle.js'
    ],

    autoWatch : true,

    frameworks: ['jasmine'],

    browsers : ['Safari'],

    plugins : [
            'karma-chrome-launcher',
            'karma-safari-launcher',
            'karma-firefox-launcher',
            'karma-jasmine',
            'karma-junit-reporter'
            ],

    junitReporter : {
      outputFile: 'test_out/unit.xml',
      suite: 'unit'
    }

  });
};
