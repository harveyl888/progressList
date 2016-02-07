/* progUpdate - update a single progressList element by name */
Shiny.addCustomMessageHandler('progUpdate', function(message) {
  id = $('[proglistid = \"' + message.label + '\"]').attr('id');
  $('#' + id).removeClass();
  $('#' + id).addClass('prog-list-' + message.newstatus);
});
