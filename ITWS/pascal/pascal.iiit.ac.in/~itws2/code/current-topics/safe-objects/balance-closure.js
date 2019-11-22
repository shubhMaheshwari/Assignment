var MakeBalance = function(init) {
	// init : is_nat
	var balance = init;

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

	var a = {};
	a.show = show;
	a.deposit = deposit;
	a.withdraw = withdraw;
	return a;
};

var b = MakeBalance(200);
