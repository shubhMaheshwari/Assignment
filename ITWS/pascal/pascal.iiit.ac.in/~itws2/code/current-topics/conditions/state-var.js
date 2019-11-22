var StateVar = {};
StateVar.make = function(name, initVal) {
    var a = {};
    var conditionHandlers = []; // list of pairs
                                 // of conditions
                                 // and handlers

    var currentValue = initVal;

    var getName = function() {
		return name;
	};

    var getValue = function() {
		return currentValue;
    };

    var setValue = function(newValue) {
		currentValue = newValue;
		conditionHandlers.forEach(function(ch) {
			if (ch.cond(newValue)) {
				ch.handler(newValue);
			}
		});
	};

    var addConditionHandler = function(cond, handler) {
		conditionHandlers.push({cond: cond, handler: handler});
	};

    a.getName =  getName;
    a.getValue = getValue;
    a.setValue = setValue;
    a.addConditionHandler = addConditionHandler;

    return a;
};
