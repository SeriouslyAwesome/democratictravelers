(function() {
  window.DemocraticTravelers = window.DemocraticTravelers || {};

  DemocraticTravelers.Templates = DemocraticTravelers.Templates || {};

  DemocraticTravelers.Templates.experience = function(data) {
    var html = '';
    html += '<div class="suggestion" data-experience-id="' + data.slug + '" data-location-id="' + data.locationId + '" data-user-id="' + data.username + '">';
    html += '  <h4>';
    html += '    <div class="map-pin ' + (data.done ? 'map-pin-done' : '') + '">';
    html += '      <span>' + data.votes + '</span>';
    html += '    </div>';
    html += '    &lsquo;' + data.name + '&rsquo;';
    html += '    <small>at ' + data.venue + ' in ' + data.city + ', ' + data.state + '</small>';
    html += '  </h4>';
    html += '  <p class="why"><strong>Why:</strong> ' + data.description + '</p>';
    html += '  <p class="meta">Suggested by <a href="/map/ambassadors/' + data.username + '" class="map-user-link">' + data.userShortName + '</a> on ' + data.date + '</p>';
    html += '  <p class="voting">';
    if (data.done) {
      html += '    <strong>We did this!</strong><br>';
      html += '    <button href="#" class="done" disabled="disabled"><i class="fa fa-check-circle fa-lg"></i> Done!</button>';
      html += '    <span class="votes">' + data.votesText + '</span>';
    } else {
      html += '    <strong>Should we do this?</strong><br>';
      html += '    <button data-id="' + data.slug + '" class="upvote" ' + (data.upvoted ? 'disabled="disabled"' : '') + '><i class="fa fa-thumbs-up fa-lg"></i></button>';
      html += '    <span class="votes">' + data.votesText + '</span>';
      html += '    <button data-id="' + data.slug + '" class="downvote" ' + (data.downvoted ? 'disabled="disabled"' : '') + '><i class="fa fa-thumbs-down fa-lg"></i></button>';
    }
    html += '  </p>';
    html += '</div>';
    return html;
  };
})();
