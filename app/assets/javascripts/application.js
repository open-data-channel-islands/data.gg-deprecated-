// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

//= require bootstrap-sprockets

//= require highcharts
//= require highcharts/highcharts-more
//= require highcharts/modules/map

/// ****************************************************|
// These three methods output with thousand separators
/// ****************************************************|
Chart.defaults.global.scaleLabel = function(label){return label.value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");};

Chart.defaults.global.multiTooltipTemplate = function(label) {
  var result = "";
  if (label.datasetLabel != undefined) {
    return label.datasetLabel + ": " + label.value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
  } else {
    return label.value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
  }
};

Chart.defaults.global.tooltipTemplate = function(label) {
  //alert(JSON.stringify(label));
  var result = "";
  if (label.label != undefined) {
    return label.label + ": " + label.value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
  } else {
    return label.value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
  }
};
/// ****************************************************|

Chart.defaults.global.responsive = true;