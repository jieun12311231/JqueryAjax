<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<!-- css -->
<link rel="stylesheet" type="text/css" href="//cdn.datatables.net/1.13.1/css/jquery.dataTables.min.css">

<script src="//cdn.datatables.net/1.13.1/js/jquery.dataTables.min.js"></script>

<style>
    @font-face {
        font-family: 'GangwonEdu_OTFBoldA';
        src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2201-2@1.0/GangwonEdu_OTFBoldA.woff') format('woff');
        font-weight: normal;
        font-style: normal;
    }
    *{
        font-family: 'GangwonEdu_OTFBoldA';
    }
    </style>
<br>
<h3 align="center">๐notice๐</h3>

<table id="example" class="display" style="width:100%">
    <thead>
        <tr>
            <th>๊ธ ๋ฒํธ</th>
            <th>์์ฑ์</th>
            <th>์์ฑ์ผ์</th>
            <th>๊ธ ์ ๋ชฉ</th>
            <th>์ฒจ๋ถํ์ผ</th>
            <th>์กฐํ์</th>
        </tr>
    </thead>
    <tfoot>
        <tr>
            <th>๊ธ ๋ฒํธ</th>
            <th>์์ฑ์</th>
            <th>์์ฑ์ผ์</th>
            <th>๊ธ ์ ๋ชฉ</th>
            <th>์ฒจ๋ถํ์ผ</th>
            <th>์กฐํ์</th>
        </tr>
    </tfoot>
</table>
<script>
    $(document).ready(function () {
        $('#example').DataTable({
            // ajax: 'data/arrays.txt',  //๋ฐฐ์ด์ ํํ๋ก ๋์ด ์์ผํจ 
         ajax:'noticeListPaging.do'
        });
    });
</script>