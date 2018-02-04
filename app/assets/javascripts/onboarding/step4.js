$(function() {
  // listen for when user select 'other' in dropdown
  function bindFaveColorOtherSelection() {
    $("#user_fave_color").change(function(){
      var choice = $(this).find("option:selected").val();
      if (choice == "Other") {
        replaceSelectFaveColorWithTextInput();
      };
    });
  }

  // remove select input and replace it with text input
  function replaceSelectFaveColorWithTextInput() {
    $(".color-select").hide();
    $(".color-text").html(faveColorTextInputHtml());
  }

  function faveColorTextInputHtml() {
    return "<label class='control-label required' for='user_fave_color'><abbr title='required'>*</abbr> Custom Color</label><input type='text' name='user[fave_color]' class='form-control'>"
  }

  function checkIfTextFilled() {
    // if the text box has a value that is not "" remove color-select
    if (($(".color-text input").val()) && $(".color-text input").val().length > 0) {
      $(".color-select").hide();
    }
  }

  checkIfTextFilled();
  bindFaveColorOtherSelection();
});
