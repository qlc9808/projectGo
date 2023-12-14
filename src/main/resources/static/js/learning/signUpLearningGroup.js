var grid;
var gridData;

document.addEventListener("DOMContentLoaded", function (){
    learningGroupList();
})

function learningGroupList() {
    $.ajax({
        url: "learning/signUpLearningGroup",
        method: "GET",
        success: function (response) {

        },
    })
}
