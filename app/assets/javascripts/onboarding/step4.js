$(function() {
  // listen for when user detects other user[fave_color]
  function bindFaveColorOtherSelection() {
    $("#user_fave_color").change(function(){
      var choice = $(this).find("option:selected").val();
      if (choice == "Other") {
        this.remove();
        $(".user_fave_color").html(otherFaveColorInput());
      }
    });
  }

  function otherFaveColorInput() {
    return "<label>Input your favorite color</label><input type='text' name='user[fave_color]' id='user_fave_color'><br>"
  }
  bindFaveColorOtherSelection();
});
