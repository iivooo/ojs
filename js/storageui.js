// $(document).ready(function(){
//     $('.myBtn').onclick($('.myModal'))
// })
//
//
//
// // Get the modal
// var modal = document.getElementById('myModal');
//
// // Get the button that opens the modal
// var btn = document.getElementById("myBtn");
//
// // Get the <span> element that closes the modal
// var span = document.getElementsByClassName("close")[0];
//
// // When the user clicks the button, open the modal
// btn.onclick = function () {
//     modal.style.display = "block";
// }
//
// // When the user clicks on <span> (x), close the modal
// span.onclick = function () {
//     modal.style.display = "none";
// }
//
// // When the user clicks anywhere outside of the modal, close it
// window.onclick = function (event) {
//     if (event.target == modal) {
//         modal.style.display = "none";
//     }
// }

var baseURL = "https://iivooo.suhail.uberspace.de/ojs/proxy.php";
//stuff for login
$(document).ready(function () {


    // process for the additional data
    $('.login-form-additional').submit(function (event) {

        // get the form data
        // there are many ways to get this data using jQuery (you can use the class or id also)
        var formData = {
            "usr": $(this).find('input[name=usr]').val(),//$('input[usr=usr]').val(),
            "pwd": $(this).find('input[name=pwd]').val()//$('input[pwd=pwd]').val(),
        };
        console.log($(this).find('input[name=storagePath]').val())
        console.log($(this).find('input[name=usr]').val())
        console.log($(this).find('input[name=pwd]').val())
        baseURL = $(this).find('input[name=storagePath]').val() + "/"+$(this).find('input[name=usr]').val()+"/"+
            $(this).find('input[name=pwd]').val();
        console.log(baseURL)

        var id = $(this).find('input[name=thisid]').val()

        // process the form
        $.ajax({
            type: 'GET', // define the type of HTTP verb we want to use (POST for our form)
            url: baseURL, // the url where we want to POST
            // data: formData, // our data object
            dataType: 'json', // what type of data do we expect back from the server
            encode: true,
            headers: {
                "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
            },

            beforeSend: function (request) {
                request.setRequestHeader("Access-Control-Allow-Origin", "*");
                request.setRequestHeader("Access-Control-Allow-Methods", "POST, GET, PUT, UPDATE, OPTIONS");
                request.setRequestHeader("Access-Control-Allow-Headers", "Content-Type, Accept, X-Requested-With");
            },

            success: function (result) {
                console.log('result:')
                console.log(result);
                if (result.errors){
                    var alertBox = "<h5>Errors: </h5><ul>";
                    result.errors.forEach(function (item){
                        alertBox += "<li>"+item.msg+"</li>"
                    })
                    alertBox += "</ul>"
                    console.log(alertBox)
                    $('#responseAlert'+id).css("visibility", "visible")
                    $('#responseAlert'+id).html(alertBox)
                } else {
                    $('#responseAlert'+id).css("visibility", "visible")
                    $('#responseAlert'+id).css("background-color", "green")
                    $('#responseAlert'+id).html("<h5>Article sucessfully uploaded!</h5>")
                    window.setTimeout(location.reload() , 3000)

                }


            },
            error: function (xhr, ajaxOptions, thrownError) {
                console.log(xhr.status);
                console.log(thrownError);
                $('#responseAlert'+id).html('Currently not able to access StorageUI')
                $('#responseAlert'+id).css("visibility", "visible")
            }
        })


        // stop the form from submitting the normal way and refreshing the page
        event.preventDefault();


        // TODO: 3 parameters   path=$submission->getId()|to_array:$submissionFile->getFileId():$submissionFile->getRevision()}"
        //    Path=<a href="https://iivooo.suhail.uberspace.de/ojs/index.php/testJournal/author/downloadFile/19/24/1" class="file">19-24-1-SM.pdf</a> ... get from dummy a href?
    });

    // process for articles
    $('.login-form').submit(function (event) {

        // get the form data
        // there are many ways to get this data using jQuery (you can use the class or id also)
        var formData = {
            "usr": $(this).find('input[name=usr]').val(),//$('input[usr=usr]').val(),
            "pwd": $(this).find('input[name=pwd]').val()//$('input[pwd=pwd]').val(),
        };
        console.log($(this).find('input[name=storagePath]').val())
        console.log($(this).find('input[name=usr]').val())
        console.log($(this).find('input[name=pwd]').val())
        baseURL = $(this).find('input[name=storagePath]').val() + "/"+$(this).find('input[name=usr]').val()+"/"+
            $(this).find('input[name=pwd]').val();
        console.log(baseURL)

        var id = $(this).find('input[name=thisid]').val()

        // process the form
        $.ajax({
            type: 'GET', // define the type of HTTP verb we want to use (POST for our form)
            url: baseURL, // the url where we want to POST
            // data: formData, // our data object
            dataType: 'json', // what type of data do we expect back from the server
            encode: true,
            headers: {
                "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
            },

            beforeSend: function (request) {
                request.setRequestHeader("Access-Control-Allow-Origin", "*");
                request.setRequestHeader("Access-Control-Allow-Methods", "POST, GET, PUT, UPDATE, OPTIONS");
                request.setRequestHeader("Access-Control-Allow-Headers", "Content-Type, Accept, X-Requested-With");
            },

            success: function (result) {
                console.log('result:')
                console.log(result);
                if (result.errors){
                    var alertBox = "<h5>Errors: </h5><ul>";
                    result.errors.forEach(function (item){
                        alertBox += "<li>"+item.msg+"</li>"
                    })
                    alertBox += "</ul>"
                    console.log(alertBox)
                    $('#responseAlert'+id).css("visibility", "visible")
                    $('#responseAlert'+id).html(alertBox)
                } else {
                    $('#responseAlert'+id).css("visibility", "visible")
                    $('#responseAlert'+id).css("background-color", "green")
                    $('#responseAlert'+id).html("<h5>Article sucessfully uploaded!</h5>")
                    window.setTimeout(location.reload() , 3000)

                }


            },
            error: function (xhr, ajaxOptions, thrownError) {
                console.log(xhr.status);
                console.log(thrownError);
                $('#responseAlert'+id).html('Currently not able to access StorageUI')
                $('#responseAlert'+id).css("visibility", "visible")
            }
        })


        // stop the form from submitting the normal way and refreshing the page
        event.preventDefault();


    // TODO: 3 parameters   path=$submission->getId()|to_array:$submissionFile->getFileId():$submissionFile->getRevision()}"
    //    Path=<a href="https://iivooo.suhail.uberspace.de/ojs/index.php/testJournal/author/downloadFile/19/24/1" class="file">19-24-1-SM.pdf</a> ... get from dummy a href?
    });

    // register form
    $('.register-form').submit(function (event) {

        // get the form data
        // there are many ways to get this data using jQuery (you can use the class or id also)
        var formData = {
            "usr": $(this).find('input[name=regusr]').val(),//$('input[usr=usr]').val(),
            "pwd": $(this).find('input[name=regpwd1]').val(),//$('input[pwd=pwd]').val(),
            "pwd2": $(this).find('input[name=regpwd2]').val()//$('input[pwd=pwd]').val(),

        };

        baseURL = 'https://iivooo.suhail.uberspace.de/ojs/proxy.php'
        console.log(baseURL)

        var id = $(this).find('input[name=thisid]').val()

        // process the form
        $.ajax({
            type: 'POST', // define the type of HTTP verb we want to use (POST for our form)
            url: baseURL, // the url where we want to POST
            data: formData, // our data object
            dataType: 'json', // what type of data do we expect back from the server
            encode: true,
            headers: {
                "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
            },

            beforeSend: function (request) {
                request.setRequestHeader("Access-Control-Allow-Origin", "*");
                request.setRequestHeader("Access-Control-Allow-Methods", "POST, GET, PUT, UPDATE, OPTIONS");
                request.setRequestHeader("Access-Control-Allow-Headers", "Content-Type, Accept, X-Requested-With");
            },

            success: function (result) {
                console.log('result:')
                console.log(result);
                if (result.errors){
                    var alertBox = "<h5>Errors: </h5><ul>";
                    result.errors.forEach(function (item){
                        alertBox += "<li>"+item.msg+"</li>"
                    })
                    alertBox += "</ul>"
                    console.log(alertBox)
                    $('#responseAlert'+id).css("visibility", "visible")
                    $('#responseAlert'+id).css("background-color", "lightred")
                    $('#responseAlert'+id).html(alertBox)
                } else {
                    $('#responseAlert'+id).css("visibility", "visible")
                    $('#responseAlert'+id).css("background-color", "lightgreen")
                    $('#responseAlert'+id).html("<h5>Successfully registered!</h5>")

                }


            },
            error: function (xhr, ajaxOptions, thrownError) {
                console.log(xhr.status);
                console.log(thrownError);
                $('#responseAlert'+id).html('Currently not able to access StorageUI')
                $('#responseAlert'+id).css("visibility", "visible")
            }
        })


        // stop the form from submitting the normal way and refreshing the page
        event.preventDefault();


        // TODO: 3 parameters   path=$submission->getId()|to_array:$submissionFile->getFileId():$submissionFile->getRevision()}"
        //    Path=<a href="https://iivooo.suhail.uberspace.de/ojs/index.php/testJournal/author/downloadFile/19/24/1" class="file">19-24-1-SM.pdf</a> ... get from dummy a href?
    });



});
