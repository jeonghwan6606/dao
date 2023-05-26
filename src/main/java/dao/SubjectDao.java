package dao;
import util.DBUtil;
import java.util.*;
import java.sql.*;
import vo.Subject;

public class SubjectDao {

	//1) 과목목록
	public ArrayList<Subject> selectSubjectListByPage(int beginRow, int rowPerPage) throws Exception {
		ArrayList<Subject> subjectList = new ArrayList<>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// PreparedStatement
		String subjectSql = "SELECT subject_no, subject_name, subject_time, createdate,updatedate from subject limit ?,?";
		PreparedStatement subjectStmt = conn.prepareStatement(subjectSql); 
		subjectStmt.setInt(1,beginRow); 	
		subjectStmt.setInt(2,rowPerPage);
		// ResultSet
		ResultSet subjectRs = subjectStmt.executeQuery();
		
		while(subjectRs.next()) {
			Subject s = new Subject();
			s.setSubjectNo(subjectRs.getInt("subject_no"));
			s.setSubjectName(subjectRs.getString("subject_name"));
			s.setSubjectTime(subjectRs.getInt("subject_time"));
			s.setCreatedate(subjectRs.getString("createdate"));
			s.setUpdatedate(subjectRs.getString("updatedate"));
			subjectList.add(s);
		}
		return subjectList;
	}

	
	//2) 과목추가
	public int insertSubject(Subject subject) throws Exception {
		int insertSubjectRow = 0;
		//유효성 여부
		if(subject!=null) {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		//insert 쿼리
		String insertSql = "Insert INTO subject(subject_name, subject_time,createdate,updatedate) Values(?,?,now(),now())";
		PreparedStatement insertSubjectStmt = conn.prepareStatement(insertSql);
		insertSubjectStmt.setString(1,subject.getSubjectName()); 	
		insertSubjectStmt.setInt(2,subject.getSubjectTime()); 	
		insertSubjectRow = insertSubjectStmt.executeUpdate();
		}
		return insertSubjectRow;
	}
	
	//3) 과목삭제
	
	public int deleteSubject(int subjectNo) throws Exception {
		
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection(); 
		//delete 쿼리
		String deleteSql = "DELETE FROM subject where subject_no = ?";
		PreparedStatement deleteSubjectStmt = conn.prepareStatement(deleteSql);
		deleteSubjectStmt.setInt(1,subjectNo); 	
		
		int deleteSubjectRow = deleteSubjectStmt.executeUpdate();
		if(deleteSubjectRow==1) {
			System.out.println("삭제성공");
		}else{
			deleteSubjectRow=0;
			System.out.println("삭제실패");
		}
		
		return deleteSubjectRow;
	}
	
	//4) 과목수정
	public int updateSubject(Subject subject) throws Exception {
		int updateSubjectRow=0;
		if(subject!=null) {
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection(); 
			//Update 쿼리
			String updateSubjectSql = "UPDATE subject SET subject_name =?, subject_time=?, updatedate=now() Where subject_no= ? ";
			PreparedStatement updateSubjectStmt = conn.prepareStatement(updateSubjectSql); 
			updateSubjectStmt.setString(1,subject.getSubjectName()); 	
			updateSubjectStmt.setInt(2,subject.getSubjectTime());
			updateSubjectStmt.setInt(3,subject.getSubjectNo());
			// Row 
			updateSubjectRow = updateSubjectStmt.executeUpdate();
			if(updateSubjectRow==1) {
				System.out.println("수정성공");
			}else{
				updateSubjectRow=0;
				System.out.println("수정실패");
			}
		}
		return updateSubjectRow;
		
	}
	
	//5)과목 하나 상세 
	public Subject selectSubjectOne(int subjectNo) throws Exception {
		Subject subject = null;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection(); 
		// PreparedStatement
		String subjectOneSql = "SELECT subject_no, subject_name, subject_time, createdate,updatedate from subject where subject_no= ?";
		PreparedStatement subjectOneStmt = conn.prepareStatement(subjectOneSql); 
		subjectOneStmt.setInt(1,subjectNo); 	
		
		// ResultSet
		ResultSet subjectOneRs = subjectOneStmt.executeQuery();
		
		if(subjectOneRs.next()) {
			subject = new Subject();
			subject.setSubjectNo(subjectOneRs.getInt("subject_no"));
			subject.setSubjectName(subjectOneRs.getString("subject_name"));
			subject.setSubjectTime(subjectOneRs.getInt("subject_time"));
			subject.setCreatedate(subjectOneRs.getString("createdate"));
			subject.setUpdatedate(subjectOneRs.getString("updatedate"));
		}
		
		return subject; 
	}
	
	
	//5) 과목전체row 구하는 메소드
	public int selectSubjectCnt() throws Exception {
		int totalRow = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection(); 
		// PreparedStatement
				String subjectCntSql = "SELECT Count(*) from subject";
				PreparedStatement subjectCntStmt = conn.prepareStatement(subjectCntSql); 					
				
				// ResultSet
				ResultSet subjectCntRs = subjectCntStmt.executeQuery();
				
				if(subjectCntRs.next()){
					totalRow = subjectCntRs.getInt(1); //행이 하나일때 index 1사용
				}
		
		return totalRow; 
	}
}
