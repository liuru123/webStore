<%@ page import="java.util.ArrayList" %><%--
  Created by IntelliJ IDEA.
  User: liuru
  Date: 17-7-24
  Time: 下午9:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" import="entity.items,dao.ItemsDao" language="java" %>
<html>
  <head>
    <title>首页</title>
    <style type="text/css">
      div{
        float:left;
        margin:10px;
      }
      div dd{
        margin:0px;
        font-size:12pt;
      }

      div dd.dd_name{
        color:blue;
      }

      div dd.dd_city{
        color:#000;
      }
    </style>
  </head>
  <body>
  <h1>商品展示</h1>

  <table align="center" width="720" height="60" cellpadding="0" cellspacing="0" border="0">
    <%
      ItemsDao itemsDao = new ItemsDao();
      ArrayList<items> list = itemsDao.getAll();
      if(list!=null && list.size()>0){
        for(int i=0;i<list.size();i++){

          items item = list.get(i);
            if (i % 3 == 0){
               %>
              <tr>
                <td>
                  <div align="center">
                    <dl>
                      <dt>
                        <a href="details.jsp?id=<%=item.getId()%>"><img src=<%=item.getPic()%> width="120" height="90" border="1"/> </a>
                      </dt>
                      <dd class="dd_name"><%=item.getName()%></dd>
                      <dd class="dd_city">产地:<%=item.getCity()%>&nbsp;&nbsp;价格：<%=item.getPrice()%>￥</dd>
                    </dl>
                  </div>
                </td>
          <%}else{%>
                <td>
                  <div align="center">
                    <dl>
                      <dt>
                        <a href="details.jsp?id=<%=item.getId()%>"><img src=<%=item.getPic()%> width="120" height="90" border="1"/> </a>
                      </dt>
                      <dd class="dd_name"><%=item.getName()%></dd>
                      <dd class="dd_city">产地:<%=item.getCity()%>&nbsp;&nbsp;价格：<%=item.getPrice()%>￥</dd>
                    </dl>
                  </div>
                </td>
                <%

                  if ((i + 1) % 3 == 0){
                  %>
                </tr>
                 <% }
                  %>

            <%}
          }
        }
      %>
  </table>

  </body>
</html>
