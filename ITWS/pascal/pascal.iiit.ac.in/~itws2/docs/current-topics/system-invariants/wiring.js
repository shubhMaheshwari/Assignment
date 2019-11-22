tbox.onChangeX = function(v) {
	tbox.value = v;
	g();
};

m.setX = function(v) {
	m.oldSetX(v);
	for (h of m.handlers) {
		h.onChangeX(v);
	};
}

m.init = function() {
	m.handlers = [];
};

m.register = function(o) {
	m.handlers.push(o);
};

window.addEventListener('load', function() {
	m.init();
	m.register(tbox);
});
