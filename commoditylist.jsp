<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>商品列表</title>
<style>
#box ul ul{display:none;}
#box ul li.none{list-style:none;}
</style>
<script>
window.onload=function()
{
   var arr=[{title:"一级菜单",nei:[{title:"二级菜单",nei:[{title:"三级菜单",nei:[]}]}]},{title:"一级菜单",nei:[{title:"二级菜单",nei:[{title:"三级菜单",nei:[]}]}]}]
   var oBox=document.getElementById('box');

   function sheng(list)
   { 
       var ul=document.createElement('ul');
        for(var i=0;i<list.length;i++)
        {
            var li=document.createElement('li');
            var h2=document.createElement('h2'); 
            h2.innerHTML=list[i].title
            li.appendChild(h2);
            if(list[i].nei.length!=0)
           {
                li.appendChild(sheng(list[i].nei));
           }
            ul.appendChild(li); 
        }
        return ul;
   }
   oBox.appendChild(sheng(arr));

   var aH2=oBox.getElementsByTagName('h2');
   for(var i=0;i<aH2.length;i++)
   {
      aH2[i].onclick=function()
      {
             if(this.getAttribute('ti')!=1)
            {
                 for(var i=0;i<aH2.length;i++)
                 {
                       aH2[i].setAttribute('ti',0);
                       if(aH2[i].nextElementSibling)
                       { 
                           aH2[i].nextElementSibling.style.display='none';
                       }
                  }
               this.setAttribute('ti',1);
               this.nextElementSibling.style.display='block';
               var _this=this;
               _this.parentNode.parentNode.previousElementSibling.setAttribute('ti',1);
               _this.parentNode.parentNode.style.display='block';
            }else
            {
               this.setAttribute('ti',0);
               this.nextElementSibling.style.display='none';
            }
      }
   }
}
</script>
</head>
<body>
<!-- 搜索 -->
<form action="${pageContext.request.contextPath}/findAll.do" method="post" align="center">
	<div>
	     <input id="name" type="text" name="name">
	</div>
    <input type="submit" value="搜索"/>
</form>
<div id="box" align="left"></div>
<div align="center">
<c:if test="${empty pageInfo.list}" >
		没有任何商品信息！
</c:if>
<c:if test="${!empty pageInfo.list}" >
		<table border="1" cellpadding="10" cellspacing="0" class="table1" >
		<thead>
			<tr>
				<td>id</td>
				<td>名称</td>
				<td>价格(单位元)</td>
			</tr>
			</thead>
			<c:forEach items="${pageInfo.list}" var="u">
				<tr>
					<th>${u.id }</th>
					<th><a href="/Shopping/selectCommodityById?id=${u.id}" >${u.name}</a></th>
					<th>${u.price }</th>
				</tr>
			</c:forEach>		
		</table>	
</c:if>
</div>
<!-- 分页 -->
<div align="bottom">
	<ul >
	    <li><a href="/Shopping/findAll.do?name=${pageInfo.name}" >首页</a></li>
	    <li><a href="/Shopping/findAll.do?currentPage=${pageInfo.currentPage-1}&name=${pageInfo.name}">上一页</a></li>
	    
		<c:forEach begin="1" end="${pageInfo.totalPage}" var="pageNum">
			<li><a href="/Shopping/findAll.do?currentPage=${pageNum}&name=${pageInfo.name}">${pageNum}</a></li>
		</c:forEach>
		<li><a href="/Shopping/findAll.do?currentPage=${pageInfo.currentPage+1}&name=${pageInfo.name}">下一页</a></li>
		<li><a href="/Shopping/findAll.do?currentPage=${pageInfo.totalPage}&name=${pageInfo.name}" >尾页</a></li>
		<li><a href="${pageContext.request.contextPath}/touser.action">返回上一页</a></li>
	</ul>
</div>
<a href="${pageContext.request.contextPath}/touser.action">返回主页</a>
</body>
</html>