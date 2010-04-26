$(document).ready(function() {
  // admin pages
  $(".flash").flashThenFadeOut();

  // product show page initialization
  $("ul.medium-photos li").hide();
  $("ul.medium-photos li.active-medium-photo").show();

  // product show page thumbnail click
  $(".show ul.photos li").showMediumOnClick();

  // product listing (home page)
  $(".product").each(function(i, p) {
    $("#" + p.id).pagePhotos(p.id);
  });
});

$.fn.flashThenFadeOut = function() {
  self = this;
  this.animate({opacity:1}, 4000, 'linear', function() {
    self.fadeOut(2000);
  });
};

$.fn.showMediumOnClick = function() {
  this.each(function(i, p) {
    thumb = $("#" + p.id);
    thumb.click(function(){
      $("ul.medium-photos li").hide();
      medium = $("#medium_" + p.id);
      medium.show();
    });
  });
}

// direction is 'right' or 'left'
$.fn.arrowClick = function(product_id, direction) {
  this.click(function(){

    var arrow;
    var current_photo;
    var next_photo;
    var active_dot_element;

    current_photo = $("#" + product_id + " ul.photos li.active-photo:first");
    active_dot_element = $("#" + product_id + " .active-dot:first");

    if (direction == 'right') {
      arrow = active_dot_element.next();
      next_photo = current_photo.next();
    }
    else if (direction == 'left') {
      arrow = active_dot_element.prev();
      next_photo = current_photo.prev();
    }

    if (arrow.size() != 0) {
      active_dot_element.removeClass("active-dot");
      arrow.addClass("active-dot");

      current_photo.removeClass("active-photo");
      next_photo.addClass("active-photo");
      $("#" + product_id + " ul.photos li").hide();
      $("#" + product_id + " ul.photos li.active-photo").show();
    }
    return false;
  });
}

$.fn.pagePhotos = function(product_id) {
  product = this;
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
      first_dot_element.after("<div id=\"" + product_id + "_dot_" + i + "\" class=\"dot\">&nbsp;</div>");
      i++;
    }

    $("#" + product_id + "_left-arrow").arrowClick(product_id, 'left');
    $("#" + product_id + "_right-arrow").arrowClick(product_id, 'right');
  }
};
