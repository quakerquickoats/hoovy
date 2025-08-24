var CL = {
	pe: null,
	debug: null,
	display: null,
	
	map: {}
};

function engine_create()
{
	//    if (!ROT.isSupported()) {
	//      alert("The rot.js library isn't supported by your browser.");

	CL.debug = document.createElement("div");
	document.body.appendChild(CL.debug);
	CL.debug.innerHTML = "Debug.";
	
	CL.display = new ROT.Display({width:48,  //64,
								  height:24,   //48,
								  fontSize:24,
								  spacing:1,
//							      tileWidth:16, tileHeight:16,
								  forceSquareRatio:true});

//  const ratio = window.devicePixelRatio;
//  CL.display.getContext("2d").scale(ratio, ratio);
	document.body.appendChild(CL.display.getContainer());

    var foreground, background, colors;
    for (var i = 0; i < 15; i++) {
        // Calculate the foreground color, getting progressively darker
        // and the background color, getting progressively lighter.
        foreground = ROT.Color.toRGB([255 - (i*20),
                                      255 - (i*20),
                                      255 - (i*20)]);
        background = ROT.Color.toRGB([i*20, i*20, i*20]);
        // Create the color format specifier.
        colors = "%c{" + foreground + "}%b{" + background + "}";
        // Draw the text two columns in and at the row specified
        // by i
        CL.display.drawText(2, i, colors + "Hello, world!גכשגכשגכ");
    }

	//var input = document.createElement("input");
	//document.body.appendChild(input);N

	//input.focus();
	window.addEventListener("keydown", function(e) {
		var k = e.keyCode;
		CL.debug.innerHTML = "pressed: " + k;

		switch (k) {
		case 72: // H
			break;
		case 74: // J
			break;
		case 75: // K
			break;
		case 76: // L
			break;
		}
	},true);


	/////////////////////////
	//
	// from tutorial, ehh, why are they making it text list !?
	//

	var digger = new ROT.Map.Digger();

    var digCallback = function(x, y, value) {
        if (value) { return; } /* do not store walls */

        var key = x+","+y;
        CL.map[key] = "🥰";
    }
    digger.create(digCallback.bind(this));

	//	console.log(map);

	for (var key in CL.map) {
        var parts = key.split(",");
        var x = parseInt(parts[0]);
        var y = parseInt(parts[1]);
        CL.display.draw(x, y, CL.map[key]);
    }
}

function engine_prompt()
{
	CL.pe.input(prompt(this.data));
}

function engine_output()
{
	CL.pe.debug.innerHTML = this.data;
}

////////////////////////////////////////////////

window.onload = function()
{
	CL.pe = new Pengine({
		oncreate: engine_create,
		onprompt: engine_prompt,
		onoutput: engine_output
	});
}

