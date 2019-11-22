var modelMaker = function(init) {
	var x = init;
    // gets the value of x
	var getX = function() {
		return x;
	}; 

    // sets the value of x to v
    var setX = function(v) {
		x = v;
	};

	var a = {};
	a.getX = getX;
	a.setX = setX;
	return a;
};

var m = modelMaker(5);
