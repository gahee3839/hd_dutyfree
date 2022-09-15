function go_cart() {
  if (document.formm.quantity.value == "") {
    alert("수량을 입력하여 주세요.");
    document.formm.quantity.focus();
  } else {
    document.formm.action = "DutyfreeServlet?command=cart_insert";
    document.formm.submit();
  }
}

function allChk(obj){
	var chkObj = document.getElementsByName("cartSeq");
	var rowCnt = chkObj.length - 1;
	var check = obj.checked;
	if(check){
		for(var i=0; i<=rowCnt; i++){
			if(chkOb[i].type == "checkbox"){
				chkObj[i].checked = true;
			}
		}
	} else{
		for(var i=0; i<=rowCnt; i++){
			if(chkObj[i].type == "checkbox"){
				chkObj[i].checked = false;
			}
		}
	}
}

function go_cart_delete() {
  var count = 0;

  if (document.formm.cartSeq.length == undefined) {
    if (document.formm.cartSeq.checked == true) {
      count++;
    }
  }

  for ( var i = 0; i < document.formm.cartSeq.length; i++) {
    alert("" + document.formm.cartSeq[i].checked);
    if (document.formm.cartSeq[i].checked == true) {
      count++;
      alert("" + count);
    }
  }
  if (count == 0) {
    alert("삭제할 항목을 선택해 주세요.");

  } else {
    document.formm.action = "DutyfreeServlet?command=cart_delete";
    document.formm.submit();
  }
}

function go_order_insert() {
  document.formm.action = "DutyfreeServlet?command=order_insert";
  document.formm.submit();
}

function go_order_delete() {
  var count = 0;

  if (document.formm.oseq.length == undefined) {
    if (document.formm.oseq.checked == true) {
      count++;
    }
  }

  for ( var i = 0; i < document.formm.oseq.length; i++) {
    if (document.formm.oseq[i].checked == true) {
      count++;
    }
  }
  if (count == 0) {
    alert("삭제할 항목을 선택해 주세요.");

  } else {
    document.formm.action = "NonageServlet?command=order_delete";
    document.formm.submit();
  }
}

function go_order() {
  document.formm.action = "NonageServlet?command=mypage";
  document.formm.submit();
}