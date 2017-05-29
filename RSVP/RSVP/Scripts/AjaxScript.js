function submitForm() {
    var form = document.myform;

    var dataString = $(form).serialize();
    $.ajax({
        type: 'POST',
        url: 'carousel.php',
        data: dataString,
        success: function (data) {
            $('#myResponse').html(data);


        }
    });
    return false;
}