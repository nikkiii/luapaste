function createPaste() {
	$("#paster").submit();
}

$(document).ready(function() {
	$('textarea').focus().tabby();
	$('.save').click(function() {
		$('#submit').click();
	});
});
