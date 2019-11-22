	var tbox = $('#tbox')[0];
    /* $ is jquery syntax */
	var editButton = $('#edit')[0];
	var doneButton = $('#done')[0];

    // makes tbox editable
	var f = function() {
		tbox.readOnly = false;
		tbox.style.borderWidth = "2px";
	};

    // disables tbox editing
	var g = function() {
		tbox.readOnly = true;
		tbox.style.borderWidth = "0px";
	};

    // adds the handlers to the buttons
	var h = function() {
		editButton.addEventListener('click', f);
		doneButton.addEventListener('click', g);
	};

// warning: document.addEventListener doesn't work!
// use window.addEventListener
window.addEventListener('load', function() {
	h(); // add handlers to the buttons
	g(); // initialize the text box
	console.log("document.load event listener ran"); 
});
var s = function() {
	m.setX(tbox.value); 
	console.assert(tbox.value === m.getX());
};

window.addEventListener('load', function() {
	doneButton.addEventListener('click', s);
	console.log("doneButton now has handler that pushes value to model"); 
});
m.oldSetX = m.setX;

m.setX = function(v) {
	console.log("invoking setX(" + v + ")");

	m.oldSetX(v);
	tbox.value = m.getX();  // push m's value to tbox.

	console.log("tbox.value changed to " + tbox.value);

	g();   // change tbox's edit status

};
