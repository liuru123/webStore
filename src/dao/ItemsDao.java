package dao;

import entity.items;
import util.DBHelper;

import java.net.URLDecoder;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.concurrent.ExecutorService;

/**
 * Created by liuru on 17-7-24.
 */
//商品信息的类
public class ItemsDao {
    //获取所有的商品信息的方法
    public ArrayList<items> getAll(){

        ArrayList<items> list = new ArrayList<>();
        //三个对象，连接、预处理、结果集
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        //sql语句
        String sql = "select * from items";
        //预处理sql语句
        try {
            //首先获取连接
            conn = DBHelper.getConnection();
            //利用连接进行预处理
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();
            while(rs.next()){
                items item = new  items();

                item.setId(rs.getInt("id"));
                item.setName(rs.getString("name"));
                item.setCity(rs.getString("city"));
                item.setPrice(rs.getDouble("price"));
                item.setPic((rs.getString("pic")));
                item.setNum(rs.getInt("num"));

                list.add(item);

            }
            return list;
        }catch(Exception e){
            e.printStackTrace();
            conn=null;
        }finally{
            //释放资源时从小到大释放
            //释放数据集
            if(rs!=null){
                try {
                    rs.close();
                    rs=null;
                }catch (Exception e){
                    e.printStackTrace();
                }
            }

            //释放预处理对象
            if(stmt!=null){
                try{
                    stmt.close();
                    stmt = null;
                }catch (Exception e){
                    e.printStackTrace();
                }
            }
        }
        return null;
    }


    //展示一个显示商品详情的页面
    public items getItemsByid(int id){

        Connection conn =null;
        PreparedStatement stmt =null;
        ResultSet rs =null;
        try {
            conn = DBHelper.getConnection();
            String sql = "select * from items where id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1,id);

            rs = stmt.executeQuery();
            if(rs.next()){
                items item = new items();
                item.setId(rs.getInt("id"));
                item.setName(rs.getString("name"));
                item.setCity(rs.getString("city"));
                item.setPrice(rs.getDouble("price"));
                item.setNum((rs.getInt("num")));
                item.setPic(rs.getString("pic"));
                return item;
            }

        }catch (Exception e){
            e.printStackTrace();
        }finally {
            if(rs!=null){
                try{
                    rs.close();
                    rs=null;
                }catch (Exception e){
                    e.printStackTrace();
                }
            }
            if(stmt!=null){
                try{
                    stmt.close();
                    stmt=null;
                }catch (Exception e){
                    e.printStackTrace();
                }
            }
        }
        return null;
    }


    //获取最近的前五条记录
    public ArrayList<items> getRecentItems(String list){
        ArrayList<items> arrayList = new ArrayList<>();

        if(list!=null && list.length()>0) {
            String[] arr = list.split(":");
            if (arr.length >= 5) {
                for (int i = arr.length - 1; i >= arr.length - 5; i--) {
                    arrayList.add(getItemsByid(Integer.parseInt(arr[i])));

                }
            }else{
                for(int i=arr.length-1;i>=0;i--){
                    arrayList.add(getItemsByid(Integer.parseInt(arr[i])));
                }
            }
            return arrayList;
        }
        return null;
    }
}

