checked=false;
secondarychecked=false;

function checkAllPlates() {

	var cp = document.getElementsByClassName('plates_check_all');
	var aa = document.getElementsByClassName('plates_check');
	checked=cp[0].checked;
	 if (checked == true)
          {
           checked = true
          }
        else
          {
          checked = false
          }
	for (var i=0; i < aa.length; i++) 
	{
	 
	 aa[i].checked = checked;
	}
}




function checkAllSecondaryPlates() {
	var sp= document.getElementsByClassName('secondary_plates_check');
    var scp= document.getElementsByClassName('secondary_plates_check_all');
	secondarychecked=scp[0].checked;
	 if (secondarychecked == true)
          {
           secondarychecked = true
          }
        else
          {
          secondarychecked = false
          }
	for (var i =0; i < sp.length; i++) 
	{
	 sp[i].checked = secondarychecked;
	}
}

