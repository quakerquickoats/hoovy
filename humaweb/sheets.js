sheets =
{
    make_menu: function()
    {
        var Menu = dom.make_svg({id: 'game_menu',
                                 width: "100%", height: "100%"});
        
        var Defs = dom.make_element(dom.svg_element, 'title');
        Defs.innerHTML = "Gamelikeのメニュー"; // できないはず。。。
        Menu.appendChild(Defs);

        var Status = dom.make_svg({id: 'menu_status',
                                   width: "25%", height: "100%"});
        var StatusRect = dom.make_element(dom.svg_element, 'rect');
        dom.set_attributes(StatusRect, {width: "100%", height: "100%",
                                        fill: "blue", stroke: "white",
                                        'stroke-width': 4,
                                        rx: 8, ry: 8});

        Status.appendChild(StatusRect);
        Menu.appendChild(Status);

        document.body.appendChild(Menu);
    }
};
