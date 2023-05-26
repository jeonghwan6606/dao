package dao;
import util.DBUtil;
import vo.Teacher;

import java.util.*;
import java.sql.*;


public class TeacherDao {
	
	//1)teacher목록
	/*
	 ISSUE : 교과목 연결되지 않은 강사는 출력되지 않는다 inner join -> outer join
 SELECT t.teacher_no, t.teacher_id, t.teacher_name, ts.subject_no, s.subject_name, GROUP_CONCAT(s.subject_name)
	FROM teacher t 
	left JOIN teacher_subject ts  ON t.teacher_no = ts.teacher_no
	left JOIN subject s ON ts.subject_no = s.subject_no
	GROUP BY t.teacher_no, t.teacher_id, t.teacher_name LIMIT 0,10;	 
	 */
	
	public ArrayList<HashMap<String,Object>> selectTeacherListByPage(
			int beginRow, int rowPerPage)  throws Exception {
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String teacherSubjectSql = "SELECT t.teacher_no teacherNo, t.teacher_id teacherId, t.teacher_name teacherName, ts.subject_no subjectNo, GROUP_CONCAT(s.subject_name) subjectName FROM teacher t left JOIN teacher_subject ts  ON t.teacher_no = ts.teacher_no left JOIN subject s ON ts.subject_no = s.subject_no GROUP BY t.teacher_no, t.teacher_id, t.teacher_name LIMIT ?,? ";
		PreparedStatement teacherSubjectStmt = conn.prepareStatement(teacherSubjectSql); 
		teacherSubjectStmt.setInt(1,beginRow); 	
		teacherSubjectStmt.setInt(2,rowPerPage);
		// ResultSet
		ResultSet teacherSubjectRs = teacherSubjectStmt.executeQuery();
		
		ArrayList<HashMap<String, Object>> teacherList = new ArrayList<HashMap<String, Object>>();
		while(teacherSubjectRs.next()) {
			HashMap<String, Object> ts = new HashMap<String, Object>();
			ts.put("teacherNo",teacherSubjectRs.getInt("teacherNo"));
			ts.put("teacherId",teacherSubjectRs.getString("teacherId"));
			ts.put("teacherName",teacherSubjectRs.getString("teacherName"));
			ts.put("subjectNo",teacherSubjectRs.getString("subjectNo"));
			ts.put("subjectName",teacherSubjectRs.getString("subjectName"));
			teacherList.add(ts);
			
		}
		
		return teacherList;
	}
	
	//2) teacher추가  메소드
		public int insertTeacher(HashMap<String,Object> teacher) throws Exception {
			int insertTeacherRow = 0;
			
			
			// 아이디 중복부터 체크 
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
			if(teacher!=null) {
				String idCkSql ="Select teacher_id from teacher Where teacher_id=?";
				
				PreparedStatement idCkStmt = conn.prepareStatement(idCkSql);
				idCkStmt.setString(1,(String)teacher.get("teacherId")); 
				ResultSet ckIdRs = idCkStmt.executeQuery();
				if(ckIdRs.next()) { //동일한 아이디가 있으면
					return insertTeacherRow;
				}
				//유효성 여부
								
				//insert 쿼리
				String insertSql = "Insert INTO teacher(teacher_Id, teacher_name, teacher_history, createdate,updatedate) Values(?,?,?,now(),now())";
				PreparedStatement insertTeacherStmt = conn.prepareStatement(insertSql);
				insertTeacherStmt.setString(1,(String)teacher.get("teacherId")); 
				insertTeacherStmt.setString(2,(String)teacher.get("teacherName")); 	
				insertTeacherStmt.setString(3,(String)teacher.get("teacherHistory")); 		
				insertTeacherRow = insertTeacherStmt.executeUpdate();
				}
			return insertTeacherRow;
		}
		//3) teacher삭제 메소드
		
		public int deleteTeacher(int teacherNo) throws Exception {
			
			
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection(); 
			//delete 쿼리
			String deleteSql = "DELETE FROM teacher where teacher_no = ?";
			PreparedStatement deleteTeacherStmt = conn.prepareStatement(deleteSql);
			deleteTeacherStmt.setInt(1,teacherNo); 	
			
			int deleteTeacherRow = deleteTeacherStmt.executeUpdate();
			if(deleteTeacherRow==1) {
				System.out.println("삭제성공");
			}else{
				deleteTeacherRow=0;
				System.out.println("삭제실패");
			}
			
			return deleteTeacherRow;
		}
		
		//4) teacher수정  메소드
		public int updateTeacher(Teacher teacher) throws Exception {
			int updateTeacherRow=0;
			if(teacher!=null) {
				DBUtil dbUtil = new DBUtil();
				Connection conn = dbUtil.getConnection(); 
				
				//id 중복체크
				String idCkSql ="Select teacher_id from teacher Where teacher_id=?";
				
				PreparedStatement idCkStmt = conn.prepareStatement(idCkSql);
				idCkStmt.setString(1,teacher.getTeacherId()); 
				ResultSet ckIdRs = idCkStmt.executeQuery();
				if(ckIdRs.next()) { //동일한 아이디가 있으면
					return updateTeacherRow;
				}
				//Update 쿼리
				String updateTeacherSql = "UPDATE teacher SET teacher_id =?, teacher_name=?, teacher_history=?, updatedate=now() Where teacher_no= ? ";
				PreparedStatement updateTeacherStmt = conn.prepareStatement(updateTeacherSql); 
				updateTeacherStmt.setString(1,teacher.getTeacherId()); 	
				updateTeacherStmt.setString(2,teacher.getTeacherName()); 
				updateTeacherStmt.setString(3,teacher.getTeacherHistory()); 
				updateTeacherStmt.setInt(4,teacher.getTeacherNo());
				// Row 
				updateTeacherRow = updateTeacherStmt.executeUpdate();
				if(updateTeacherRow==1) {
					System.out.println("수정성공");
				}else{
					updateTeacherRow=0;
					System.out.println("수정실패");
				}
			}
			return updateTeacherRow;
			
		}
		
		//5)teacher 하나 상세  메소드
		public HashMap<String,Object> selectTeacherOne(int teacherNo) throws Exception {
			
			System.out.println(teacherNo+"TeacherDao teacherNo");
			
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection(); 
			// PreparedStatement
			String teacherOneSql = "SELECT teacher_id teacherId,teacher_name teacherName, teacher_no teacherNo, teacher_history teacherHistory, updatedate,createdate FROM teacher Where teacher_no= ? ";
			PreparedStatement teacherOneStmt = conn.prepareStatement(teacherOneSql); 
			teacherOneStmt.setInt(1,teacherNo); 				
			// ResultSet
			ResultSet teacherOneRs = teacherOneStmt.executeQuery();
			
			HashMap<String, Object> teacher = null;
			if(teacherOneRs.next()) {
				teacher = new HashMap<String, Object>();
				teacher.put("teacherNo",teacherOneRs.getInt("teacherNo"));
				teacher.put("teacherId",teacherOneRs.getString("teacherId"));
				teacher.put("teacherHistory",teacherOneRs.getString("teacherHistory"));
				teacher.put("teacherName",teacherOneRs.getString("teacherName"));
				teacher.put("createdate",teacherOneRs.getString("createdate"));
				teacher.put("updatedate",teacherOneRs.getString("updatedate"));						
			}
			return teacher;
		}
	
	//6)teacher전체 행수 메소드
	public int teacherSubjectCnt() throws Exception {
		int totalRow = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection(); 
		// PreparedStatement
				String teacherSubjectCntSql = "SELECT Count(*) from teacher";
				PreparedStatement teacherSubjectCntStmt = conn.prepareStatement(teacherSubjectCntSql);	
				
				// ResultSet
				ResultSet teacherSubjectCntRs = teacherSubjectCntStmt.executeQuery();
				
				if(teacherSubjectCntRs.next()){
					totalRow = teacherSubjectCntRs.getInt(1); //행이 하나일때 index 1사용
				}
		
		return totalRow; 
	}	
}
