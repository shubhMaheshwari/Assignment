// NOTE: will need to run chrome with cross origin requests enabled
// which is considered unsafe.

// linux: chromium-browser --disable-web-security --user-data-dir
// mac os: open /Applications/Google\ Chrome.app --args --disable-web-security

function getIP() {
    var obj = {ip: "undefined"};

    var p = $.get("https://api.ipify.org/");

	p.done(function(data, responseText, xhr) { 
		console.log("GET Succeeded");
		console.dir({data: data, 
					 responseText: responseText, 
					 xhr: xhr});
		obj.ip = data; 
	});

    p.fail(
		function(xhr, responseText, error) { 
			obj.ip = "GET failed"; 
       		console.log("GET Failed");
     		console.dir({error: error, 
						 responseText: responseText, 
						 xhr: xhr});
		});

	var ans = {obj: obj, p: p};
	return ans;
};
function logIPAddress() {
    function loopFor(millisec) {
        var now = new Date().getTime();
        while(new Date().getTime() < now + millisec) { 
			/* no op */
		}; 
    };

	var ans = getIP();

    console.log("long job started...");
	
    loopFor(1000 * 20); // 20 seconds
                        // all console 
                        // interactions queued
                        // up during this time
    console.log("long job ended.");
	return ans;
}
