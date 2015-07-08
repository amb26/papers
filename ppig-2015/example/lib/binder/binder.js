    var gpii = fluid.registerNamespace("gpii");
    
    fluid.defaults("gpii.templates.binder", {
        events: {
            onDomBind: null
        },
        listeners: {
            "onCreate.bindDom": {
                func: "{that}.events.onDomBind.fire"
            },
            "onDomBind.applyBinding": {
                funcName: "gpii.templates.binder.applyBinding"
            }
        },
    });

    gpii.templates.binder.refreshDom = function (that) {
        // Adapted from: https://github.com/fluid-project/infusion/blob/master/src/framework/preferences/js/Panels.js#L147
        var userJQuery = that.container.constructor;
        that.container = userJQuery(that.container.selector, that.container.context);
        fluid.initDomBinder(that, that.options.selectors);
        that.events.onDomBind.fire(that);
    };

    // The main function to create bindings between markup and model elements.  See above for usage details.
    gpii.templates.binder.applyBinding = function (that) {
        var bindings = that.options.bindings;
        fluid.each(bindings, function (value, key) {
            var path     = typeof value === "string" ? value : value.path;
            var selector = typeof value === "string" ? key : value.selector;
            var element = that.locate(selector);

            // Update the model when the form changes
            element.change(function () {
                var elementValue = Number(fluid.value(element)); // TODO: botched conversion
                fluid.log("Changing model at path " + path + " to value " + elementValue + " based on element update.");
                that.applier.change(path, elementValue);
            });

            // Update the form elements when the model changes
            that.applier.modelChanged.addListener(path, function (change) {

                // This syntax is required until Fluid is updated per the following pull request:
                //
                //   https://github.com/fluid-project/infusion/pull/591
                //
                // For a description of a similar problem caused by the same behavior, see:
                //
                //   https://issues.fluidproject.org/browse/FLUID-4739
                //
                var value = change[path] ? change[path] : change;
                fluid.log("Changing value at path " + path + " to " + value + " based on model update.");
                fluid.value(element, value);
            });

            // If we have model data initially, update the form.  Model values win out over markup.
            var initialModelValue = fluid.get(that.model, path);
            if (initialModelValue) {
                fluid.value(element, initialModelValue);
            }
            // If we have no model data, but there are defaults in the markup, using them to update the model.
            else {
                var initialFormValue = fluid.value(element);
                if (initialFormValue) {
                    that.applier.change(path, initialFormValue);
                }
            }
        });
    };