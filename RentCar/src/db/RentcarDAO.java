package db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class RentcarDAO {
	
	Connection con;
	PreparedStatement pstmt;
	ResultSet rs;
	
	//데이터 베이스 연결
	public void getCon(){
		try{			
			Context initCon=new InitialContext();
			Context envCon =(Context)initCon.lookup("java:comp/env");
			DataSource ds =(DataSource) envCon.lookup("jdbc/pool");
			con=ds.getConnection();			
		}catch(Exception e){
			e.printStackTrace();
		}
	}	
	
	//메인 최신순 3대의 자동차를 리턴하는 메소드
	public Vector<CarListBean> getMainSelectCar(){
		String sql ="select * from RENTCAR  order by no desc";	
		return commonCarBean(sql, true, 3);
	}
	
	// 메인 배너 3대의 자동차를 리턴하는 메소드
	public Vector<CarListBean> getMainBannerSelectCar(){
		String sql ="select * from RENTCAR  order by no asc";	
		return commonCarBean(sql, true, 3);
	}
	
	
	// 최신순 6대의 자동차를 리턴하는 메소드
	public Vector<CarListBean> getSelectCar(){
		String sql ="select * from RENTCAR  order by no desc";	
		return commonCarBean(sql, true, 6);
	}
	
	
	
	
	
	//카테고리별 자동차 리스트를 저장하는 메소드
	public Vector<CarListBean> getCategoryCar(int cate){
		//sql injection 에 대한 보안상 파라미터값이 숫자가 아니면  cate 값은 1로변경 
		if(!isNumeric(String.valueOf(cate))) cate=1 ;
		String sql="select * from rentcar where category=" +cate;
		return commonCarBean(sql, false, 0);
	}
	
	//모든 차량을 검색하는 메소드
	public  Vector<CarListBean> getAllCar(){
		String sql="select * from rentcar ";
		return commonCarBean(sql, false, 0);
	}
	
	
	//하나의 자동차 정보를 리턴하는 메소드
	public CarListBean getOneCar(int no){
		//sql injection 에 대한 보안상 파라미터값이 숫자가 아니면  no 값은 1로변경 
		if(!isNumeric(String.valueOf(no))) no=1 ;
	
		String sql ="select * from RentCar where no="+no;
		Vector<CarListBean> v=commonCarBean(sql, false, 0);
		//리턴타입 선언
		CarListBean bean =v.get(0);
		return bean;
	}
	
	//보안상 파라미터값이 숫자인지 체크
	public static boolean isNumeric(String s){
		try{
			Double.parseDouble(s);
			return true;
		}catch(NumberFormatException e){
			return false;
		}
	}
	
	
	//회원 정보가 있는지를 비교
	public int getMember(String id, String pass){
		int result =0;
		getCon();
		try{
			String sql ="select count(*) from member where id =? and pass1= ?";
			pstmt =con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pass);
			rs=pstmt.executeQuery();
			if(rs.next()){
				result=rs.getInt(1);//0또는 1값이 저장됨
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			closed();
		}
		return result;
	}
	
	//하나의 예약 정보를 저장하는 메소드
	public void setReserveCar(CarReserveBean  bean){
		getCon();
		try{
			String sql ="insert into CARRESERVE (RESERVENO, NO, ID, QTY, DDAY, RDAY, USERIN, USEWIFI, USESEAT, USENAVI )"
					+ " VALUES(RESERVE_SEQ.nextval, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			pstmt =con.prepareStatement(sql);
			
			System.out.println(bean.toString());
			
			//?에 값을 대입
			pstmt.setInt(1, bean.getNo());
			pstmt.setString(2, bean.getId());
			pstmt.setInt(3, bean.getQty());
			pstmt.setInt(4, bean.getDday());
			pstmt.setString(5, bean.getRday());
			
			pstmt.setInt(6, bean.getUserin());
			pstmt.setInt(7, bean.getUsewifi());
			pstmt.setInt(8, bean.getUseseat());
			pstmt.setInt(9, bean.getUsenavi());
			pstmt.executeUpdate();
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			closed();
		}
	}
	
	//회원의 예약정보를 리턴하는 메소드
	public Vector<CarViewBean> getAllReserve(String id){
		Vector<CarViewBean> v=new Vector<CarViewBean>();
		CarViewBean bean=null;
		getCon();
		try{
			//쿼리문
			String sql="select * from  RENTCAR natural join CARRESERVE "
					+ " where  sysdate < to_date(rday, 'YYYY-MM-DD') and id= ?";
			
			pstmt =con.prepareStatement(sql);
			//?
			pstmt.setString(1, id);
			//결과리턴
			rs=pstmt.executeQuery();
			while(rs.next()){
				bean=new CarViewBean();
				bean.setName(rs.getString("name"));
				bean.setDday(rs.getInt("dday"));
				bean.setImg(rs.getString("img"));
				bean.setPrice(rs.getInt("price"));
				bean.setQty(rs.getInt("qty"));
				bean.setRday(rs.getString("rday"));
				bean.setUsenavi(rs.getInt("usenavi"));
				bean.setUserin(rs.getInt("userin"));
				bean.setUseseat(rs.getInt("useseat"));
				bean.setUsewifi(rs.getInt("usewifi"));
				bean.setReserveno(rs.getInt("reserveno"));
				v.add(bean);
	
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			closed();
		}
		return v;
	}
	
	//하나의 예약 삭제
	public void carRemoveReserve(int reserveno,String ID){
		
		getCon();
		try{
			String sql=" delete from CARRESERVE where reserveno=? and ID=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, reserveno);
			pstmt.setString(2, ID);
			pstmt.executeUpdate();
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			closed();
		}
	}
	
	
	
	//자원 닫는 메소드
	private void closed(){
		try{
			if(rs!=null)rs.close();
			if(pstmt!=null)pstmt.close();
			if(con!=null)con.close();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	// 공통 부분 메소드 로 만듬.
	private Vector<CarListBean> commonCarBean(String sql, boolean option, int num){
		getCon(); //커넥션이 연결되엉야 쿼리를 실행 가능
		Vector<CarListBean> v =new Vector<>();
		CarListBean bean =null;
		try {
			pstmt=con.prepareStatement(sql);
			//쿼리 실행후 결과를 Result 타입으로 리턴
			
			rs =pstmt.executeQuery();
			int count=0;
			while(rs.next()){			
				bean = new CarListBean();
				bean.setNo(rs.getInt(1));
				bean.setName(rs.getString(2));
				bean.setCategory(rs.getInt(3));
				bean.setPrice(rs.getInt(4));
				bean.setUsepeople(rs.getInt(5));
				bean.setCompany(rs.getString(6));
				bean.setImg(rs.getString(7));
				bean.setInfo(rs.getString(8));
				//벡터를 빈 클래스에 저장
				v.add(bean);
			
				if(option){	
					count++;
					if(count >=num)break; //반복문을 빠져나가시오.
				}
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			closed();
		}
		return v;
	}
	
	


	
}







