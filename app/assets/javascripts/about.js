(function() {
  $(document).ready(function() {
    var baseline = 28;

    $('#family').each(function() {
      $(this).waitForImages(function() {
        $(this).find('img').baseline(baseline);
      });
    });

    $('#press').waitForImages(function() {
      $(this).find('img').baseline(baseline);
    });
  });
})();
