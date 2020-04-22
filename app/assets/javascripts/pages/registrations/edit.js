(function(){
  window.DABBLE.pages.Registrations_edit = window.DABBLE.pages.Registrations_update = function(){
    
    $(".j-delete-user").on({
      click: function(e){
        if ($('#user_current_password').val().length === 0) {
          swal({title: "Password Needed", text: "Enter your current password to delete your account.", type: "error", confirmButtonText: "Ok"});
          return false;
        }
      }
    });

    var tomorrow = new Date();
    tomorrow.setDate(tomorrow.getDate() + 1);
    $.extend($.fn.pickadate.defaults, {
      format: 'mmmm d, yyyy',
      selectYears: true,
      selectMonths: true,
      max: tomorrow
    });

    $('.pickadate').pickadate();      

    $('form').submit(function(){
      $(this).find('input[type=submit]').prop('disabled', true);
      $(this).find('input[type=submit]').addClass('disabled');
    });

  };
}());
