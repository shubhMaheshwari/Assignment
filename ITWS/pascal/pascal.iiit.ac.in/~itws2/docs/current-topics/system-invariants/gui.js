	var tbox = $('#tbox')[0];
	var editButton = $('#edit')[0];
	var doneButton = $('#done')[0];

	var f = function() {
		tbox.readOnly = false;
		tbox.style.borderWidth = "2px";
	};

	var g = function() {
		tbox.readOnly = true;
		tbox.style.borderWidth = "0px";
	};

	var h = function() {
		editButton.addEventListener('click', f);
		doneButton.addEventListener('click', g);
	};
// window.addEventListener works; 
// document.addEventListener doesn't!

window.addEventListener('load', function() {
	h();
	g();
	console.log("document.load event listener ran"); 
});

var s = function() {
	m.setX(tbox.value); // type error here?
	console.assert(tbox.value === m.getX());
};

window.addEventListener('load', function() {
	doneButton.addEventListener('click', s);
	console.log("doneButton now has handler that pushes to model"); 
});

m.oldSetX = m.setX;

m.setX = function(v) {
	console.log("invoking setX(" + v + ")");
	m.oldSetX(v);
	tbox.value = m.getX();
	console.log("tbox.value changed to " + tbox.value);
	g();
};
