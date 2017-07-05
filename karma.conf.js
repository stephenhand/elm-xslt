module.exports = function(config) {
    config.set({
        preprocessors: {
            "./src/**/*.elm": ['elm'],
            "./tests/**/*.elm": ['elm']
        },
        frameworks: ["elm-test"],
        files: ["./src/**/*.elm", "./tests/**/*.elm"],
        client : {
            "elm-test":{
                suites:[
                    {
                        module:"XsltTest",
                        tests:["XsltTest.suite"]
                    }
                ],
                "test-source-directories" : [
                    "./tests"
                ]
            }
        },
        browsers: ['Chrome','Edge'],
        autoWatch:true,
        singleRun:false
    });
};