// <!-- This is a test file for using timestamp.org -->

  //include("https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js");
  var hash;
  function handleFileSelect() {
    var reader = new FileReader();
    var file = document.getElementById('submissionFile1').files[0];
    reader.onload = function(e) {
      localStorage['hash'] = forge_sha256(reader.result); //use localstorage due to redirecting
      console.log(localStorage['hash']);
      // uploadHash(hash);
    }
    reader.readAsBinaryString(file);
  }

  var apiKey = "988e7238-995e-4db0-8277-ce8f75d4b037";
  var baseURL = "https://api.originstamp.org/api/";

  function uploadHash() {
    var ajaxDump = $.ajax({
      url: baseURL.concat(localStorage['hash']),
      type: "POST",

      data: JSON.stringify({submit_ops: ["multi_seed"]}),
      contentType: "application/json; charset=UTF-8",
      async: false,
      headers: {
      "Authorization": apiKey},
      dataType: "json",
      success: function (result){
        console.log(result);
      },
      error: function (xhr, ajaxOptions, thrownError){
        console.log(xhr.status);
        console.log(thrownError);
      }
    });
    console.log(JSON.stringify(ajaxDump, null, 2));
    localStorage['hash']="";
  }
 console.log("script loaded");
//   $('#submitStep2').submit('click', function(e) {
//      e. preventDefault();
//     console.log("ajax invoked");
//     handleFileSelect();
//     return true; // return false to cancel form action
// });
