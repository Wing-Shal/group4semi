<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
.box{
    display: block;
    font-size: 15px;
    padding: 0.7em;
}
/* .box도 있고 .input도 있는 경우 선택*/
.box.input{
    border: 2px solid #ccc;
    /* 입력창의 기본 강조효과 제거 */
	outline: none; 
}
/* 조건부 선택자*/
.box.input:focus{
    border-color: #2db400;
}
.input {
	border-radius: 4px;
	margin:5px !important;
	width: 100%;
}
*{
	box-sizing: border-box;
	font-family: sans-serif;    
} 

/*라벨 글씨 크기 스타일*/
label {
	 font-weight: bold !important; 
     font-size: 16px !important; 
     color: #2d3436;
}

.labelText {
	padding : 20px !important;
    padding-top : 20px !important;
}
.pwLabelText {
    padding-top : 16px !important;
}
 
/*아이디,비밀번호 placeholder*/		
input.tool::placeholder {
	color: #b2bec3;
	font-size: 14px;
}
		
.timer{
	color: red;
}
/*수정 버튼 디자인*/
.editBtn{
	color: white;
	background-color: #74b9ff;
	border-radius: 5px;
}
/*블럭별 디자인*/
.block{
	padding: 0.4em;
	margin-top: 1em;
	box-shadow: 0 0 25px rgba(0, 0, 0, 0.2);
	border-radius: 0.5em;
}
/* 웹킷(WebKit) 기반 브라우저용 스타일 */
input[type="file"]::-webkit-file-upload-button {
	  background: #74b9ff;;
	  color: #fff;
	  border: none;
	  padding: 10px 20px;
	  border-radius: 5px;
	  cursor: pointer;
}
	
/* 파이어폭스(Firefox)용 스타일 */
.input::file-selector-button {
  	background: #74b9ff;;
  	color: #fff;
    border: none;
	padding: 10px 20px;
	border-radius: 5px;
	cursor: pointer;
}


.new-flex-cell {
    display: flex;
}
.new-flex-cell > .width-fill {
    flex-grow: 1;
}
.new-flex-cell.auto-width > * {
    flex-grow: 1;
}
/* .new-flex-cell.vertical {
    flex-direction: column;
}  */
.new-flex-cell.tool > * {
	flex-wrap:wrap;
	flex-direction: row;
}

.new-flex-cell.middle {
    justify-content: center;
    align-items: center;
} 


.second-flex-cell {
    display: flex;
}
</style>




<!-- 제약조건 검사 -->
<script type="text/javascript"> 
$(function(){
    var state = {
	        //필수항목 : true; , 선택항목 : false;
	        memberNameKorValid : false,
	        memberNameEngValid : true,//선택
	        memberContact1Valid : false,
	        memberContact2Valid : true,//선택
	        memberBirthValid : true, //선택
	        memberClrearanceIdValid : true,//선택
	        memberAddressValid : true,//선택
	        memberPwValid : false,
	        //객체에 함수를 변수처럼 생성할 수 있다
	        ok : function(){
	            return this.memberPwValid 
            		&& this.memberPwCheckValid && this.memberNameKorValid 
            		&& this.memberContact1Valid && this.memberPwValid
            		&& this.memberContact2Valid && this.memberBirthValid 
            		&& this.memberClrearanceIdValid && this.memberAddressValid;
	        },
   		 };
    
    //한글이름 검사
     $("[name=memberNameKor]").blur(function(){
        var regex = /^[가-힣]{2,7}$/;
        var value = $(this).val();
    	state.memberNameKorValid = regex.test($(this).val);
    	
    	if(regex.test(value)){// 형식 검사 통과
    		$(this).removeClass("fail").addClass("success");
    		state.memberNameKorValid = true;
    	}
    	else{ //한글 이름 형식 검사 실패
    		$(this).removeClass("success fail")
							 .addClass(state.memberNameKorValid ? "success" : "fail");
    	}
    }); 
    //영어이름 검사
    $("[name=memberNameEng]").blur(function(){
    	var regex = /^[A-Za-z]+$/;
    	var value = $(this).val();
    	state.memberNameEngValid = value.length == 0 || regex.test(value);
        $(this).removeClass("success fail")
                    .addClass(state.memberNameEngValid ? "success" : "fail");
    });
    
    //비밀번호 검사(+비밀번호 확인)
    $("[name=memberPw]").on("blur", function(){
        var regex = /^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$])[A-Za-z0-9!@#$%^&*]{6,15}$/;
        var value = $(this).val();	
        
        if(regex.test(value)) {//비밀번호 형식 검사 
            $.ajax({
                url : "${pageContext.request.contextPath}/rest/member/checkInputPw",
                method : "post",
                data: {
                    memberPw : value
                },
                success : function(response) {
                    if(response) {
                    	$("[name=memberPw]").removeClass("success fail fail2").addClass("success");
                    	state.memberPwValid = true;
                    }
                    else {
                        $("[name=memberPw]").removeClass("success fail fail2").addClass("fail");
                        state.memberPwValid = false;
                    }
                }
            });
        }
        else {
            $("[name=memberPw]").removeClass("success fail fail2").addClass("fail");
            state.memberPwValid = false;
        }
    });	     
 	   
    
        
    //연락처1* 검사
     $("[name=memberContact1]").blur(function(){
        var regex = /^[0-9]+$/;
        var value = $(this).val();
    	state.memberContact1Valid = regex.test($(this).val);
    	
    	if(regex.test(value)){
    		$(this).removeClass("fail").addClass("success");
    		state.memberContact1Valid = true;
    	}
    	else{
    		$(this).removeClass("success fail")
							 .addClass(state.memberContact1Valid ? "success" : "fail");
    	}
    });    	    
    
    //연락처2 검사
    $("[name=memberContact2]").blur(function(){
    	var regex = /^[0-9]+$/;
    	var value = $(this).val();
    	state.memberContact2Valid = value.length == 0 || regex.test(value);
        $(this).removeClass("success fail")
                    .addClass(state.memberContact2Valid ? "success" : "fail");
    });	    
    
    //생년월일 검사
    $("[name=memberBirth]").blur(function(){
    	var regex = /^(19[0-9]{2}|20[0-9]{2})-(02-(0[1-9]|1[0-9]|2[0-8])|(0[469]|11)-(0[1-9]|1[0-9]|2[0-9]|30)|(0[13578]|1[02])-(0[1-9]|1[0-9]|2[0-9]|3[01]))$/;
    	var value = $(this).val();
    	state.memberBirthValid = value.length == 0 || regex.test(value);
        $(this).removeClass("success fail")
                    .addClass(state.memberBirthValid ? "success" : "fail");
    });	    
    
    //통관번호 
    $("[name=memberClearanceId]").blur(function(){
    	var regex = /^P[0-9]{12}$/; //db 정규표현식 P대문자만 허용 됨
    	var value = $(this).val();
    	state.memberClearanceIdValid = value.length == 0 || regex.test(value);
        $(this).removeClass("success fail")
                    .addClass(state.memberClearanceIdValid ? "success" : "fail");
    });	   
    
    //주소
    $("[name=memberAddress2]").blur(function(){
    	var zipcode = $("[name=memberZipcode]").val();
        var address1 = $("[name=memberAddress1]").val();
        var address2 = $("[name=memberAddress2]").val();

        var isClear = zipcode.length == 0 && address1.length == 0 && address2.length == 0;
        var isFill = zipcode.length > 0 && address1.length > 0 && address2.length > 0;
        var address2Null = zipcode.length > 0 && address1.length > 0 && address2.length == 0;
        
        state.memberAddressValid = isClear || isFill || address2Null;
        
        $("[name=memberZipcode], [name=memberAddress1], [name=memberAddress2]")
			            .removeClass("success fail")
			         	  	 .addClass(state.memberAddressValid ? "success" : "fail");
	});
    
  //제출이 되는 경우
    $(".check-form").submit(function(){
    	var choice = window.confirm("수정하시겠습니까?");
		if(choice) {
        	$(this).find(".tool").not(".success, .fail, .fail2").blur();
       		return state.ok();
        } else {
        	return false;
        }
    });
});
</script>


<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    $(function(){
        $(".btn-address-search").click(function(){
            new daum.Postcode({
                oncomplete: function(data) {
                    // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                    // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                    // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                    var addr = ''; // 주소 변수

                    //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                    if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                        addr = data.roadAddress;
                    } else { // 사용자가 지번 주소를 선택했을 경우(J)
                        addr = data.jibunAddress;
                    }

                    // 우편번호와 주소 정보를 해당 필드에 넣는다.
                    $("[name=memberZipcode]").val(data.zonecode);
                    $("[name=memberAddress1]").val(addr);
                    
                    // 커서를 상세주소 필드로 이동한다.
                    $("[name=memberAddress2]").focus();
                }
            }).open();
        });
        
        $(".btn-address-clear").click(function(){
        	$("[name=memberZipcode]").val("");
        	$("[name=memberAddress1]").val("");
        	$("[name=memberAddress2]").val("");
        });
    });
    
    
    
    
</script>

<!-- 개인정보 수정 페이지 -->
<!-- <form action="/member/mypage/change" method="post" autocomplete="off"> -->
<form action="change" method="post" autocomplete="off" class="check-form">
	<div class="container w-550">
		<div class="cell center">
			<h1 style= "color: #74b9ff;">개인정보 변경</h1>	
		</div>
		<!-- 수정할 정보(첫번째 블럭) -->
		<div class="container w-550 block">
			<div class="container w-500">
				<div class="cell flex-cell">
					<div class="w-25 labelText">
						<label>아이디<b style="color:red">*</b></label>
					</div>
					<div class="w-75 pe-20">
						<input type="text" name="memberId" class= "tool box input" placeholder="아이디" value="${memberDto.memberId}" readonly style="width: 100%;"/>
					</div>
				</div>
				<div class="cell flex-cell">
					<div class="w-25 labelText">
						<label>이름(한글)<b style="color:red">*</b></label>
					</div>
					<div class="w-75 pe-20">
						<input type="text" name="memberNameKor" class="tool box input" value="${memberDto.memberNameKor}">
						<div class="success-feedback">
							<label></label>
						</div>
						<div class="fail-feedback">한글 이름을 입력해주세요</div>
					</div>					
				</div>
				<div class="cell flex-cell">
					<div class="w-25 labelText">
						<label>이름(영문)</label>
					</div>
					<div class="w-75 pe-20">
						<input type="text" name="memberNameEng" class="tool box input" value="${memberDto.memberNameEng}">
						<div class="success-feedback">
							<label></label>
						</div>
						<div class="fail-feedback">잘못된 영어 이름입니다.</div>
					</div>
				</div>
				<div class="cell flex-cell">
					<div class="w-25 labelText">
						<label>이메일<b style="color:red">*</b></label>
					</div>
					<div class="w-75 pe-20">
						<input type="text" name="memberEmail" class= "tool box input" value="${memberDto.memberEmail}" readonly/>
					</div>
				</div>
				<div class="cell flex-cell">
					<div class="w-25 labelText">
						<label>통관번호</label>
					</div>
					<div class="w-75 pe-20">
						<input type="text" name="memberClearanceId" class= "tool box input" value="${memberDto.memberClearanceId}">
						<div class="success-feedback">
							<label></label>
						</div>
						<div class="fail-feedback">잘못된 형식입니다.</div>
					</div>
				</div>
				<div class="cell flex-cell">
					<div class="w-25 labelText">
						<label>연락처1<b style="color:red">*</b></label>
					</div>
					<div class="w-75 pe-20">
						<input type="text" name="memberContact1" class= "tool box w-75 input" value="${memberDto.memberContact1}">
						<div class="success-feedback">
							<label></label>
						</div>
						<div class="fail-feedback">연락처 형식 오류</div>		
					</div>
				</div>
				<div class="cell flex-cell">
					<div class="w-25 labelText">
						<label>연락처2</label>
					</div>
					<div class="w-75 pe-20">
						<input type="text" name="memberContact2" class= "tool box w-75 input" value="${memberDto.memberContact2}">
						<div class="success-feedback">
							<label></label>
						</div>
						<div class="fail-feedback">잘못된 연락처입니다.</div>
					</div>
				</div>
				<!-- 주소 입력창 -->
				<!-- 우편번호 입력창 -->
				<div class="cell flex-cell">
					<div class="w-25 labelText">
						<label>주소</label>
					</div>
					<div class="w-75 right pe-20">
						<div class="cell second-flex-cell">
							<div class="w-50">
								<input type="text" name="memberZipcode" class= "tool box input" placeholder="우편번호" readonly/>	
							</div>
							<div class="w-10">
								<button type="button" class="btn btn-address-search ms-10 me-40" style= "border-right: 1px; height: 48px; margin-top:5px;">
				                	<i class="fa-solid fa-magnifying-glass"></i>
				            	</button>
							</div>
							<div class="w-10">
								<button type="button" class="btn btn-address-clear ms-20" style= "border-right: 1px; height: 48px; margin-top:5px;">
							     <i class="fa-solid fa-xmark"></i>
								</button>
							</div>
						</div>
						<div class="cell">
							<input type="text" name="memberAddress1" class= "tool w-100 box input" placeholder= "기본주소" readonly>
						</div>
						<div class="cell">
							<input type="text" name="memberAddress2" class= "tool w-100 box input" placeholder="상세주소">
							<div class="success-feedback">
								<label></label>
							</div>
							<div class="fail-feedback">주소를 검색하여 우편번호를 입력해주세요.</div>
						</div>		
					</div>
				</div>
				<div class="cell flex-cell">
					<div class="w-25 labelText">
						<label>생년월일</label>
					</div>
					<div class="w-75 pe-20">
						<input type="text" name="memberBirth" class= "tool box w-75 input" value="${memberDto.memberBirth}">
						<div class="success-feedback">
							<label></label>
						</div>
						<div class="fail-feedback">잘못된 형식입니다.</div>						
					</div>
				</div>
			</div>
		</div><!-- 첫번째 블럭 닫는 태그 -->		
		
		<!-- 개인정보 수정을 위한 비밀번호 확인 -->
		<div class="container w-550 block">
			<div class="container w-500">
				<div class="cell flex-cell">
					<div class="w-25 pwLabelText">
						<label>비밀번호 확인<b style="color:red">*</b></label>
					</div>
					<div class="w-75 pe-20">
						<input type="password" name="memberPw" class="tool box input">
			          	<c:if test="${param.error != null}">
			               <div class="fail-feedback">비밀번호가 일치하지 않습니다</div>
			            </c:if>
					</div>
		        </div>
			</div>
		</div><!-- 두번째 블럭 닫는 태그 -->
		
		<div class="container w-550 pt-10 pb-20">
			<div class="cell">
				<button class="btn w-100 editBtn">
					<i class="fa-regular fa-pen-to-square"></i> 변경
				</button>
			</div>
		</div>
		
	</div>

</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>