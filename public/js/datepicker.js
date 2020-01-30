// $(function() {
//   $('input[name="dates"]').daterangepicker({
//     opens: 'left'
//   }, function(start, end, label) {
//     console.log("A new date selection was made: " + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD'));
//   });
// });


$(function() {

  $('input[name="dates"]').daterangepicker({
      autoUpdateInput: false,
      locale: {
          cancelLabel: 'Clear'
      }
  });

  $('input[name="dates"]').on('apply.daterangepicker', function(ev, picker) {
      $(this).val(picker.startDate.format('DD/MM/YYYY') + ' - ' + picker.endDate.format('DD/MM/YYYY'));
  });

  $('input[name="dates"]').on('cancel.daterangepicker', function(ev, picker) {
      $(this).val('');
  });

});