$(function() {
  initPage();
});
$(window).bind('page:change', function() {
  initPage();
});

var dataSet;

Number.prototype.formatMoney = function(c, d, t){
var n = this,
    c = isNaN(c = Math.abs(c)) ? 2 : c,
    d = d == undefined ? "." : d,
    t = t == undefined ? "," : t,
    s = n < 0 ? "-" : "",
    i = parseInt(n = Math.abs(+n || 0).toFixed(c)) + "",
    j = (j = i.length) > 3 ? j % 3 : 0;
   return s + (j ? i.substr(0, j) + t : "") + i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + t) + (c ? d + Math.abs(n - i).toFixed(c).slice(2) : "");
 };

function ApplyViewModel() {
  this.salary = ko.observable(20000);

  this.tax = ko.computed(function() {
    return ((Number(20 * this.salary())) / 100);
  }, this);

  this.healthCommunityServices = ko.computed(function() {
    return (((dataSet["Health and community services"] * this.tax()) / 100) / 365).formatMoney(2);
  }, this);

  this.pensions = ko.computed(function() {
    return (((dataSet["Pensions"] * this.tax()) / 100) / 365).formatMoney(2);
  }, this);

  this.education = ko.computed(function() {
    return (((dataSet["Education"] * this.tax()) / 100) / 365).formatMoney(2);
  }, this);

  this.socialWelfareBenefits = ko.computed(function() {
    return (((dataSet["Social welfare benefits"] * this.tax()) / 100) / 365).formatMoney(2);
  }, this);

  this.orderSafety = ko.computed(function() {
    return (((dataSet["Order and Safety"] * this.tax()) / 100) / 365).formatMoney(2);
  }, this);

  this.governmentAdministration = ko.computed(function() {
    return (((dataSet["Government and administration"] * this.tax()) / 100) / 365).formatMoney(2);
  }, this);

  this.transferCapitalReserve = ko.computed(function() {
    return (((dataSet["Transfer to capital reserve"] * this.tax()) / 100) / 365).formatMoney(2);
  }, this);

  this.landManagementInfrastructureTransport = ko.computed(function() {
    return (((dataSet["Land management infrastructure and transport"] * this.tax()) / 100) / 365).formatMoney(2);
  }, this);

  this.economicDevelopmentTourism = ko.computed(function() {
    return (((dataSet["Economic development and tourism"] * this.tax()) / 100) / 365).formatMoney(2);
  }, this);

  this.artsSportCulture = ko.computed(function() {
    return (((dataSet["Arts sport and culture"] * this.tax()) / 100) / 365).formatMoney(2);
  }, this);
}

function initPage() {
    //$('#government_spending_slider')

    var data_url = "http://localhost:3000/api/1.1/government-spending/percentage.json";
    $.getJSON( "http://localhost:3000/api/1.1/government-spending/percentage.json", function( data ) {
      dataSet = data[1];
      ko.applyBindings(new ApplyViewModel());
    });
}

//$('#salaryInput')