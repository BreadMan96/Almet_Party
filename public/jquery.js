// InputMaska - для телефона
$(function(){
  $("#phone").mask("+7(999) 999-9999");
});
// InputMaska - для телефона


// Подсчёт кол-во символов
var maxCount = 200;
var redCount = 0;
$("#count").text(maxCount);
function getCount() {
  var count = maxCount - $("#seo-title").val().length;
  $("#count").text(count);
  if (count <= redCount) { $(".inform-text").addClass("red"); } else if (count > 0 && $(".inform-text").hasClass("red")) {
    $(".inform-text").removeClass("red");
  }
}
$("#seo-title").val().length;
// Подсчёт кол-во символов

