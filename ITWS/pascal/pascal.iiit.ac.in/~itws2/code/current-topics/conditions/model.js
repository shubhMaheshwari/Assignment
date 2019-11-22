var Counter = {};
Counter.MIN = 0;
Counter.MAX = 10;

Counter.c = StateVar.make("c", 0);

var c = Counter.c;

Counter.incr = function() {
	c.setValue(c.getValue() + 1);
};

Counter.decr = function() {
	c.setValue(c.getValue() - 1);
};


Counter.reset = function() {
	c.setValue(0);
};
var isMin = function(v) {
	return v === Counter.MIN;
};

var isMax = function(v) {
	return v === Counter.MAX;
};
c.addConditionHandler(isMin, function() {
	document.getElementById('decr').disabled = true;
});


c.addConditionHandler(isMax, function() {
	document.getElementById('incr').disabled = true;
});
var inInterior = function(v) {
	return !(isMin(v) || isMax(v));
};

c.addConditionHandler(inInterior, function() {
	document.getElementById('incr').disabled = false;
	document.getElementById('decr').disabled = false;
});
var incrFromMin = (function(){
	var oldVal = c.getValue();
    return function(newValue) {
        var wasMin = oldVal === Counter.MIN;
        oldVal = newValue;
        return wasMin;
    };
})();

var decrFromMax = (function(){
	var oldVal = c.getValue();
    return function(v) {
        var wasMax = oldVal === Counter.MAX;
        oldVal = v;
        return wasMax;
    };
})();
c.addConditionHandler(incrFromMin, function() {
	console.log("invoked incrFromMin handler");
	document.getElementById('decr').disabled = false;
});

c.addConditionHandler(decrFromMax, function() {
	console.log("invoked decrFromMax handler");
	document.getElementById('incr').disabled = false;
});
var isEven = function(v) {
	return v % 2 === 0;
};

var sumHandler = (function() {
	var sum = 0;
	return function(v) {
		sum = sum + v;
		console.log(v);
		console.log("sum: " + sum);
	};
})();
c.addConditionHandler(isEven, sumHandler);
document.getElementById("decr")
	.addEventListener('click',  Counter.decr);

document.getElementById("incr")
	.addEventListener('click', Counter.incr);

document.getElementById("reset")
	.addEventListener('click', Counter.reset);


c.addConditionHandler(function() {return true;}, 
					  function(v) {
						  document.getElementById("counter").textContent = v;
					  });
