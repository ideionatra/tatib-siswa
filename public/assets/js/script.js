const sidebar = document.getElementById("sidebar-container");
const mainContent = document.getElementById("main-content");
const hamburger = document.getElementById("hamburger");

hamburger.addEventListener("click", () => {
    console.log("CLICKED");
    sidebar.classList.toggle("active");
    mainContent.classList.toggle("width");
});