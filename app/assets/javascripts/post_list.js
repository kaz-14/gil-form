$(document).on('turbolinks:load', function() { 
  let tabs = $(".menu_item");

  function tabSwitch() {
    $(".active").removeClass("active");
    $(this).addClass("active");
    const index = tabs.index(this);
    $(".content").removeClass("show").eq(index).addClass("show")
    return false;
  }
  tabs.click(tabSwitch);
});