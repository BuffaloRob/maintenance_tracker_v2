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

})

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

//     $.getJSON(detailsPath)
//       .done(function (data) {

//         let result = "";
//         const id = data.id;
//         const note = data.notes;
//         const date_performed = data.date_performed;
//         const date_due = data.date_due;
//         const tools = data.tools;
//         const cost = data.cost;
//         debugger
//         const $details = $("#showDetails_" + id);

//         result +=
//           "<p>Performed on: " + date_performed + "</p>" + "\n" +
//           "<p>Due on: " + date_due + "</p>" + "\n" +
//           "<p>Notes: " + note + "</p>" + "\n" +
//           "<p>Cost: $" + cost + "</p>" + "\n" +
//           "<p>Tools: " + tools + "</p>" +
//           "<hr>";

//         $details.append(result);
//       })
//       .fail(function (data) {
//         console.log("Error:");
//         console.log(data);
//       });
//   });
// })

