function toggleDropdown() {
    const menu = document.getElementById('dropdownMenu');
    menu.classList.toggle('hidden');
}

// Close dropdown if clicked outside
window.addEventListener('click', function (e) {
    const dropdownButton = document.getElementById('dropdownButton');
    const dropdownMenu = document.getElementById('dropdownMenu');
    if (!dropdownButton.contains(e.target)) {
        dropdownMenu.classList.add('hidden');
    }
});