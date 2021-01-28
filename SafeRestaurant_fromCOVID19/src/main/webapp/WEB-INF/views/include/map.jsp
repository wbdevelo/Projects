<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
	/* 맵(지도) */
    .map-container{
        border: 1px solid black; 
        height: 500px; 
        margin-top: 50px; 
        display: flex; 
        flex-wrap: wrap; 
        justify-content: space-between;
    }
    .map-item{
        border: 1px solid black;
        width: 70%;
    }
    .map-null{
    
    }
    .rank{
        border: 1px solid black; 
        width: 20%; 
        text-align: center; 
        display: flex; 
        flex-direction: column;
    }
    .rank-star{
        
    }
    .rank-star > select{
        height: 30px; 
        width: 50%; 
        margin: 10px;
    }
    .rank-item{
        border: 1px solid black; 
        height: 10%; 
        margin-top: 10px; 
        position: relative;
    }
    .rank-num{
        border: 1px solid black; 
        position: absolute; 
        height: 100%; 
        line-height:200%; 
        width: 10%; 
        left: 0;
    }
    .rank-text{
        position: absolute; 
        left: 10%; 
        border: 1px solid red; 
        width: 90%; 
        height: 100%; 
        line-height: 200%;
    }
</style>

<!-- 지도 -->
<div class="map-container">
    <div class="map-null"></div>
    <div class="map-item">
        지도 띄울수 있으면 띄우기
    </div>
    <div class="rank">
        <div class="rank-star">별점 랭킹 : 
            <select name="" id="">
                <option value="">도 시 선택하기</option>
            </select>
        </div>
        <div class="rank-item">
            <span class="rank-num">1</span>
            <div class="rank-text">바보분식</div>
        </div>
        <div class="rank-item" style="border: 1px solid black; height: 10%; margin-top: 10px;">2</div>
        <div class="rank-item" style="border: 1px solid black; height: 10%; margin-top: 10px;">3</div>
        <div class="rank-item" style="border: 1px solid black; height: 10%; margin-top: 10px;">4</div>
        <div class="rank-item" style="border: 1px solid black; height: 10%; margin-top: 10px;">5</div>
        <div class="rank-item" style="border: 1px solid black; height: 10%; margin-top: 10px;">6</div>
        <div class="rank-item" style="border: 1px solid black; height: 10%; margin-top: 10px;">7</div>
        <div class="rank-item" style="border: 1px solid black; height: 10%; margin-top: 10px;">8</div>
        <div class="rank-item" style="border: 1px solid black; height: 10%; margin-top: 10px;">9</div>
        <div class="rank-item" style="border: 1px solid black; height: 10%; margin-top: 10px;">10</div>
    </div>
    <div class="map-null"></div>
</div>

<script>

</script>