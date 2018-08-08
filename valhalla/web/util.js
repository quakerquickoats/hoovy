
function dom_element (id)
{
    return document.getElementById(id);
}

function dom_hide (id)
{
    dom_element(id).style.display = "none";
}

function dom_show (id)
{
    dom_element(id).style.display = "block";
}

/////////////////////////////////////////////////
//
// clone() and extend() from http://oranlooney.com/classes-and-objects-javascript/
//

function Clone () { }
function clone (obj)
{
    Clone.prototype = obj;
    return new Clone();
}

// Pass in the subclass constructor, superclass constructor,
// and an Object of methods/static properties to
// add to the subclass.  The function correctly sets up
// subclass.prototype.
function extend (subclass, superclass, methods)
{
    subclass.prototype = clone (superclass.prototype);
    subclass.prototype.constructor = subclass;
    
    for (var key in methods)
    {
        subclass.prototype[key] = methods[key];
    }
}

////////////////////////////////////////////////////////////////

/* unused

Storage.prototype.setObject = function (key, value)
{
    this.setItem (key, JSON.stringify (value));
}

Storage.prototype.getObject = function (key)
{
    return JSON.parse (this.getItem (key));
}
*/

/////////////////////////////////////////////////////////////////

function RequestData (name, f)
{
    var r = new XMLHttpRequest ();
    //r.open ('GET', 'file:///Users/humasect/Hoovy/code/gl/data/'+name, false);
    r.open ('GET', 'data/'+name, false);
    r.setRequestHeader ('User-Agent', navigator.userAgent);

    r.onreadystatechange = function(evt)
    {
        if (r.readyState == 4)
        {
            if (r.status == 0 || r.status == 200)
            {
                f (r.responseText);
            }
            else
            {
                alert ('cannot load "'+name+'"');
            }
        }
    };

    r.send (null);
}

function RequestEval (name, f)
{
    RequestData (name, function (text)
    {
        f (eval ('(' + text + ')'));
    });
}
