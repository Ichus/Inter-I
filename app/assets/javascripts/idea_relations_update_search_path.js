// Swap out the Explore Ideas Search button for one with a formaction containing
// the Absolute Path of the idea being searched
$( "#idea" )
.change(function () {
  var ideaPath = $( this ).val();
  var pageUri = location.href;
  var hostRegEx = /http:\/\/[^\/]*/;
  var hostMatchArray = hostRegEx.exec(pageUri);
  var hostUri = hostMatchArray[0].toString();
  $( "<span id=\"explore-ideas\"><input class=\"tiny button blue-button\" formaction=\"" + hostUri + "/relationships/" + ideaPath + "\" type=\"submit\" value=\"Explore Ideas\" /></span>" ).replaceAll( "#explore-ideas" );
});


// Swap out the Explore Ideas Search button for one with a formaction containing
// the Relative Path of the idea being searched
// $( "#idea" )
// .change(function () {
//   var ideaPath = $( this ).val();
//   $( "<span id=\"explore-ideas\"><input class=\"tiny button blue-button\" formaction=\"/relationships/" + ideaPath + "\" type=\"submit\" value=\"Explore Ideas\" /></span>" ).replaceAll( "#explore-ideas" );
// });
