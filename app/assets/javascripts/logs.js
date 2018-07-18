$(document).on('turbolinks:load', () => {

  $("[id*=detailsBtn]").one("click", event => {
    event.preventDefault();
    let detailsPath = event.target.pathname;
    fetch(detailsPath, {
      credentials: 'same-origin',
      headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
      }
    })
      .then(resp => {
        return resp.json();
      })
      .then(data => {
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

  $("[id*=detailsBtn]").on("click", event => {
    event.preventDefault();
  });

  class LogDetails {
    constructor(notes, tools, cost, datePerformed, dateDue) {
      this.notes = notes;
      this.tools = tools;
      this.cost = cost;
      this.datePerformed = new Date(datePerformed).toLocaleDateString("en-US", { timeZone: "UTC" });
      this.dateDue = new Date(dateDue).toLocaleDateString("en-US", { timeZone: "UTC" });
    }

    renderDetails() {
      return `
      <h5>Due Date: ${this.dateDue}</h5>
      <p>Cost: $ ${this.cost}</p>
      <p>Tools: ${this.tools}</p>
      <p>Notes: ${this.notes}</p>
    `
    }
  }

  // For adding new log via ajax
  $('form').submit( function (event) {
    event.preventDefault();
    let values = $(this).serialize();

    let action = $(this).attr('action')

    let logs = $.post(`${action}.json`, values);

    logs.done(data => {
      let log = data;
      let datePerformed = new Date(log.date_performed);
      let dateDue = new Date(log.date_due);

      $("#logDatePerformed").text(datePerformed.toLocaleDateString('en-US', { timeZone: 'UTC' }));
      $("#logDatePerformed").prepend("Performed on: ");

      $("#logDateDue").text(dateDue.toLocaleDateString('en-US', { timeZone: 'UTC' }));
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




