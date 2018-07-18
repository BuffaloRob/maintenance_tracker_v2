$(document).on('turbolinks:load', () => {

  $("[id*=logBtn]").one("click", event => {
    event.preventDefault();
    let logPath = event.target.pathname;

    $.getJSON(logPath)
      .done( data => {

        for (obj of data) {
          let result = "";
          let id = obj.category.id;
          let note = obj.notes;
          let date_performed = new Date(obj.date_performed);
          let date_due = new Date(obj.date_due);
          let tools = obj.tools;
          let $log = $("#showLog_" + id);

          result += "<p>Performed on: " + date_performed.toLocaleDateString('en-US', { timeZone: 'UTC' }) + "</p>" + "\n" +
            "<p>Due on: " + date_due.toLocaleDateString('en-US', { timeZone: 'UTC' }) + "</p>" + "\n" +
            "<p>Notes: " + note + "</p>" +
            "<hr>";

          $log.append(result);
        }
      })
      .fail( data => {
        console.log("Error:");
        console.log(data);
      });
  });

  $(".accordion").accordion({
    collapsible: true,
    active: false,
  });

  $("[id*=logBtn]").on("click", event => {
    event.preventDefault();
  })

})


