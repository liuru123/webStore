package util;

import java.sql.Connection;
import java.sql.DriverManager;

/**
 * Created by liuru on 17-7-24.
 */
public class DBHelper {

    //jdbc常用的四个变量
    private static final String driver = "com.mysql.jdbc.Driver";
    private static final String url = "jdbc:mysql://localhost:3306/shoping?useUnicode=true&characterEncoding=utf-8";
    private static final String username = "root";
    private static final String password = "111111";

    //创建一个私有类型的连接对象
    private static Connection conn = null;

    //静态初始化块负责加载驱动
    static {
        try {
            Class.forName(driver);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    //采用单例模式返回一个数据库连接
    public static Connection getConnection() throws Exception {
        if (conn == null) {
            conn = DriverManager.getConnection(url, username, password);
            return conn;
        } else {
            return conn;
        }
    }

    //测试连接是否成功
    public static void main(String[] args) {
        try {
            Connection conn = DBHelper.getConnection();
            if (conn == null) {
                System.out.println("数据库连接异常");
            } else {
                System.out.println("数据库连接正常");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}