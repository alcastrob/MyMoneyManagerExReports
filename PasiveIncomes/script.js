var tableBody = document.getElementById('table-body');
var tableFooter = document.getElementById('table-footer');

// Función para filtrar los datos según la opción seleccionada en el filtro de fecha
function filterDataByDate(option) {
  return data.filter(function (item) {
    var moment = new Date(item.moment);
    var currentDate = new Date();

    switch (option) {
      case 'last-year':
        return moment.getFullYear() === currentDate.getFullYear() - 1;
      case 'this-year':
        return moment.getFullYear() === currentDate.getFullYear();
      case 'this-quarter':
        var currentQuarter = Math.floor(currentDate.getMonth() / 3 + 1);
        var momentQuarter = Math.floor(moment.getMonth() / 3 + 1);
        return moment.getFullYear() === currentDate.getFullYear() && momentQuarter === currentQuarter;
      case 'last-month':
        var lastMonth = currentDate.getMonth() === 0 ? 11 : currentDate.getMonth() - 1;
        return moment.getMonth() === lastMonth && moment.getFullYear() === currentDate.getFullYear();
      case 'this-month':
        return moment.getMonth() === currentDate.getMonth() && moment.getFullYear() === currentDate.getFullYear();
      case 'all':
      default:
        return true;
    }
  });
}

function renderTable(filteredData) {
  // Limpiar tabla antes de renderizar los nuevos datos
  tableBody.innerHTML = '';
  var totalAmount = 0;

  filteredData.forEach(function (item) {
    var row = document.createElement('tr');

    var dateCell = document.createElement('td');
    dateCell.textContent = item.moment;
    row.appendChild(dateCell);

    var typeCell = document.createElement('td');
    typeCell.textContent = item.type;
    row.appendChild(typeCell);

    var categoryCell = document.createElement('td');
    categoryCell.textContent = item.category;
    row.appendChild(categoryCell);

    var amountCell = document.createElement('td');
    amountCell.textContent = item.amount.toFixed(2) + ' €';
    amountCell.classList.add('money');
    row.appendChild(amountCell);

    tableBody.appendChild(row);
    totalAmount += item.amount;
  });

  // Actualizar el total en el footer
  var footerRow = document.createElement('tr');
  var emptyCell = document.createElement('td');
  emptyCell.setAttribute('colspan', '3');
  footerRow.appendChild(emptyCell);

  var totalCell = document.createElement('td');
  totalCell.textContent = 'Total: ' + totalAmount.toFixed(2) + ' €';
  footerRow.appendChild(totalCell);

  tableFooter.innerHTML = ''; // Limpiar footer antes de añadir el nuevo total
  tableFooter.appendChild(footerRow);
}

function renderXYChart(data) {
  // var chart = am5.xy.XYChart.new('xy-chart');
  // chart.data = data.map(function (item, index) {
  //   return {
  //     category: index,
  //     value: item.amount,
  //   };
  // });

  // var xAxis = chart.xAxes.push(
  //   am5.xy.CategoryAxis.new(root, {
  //     dataFields: { category: 'category' },
  //   })
  // );

  // var yAxis = chart.yAxes.push(am5.xy.ValueAxis.new(root));

  // var series = chart.series.push(
  //   am5.xy.LineSeries.new(root, {
  //     dataFields: {
  //       categoryX: 'category',
  //       valueY: 'value',
  //     },
  //   })
  // );

  // chart.cursor = new am5.xy.XYCursor.new(root);

  // // Muestra el valor acumulado en la tabla como una línea horizontal
  // var lineSeries = chart.series.push(
  //   am5.xy.LineSeries.new(root, {
  //     dataFields: {
  //       valueY: 'total',
  //     },
  //     strokeWidth: 2,
  //     stroke: am5.color(255, 0, 0),
  //     tooltipText: 'Total: {valueY}',
  //     bullets: [
  //       {
  //         type: 'Bullet',
  //         locationY: 0.5,
  //         background: am5.color(255, 0, 0),
  //         propertyFields: {
  //           minPixelDistance: 50,
  //         },
  //       },
  //     ],
  //   })
  // );

  // var total = data.reduce((acc, cur) => acc + cur.amount, 0);
  // lineSeries.data = [
  //   { category: 0, total },
  //   { category: data.length - 1, total },
  // ];
}

var dateFilter = document.getElementById('date-filter');
dateFilter.addEventListener('change', function () {
  var selectedOption = this.value;
  var filteredData = filterDataByDate(selectedOption);
  totalAmount = 0; // Restablecer totalAmount antes de volver a calcularlo

  renderTable(filteredData);
  renderXYChart(filteredData);
});

var selectedOption = dateFilter.value;
var filteredData = filterDataByDate(selectedOption);
// Mostrar todos los registros inicialmente
renderTable(filteredData);
renderXYChart(filteredData);
