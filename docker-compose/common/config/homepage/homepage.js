fetch('apps-metadata.json')
    .then(res => res.json())
    .then(res => buildMenu(res))
    .catch(err => console.error('Failed to load apps metadata:', err))

let buildMenu = (apps) => {
    const menu = document.getElementById('gridcapa-homepage-menu');
    const fragment = document.createDocumentFragment();
    for (const app of apps) {
        const li = document.createElement('li');
        const a = document.createElement('a');
        a.href = app.url;
        a.style.color = app.appColor;
        a.textContent = app.name.replace('Capa ', '');
        li.appendChild(a);
        fragment.appendChild(li);
    }
    menu.appendChild(fragment);
}