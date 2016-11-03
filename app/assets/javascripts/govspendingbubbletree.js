$(function() {
  var tmp_data = {
    label: 'Total',
    amount: 100,
        color: '#0066bb',  // color for root node, will be inherited by children
        children: [
        { label: 'First child', amount: 30,         children: [
        { label: 'First child', amount: 30 },
        { label: 'Second child', amount: 40 },
        { label: 'Third child', amount: 30, color: '#ff3300' }
        ]},
        { label: 'Second child', amount: 40 },
        { label: 'Third child', amount: 30, color: '#ff3300' }
        ]
      };

      var $tooltip = $('<div class="tooltip">Tooltip</div>');
      $('.bubble-chart').append($tooltip);
      $tooltip.hide();
      var getTooltip = function() {
        return this.getAttribute('tooltip');
      };

      var initTooltip = function(node, domnode) {
        domnode.setAttribute('tooltip', node.label+' &nbsp;<br /><big><b>'+node.famount+'</b></big>');
        vis4.log(domnode.getAttribute('tooltip'));
        $(domnode).tooltip({ delay: 200, bodyHandler: getTooltip });
      };

      var data_url = "/charts/government-spending/bubble-tree.json";
      $.getJSON( data_url, function( data ) {
        new BubbleTree({
          data: data,
          container: '.bubbletree',
          bubbleType: 'donut',
          maxNodesPerLevel: 12,
          autoColors: true,
        });
      });

});