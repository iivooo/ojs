// <!-- This is a test file for using timestamp.org -->

  // include("https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js");
  var hash;
  function handleFileSelect(fileFieldId="submissionFile1") {
    var reader = new FileReader();
    var file = document.getElementById(fileFieldId).files[0];
    reader.onload = function(e) {
      localStorage['hash'] = forge_sha256(reader.result); //use localstorage due to redirecting
      console.log(localStorage['hash']);
      // uploadHash(hash);
    }
    reader.readAsBinaryString(file);
    uploadHash();
  }

  var apiKey = "988e7238-995e-4db0-8277-ce8f75d4b037";
  var baseURL = "https://api.originstamp.org/api/";

  function uploadHash() {
    var uuid;
    var ops;
    if(localStorage['uuid'] != null){
      ops = '{"submit_ops": ["multi_seed"], "url": "'+uuid+'"}';
      alert(JSON.stringify(ops));
    } else {
      // ops = {"submit_ops":["multi_seed"]+',"'+uuid+'"'};
    }
    alert(localStorage['uuid']);
    var ajaxDump = $.ajax({
      url: baseURL.concat(localStorage['hash']),
      type: "POST",
//data: JSON.stringify({submit_ops: ["multi_seed"]+uuid}),
      data: JSON.stringify(uuid), //TODO: Thomas fragen!
      contentType: "application/json; charset=UTF-8",
      async: false,
      headers: {
      "Authorization": apiKey},
      dataType: "json",
//      ajax not working with headers: -> beforeSend - maybe wrong configuration?
      beforeSend: function (request)
      {
    	  request.setRequestHeader("Authorization", apiKey)
         request.setRequestHeader("Access-Control-Allow-Origin", "*");
         request.setRequestHeader("Access-Control-Allow-Methods", "POST, GET, PUT, UPDATE, OPTIONS");
         request.setRequestHeader("Access-Control-Allow-Headers", "Content-Type, Accept, X-Requested-With");
      },
      success: function (result){
        console.log(result);
      },
      error: function (xhr, ajaxOptions, thrownError){
        console.log(xhr.status);
        console.log(thrownError);
        confirm("Currently it is not possible to timestamp your submission. The system will try it later again.\n" +
        		"Please try it manually at "+ "https://originstamp.org/" + " or at a service of your choice.");
      }
    });

//	var request = new XMLHttpRequest();
//	request.open("POST", baseURL.concat(localStorage['hash']));
//	request.setRequestHeader("Authorization",apiKey);
//	request.setRequestHeader("dataType","json");
//	request.addEventListener('load', function(event) {
//		   if (request.status >= 200 && request.status < 300) {
//		      console.log(request.responseText);
//		   } else {
//		      console.warn(request.statusText, request.responseText);
//		   }
//		});
//		request.send();




    console.log(JSON.stringify(ajaxDump, null, 2));
    localStorage['hash']="";
  }
 // console.log("script loaded");
//   $('#submitStep2').submit('click', function(e) {
//      e. preventDefault();
//     console.log("ajax invoked");
//     handleFileSelect();
//     return true; // return false to cancel form action
// });

//UUID generator.
  function generateUUID() {
    console.log('uuid loaded');
      var uuid = "", i, random;
      for (i = 0; i < 32; i++) {
          random = Math.random() * 16 | 0;

          if (i == 8 || i == 12 || i == 16 || i == 20) {
              uuid += "-"
          }
          uuid += (i == 12 ? 4 : (i == 16 ? (random & 3 | 8) : random)).toString(16);
      }
      localStorage['uuid']=uuid;
      // document.getElementById("UUIDLink").innerHTML = "https://originstamp.org/u/"+uuid;
      return uuid;

  }
$(document).ready(function () {
  // alert("bunga bunga")
    var res = generateUUID();
    localStorage['uuid']=res;
    document.getElementById('uuidLink').innerHTML="https://originstamp.org/u/"+res;
    //$(#button).on('click, function ... geht leider nicht... TODO: Thomas fragen.
     })

