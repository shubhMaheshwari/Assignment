var tbox2 = $('#tbox2')[0];
tbox2.onChangeX = function(v) {
	tbox2.value = v;
};

window.addEventListener('load', function() {
	m.register(tbox2);
});
