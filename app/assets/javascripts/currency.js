$(document).ready(function(){
  var currencyName = document.URL.replace(/.*\//, '');
  var margin = {top: 20, right: 20, bottom: 30, left: 50},
    width = 960 - margin.left - margin.right,
    height = 500 - margin.top - margin.bottom;

  var parseDate = d3.time.format("%Y-%m-%d").parse;

  var x = d3.time.scale()
      .range([0, width]);

  var y = d3.scale.linear()
      .range([height, 0]);

  var xAxis = d3.svg.axis()
      .scale(x)
      .orient("bottom");

  var yAxis = d3.svg.axis()
      .scale(y)
      .orient("left");

  var valueline = d3.svg.line()
      .x(function(d) { return x(d.date); })
      .y(function(d) { return y(d.average_exchange_rate); });

  var svg, curr;

  var makePlot = function(data) {
    d3.select(".graph svg").remove();
    svg = d3.select(".graph").append("svg")
        .attr("width", width + margin.left + margin.right)
        .attr("height", height + margin.top + margin.bottom)
      .append("g")
        .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

    x.domain(d3.extent(data, function(d) { return d.date; }));
    y.domain(d3.extent(data, function(d) { return d.average_exchange_rate; }));

    svg.append("path")
        .attr("class", "line")
        .attr("d", valueline(data));

    svg.append("g")
        .attr("class", "x axis")
        .attr("transform", "translate(0," + height + ")")
        .call(xAxis);

    svg.append("g")
        .attr("class", "y axis")
        .call(yAxis);
  };

  var filter = function(lessThan,biggerThan){
    return curr.filter(function(el){
      return el.date < parseDate(lessThan) && el.date > parseDate(biggerThan);
    });
  }

  $('#submit').click(function(event){
    event.preventDefault();
    makePlot(filter($('#lessThan').val(),$('#greaterThan').val()));
  });

  d3.json('/currency/'+currencyName+'.json', function(error, data) {
    data.forEach(function(d) {
      d.date = parseDate(d.date);
    });
    curr = data;
    makePlot(curr);
  });

});
