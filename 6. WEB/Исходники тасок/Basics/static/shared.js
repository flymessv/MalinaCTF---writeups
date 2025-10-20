document.addEventListener("DOMContentLoaded", function() {
    let menu_bg = document.querySelector(".menu-bg");
    let menu_open = document.querySelector(".menu-open");
    let menu_close = document.querySelector(".menu-close");
    if (menu_bg && menu_open && menu_close) {
        menu_open.addEventListener("click", function() {
            menu_bg.hidden = false;
        });
        menu_close.addEventListener("click", function() {
            menu_bg.hidden = true;
        });
    }
});
