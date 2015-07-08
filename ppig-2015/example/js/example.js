// User A's original app

fluid.defaults("examples.simpleRelay", {
    gradeNames: "fluid.component",
    components: {
        celsiusHolder: {
            type: "fluid.modelComponent",
            options: {
                model: {
                    celsius: 22
                }
            }
        },
        fahrenheitHolder: {
            type: "fluid.modelComponent",
            options: {
                modelRelay: {
                    source: "{celsiusHolder}.model.celsius", // IoC reference to celsius model field in the other component
                    target: "{that}.model.fahrenheit",       // this reference could be shortened to just "fahrenheit"
                    singleTransform: {
                        type: "fluid.transforms.linearScale",
                        factor: 9/5,
                        offset: 32
                    }
                }
            }
        }
    }
});

// User D's view app
fluid.defaults("examples.relayApp", {
    gradeNames: ["gpii.templates.binder", "fluid.viewComponent", "examples.simpleRelay"],
    model: {
        celsius: "{celsiusHolder}.model.celsius",
        fahrenheit: "{fahrenheitHolder}.model.fahrenheit"
    },
    selectors: {
        celsius: "#celsius",
        fahrenheit: "#fahrenheit"
    },
    bindings: {
        celsius: "celsius",
        fahrenheit: "fahrenheit"
    }
});

// User A' designates a "decorated variety" of our simpleRelay type which will log messages on model changes
fluid.defaults("examples.reportingRelay", {
    distributeOptions: [{ // options distributions route options to the subcomponents in the tree compactly
        record: {
            funcName: "fluid.log",
            args: ["Celsius value has changed to", "{change}.value"]
        },
        target: "{that celsiusHolder}.options.modelListeners.celsius"
    }, {
        record: {
            funcName: "fluid.log",
            args: ["Fahrenheit value has changed to", "{change}.value"]
        },
        target: "{that fahrenheitHolder}.options.modelListeners.fahrenheit"
    }]
});

fluid.setLogging(true);