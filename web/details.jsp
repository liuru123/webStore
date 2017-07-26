<%--
  Created by IntelliJ IDEA.
  User: liuru
  Date: 17-7-24
  Time: 下午9:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" import ="entity.items,dao.ItemsDao" language="java" %>
<%@ page import="java.util.ArrayList" %>


<html>
<head>
    <title>详情页面</title>
    <style type="text/css">
        .div{
            position: absolute;
            left:430px;
            top:100px;

            font-size:15pt;
        }
       .dd{
           position: absolute;
           left:90px;
           font-size:15pt;
        }
        .ddd{
            position: absolute;
            right:300px;
            font-size:10pt;
            background-color: aliceblue;
        }
        .div1{
            position: absolute;
            right:200px;
            font-size: 10pt;
        }
    </style>
</head>
<body>
<table  align="center" width="750" height="60" cellpadding="0" cellspacing="0" >
    <%
        ItemsDao itemsDao = new ItemsDao();
        items item = itemsDao.getItemsByid(Integer.parseInt(request.getParameter("id")));
        if(item!=null){
     %>

    <tr>
        <td>
            <img class="dd" width="250" height="250" src=<%=item.getPic()%>>
        </td>
    <td class="div">
            名称：<%=item.getName()%><br>
            价格：<%=item.getPrice()%><br>
            剩余数量：<%=item.getNum()%><br>
            城市：<%=item.getCity()%><br>
        <br><br><br><br>
    </td>
    </tr>
    <%
        }
    %>
</table>

<%
    //首先创建一个空字符串，保存每次访问的商品的编号
    String list= "";
    Cookie[] cookies = request.getCookies();
    if(cookies!=null && cookies.length>0) {
        for (Cookie c : cookies) {
            if (c.getName().equals("cookieStore")) {
                list = c.getValue();
                System.out.println(list);
            }
        }
    }

        list+=request.getParameter("id")+":";
        String[] arr = list.split(":");

        if(arr!=null &&arr.length>0) {
            if (arr.length >= 1000) {
                list = "";
            }
        }

//            list=list.substring(0,list.length()-2);
            Cookie cookie = new Cookie("cookieStore", list);
            response.addCookie(cookie);
%>
<%--浏览过的商品--%>

<div width="200"  bgcolor="#5f9ea0" align="center" class="ddd">
<%--循环开始了--%>
    <h3>您浏览过的商品</h3>
    <%
        ArrayList<items> itemsArrayList = itemsDao.getRecentItems(list);
        if(itemsArrayList!=null && itemsArrayList.size()>0){
            for(int i=0;i<itemsArrayList.size();i++){

      %>
    <div>
        <dl>
            <dt>
                <a href="details.jsp?id=<%=itemsArrayList.get(i).getId()%>"> <img src="<%=itemsArrayList.get(i).getPic()%>" width="160" height="160"></a>
            </dt>
            <tr>
                <td class="div1">
                    名称：<%=itemsArrayList.get(i).getName()%>&nbsp;&nbsp;&nbsp;&nbsp;
                    价格：<%=itemsArrayList.get(i).getPrice()%>&nbsp;&nbsp;&nbsp;&nbsp;<br>
                    剩余数量：<%=itemsArrayList.get(i).getNum()%>&nbsp;&nbsp;&nbsp;&nbsp;
                    城市：<%=itemsArrayList.get(i).getCity()%>&nbsp;&nbsp;&nbsp;&nbsp;
                </td>
            </tr>
        </dl>
    </div>
    <%
            }
        }
    %>
</div>

</body>
</html>
