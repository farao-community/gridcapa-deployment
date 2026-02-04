fetch('apps-metadata.json')
    .then(res => res.json())
    .then(res => buildMenu(res))

let buildMenu = (apps) => {
    const menu = document.getElementById('gridcapa-homepage-menu');
    for (const app of apps) {
        menu.innerHTML +=
            '<li><a href="'
            + app.url
            + '" style="color: '
            + app.appColor + '">'
            + app.name.replace('Capa ', '')
            + '</a></li>';
    }
}