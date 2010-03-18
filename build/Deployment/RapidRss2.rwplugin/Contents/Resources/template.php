<div class="rssHeader">
<?php echo "$((rssHeader))" ?>
</div>

<!-- ++Begin Dynamic Feed Wizard Generated Code++ -->
<!--
// Created with a Google AJAX Search and Feed Wizard
// http://code.google.com/apis/ajaxsearch/wizards.html
-->

	<!--
	// The Following div element will end up holding the actual feed control.
	// You can place this anywhere on your page.
-->
	<div id="feed-control">
    <span style="color:#676767;font-size:11px;margin:10px;padding:4px;">Loading...</span>
	</div>

	<!-- Google Ajax Api
-->
  <script src="http://www.google.com/jsapi?key=notsupplied-wizard"
    type="text/javascript"></script>

	<!-- Dynamic Feed Control and Stylesheet -->
  <script src="http://www.google.com/uds/solutions/dynamicfeed/gfdynamicfeedcontrol.js"
    type="text/javascript"></script>

	<script type="text/javascript">
    function LoadDynamicFeedControl() {
		var chaine = "$((message))";
        var splitChaine = new Array();
        splitChaine = chaine.split(',');
		var feeds = new Array();
		feeds = splitChaine;
		var options = {
linkTarget : google.feeds.LINK_TARGET_BLANK,
pauseOnHover : false,  
stacked : true,
horizontal : false,
numResults : $((NumberOfItem)),
displayTime : 3000
		}
		
		new GFdynamicFeedControl(feeds, 'feed-control', options);
    }
    // Load the feeds API and set the onload callback.
    google.load('feeds', '1');
    google.setOnLoadCallback(LoadDynamicFeedControl);
	</script>
	<!-- ++End Dynamic Feed Control Wizard Generated Code++ -->

