var mk_balance = function(init) {
	var balance = init;

	var show = function() {
		return balance;
		};

	var deposit = function(d) {
		// d : is_nat
		balance = balance + d;
	};

    // withdraw : is_nat -> void,  throws Error()
    var withdraw = function(w) {
          if (balance < w) {
          throw new Error("insufficient balance");
          }
          else {
              balance = balance-w;
          };
    };

	var a = {};
	a.show = show;
	a.deposit = deposit;
	a.withdraw = withdraw;
	return a;
};
