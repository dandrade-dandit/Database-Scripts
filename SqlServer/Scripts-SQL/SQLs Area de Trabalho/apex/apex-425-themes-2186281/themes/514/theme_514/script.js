$(function(){ 
	$('select.selectlist').wrap('<span class="select" />');
		
	if ($.browser.msie) {
	$('ul.htmlTree li:nth-child(odd), .hierarchical-expanded li:nth-child(odd), .VerticalUnorderedListwithBullets li:nth-child(odd), .VerticalUnorderedLinkswithoutBullets li:nth-child(odd), ol.VerticalOrderedList li:nth-child(odd), .WizardProgressList li:nth-child(odd)').css("background-color","#FFF");
	$('ul.htmlTree li:nth-child(even), .hierarchical-expanded li:nth-child(even), .VerticalUnorderedListwithBullets li:nth-child(even) , 	.VerticalUnorderedLinkswithoutBullets li:nth-child(even) ,	ol.VerticalOrderedList li:nth-child(even) ,	.WizardProgressList li:nth-child(even) ').css("background-color","#e4f0fc");
	}
	

});