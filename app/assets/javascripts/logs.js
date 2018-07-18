$(document).on('turbolinks:load', function () {

  $("[id*=detailsBtn]").one("click", function(event) {
    event.preventDefault();
    let detailsPath = event.target.pathname;
    fetch(detailsPath, {
      credentials: 'same-origin',
      headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
      }
    })
      .then(function (resp) {
        return resp.json();
      })
      .then(function (data) {
        const id = data.id
        const logDetails = new LogDetails(data.notes, data.tools, data.cost, data.date_performed, data.date_due);

        $("#showDetails_" + id).append(logDetails.renderDetails());
        console.log(logDetails.renderDetails());
      });
  });

  $(".accordion").accordion({
    collapsible: true,
    active: false,
  });

  $("[id*=detailsBtn]").on("click", function (event) {
    event.preventDefault();
  });

  class LogDetails {
    constructor(notes, tools, cost, date_performed, date_due) {
      this.notes = notes;
      this.tools = tools;
      this.cost = cost;
      this.date_performed = new Date(date_performed).toLocaleDateString("en-US", { timeZone: "UTC" });
      this.date_due = new Date(date_due).toLocaleDateString("en-US", { timeZone: "UTC" });
    }

    renderDetails() {
      return `
      <h5>Due Date: ${this.date_due}</h5>
      <p>Cost: $ ${this.cost}</p>
      <p>Tools: ${this.tools}</p>
      <p>Notes: ${this.notes}</p>
    `
    }
  }

  // For adding new log via ajax
  $('form').submit(function (event) {
    event.preventDefault();
    let values = $(this).serialize();

    let action = $(this).attr('action')

    let logs = $.post(`${action}.json`, values);

    logs.done(function (data) {
      let log = data;
      let date_performed = new Date(log.date_performed);
      let date_due = new Date(log.date_due);

      $("#logDatePerformed").text(date_performed.toLocaleDateString('en-US', { timeZone: 'UTC' }));
      $("#logDatePerformed").prepend("Performed on: ");

      $("#logDateDue").text(date_due.toLocaleDateString('en-US', { timeZone: 'UTC' }));
      $("#logDateDue").prepend("Due on: ");

      $("#logCost").text(log.cost);
      $("#logCost").prepend("Cost: $");

      $("#logNotes").text(log.notes);
      $("#logNotes").prepend("Note: ");

      $("#logTools").text(log.tools);
      $("#logTools").prepend("Tools: ");
    });
  });

})




