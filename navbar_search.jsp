<form class="navbar-search pull-left" method="get" action="search.do">
	<div class="input-append">
		<div id="selectpicker_id">
			<select class="selectpicker .clearfix" name="category" style="display:inline;margin-top:0px">
	       		<option value="location">location</option>                     
				<option value="people">people</option> 
			</select>
		</div>
		<input name="keywords" type="text" class="span3" id="appendedInputButton" placeholder="Search..." style="display:inline;border-right:none;" x-webkit-speech />
		<p style="display:none">Speech input is not enabled in your browser.<br> Try running Google Chrome with the <code>--enable-speech-input</code> flag.</p>
		<button class="btn" type="submit" style="border-radius:0 10px 10px 0;border-left:0;">
		<i class="icon-search"></i></button>
	</div>
</form>
