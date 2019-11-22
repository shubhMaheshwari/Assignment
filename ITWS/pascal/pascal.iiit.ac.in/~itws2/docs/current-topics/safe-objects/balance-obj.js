
var Balance = function(init) {
	
	this.balance = init;
};

var show = function() {
	return this.balance;
}

var deposit = function(d) {
	// d : is_nat

	this.balance = this.balance + d;
}

var withdraw = function(w) {
	// w : is_nat
	this.balance = this.balance - w;
};

Balance.prototype.show = show;
Balance.prototype.deposit = deposit;
Balance.prototype.withdraw = withdraw;

var b = new Balance(100);
