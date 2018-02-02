$(function() {
  // listen for when user select 'other' in dropdown
  function bindFaveColorOtherSelection() {
    $("#user_fave_color").change(function(){
      var choice = $(this).find("option:selected").val();
      if (choice == "Other") {
        replaceSelectFaveColorWithTextInput(this);
      };
    });
  }

  // remove select input and replace it with text input
  function replaceSelectFaveColorWithTextInput(selectForm) {
    $(selectForm).remove();
    $(".user_fave_color").append(faveColorTextInputHtml());
  }

  function faveColorTextInputHtml() {
    return "<input type='text' name='user[fave_color]' class='form-control'>"
  }

  bindFaveColorOtherSelection();
});
