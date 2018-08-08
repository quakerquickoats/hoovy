
dom =
{
    element: function(Id)
    {
        return document.getElementById(Id);
    },

    hide: function(Id)
    {
        dom.element(Id).style.display = "none";
    },

    show: function(Id)
    {
        dom.element(Id).style.display = "block";
    },

    sethtml: function(Id, HTML)
    {
        dom.element(Id).innerHTML = HTML;
    },

    // SVGの作りと利用され

    svg_namespace: "http://www.w3.org/2000/svg",

    make_element: function(Namespace, Name)
    {
        return document.createElementNS(Namespace, Name);
    },

    set_attributes: function(Element, Dict)
    {
        for (var X in Dict)
            Element.setAttribute(X, Dict[X]);
    },

    make_svg: function(Dict, Children)
    {
        var SVG = dom.make_element(dom.svg_namespace, 'svg');
        dom.set_attributes(SVG, {'xmlns': dom.svg_namespace,
                                 'xmlns:xlink': "http://www.w3.org/1999/xlink",
                                 'version': "1.1"});

        dom.set_attributes(SVG, Dict);
        return SVG;
    }
};

