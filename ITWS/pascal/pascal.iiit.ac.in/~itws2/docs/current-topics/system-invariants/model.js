var modelMaker = function(init) {
	var x = init;
	var getX = function() {
		return x;
	};

    var setX = function(v) {
		// v: Number.isInteger
		x = v;
	};

	var a = {};
	a.getX = getX;
	a.setX = setX;
	return a;
};

var m = modelMaker(5);
