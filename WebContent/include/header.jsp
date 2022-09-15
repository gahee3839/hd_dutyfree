<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  

<%
String memId=(String)session.getAttribute("memId");
%>  
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="format-detection" content="telephone=no">
	<meta name="title" content="현대백화점인터넷면세점">
    <meta name="description" content="해외명품/화장품/시계/가방, 적립금/할인/쿠폰 등 다양한 혜택, 공동구매/가상착장(AR)서비스 제공">  
    <meta name="metaKeywords" content="현대면세점, 현대백화점인터넷면세점, 현대인터넷면세점, 현대백화점면세점, 현대면세, 인터넷현대면세점, 현대온라인면세점, 현대백화점온라인면세점, 현대백화점DUTYFREE,현대무역센터면세점, 현대무역센터점, 현대동대문면세점, 현대동대문점, 현대인천공항면세점, 현대인천공항점, 면세쇼핑몰, 인터넷면세점, 온라인면세점, 인천공항면세점, 인천공항면세, 공항면세, 공항면세점, 공항쇼핑, dutyfree, 면세할인, 면세점할인, 면세가격, 면세점할인방법, 면세추천, 면세선물, 면세점선물, 면세점선물추천, 현대면세점인도장, 면세점인도장, 면세점상품수령, 쇼핑, 쇼핑몰, 명품쇼핑, 해외여행, 인천공항, 출장, 출국, 신혼여행, 허니문, 여행선물, 선물인터넷면세점주문, 인터넷면세점주문가능시간, 출국3시간전, 출국전쇼핑, 출국전인터넷쇼핑, 쿠폰, 할인쿠폰, 면세쿠폰, 면세점쿠폰, 현대면세점쿠폰, 적립금, 면세점적립금, 면세적립금, 현대면세점적립금,화장품, 향수, 가방, 명품, 해외명품, 브랜드, 면세점주류, 면세점담배, 면세점홍삼, 면세점화장품, 면세점향수, 면세점명품, 면세점시계, 면세점가방, 명품가방, 면세점정품">
    <meta property="og:title" content="현대백화점인터넷면세점">
	    <meta property="og:description" content="해외명품/화장품/시계/가방, 적립금/할인/쿠폰 등 다양한 혜택, 공동구매/가상착장(AR)서비스 제공">
	    <meta property="og:image" content="https://cdn.hddfs.com/front/images/KO/common/hddfs_og.png">
	<script src="https://cdn.hddfs.com/front/js/KO/jquery-1.12.4.min.js?ver=18"></script>
	<script src="https://cdn.hddfs.com/front/js/KO/jquery-ui.js?ver=18"></script>
	<script src="https://cdn.hddfs.com/front/js/KO/lottie.min.js?ver=18"></script>
	<script src="https://cdn.hddfs.com/front/js/KO/swiper-bundle.min.js?ver=18"></script>
	<script src="https://cdn.hddfs.com/front/js/KO/jquery.lazyload.min.js?ver=18"></script>
	<script src="https://cdn.hddfs.com/front/js/KO/jquery.lazyloadxt.min.js?ver=18"></script>
	<script src="https://cdn.hddfs.com/front/js/KO/common.ui.js?ver=18"></script>
	<script src="https://cdn.hddfs.com/front/js/KO/main.ui.js?ver=18"></script>
	<link rel="shortcut icon" href="https://cdn.hddfs.com/front/images/KO/common/favicon_H.ico">
	<link rel="stylesheet" href="https://cdn.hddfs.com/front/css/KO/jquery-ui.css?ver=18">
	<link rel="stylesheet" href="https://cdn.hddfs.com/front/css/KO/swiper-bundle.min.css?ver=18">
	<link rel="stylesheet" href="https://cdn.hddfs.com/front/css/KO/common.css?ver=18">
	<link rel="stylesheet" href="https://cdn.hddfs.com/front/css/KO/layout.css?ver=18">
	<link rel="stylesheet" href="https://cdn.hddfs.com/front/css/KO/main.css?ver=18">
	<script language="javascript">
    // 현재 요청경로    
</script>

<script type="text/javascript" src="https://cdn.hddfs.com/front/js/KO/crew/crew.source.js?ver=18"></script>
<script type="text/javascript" src="https://cdn.hddfs.com/front/js/KO/crew/form/form.source.js?ver=18"></script>
<script type="text/javascript" src="https://cdn.hddfs.com/front/js/KO/crew/sns.js?ver=18"></script>
<script type="text/javascript" src="https://cdn.hddfs.com/front/js/KO/jquery.cookie.js?ver=18"></script>
<script type="text/javascript" src="https://cdn.hddfs.com/front/js/KO/common.js?ver=18"></script>
<!-- S: 다이퀘스트 스크립트 추가 -->
<script type="text/javascript" src="https://cdn.hddfs.com/front/js/KO/diquest/dqAutoCompleteCommon.js?ver=18"></script>
<script type="text/javascript" src="https://cdn.hddfs.com/front/js/KO/diquest/dqHeader.js?ver=18"></script>
<!-- E: 다이퀘스트 스크립트 추가 -->
<script type="text/javascript" src="https://cdn.hddfs.com/front/js/KO/cloud-zoom.1.0.2.js?ver=18"></script>
<script type="text/javascript" src="https://cdn.hddfs.com/front/js/KO/SsoAjax.js?ver=18"></script>
<script type="text/javascript" src="https://cdn.hddfs.com/front/js/KO/SsoHttpRequest.js?ver=18"></script>
<script type="text/javascript" src="https://cdn.hddfs.com/front/js/KO/makePCookie.js?ver=18"></script>
<script type="text/javascript" src="https://cdn.hddfs.com/front/js/KO/crew/hash.js?ver=18"></script>
</head>

<header id="header" style="padding:0 50px;">
	<section class="box">
	    <!-- <h1 onclick="goMainPage();" style="cursor: pointer;">HYUNDAI DEPARTMENT SHOP - DUTY FREE</h1> -->
	    <h1 onclick="goMainPage();" style="cursor: pointer;" ><img id = "mainLogo" src="https://cdn.hddfs.com/front/images/KO/common/logo.png?RS=192X40" alt="HYUNDAI DEPARTMENT SHOP - DUTY FREE"></h1>
	    <form name="searchHeader" id="searchHeader" method="get" onsubmit="return false;">
	    <fieldset class="searchfield" >
	    	<legend>통합검색</legend>
	        
	        <div class="mainsearchinput">
		        <input type="search" class="text_search" name="searchTerm" id="basicSearchTerm" maxlength="" value="" placeholder="검색어를 입력해주세요" onkeypress="javascript:if(event.keyCode == 13) { searchHeaderAction();}" onmousedown="dq_setTextbox('1',event);" onfocusin="srchLayer();" onkeydown="dq_setTextbox('1',event);" autocomplete="off"/>
		        <input type="search" class="tag_search" name="searchTerm" id="hashSearchTerm" maxlength="" value="" placeholder="해시태그를 입력해주세요" onkeypress="javascript:if(event.keyCode == 13) { searchHeaderAction();}" onmousedown="dq_setTextbox('1',event);" onfocusin="srchLayer();" onkeydown="dq_setTextbox('1',event);" autocomplete="off"/>
		        <input type="hidden" id="movUrl" name="movUrl" value=""/>
		        <input type="hidden" id="rcntOffYn" name="rcntOffYn" value="" />	  <!-- 최근검색어 저장 사용 유무 -->
			    <input type="hidden" id="rcntWrdYn" name="rcntWrdYn" value="" />      <!-- 최근검색어 존재 유무 여부 -->
			    <input type="hidden" id="autoOffYn" name="autoOffYn" value="" />      <!-- 자동완성 사용 여부 -->
			    <input type="hidden" id="searchType" name="searchType" value="" />   <!-- 검색 타입 구분 -->
			    <input type="hidden" id="searchOrder" name="order" value="" />   		  <!-- 정렬 구분 -->
		    </div>
	        <button class="btn_search" onclick="searchHeaderAction();">검색</button>
	    </fieldset>
	    </form>
	    <!-- 검색 레이어 영역 START -->
    	<div class="advanced_search">
	<div class="tab-action theme_search" id="allSearchArea">
	    <ul class="tab_textmedium" id="searchTabBox" style="display:none">
	        <li id="rcntTab">
	            <a href="#advanced_search_01">최근 · 인기검색어</a>
	        </li>
	        <li id="brandTab">
	            <a href="#advanced_search_02">브랜드검색</a>
	        </li>
	    </ul>

	    <div class="adsearch_panel" id="searchLayerList">
	    	<div id="advanced_search_01" class="popular_search">
	    	
	    	</div>
	    	
	    	<div id="advanced_search_02" class="brand_search">
	            <div class="tab-action">
	                <ul class="tab_round">
	                    <li id="default_brand_tab">
	                        <a href="#advanced_search_brand_01">BRA ND</a>
	                    </li>
	                    <li id="default_category_tab">
	                        <a href="#advanced_search_brand_02">CATEGORY</a>
	                    </li>
	                </ul>
	                <div id="advanced_search_brand_01">
	                    <div class="sort_wrap">
	                        <div class="tab-action">
	                            <ul class="sortbtn_wrap" id="brandSortBtn">
	                                <li><a href="#brand_sortbtn_01" onclick="switchBranTab('01');">가나다순</a></li>
	                                <li><a href="#brand_sortbtn_02" onclick="switchBranTab('02');">ABC순</a></li>
	                            </ul>
	                            <div id="brand_sortbtn_01" class="lang_sort on">
	                                <div class="brand_cate">
										<ul id="brandKrList">
											</ul>
		                            </div>
		                            
	                            </div>
	                            <div id="brand_sortbtn_02" class="lang_sort">
		                            <div class="brand_cate">
										<ul id="brandEnList">
											</ul>
		                            </div>
	                            </div>
	                        </div>
	                    </div>
	                </div>
	                
	                <div id="advanced_search_brand_02">
	                    <div class="sort_wrap">
	                        <div class="tab-action">
	                            <div id="brand_sortbtn_03" class="lang_sort on">
	                                <div class="brand_cate">
										<ul id="cateList">
											</ul>
		                            </div>
	                            </div>
	                        </div>
	                        
	                    </div>
	                </div>
	            </div>
	        </div>
	    </div>
	</div>
	<div class="search_autocomplete" id="autoList" style="display:none;">
	    <div class="none_autoword" id="no_autoComplete" style="display:none;">자동완성기능을 사용하고 있지 않습니다.</div>
	    <span class="switch autoword">
	    	<input type="checkbox" id="autoCompleteBtn" onclick="javascript:autoCompleteSwitch();">
	        <label for="autoCompleteBtn">
	            <span class="slider"></span>
	            <span>자동완성</span>
	        </label>
	    </span>
	</div>
	<a href="javascript:" class="search_close">닫기</a>
</div>

<script src="https://cdn.hddfs.com/front/js/KO/diquest/dqAutoComplete.js"></script>	
<script type="text/javascript">	

	
	$(function(){
		
		// 검색결과에 따라 검색창 변환
		changeSearchArea();
		
		if($("#autoOffYn").val() == "" || $("#autoOffYn").val() == null){
			$("#autoOffYn").val('Y');
		}
		
		// 일반 검색창에 # 입력시 해시태그 검색창 전환
		$("#basicSearchTerm").on('keyup', function(){
			if($("#basicSearchTerm").val() === "#"){
				$(".select_search #hashSrchCond").trigger('click');
				//changeSearchTextBox();
				//console.log("dq_autoSearchType : " + dq_autoSearchType);
				$("#hashSearchTerm").focus();
			}
		});
		
		// 검색 조건 클릭시 자동완성 타입 변경
		$(".select_search button").on('click', function(){
			changeSearchTextBox();
		});
		
		// 검색창 클릭시 검색 레이어 호출
		$("#basicSearchTerm, #hashSearchTerm").on('click', function(){
			if( ($("#brandKrList > li").length <1) || ($("#brandEnList > li").length <1)){
				loadBranIcKrList();
			} 
			if($("#brandTab").attr('tabindex') == '0'){
				wiseLogAggr("KR_PC_Common_BrandSearch");
			}else{
				wiseLogAggr("KR_PC_Common_SearchKeyword");
			}
			srchLayer();
		});
		
		$("#default_category_tab > a").click(function(){
			//카테고리 로드
			loadCtgList();
		});
		
		$("#brandTab").on('click', function(){
			wiseLogAggr("KR_PC_Common_BrandSearch");
			$(".tab_round #default_brand_tab a").trigger('click');
		});
		
		$("#rcntTab").on('click', function(){
			wiseLogAggr("KR_PC_Common_SearchKeyword");
		});
		
		$("#default_brand_tab a").on('click', function(){
			wiseLogAggr("KR_PC_Common_BrandSearch_Brand");
		});
		
		$("#default_category_tab a").on('click', function(){
			wiseLogAggr("KR_PC_Common_BrandSearch_Category");
		});
		
	});
	
	function branAction(branCd){
		$(location).attr('href', ctx_curr+"/dm/bran/brand.do?onlnBranCd="+branCd);
		
 	}
	
	//브랜드 ㄱㄴㄷ > ABC 변경시
	function switchBranTab(type){
		if(type =="02"){
			//ABC 순 조회
			loadBranIcEnList();
		}
		$("#brand_sortbtn_"+type+" > div > ul > li > button").removeClass("on");
		$("#brand_sortbtn_"+type+" > div > ul > li:eq(0) > button").addClass("on");
		$("#brand_sortbtn_"+type+" > div > ul > li > .branTabResult").removeClass("on");		
		$("#brand_sortbtn_"+type+" > div > ul > li:eq(0) > .branTabResult").addClass("on");
	}
	
	// 초성 선택시 동작
	function chgBranTab($this,type){
		if(!$($this).hasClass("disabled")){
			if(type ==1){		//국문
				$("#brandKrList > li").each(function(){
					var dataGroup = $(this).data("group-pos");
					if($('[data-group="bran'+dataGroup+'"]:checked').length < 1){
						$(this).find("button").removeClass("on");
					}
				});
			}else{
				$("#brandEnList > li").each(function(){
					var dataGroup = $(this).data("group-pos");
					if($('[data-group="bran'+dataGroup+'"]:checked').length < 1){
						$(this).find("button").removeClass("on");
					}
				});
			} 
			$(".branTabResult").removeClass("on");
			$($this).addClass("on");
			$($this).parent().find("div").addClass("on");
		}
	}
	
	// 카테고리 선택시 동작
	function chgCateTab($this){
		if(!$($this).hasClass("disabled")){
			$("#cateList > li").each(function(){
				var dataGroup = $(this).data("group-pos");
				if($('[data-group="cate'+dataGroup+'"]:checked').length < 1){
					$(this).find("button").removeClass("on");
				}
			});
			$(".cateTabResult").removeClass("on");
			$($this).addClass("on");
			$($this).parent().find("div").addClass("on");
		}
	}
	
	// 검색어 목록 call json
  	function srchLayer(){
		// 검색어 있는 상태일때 자동완성 실행
		if($("#basicSearchTerm").val().length > 0 || $("#hashSearchTerm").val().length > 0){
			dq_reqSearch();
		}
		
		// 검색 타입 구분
		var searchType = $("#searchType").val();
		
		$.ajax({
		    async       : true,
		    url         : ctx_curr + "/sr/searchLayer.json",
		    dataType    : "json",
		    type        : "POST",
		    data        : { searchType : searchType },
		    success     : function(data, textStatus, jqXHR){
		        if(!crew.ajaxValidate(data)){ return; }
		        // 검색어 목록 추가
		        //$("#searchLayerList").append(data.html);
		        $("#advanced_search_01").html(data.html);
		        
		        // 최근 검색어 존재 유무 세팅
	        	$("#rcntWrdYn").val(data.dqGoosSrch.rcntWrdYn);
				
		        // 자동 저장 사용 유무를 쿠키에서 받아옴
		        if(data.rcntOffYn != null){
		        	$("#rcntOffYn").val(data.rcntOffYn);
		        }else{
		        	$("#rcntOffYn").val('Y');
		        }
		        
		     	// 정렬값를 쿠키에서 받아옴
		        if(data.order != null){
		        	$("#searchOrder").val(data.order);
		        }else{
		        	$("#searchOrder").val('random');
		        }
	        	// 초기 자동저장 세팅 
	        	setAutoSave();
		     	
		    	 // 자동완성 기능 사용여부 
				if($("#autoOffYn").val() == 'N'){
					dq_acOff();
				}else{
					dq_acArrow();
				}
		    },
		    error       : function(jqXHR, textStatus, errorThrown){
		        //console.log(jqXHR.status);
		    }
		});
	}
	
   
	
	
	// 해시태그 결과 페이지인 경우 검색창 전환
	function changeSearchArea(){
		if($("#resultSearchType").val() == "hash"){
	 		dq_autoSearchType = "hash";
	 		$(".searchfield .select_search").addClass("tag");
			$(".mainsearchinput").addClass("tag");
			$(".searchfield .tooltip").text("일반단어로 검색하세요 :)")
			$("#basicSearchTerm").val('');
			//console.log("해시태그 결과 페이지 확인 : " + dq_autoSearchType);
		} else {
	 		dq_autoSearchType = "basic";
	 		$(".searchfield .select_search").removeClass("tag");
			$(".mainsearchinput").removeClass("tag");
			$(".searchfield .tooltip").text("해시태그로 검색하세요 :)")
			$("#hashSearchTerm").val('');
			//console.log("일반 결과 페이지 확인 : " + dq_autoSearchType);
		}
	}
	
	
    // HDDFS 리뉴얼 프로젝트 [이승훈-2021.04.16] - 자동완성 기능 추가
    // 자동완성 on/off
	function autoCompleteSwitch(){
	    
    	if ($("#autoOffYn").val() === 'Y') {
	        dq_acOff();
//   		console.log("자동완성 미사용 전환  : " + $("#autoOffYn").val());
    		
    	} else {
    		dq_acArrow();
//    		console.log("자동완성 사용 전환  : " + $("#autoOffYn").val());
    	}
	}
	
	// 자동 저장 on/off
    function autoSaveSwitch() {
    	
    	// 사용 -> 미사용으로 전환
    	if ($("#rcntOffYn").val() === 'Y') {
    		$("#rcntOffYn").val('N');
    		$("#rcntKeyword").hide();
    		$("#deleteAll").hide();
    		$(".words_list #noRcnt").show();
    		$("#noRcnt").text('자동저장 기능 미사용 중입니다.');
//    		console.log("자동저장 미사용으로 전환 : " + $("#rcntOffYn").val());
        // 미사용 -> 사용으로 전환   
    	} else {
    		$("#rcntOffYn").val('Y');
    		$(".words_list #noRcnt").hide();
    		$("#rcntKeyword").show();
    		$("#deleteAll").show();
//    		console.log("자동저장 사용으로 전환 : " + $("#rcntOffYn").val());
       		
    		// 사용하지만 최근 검색어가 없을때 
    	 	if ($("#rcntWrdYn").val() === 'N') {
    	 		$("#rcntKeyword").hide();
    	 		$("#deleteAll").hide();
    	 		$(".words_list #noRcnt").show();
    	 		$("#noRcnt").text('최근 검색어가 없습니다.');
    	 	}
    	}
    	
    	autoSaveActionBySaveCookie();	
    	
    	
    }
	
    // 쿠키 사용 (자동저장 유무 값 유지용도)
	function autoSaveActionBySaveCookie() {
	    
		var rcntOffYn = $("#rcntOffYn").val();
		
	    $.ajax({
	        async       : true,
	        url         : ctx_curr+"/sr/srchWrdSave.json",
	        dataType    : "json",
	        type        : "POST",
	        cache       : false,
	        data        : {"rcntOffYn" : rcntOffYn},
	        success     : function(data, textStatus, jqXHR){
	            if(!crew.ajaxValidate(data)){ return; }
	        },
	        error       : function(jqXHR, textStatus, errorThrown){
	            //console.log(jqXHR.status);
	        }
	    });
	} 	

	// 최근 검색어 삭제
	function delSrchWrd(srchWrd, hashTagYn){
	
		//console.log("삭제된 검색어 srchWrd : " + srchWrd);
		
		var searchType = "";
		if(hashTagYn == 'Y'){
			searchType = "hash"
		}else if(hashTagYn == 'all'){
			searchType = "all"
		}else {
			searchType = "basic"
		}
		
		//console.log(searchType);
		
		if (srchWrd === null || srchWrd === undefined) {
			srchWrd = "";
		}
		
	    var html = "";
	    
	    /* 최근검색어 삭제요청 */
	    $.ajax({
	        async       : true,
	        url         : ctx_curr+"/sr/delSrchWrd.json",
	        dataType    : "json",
	        type        : "POST",
	        cache       : false,
	        data        : {
	        				"srchWrd" : srchWrd, 
	        				"searchType" : searchType 
	        	  		  },
	        
	        success     : function(data, textStatus, jqXHR){
	            if(!crew.ajaxValidate(data)){ return; }
	            
		           	if(data.recentList.length > 0){
		            	$.each(data.recentList,function(key){
		                    var list = data.recentList[key];
		                    
		                    if(list.srchClsCd == "001"){
		                    	html += "<li><a href=\""+ctx_curr+"/sr/searchResult.do?searchTerm="+ encodeURIComponent(list.srchWrd) + "&searchType="+encodeURIComponent("basic")+"\">"+list.srchWrd+"</a><button type=\"button\" class=\"ic_x deleteOne\" onclick=\"javascript:delSrchWrd('"+list.srchWrd+"', 'N');\">X</button></li>";
		                    }else{
		                    	html += "<li><a href=\""+ctx_curr+"/sr/hashSearchResult.do?searchTerm="+ encodeURIComponent(list.srchWrd) +"&searchType="+encodeURIComponent("hash")+"\">#"+list.srchWrd+"</a><button type=\"button\" class=\"ic_x deleteOne\" onclick=\"javascript:delSrchWrd('"+list.srchWrd+"', 'Y');\">X</button></li>";
		                    }
		                });
		            	$("#rcntKeyword").html(html);
		            }else{
		            	$("#rcntKeyword").empty();
		            	$("#noRcnt").show();
		            	$("#noRcnt").text('최근 검색어가 없습니다.');
		            	$("#deleteAll").hide();
		            }
		            
		           	// 최근 검색어가 있을때
		            if(data.dqGoosSrch.rcntWrdYn == 'Y'){
		            	$("#rcntWrdYn").val('Y');
		            	$("#rcntKeyword").show();
		                $("#noRcnt").hide();
		            // 최근 검색어가 없을때
		            }else{
		            	$("#rcntWrdYn").val('N');
		            	$("#rcntKeyword").hide();
		            	$("#noRcnt").show();
		            	$("#noRcnt").text('최근 검색어가 없습니다.');
		            }
	            
	        },
	        error       : function(jqXHR, textStatus, errorThrown){
	            //console.log(jqXHR.status);
	        }
	    });
	}
	
	
	// 검색어 체크
	function checkSearchTerm(searchTerm){
		var ke = dqc_trimSpace(searchTerm);

		while(ke.indexOf("\\") != -1)
			ke = ke.replace("\\", "");

		while(ke.indexOf("\'") != -1)
			ke = ke.replace("\'", "");
		
		return ke;		
	}
	
	// form submit
    function searchHeaderAction(){
    	wiseLogAggr("KR_PC_GNB_SearchIcon");
    	//$(".advanced_search").removeClass("adsearch_open");

		// 검색어 미입력 시 삽입된 문구로 검색 혹은 지정된 url로 이동
		/* if ($("#basicSearchTerm").val() === "" && $("#hashSearchTerm").val() === "") {
			var url = $("#searchHeader").find("[name=movUrl]").val();
		    
			if(url != ""){
				location.href = url;
		    }else{
		    	alert("검색어를 입력해주세요."); // 검색어를 입력해주세요 
		    }
		}else{ */
			var result = '';
			$("#movUrl").attr('disabled', true);
		
	     	// 일반 검색 일때
	     	if (!$(".mainsearchinput").hasClass('tag')){
	     		if ($("#basicSearchTerm").val() === "") {
	    			var url = $("#searchHeader").find("[name=movUrl]").val();
	    		    
	    			if(url != ""){
	    				location.href = url;
	    		    }else{
	    		    	alert("검색어를 입력해주세요."); // 검색어를 입력해주세요 
	    		    }
	     		}else{
	     			$(".advanced_search").hide();
	     			
		     		result = checkSearchTerm($("#basicSearchTerm").val());
		     		$("#basicSearchTerm").val(result);
		     		$("#hashSearchTerm").val('');
		     		$("#basicSearchTerm").attr('disabled', false);
		    		$("#hashSearchTerm").attr('disabled', true);
		    		// 일반검색은 order값 제외
		    		$("#searchOrder").attr('disabled', true); 
		    		// 검색 타입 구분
		    		$("#searchType").val("basic");
		    		
		    		searchHeader.action = ctx_curr+"/sr/searchResult.do";
		    		searchHeader.submit();
	     		}
	    	} else {
	    	// 해시태그 검색 일때
	    		if ($("#hashSearchTerm").val() === "") {
    		    	alert("검색어를 입력해주세요."); // 검색어를 입력해주세요 
	     		}else{
	     			$(".advanced_search").hide();
	     			
		    		result = checkSearchTerm($("#hashSearchTerm").val());
		     		$("#hashSearchTerm").val(result);
		     		$("#basicSearchTerm").val('');
		     		$("#basicSearchTerm").attr('disabled', true);
		    		$("#hashSearchTerm").attr('disabled', false);
		    		// 검색 타입 구분
		    		$("#searchType").val("hash");
		    		
		    		searchHeader.action = ctx_curr+"/sr/hashSearchResult.do";
		    		searchHeader.submit();
	     		}
	    	}
	    	
		//}
		
	    $(".adsearch_dim").hide();
		
    }
</script><!-- 검색 레이어 영역 END-->
	    <div class="default_menu">
	    <!-- 진수 수정 -->
	      <% if(memId == null){ %> 
	    	<a class="menu_login_join" href="DutyfreeServlet?command=login_form" id="loginBtn">로그인</a>
	    			<a class="menu_login_join" href="회원가입 링크">회원가입</a>	
	    		<%}else{ %> 
	    		<a class="menu_login_join" id="logoutBtn" href="DutyfreeServlet?command=Logout">로그아웃</a>
	    		<a class="menu_login_join" href="DutyfreeServlet?command=Update_page">마이페이지</a>	
	    		

	    		<ul>
	            <li class="item_01">
	                <a href="DutyfreeServlet?command=cart_list"><strong>장바<br>구니</strong><em id="rwingCartCnt" style="display: none"></em></a>
	            </li>
	            <li class="item_02">
	                <a href="DutyfreeServlet?command=order_detail"><strong>주문<br>조회</strong></a>
	            </li>
	            <li class="item_03">
	                <a href="마이페이지 링크"><strong>마이<br>현대</strong></a>
	            </li>
	            <li class="item_04">
	                <a href="고객센터 링크"><strong>고객<br>센터</strong></a>
	            </li>
	            <li class="item_05">
	                <a href="https://www.hddfs.com/store/kr/dm/main.do?MG=KR_PC_GNB_HDDFS" target="_blank"><strong>공식<br>사이트</strong></a>
	            </li>
	            <li class="exchange_rate exchageRateTxt"></li>
	        </ul>
	        <%} %>  
	    </div>
	    <!-- 히든메뉴 START -->
	    <script type="text/javascript">

function commOpenLayer(cookieChkYn, hiddenYn){
	$.ajax({
	    async       : true,
	    url         : ctx_curr + "/dm/main/popInfo.json",
	    dataType    : "json",
	    type        : "POST",
	    success     : function(popInfo, textStatus, jqXHR){
	    	var data = popInfo.resPop;
	    	var html = "";
	    	for(var i=0; i < data.popSeqList.length; i++){
    			html+="<div class=\"main_popup\" id=\"main_bottom_pop"+data.popSeqList[i].popSeq+"\" data-seq=\""+data.popSeqList[i].popSeq+"\">";
	    		var addClass = "";
	    		var addStyle= "";
	    		if(data.popSeqList[i].popTmplCd == '001'){
	    			addClass="popswiper-container";
	    		}else{
	    			addClass="html_wrap";
	    			addStyle= "style='width:560px; height: 368px;'";
	    		}
	    		html+="<div class=\""+addClass+"\" "+addStyle+">";
	    		if(data.popSeqList[i].popTmplCd == '001'){
	    			html+="<ul class=\"swiper-wrapper mainPopList\">";
	    			for(var j=0; j < data.dataList.length; j++){
	    				if(data.popSeqList[i].popSeq == data.dataList[j].popSeq){
	    					html += "<li class=\"swiper-slide\">";
	    					var link = data.dataList[j].linkUrl != null ? data.dataList[j].linkUrl : "javascript:";		
	    					
	    					var wiseLog = "";
	    					if(link != "javascript:") {
	    						if(link.indexOf("?") != -1) {
	    							wiseLog = "&MG=KR_PC_Main_Popup"+data.popSeqList[i].popSeq+"_"+data.dataList[j].popDtlSeq;
	    						} else {
	    							wiseLog = "?MG=KR_PC_Main_Popup"+data.popSeqList[i].popSeq+"_"+data.dataList[j].popDtlSeq;
	    						}
	    					}
	    					
	    					if(data.dataList[j].shrtVdoUrl != null){
	    						html += "<video preload=\"none\" muted loop class='video-js'  style='width:560px; height:368px; object-fit:cover; background-color: black;'>";
	    						html += "<source src=\"https://cdn.hddfs.com/files/"+data.dataList[j].shrtVdoUrl+"\" type=\"video/mp4\">";
	    						html += "<strong>Your browser does not support the video tag.</strong>";
	    						html += "</video>";
	    					}else{
	    						var mainTitl = data.dataList[j].mainTitl != null ? data.dataList[j].mainTitl : "";
	    						var subTitl = data.dataList[j].subTitl != null ? data.dataList[j].subTitl : "";
	    						var bnnrWrd = data.dataList[j].bnnrWrd != null ? data.dataList[j].bnnrWrd : "";
	    						
	    						html += "<a href=\""+link+wiseLog+"\"  class='item_wrap'>";
	    						html += "<div class='pop_txt'>";
	    						html += "<strong class='cate'>"+mainTitl+"</strong>";
	    						html += "<p>"+subTitl+"</p>";
	    						html += "<p>"+bnnrWrd+"</p>";
	    						html += "</div>";
	    						html += "<img src=\"https://cdn.hddfs.com/files/"+data.dataList[j].imgUrl+"?RS=750X494\" alt=\""+data.dataList[j].mainTitl+"\">";
	    						html += "</a>";
	    					}
	    					html += "</li>";
	    				}	
	    			}
	    			html+="</ul>";
	    			html+="<div class=\"swiper_control\" id=\"mainPop_"+data.popSeqList[i].popSeq+"\">";
	    			html+="<div class=\"swiper-pagination\"></div>";
	    			html+="<div class=\"swiper-prev\"></div>";
	    			html+="<div class=\"swiper-next\"></div>";
	    			html+="</div>";
	    		}else{
	    			html += data.popSeqList[i].htmlCont;
	    		}
	    		html+="</div>";
	    		html+="<div class=\"close_section\">";
	    		html+="<span class=\"today_close chk\">";
	    		html+="<input type=\"checkbox\" class=\"today_close\" id=\"btn_hidden_layer_"+data.popSeqList[i].popSeq+"\" onclick=\"saveMainLayerCookie("+data.popSeqList[i].popSeq+");\" hiddenYn=\"N\" />";
	    		html+="<label for=\"btn_hidden_layer_"+data.popSeqList[i].popSeq+"\" style=\"cursor: pointer;\">오늘 하루 보지 않기</label>";
	    		html+="</span>";
	    		html+="<span class=\"popup_close\"  data-seq=\""+data.popSeqList[i].popSeq+"\" onclick=\"closeMainLayer("+data.popSeqList[i].popSeq+");\">닫기</span>";
	    		html+="</div>";
	    		html+="</div>";	
    		}
	    	
	    	$(".mainPopWrap").html(html); 
	    	callMainPopSwiper();
	    	
	    	if(hiddenYn == "Y"){
	    	    $(".hidden_menu").removeClass("open");
	    		$(".item").slideUp(200);
	    	}
	    	
	    	if($(".main_popup").length > 0){
		    	$('.modal_wrap').addClass('active');	//팝업 띄우기
	    	}
	    	
	    	if(cookieChkYn == "Y"){
	    		// 메인팝업
	    		$(".main_popup").each(function(){
	    			var seq = $(this).data("seq");
	    			$(".today_close.chk").show();
	    			$("#btn_hidden_layer_"+seq).attr("hiddenYn", "N");
	    			if(getCookie("closePop" + seq) == "Y"){	// 팝업 오픈
	    				$("#main_bottom_pop"+seq).remove();
	    				if($(".main_popup").length <1){
	    					$('.modal_wrap').removeClass('active');
	    				}
	    			}
	    		});
	    	}else{
	    		// 메인팝업 오픈
	    		$(".main_popup").each(function(){
	    			var seq = $(this).data("seq");
	    			$(".today_close.chk").hide();
	    			$("#btn_hidden_layer_"+seq).attr("hiddenYn", "Y");	    			
	    		});
	    	}
	    	
	    	if(hiddenYn == "Y"){
	    		$(".ui-resizable").css("position", "fixed")
	    	}
	    	
    		$(".main_popup").each(function(){
    			var seq = $(this).data("seq");
    			if($("#main_bottom_pop"+seq).find("li").length == 1){
    				$("#mainPop_"+seq).hide();
    			}
    		});
    		
    		$(".mainPopList > li").find("video").attr("preload","");
    		$(".mainPopList > li").find("video").attr("autoplay",true);
	    }
	});
}
</script>
</section>
</header>