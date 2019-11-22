tbox.onChangeX = function(v) {
	tbox.value = v;  // flow v into tbox's value
	g(); // change tbox's edit status
};
m.setX = function(v) {
	m.oldSetX(v);
	for (ob of m.observers) {
		ob.onChangeX(v);
	};
}

m.init = function() {
	m.observers = [];
};

m.register = function(ob) {
	m.observers.push(ob);
};
window.addEventListener('load', function() {
	m.init();
	m.register(tbox);
});
