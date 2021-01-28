<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
	.slide-container{
        width: 100%; 
        /*height: 500px;*/
        text-align: center;
        position: relative;
        overflow: hidden;
    }
    .slide-ltem{
        
    }
    .slide-img{
        width: 100%;
        max-height: 500px;
    }
    .prev{
        cursor: pointer;
        position: absolute;
        width: 3%;
        top: 50%;
        left: 50px;
        transform: translate(-50%, -50%);
        transition: 0.6s ease;
        color: white;
        font-size: 70px;
        border-radius: 3px;
    }
    .next{
        cursor: pointer;
        position: absolute;
        width: 3%;
        top: 50%;
        right: 10px;
        transform: translate(-50%, -50%);
        transition: 0.6s ease;
        color: white;
        font-size: 70px;
        border-radius: 3px;
    }
    .prev:hover, .next:hover {
        background-color: rgba(0,0,0,0.8);
    }
    .dot-container{
        margin-top: 10px; 
    }
    .dot {
        cursor: pointer;
        height: 20px;
        width: 20px;
        margin: 0 2px;
        background-color: #bbb;
        border-radius: 50%;
        display: inline-block;
        transition: background-color 0.6s ease;
    }
    .active, .dot:hover {
      background-color: #717171;
    }
    .fade {
        animation-name: fade;
        animation-duration: 1.5s;
    }
    @keyframes fade {
        from {opacity: .4} 
        to {opacity: 1}
    }
</style>

<div class="slide-container">

    <a class="prev" onclick="plusSlides(-1)">&#10094;</a>
    <a class="next" onclick="plusSlides(1)">&#10095;</a>
</div>
<div class="dot-container" style="text-align:center">

</div>

<script>

	$.ajax({
		type : "post",
		url : "/ajax/slide",
		data : {
			
		},
		success : function(data){
			
			var str = "";
			var str2 = "<a class='prev' onclick='plusSlides(-1)'>&#10094;</a><a class='next' onclick='plusSlides(1)'>&#10095;</a>";
			var dot_str = "";
			$.each(data, function(index, item){
				str += "<div class='slide-item fade'>"
					+ "<img class='slide-img' src='resources/slideimg/"+this['file_name']+"' alt=''>"
					+ "</div>";
					
				dot_str += "<span class='dot' onclick='currentSlide("+this['num']+")'></span>";
			});
			$(".slide-container").prepend(str).addClass("slide-img");
			/* $(".slide-container").append(str2); */
			$(".dot-container").html(dot_str);
		}
	});

	/* 슬라이드 */
	var slideIndex = 1;
	showSlides(slideIndex);
	
	/* 슬라이드 prev, next 버튼 */
	function plusSlides(n) {
	    showSlides(slideIndex += n);
	}
	/* 슬라이드 도트 버튼 */
	function currentSlide(n) {
	    showSlides(slideIndex = n);
	}
	/* 수동 슬라이드 */
	function showSlides(n) {
	    var i;
	    var slides = document.getElementsByClassName("slide-item");
	    var dots = document.getElementsByClassName("dot");
	    
	    if (n > slides.length) {slideIndex = 1}    
	    if (n < 1) {slideIndex = slides.length}

   
	    for (i = 0; i < slides.length; i++) {
	        slides[i].style.display = "none";  
	    }
	    
	    slides[slideIndex-1].style.display = "block";
	    
	    for (i = 0; i < dots.length; i++) {
	        dots[i].className = dots[i].className.replace(" active", "");
	    }
	    dots[slideIndex-1].className += " active";
	    
	    /*
	    slideIndex++;
	    if(slideIndex > slides.length){
	        slideIndex = 1;
	    }
	    setTimeout(showSlides, 3000); // 3초마다 변환
	    */
	}
</script>