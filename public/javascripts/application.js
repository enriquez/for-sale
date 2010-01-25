// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function() {
    $("#flash-notice").animate({opacity:1}, 4000, 'linear', function() {
      $("#flash-notice").fadeOut(2000);
    });
    $("#flash-error").animate({opacity:1}, 4000, 'linear', function() {
      $("#flash-error").fadeOut(2000);
    });
    $("ul.medium-photos li").hide();
    $("ul.medium-photos li.active-medium-photo").show();
    $(".show ul.photos li").each(function(i, p){
      thumb = $("#" + p.id);
      thumb.click(function(){
        $("ul.medium-photos li").hide();
        medium = $("#medium_" + p.id);
        medium.show();
      });
    });
    $(".product").each(function(i, p) {
      product = $("#" + p.id);
      photo_count = product.children(".photos").children("li").size();
      if (photo_count < 2) {
        product.children(".pager").css("visibility", "hidden");
      }
      else {
        left_margin_px = 110 - ((photo_count * 10) / 2);
        first_dot_element = $(product.children(".pager").children(".dots").children(".first-dot")[0]);
        first_dot_element.css("margin-left", left_margin_px.toString() + "px");

        i = 1;
        while (i < photo_count) {
          first_dot_element.after("<div id=\"" + p.id + "_dot_" + i + "\" class=\"dot\">&nbsp;</div>");
          i++;
        }

        left_arrow_element = $("#" + p.id + "_left-arrow");
        right_arrow_element = $("#" + p.id + "_right-arrow");

        left_arrow_element.click(function(){
          active_dot_element = $("#" + p.id + " .active-dot:first");
          prev_dot_element = active_dot_element.prev();
          if (prev_dot_element.size() != 0) {
            active_dot_element.removeClass("active-dot");
            prev_dot_element.addClass("active-dot");

            active_photo_element = $("#" + p.id + " ul.photos li.active-photo:first");
            active_photo_element.removeClass("active-photo");
            active_photo_element.prev().addClass("active-photo");
            $("#" + p.id + " ul.photos li").hide();
            $("#" + p.id + " ul.photos li.active-photo").show();
          }
          return false;
        });
        right_arrow_element.click(function(){
          active_dot_element = $("#" + p.id + " .active-dot:first");
          next_dot_element = active_dot_element.next();
          if (next_dot_element.size() != 0) {
            active_dot_element.removeClass("active-dot");
            next_dot_element.addClass("active-dot");

            active_photo_element = $("#" + p.id + " ul.photos li.active-photo:first");
            active_photo_element.removeClass("active-photo");
            active_photo_element.next().addClass("active-photo");
            $("#" + p.id + " ul.photos li").hide();
            $("#" + p.id + " ul.photos li.active-photo").show();
          }
          return false;
        });
      }
    });
});
