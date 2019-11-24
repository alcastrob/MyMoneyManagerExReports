// Format double to base currency
function currency(n) {
    n = parseFloat(n);
    n = isNaN(n) ? 0 : n.toFixed(2);
    var out = n.toString().replace(".", "|");
    out = out.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ".");
    out = out.replace("|", ",");
    return out;
}

function applyMoneyFormat(elements) {
    for (var i = 0; i < elements.length; i++) {
        var element = elements[i];
        element.style.textAlign = 'right';
        if (element.innerHTML.indexOf("-") > -1) {
            element.style.color = "#ff0000";
        }
        element.innerHTML = currency(element.innerHTML) + '€';
    }
}

applyMoneyFormat(document.getElementsByClassName("money"));