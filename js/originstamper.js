// <!-- CryptSubmit javascript library -->

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
  }

  var apiKey = "988e7238-995e-4db0-8277-ce8f75d4b037";
  var baseURL = "https://api.originstamp.org/api/";

  function uploadHash() {
    var uuid=localStorage['uuid'];
    var ops;
    if(uuid != null){
      ops = {"submit_ops": ["multi_seed"], "url": uuid};
    } else {
      ops = {"submit_ops":["multi_seed"]};
    }
    var ajaxDump = $.ajax({
      url: baseURL.concat(localStorage['hash']),
      type: "POST",
      data: JSON.stringify(ops), //TODO: Thomas fragen!
      contentType: "application/json; charset=UTF-8",
      async: false,
      headers: {
      "Authorization": apiKey},
      dataType: "json",
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

    console.log(JSON.stringify(ajaxDump, null, 2));
    localStorage['hash']="";
  }

  function generateUUID() {
      var uuid = "", i, random;
      for (i = 0; i < 32; i++) {
          random = Math.random() * 16 | 0;

          if (i == 8 || i == 12 || i == 16 || i == 20) {
              uuid += "-"
          }
          uuid += (i == 12 ? 4 : (i == 16 ? (random & 3 | 8) : random)).toString(16);
      }
      localStorage['uuid']=uuid;
      return uuid;

  }
$(document).ready(function () {
    var res = generateUUID();
    localStorage['uuid']=res;
    document.getElementById('uuidLink').innerHTML="https://originstamp.org/u/"+res;
     })

