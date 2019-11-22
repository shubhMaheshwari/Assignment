var f = function(event) {
	console.log("Button-1 clicked");
	console.dir(event);
};

// register the registering of the button handler with the 
// "load" event.
window.addEventListener("load",  
						function(e) {
							console.log("page loaded!");
							console.dir(e);
							document.getElementById("button-1").
								addEventListener("click", f);
						}
);
var event = new MouseEvent('click', {
    'view': window
  });
var click_b1 = function() {
    var b1 = document.getElementById("button-1");
	b1.dispatchEvent(event);
};
