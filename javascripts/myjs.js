$(document).ready(function() {
    // $("#chennai").click(function() {
//         $.ajax({
//             url : "chennai.txt",
//             dataType: "text",
//             success : function (data) {
//                 $(".text").html(data);
//             }
//         });
//     });
jQuery.get('chennai.txt', function(data) {
    alert(data);
});
}); 