//[Dashboard Javascript]

//Project:	CRMi - Responsive Admin Template
//Primary use:   Used only for the main dashboard (index.html)


$(function () {

  'use strict';
	
		 
	var options = {
          series: [70, 38],
          chart: {
          type: 'donut',
			 height: 140,
			  width: 140,
        },
		legend: {
      		show: false,
		},
		dataLabels: {
			enabled: false,
		  },
		plotOptions: {
			pie: {
			  customScale: 0.90,
			  donut: {
				size: '80%',
				  labels: {
					show: true,
					total: {
					  showAlways: true,
					  show: true,
					}
				  }
			  },
			  offsetY: 0,
			},
			stroke: {
			  colors: undefined
			}
		  },
		colors:['#7047ee', '#e8e1ff'],
        };

        var chart = new ApexCharts(document.querySelector("#chart41"), options);
        chart.render();
	
		
		 
	var options = {
          series: [32, 80],
          chart: {
          type: 'donut',
			 height: 140,
			  width: 140,
        },
		legend: {
      		show: false,
		},
		dataLabels: {
			enabled: false,
		  },
		plotOptions: {
			pie: {
			  customScale: 0.90,
			  donut: {
				size: '80%',
				  labels: {
					show: true,
					total: {
					  showAlways: true,
					  show: true,
					}
				  }
			  },
			  offsetY: 0,
			},
			stroke: {
			  colors: undefined
			}
		  },
		colors:['#3596f7', '#cce5ff'],
        };

        var chart = new ApexCharts(document.querySelector("#chart42"), options);
        chart.render();
		
		 
	var options = {
          series: [102, 12],
          chart: {
          type: 'donut',
			 height: 140,
			  width: 140,
        },
		legend: {
      		show: false,
		},
		dataLabels: {
			enabled: false,
		  },
		plotOptions: {
			pie: {
			  customScale: 0.90,
			  donut: {
				size: '80%',
				  labels: {
					show: true,
					total: {
					  showAlways: true,
					  show: true,
					}
				  }
			  },
			  offsetY: 0,
			},
			stroke: {
			  colors: undefined
			}
		  },
		colors:['#05825f', '#ebf9f5'],
        };

        var chart = new ApexCharts(document.querySelector("#chart43"), options);
        chart.render();
	
		
		var options = {
          series: [{
          name: 'This Week',
          type: 'column',
          data: [440, 505, 414, 671, 227, 413, 201, 352, 752, 320, 257, 160]
        }, {
          name: 'Previous Week',
          type: 'line',
          data: [323, 642, 435, 527, 443, 622, 117, 231, 822, 222, 412, 116]
        }],
          chart: {
          height: 250,
          type: 'line',
          toolbar: {
            show: false
          }
        },
        stroke: {
          width: [0, 3],
			curve: 'smooth',
        },
		plotOptions: {
          bar: {
            horizontal: false,
            columnWidth: '30%',
            borderRadius: 3
          },
        },
        legend: {
          show: false,
        },
		colors:['#7047ee', '#05825f'],
        dataLabels: {
          enabled: false,
          enabledOnSeries: [1]
        },
        labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
        };

        var chart = new ApexCharts(document.querySelector("#chart44"), options);
        chart.render();
	
	
	var options = {
        series: [17, 22, 19],
        chart: {
          type: 'donut',
			width: '100%',
      		height: 240
        },
		colors:['#7047ee', '#3596f7', '#ffa800'],
		labels: ["On line", "in Store", "Marketing"],
		legend: {
		  show: true,
		  position: 'bottom',
      	  horizontalAlign: 'center', 
		},
		dataLabels: {
			enabled: false,
		  },
        responsive: [{
          breakpoint: 480,
          options: {
            chart: {
              width: 200
            },
          }
        }]
      };

      var chart = new ApexCharts(document.querySelector("#sales-chart"), options);
      chart.render();
	
	$('.activity-div').slimScroll({
		height: '250px'
	});
	
	
	
		var options = {
          series: [{
			  name: 'Earning',
			  data: [44, 55, 41, 67, 22, 43, 21, 33, 54]
			}],
          chart: {
		  foreColor:"#bac0c7",
          type: 'bar',
          height: 235,
          toolbar: {
            show: false
          },
          zoom: {
            enabled: true
          }
        },
        responsive: [{
          breakpoint: 480,
          options: {
            legend: {
              position: 'bottom',
              offsetX: -10,
              offsetY: 0
            }
          }
        }],		
		grid: {
			show: true,
			borderColor: '#f7f7f7',      
		},
		colors:['#7047ee'],
        plotOptions: {
          bar: {
            horizontal: false,
            columnWidth: '30%',
            borderRadius: 3
          },
        },
        dataLabels: {
          enabled: false
        },
 
        xaxis: {
          type: 'datetime',
          categories: ['08/01/2021 GMT', '08/02/2021 GMT', '08/03/2021 GMT', '08/04/2021 GMT','08/05/2021 GMT', '08/06/2021 GMT', '08/07/2021 GMT', '08/08/2021 GMT', '08/09/2021 GMT'
          ],
        },
        legend: {
          show: false,
        },
        fill: {
          opacity: 1
        }
        };

        var chart = new ApexCharts(document.querySelector("#charts_widget_1_chart"), options);
        chart.render();
	
	
	
}); // End of use strict
