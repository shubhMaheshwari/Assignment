
var balance;

var Balance  = function(init) {
	// init: is_nat
	balance = init;
};

var show = function() {
	return balance;
};

var deposit = function(d) {
	// d : is_nat
	balance = balance + d;
};

var withdraw = function(w) {
	// w : is_nat
	balance = balance - w;
};
