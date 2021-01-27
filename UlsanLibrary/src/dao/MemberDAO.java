package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import model.Member;


public class MemberDAO {
	Connection conn;
	Statement stmt;
	PreparedStatement pstmt;
	ResultSet rs;
	
	 DB dao = new DB();
	 
	 //회원가입
	 public void insertMember(Member bean) {
		 dao.getCon();
		 
		 try {
			 String sql= "insert into member (name, id, pass, age, email) values(?,?,?,?,?)";
				pstmt = dao.conn.prepareStatement(sql);
				
				pstmt.setString(1, bean.getName());
				pstmt.setString(2, bean.getId());
				pstmt.setString(3, bean.getPass());
				pstmt.setInt(4, bean.getAge());
				pstmt.setString(5, bean.getEmail());
				pstmt.executeUpdate();
				
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				pstmt.close();
				dao.conn.close();
			}catch (Exception e) {

			}
		}
	} 
	 //로그인 회원 매칭
	 public int loginMember(String id,String pass) {
		 dao.getCon();
		 
		 int total_record = 0;//전역변수 초기화
		 
		 try {
			String sql = "select count(*) from member where id=? and pass=?";
			
			pstmt = dao.conn.prepareStatement(sql);
			
			pstmt.setString(1, id);
			pstmt.setString(2, pass);
			
			rs = pstmt.executeQuery(); 
			
			if(rs.next()) {
				total_record = rs.getInt(1);
			}
			
			rs.close();
			pstmt.close();
			dao.conn.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		 return total_record;
	 }
	 
	//로그인 회원정보 불러오기
	public Member loginSelect(String id,String pass) {
		dao.getCon();
		
		Member bean = new Member();
		
		try {
			String sql = "select * from member where id=? and pass=?";
			
			pstmt = dao.conn.prepareStatement(sql);
			
			pstmt.setString(1, id);
			pstmt.setString(2, pass);
			
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				bean.setId(rs.getString("id"));
				bean.setName(rs.getString("name"));
				bean.setLevel(rs.getString("level"));
				bean.setState(rs.getString("state"));
				bean.setPass(rs.getString("pass"));
				bean.setEmail(rs.getString("email"));
				bean.setAge(rs.getInt("age"));
			}
			
			rs.close();
			pstmt.close();
			dao.conn.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return bean;
	}
	
	public int check_id(String id) {
		dao.getCon();
		
		int count = 0;
		
		try {
			
			String sql = "select count(*) from member where id=?";
			
			pstmt = dao.conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
			
			rs.close();
			pstmt.close();
			dao.conn.close();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return count;
	}
	
	public String search_id(String name, String email) {
		dao.getCon();
		
		String id = "";
		
		try {
			
			String sql = "select id from member where name=? and email=?";
			
			pstmt = dao.conn.prepareStatement(sql);
			pstmt.setString(1, name);
			pstmt.setString(2, email);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				id = rs.getString(1);
			}
			
			rs.close();
			pstmt.close();
			dao.conn.close();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return id;
	}
	
	public String search_pass(String id, String name, String email) {
		dao.getCon();
		
		String pass = "";
		
		try {
			
			String sql = "select pass from member where id=? and name=? and email=?";
			
			pstmt = dao.conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, name);
			pstmt.setString(3, email);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				pass = rs.getString(1);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return pass;
	}//전체 회원 불러오기
	public ArrayList<Member> getAllmember(int startRow, int endRow) {//메소드 생성
		dao.getCon();//메소드 실행할때 마다 불러와라
		
		ArrayList<Member> v = new ArrayList<>();//6개 속성 빈에 담고 Array리스트 v 에 객체"들"을 담는다.
		
		try {
			String sql = "select * from member limit ?,? ";
			
			pstmt = dao.conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Member bean = new Member();
				bean.setName(rs.getString("name"));
				bean.setId(rs.getString("id"));
				bean.setPass(rs.getString("pass"));
				bean.setAge(rs.getInt("age"));
				bean.setEmail(rs.getString("email"));
				bean.setLevel(rs.getString("level"));
				bean.setState(rs.getString("state"));
				v.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return v;
	}

	//총 회원 갯수
	public int getAllcount() {
		dao.getCon();
		
		int count = 0;//전역변수
		
		try {
			String sql = "select count(*) from member";
			pstmt = dao.conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1);//지역변수
			}
			pstmt.close();
			dao.conn.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}
	
	
	//한명의 회원정보 불러오기
		public Member viewMember(String id) {//"메소드명"(메소드 호출)
			dao.getCon();
			
			Member bean = new Member();
			try {
				String sql = "select * from member where id=?";
				
				pstmt = dao.conn.prepareStatement(sql);
				
				pstmt.setString(1, id);
				
				rs = pstmt.executeQuery();

				if(rs.next()) {
					bean.setName(rs.getString("name"));
					bean.setId(rs.getString("id"));
					bean.setPass(rs.getString("pass"));
					bean.setAge(rs.getInt("age"));
					bean.setEmail(rs.getString("email"));
					bean.setState(rs.getString("state"));
					bean.setPoint(rs.getInt("point"));
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			return bean;
		}
	
	//관리자 회원정보 수정 
	public void adminmodifymember(Member bean) {
		dao.getCon();
		
		try {
			String sql = "update member set name=?,pass=?,age=?,email=?,level=?,state=? where id=?";//?는 prepareStatement를 쓰겠따.
			pstmt = dao.conn.prepareStatement(sql);
			
			pstmt.setString(1, bean.getName());
			pstmt.setString(2, bean.getPass());
			pstmt.setInt(3, bean.getAge());
			pstmt.setString(4, bean.getEmail());
			pstmt.setString(5, bean.getLevel());
			pstmt.setString(6, bean.getState());
			pstmt.setString(7, bean.getId());
			
			pstmt.executeUpdate();
			
			pstmt.close();
			dao.conn.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	//일반회원 내 정보 수정 
	public void modifymember(Member bean) {
		dao.getCon();
		
		try {
			String sql = "update member set name=?, pass=?, age=?, email=?, level=? where id=?";//?는 prepareStatement를 쓰겠따.
			pstmt = dao.conn.prepareStatement(sql);

			pstmt.setString(1, bean.getName());
			pstmt.setString(2, bean.getPass());
			pstmt.setInt(3, bean.getAge());
			pstmt.setString(4, bean.getEmail());
			pstmt.setString(5, bean.getLevel());
			pstmt.setString(6, bean.getId());

			pstmt.executeUpdate();
			pstmt.close();
			dao.conn.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//회원삭제
	public void deletemember(Member bean) { //회원삭제는 "delete"가 아닌 "update"로 진행해야 한다.
		dao.getCon();
		
		try {
			String sql = "update member set  state=? where id=?";
			pstmt = dao.conn.prepareStatement(sql);
			
			pstmt.setString(1,"x");
			pstmt.setString(2, bean.getId());
			
			pstmt.executeUpdate();
			
			pstmt.close();
			dao.conn.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	public void AdmininsertMember(Member m) {
		dao.getCon();
		
		try {
			
			String sql = "insert into member (id, name, pass, email, age, level) values (?,?,?,?,?,?)";
			
			pstmt = dao.conn.prepareStatement(sql);
			pstmt.setString(1, m.getId());
			pstmt.setString(2, m.getName());
			pstmt.setString(3, m.getPass());
			pstmt.setString(4, m.getEmail());
			pstmt.setInt(5, m.getAge());
			pstmt.setString(6, m.getLevel());
			
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public void mem_B(String id) {
		dao.getCon();
		
		try {
			
			String sql = "update member set state=? where id=?";
			
			pstmt = dao.conn.prepareStatement(sql);
			pstmt.setString(1, "x");
			pstmt.setString(2, id);
			
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	//탈퇴할때 한명의 회원정보 불러오기
		public Member deleteviewMember(String id) {//"메소드명"(메소드 호출)
			dao.getCon();
			
			Member bean = new Member();
			try {
				String sql = "select * from member where id=?";
				
				pstmt = dao.conn.prepareStatement(sql);
				
				pstmt.setString(1, id);
				
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					bean.setName(rs.getString("name"));
					bean.setId(rs.getString("id"));
					bean.setPass(rs.getString("pass"));
					bean.setAge(rs.getInt("age"));
					bean.setEmail(rs.getString("email"));
					bean.setLevel(rs.getString("level"));
					bean.setState(rs.getString("state"));
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			return bean;
		}
		
		public void goodbye(String id) {
			dao.getCon();
			
			try {
				String sql = "update member set state=? where id=? ";
				
				pstmt = dao.conn.prepareStatement(sql);
				
				pstmt.setString(1, "x");
				pstmt.setString(2, id);
				
				pstmt.executeUpdate();
				
				pstmt.close();
				dao.conn.close();
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		public ArrayList<Member> show_mypay(String id) {
			dao.getCon();
			ArrayList<Member> m = new ArrayList<>();
			
			try {
				String sql = "select * from member where id=?";
				pstmt = dao.conn.prepareStatement(sql);
				
				pstmt.setString(1, id);
				
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					Member bean = new Member();
					
					bean.setName(rs.getString("name"));
					bean.setId(rs.getString("id"));
					bean.setPass(rs.getString("pass"));
					bean.setAge(rs.getInt("age"));
					bean.setEmail(rs.getString("email"));
					bean.setLevel(rs.getString("level"));
					bean.setState(rs.getString("state"));
					
					m.add(bean);
				}
				
				pstmt.close();
				dao.conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
			return m;
		}
	
		
		public ArrayList<Member> view_paymem(String id) {
			dao.getCon();
			ArrayList<Member> m = new ArrayList<>();
			try {
				String sql = "select * from member where id=?";
				
				pstmt = dao.conn.prepareStatement(sql);
				
				pstmt.setString(1, id);
				
				rs = pstmt.executeQuery();
				while(rs.next()) {
					Member bean = new Member();
					
					bean.setName(rs.getString("name"));
					bean.setId(rs.getString("id"));
					bean.setPass(rs.getString("pass"));
					bean.setAge(rs.getInt("age"));
					bean.setEmail(rs.getString("email"));
					bean.setLevel(rs.getString("level"));
					bean.setState(rs.getString("state"));
					
					m.add(bean);
				}
				rs.close();
				pstmt.close();
				dao.conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
			return m;
		}
		
		public ArrayList<Member>search_mem(String search, int startRow, int endRow) {
			dao.getCon();
			
			ArrayList<Member> v = new ArrayList<Member>();
			
			try {
				String sql = "select * from member where name like '%" + search + "%' or id like '%" + search +"%' or email like '%" + search +"%' limit "+startRow+","+endRow+"";
			
				stmt = dao.conn.createStatement();
				rs = stmt.executeQuery(sql);
				
				while(rs.next()){
					Member bean = new Member();
					
					bean.setName(rs.getString("name"));
					bean.setId(rs.getString("id"));
					bean.setPass(rs.getString("pass"));
					bean.setAge(rs.getInt("age"));
					bean.setEmail(rs.getString("email"));
					bean.setLevel(rs.getString("level"));
					bean.setState(rs.getString("state"));
					
					v.add(bean);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			return v;
			
		}
		
		public ArrayList<Member> select_mem(int startRow, int endRow) {
			dao.getCon();
			
			ArrayList<Member> v = new ArrayList<Member>();
			
			try {
				String sql = "select * from member limit ?,?";
				
				pstmt = dao.conn.prepareStatement(sql);
				pstmt.setInt(1, startRow);
				pstmt.setInt(2, endRow);
				
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					Member bean = new Member();
					
					bean.setName(rs.getString("name"));
					bean.setId(rs.getString("id"));
					bean.setPass(rs.getString("pass"));
					bean.setAge(rs.getInt("age"));
					bean.setEmail(rs.getString("email"));
					bean.setLevel(rs.getString("level"));
					bean.setState(rs.getString("state"));
					
					v.add(bean);
					
				}
				
				rs.close();
				pstmt.close();
				dao.conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
			return v;
			
		}
		
		public void update_pointonly(String point, String id) {
			dao.getCon();
			
			try {
				
				String sql = "update member set point=? where id=?";
				
				pstmt = dao.conn.prepareStatement(sql);
				pstmt.setString(1, point);
				pstmt.setString(2, id);
				
				pstmt.executeUpdate();
				
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
}














