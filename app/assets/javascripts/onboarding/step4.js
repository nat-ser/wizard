$(function() {
  // listen for when user select 'other' in dropdown
  function bindOtherColorSelection() {
    $("#user_fave_color").change(function(){
      var choice = $(this).find("option:selected").val();
      if (choice == "Other") {
        replaceSelectColorInputWithCustomInput();
      };
    });
  }

  function replaceSelectColorInputWithCustomInput() {
    $(".color-select").hide();
    $(".color-text").html(customColorInput());
  }

  function customColorInput() {
    return "<label class='control-label required' for='user_fave_color'><abbr title='required'>*</abbr>Custom Color</label><input type='text' name='user[fave_color]' class='form-control'>"
  }

  function customColorValuePresence() {
    return $(".color-text input").val() && $(".color-text input").val().length > 0
  }

  function hideSelectColorInputIfCustomValue() {
    if (customColorValuePresence() == true) {
      $(".color-select").hide();
    }
  }

  hideSelectColorInputIfCustomValue();
  bindOtherColorSelection();
});
