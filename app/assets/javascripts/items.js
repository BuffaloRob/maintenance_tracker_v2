$(document).on('turbolinks:load', () => {

  $("[id*=catBtn]").one("click", event => {
    event.preventDefault();
    let categoryPath = event.target.pathname;

    $.getJSON(categoryPath)
      .done( data => {
        for (cat of data) {
          let result = "";
          let id = cat.item.id;
          let name = cat.name;
          let $category = $("#showCategory_" + id);

          result += "<p>" + name + "</p>" + "<hr>";

          $category.append(result);
        }
      })
      .fail(data => {
        console.log("Error:");
        console.log(data);
      });
  });

  $(".accordion").accordion({
    collapsible: true,
    active: false,
  });

  $("[id*=catBtn]").on("click", event => {
    event.preventDefault();
  });

})

