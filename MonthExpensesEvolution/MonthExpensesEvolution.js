var lines = document.getElementsByClassName('line');
var totalSoFar = 0;
for(var i=0;i!==lines.length;i++){
    var currentLine = lines[i];
    //Positive or negative ammount depending on the type of the line
    if (currentLine.querySelector('.type').innerText!=='Deposit'){
        currentLine.querySelector('.money').innerText = '-' + currentLine.querySelector('.money').innerText;
    } 
    totalSoFar += Number(currentLine.querySelector('.money').innerText);
    currentLine.querySelector('.subtotal').innerText = totalSoFar.toFixed(2);
    currentLine.querySelector('.date').innerText = new Date(currentLine.querySelector('.date').innerText.substring(0, 10)).toLocaleDateString();
}

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
applyMoneyFormat(document.getElementsByClassName("subtotal"));