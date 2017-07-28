$(document).ready(function () {
    (function ($) {
        $("#UserGridView tbody").addClass("search");
        $('#filter').keyup(function () {
            var rex = new RegExp($(this).val(), 'i');
            // var $t = $(this).children(":eq(4))");
            $('.search tr ').hide();

            //Recusively filter the jquery object to get results.
            $('.search tr ').filter(function (i, v) {
                //Get the 1st column object here which is driver's name'
                var $t = $(this).children(":eq(" + "0" + ")");
                return rex.test($t.text());
            }).show();
        })

    }(jQuery));
});