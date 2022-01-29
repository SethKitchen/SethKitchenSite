/*
Copyright 2019 Adobe
All Rights Reserved.
NOTICE: Adobe permits you to use, modify, and distribute this file in
accordance with the terms of the Adobe license agreement accompanying
it. If you have received this file from a source other than Adobe,
then your use, modification, or distribution of it requires the prior
written permission of Adobe.
*/

/* Pass the embed mode option here */
var viewerConfig = {
  defaultViewMode: "",
};

function loadPdf(pdfUrl, pdfName, ran) {
  console.log('in loadPDF with ');
  console.log(pdfUrl);
  console.log(pdfName);
  console.log(ran);

  /* Initialize the AdobeDC View object */
  var adobeDCView = new AdobeDC.View({
    /* Pass your registered client id */
    clientId: "586c068b8f864cbd9315df31b59fa2fa",
    /* Pass the div id in which PDF should be rendered */
    divId: "adobe-dc-view"+ran,
  });

  /* Invoke the file preview API on Adobe DC View object */
  adobeDCView.previewFile({
    /* Pass information on how to access the file */
    content: {
      /* Location of file where it is hosted */
      location: {
        url: pdfUrl,
        /*
                If the file URL requires some additional headers, then it can be passed as follows:-
                header: [
                    {
                        key: "<HEADER_KEY>",
                        value: "<HEADER_VALUE>",
                    }
                ]
                */
      },
    },
    /* Pass meta data of file */
    metaData: {
      /* file name */
      fileName: pdfName
    }
  }, viewerConfig);

  adobeDCView.registerCallback(
      AdobeDC.View.Enum.CallbackType.SAVE_API,
      function(metaData, content, options) {
  console.log('in external function::::');
  console.log(JSON.stringify(metaData));
  console.log(JSON.stringify(content));
  console.log(JSON.stringify(options));
  return new Promise((resolve, reject) => {
  window.aerodocumentsSave(JSON.stringify(metaData), content, options);
  /*if(success) {
                    resolve({
                    code: AdobeDC.View.Enum.ApiResponseCode.SUCCESS,
                    metaData: metaData
                    });
                } else {
                    reject({
                        code: AdobeDC.View.Enum.ApiResponseCode.FAIL,
                        data: {}
                    });
                }*/
  });
  }
  )
}