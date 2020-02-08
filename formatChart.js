console.clear();

let data = [];

var groupBy = function(xs, key) {
  return xs.reduce(function(rv, x) {
    (rv[x[key]] = rv[x[key]] || []).push(x);
    return rv;
  }, {});
};

var datasetObject = groupBy(data, "name");
console.log(datasetObject);

var datasets = [];
var labels = datasetObject[Object.keys(datasetObject)[0]].map(a => {
  return `${a.year};${a.month};${a.week}`;
});

Object.keys(datasetObject).forEach(key => {
  datasets.push({
    label: key,
    backgroundColor: "#546E7A",
    // borderColor: getRandomColor(),
    borderColor: datasetObject[key][0].color,
    fill: false,
    spanGaps: false,
    data: datasetObject[key].map(a => {
      if (a.percent == 0) {
        a.percent = null;
      }
      return a.percent;
    })
  });
});

function getRandomColor() {
  var letters = "0123456789ABCDEF";
  var color = "#";
  for (var i = 0; i < 6; i++) {
    color += letters[Math.floor(Math.random() * 16)];
  }
  return color;
}

document.querySelector("#out").innerHTML = JSON.stringify({ labels, datasets });
// document.querySelector("pre").innerHTML = JSON.stringify(
//   { labels, datasets },
//   null,
//   " "
// );
