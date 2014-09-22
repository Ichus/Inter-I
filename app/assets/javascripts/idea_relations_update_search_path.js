$( "#idea" )
.change(function () {
  var ideaPath = $( this ).val();
  $( "<span id=\"explore-ideas\"><input class=\"tiny button blue-button\" formaction=\"/relationships/" + ideaPath + "\" type=\"submit\" value=\"Explore Ideas\" /></span>" ).replaceAll( "#explore-ideas" );
});
