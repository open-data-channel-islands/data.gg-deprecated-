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

function getDataSetRowValue(expenditureName) {
  for (var i = dataSet.length - 1; i >= 0; i--) {
    if (dataSet[i]["Expenditure"] == expenditureName) {
      return dataSet[i]["Percent"];
    }
  }
  return 0;
}

function ApplyViewModel() {
  this.salary = ko.observable(20000);

  this.tax = ko.computed(function() {
    return ((Number(20 * this.salary())) / 100);
  }, this);

  this.healthCommunityServices = ko.computed(function() {
    return (((getDataSetRowValue("Health and community services") * this.tax()) / 100) / 365).formatMoney(2);
  }, this);

  this.pensions = ko.computed(function() {
    return (((getDataSetRowValue("Old age pensions") * this.tax()) / 100) / 365).formatMoney(2);
  }, this);

  this.education = ko.computed(function() {
    return (((getDataSetRowValue("Education") * this.tax()) / 100) / 365).formatMoney(2);
  }, this);

  this.socialWelfareBenefits = ko.computed(function() {
    return (((getDataSetRowValue("Social welfare benefits") * this.tax()) / 100) / 365).formatMoney(2);
  }, this);

  this.orderSafety = ko.computed(function() {
    return (((getDataSetRowValue("Order and safety") * this.tax()) / 100) / 365).formatMoney(2);
  }, this);

  this.governmentAdministration = ko.computed(function() {
    return (((getDataSetRowValue("Government and administration") * this.tax()) / 100) / 365).formatMoney(2);
  }, this);

  this.landManagementInfrastructureTransport = ko.computed(function() {
    return (((getDataSetRowValue("Land management infrastructure and transport") * this.tax()) / 100) / 365).formatMoney(2);
  }, this);

  this.economicDevelopmentTourism = ko.computed(function() {
    return (((getDataSetRowValue("Economic development and tourism") * this.tax()) / 100) / 365).formatMoney(2);
  }, this);

  this.artsSportCulture = ko.computed(function() {
    return (((getDataSetRowValue("Arts sport and culture") * this.tax()) / 100) / 365).formatMoney(2);
  }, this);

  this.appropriationToCapitalReserve = ko.computed(function() {
    return (((getDataSetRowValue("Capital investment") * this.tax()) / 100) / 365).formatMoney(2);
  }, this);

  this.alderney = ko.computed(function() {
    return (((getDataSetRowValue("Alderney") * this.tax()) / 100) / 365).formatMoney(2);
  }, this);

  this.overseasAid = ko.computed(function() {
    return (((getDataSetRowValue("Overseas aid") * this.tax()) / 100) / 365).formatMoney(2);
  }, this);
}

function initPage() {
    var data_url = "/api/1.1/government-spending/breakdown.json";
    $.getJSON( data_url, function( data ) {
      dataSet = data;
      ko.applyBindings(new ApplyViewModel());
    });
  }