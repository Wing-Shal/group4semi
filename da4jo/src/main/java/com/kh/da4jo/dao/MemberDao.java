package com.kh.da4jo.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.da4jo.dto.MemberDto;
import com.kh.da4jo.mapper.MemberMapper;

@Repository
public class MemberDao {
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	@Autowired
	private MemberMapper memberMapper;

	// 회원 가입(등록)
	public void insert(MemberDto memberDto)
	{
		String sql = "insert into member(" + "member_id, member_pw, member_name_kor, "
				+ "member_name_eng, member_email, member_contact1, "
				+ "member_contact2, member_birth, member_clearance_id, "
				+ "member_zipcode, member_address1, member_address2 " + ") values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

		Object[] data = { memberDto.getMemberId(), memberDto.getMemberPw(), memberDto.getMemberNameKor(),
				memberDto.getMemberNameEng(), memberDto.getMemberEmail(), memberDto.getMemberContact1(),
				memberDto.getMemberContact2(), memberDto.getMemberBirth(), memberDto.getMemberClearanceId(),
				memberDto.getMemberZipcode(), memberDto.getMemberAddress1(), memberDto.getMemberAddress2() };
		jdbcTemplate.update(sql, data);
	}

	// 회원 목록 조회
	public List<MemberDto> selectList()
	{
		String sql = "select * from member order by member_id asc";
		// Object[] data = {};
		return jdbcTemplate.query(sql, memberMapper);
	}

	// 회원 검색 조회
	public List<MemberDto> selectList(String column, String keyword)
	{
		String sql = "select * from member where instr(" + column + ", ?) > 0 " + "order by " + column
				+ " asc, member_id asc";
		Object[] data = { keyword };
		return jdbcTemplate.query(sql, memberMapper, data);
	}
	

	// 회원 상세 조회(아이디)
	public MemberDto selectOne(String memberId)
	{
		String sql = "select * from member where member_id = ?"	;
		Object[] data = { memberId };
		List<MemberDto> list = jdbcTemplate.query(sql, memberMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}

	// 회원 상세 조회(이메일)
	public MemberDto selectEmail(String memberEmail)
	{
		String sql = "select * from member where member_email = ?";
		Object[] data = { memberEmail };
		List<MemberDto> list = jdbcTemplate.query(sql, memberMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}

	// 회원 상세 조회(한글이름)
	public MemberDto selectNameKor(String memberNameKor)
	{
		String sql = "select * from member where member_name_kor = ?";
		Object[] data = { memberNameKor };
		List<MemberDto> list = jdbcTemplate.query(sql, memberMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}

	// 최종로그인 시각 변경
	public boolean updateMemberLoginDate(String memberId)
	{
		String sql = "update member " + "set member_login_date=sysdate " + "where member_id = ?";
		Object[] data = { memberId };
		return jdbcTemplate.update(sql, data) > 0;
	}

	// 회원 본인 정보 수정(비밀번호 제외)
	public boolean updateMember(MemberDto memberDto)
	{
		String sql = "update member set " + "member_name_kor=?, member_name_eng=?, "
				+ "member_email=?, member_contact1=?, " + "member_contact2=?, member_birth=?, "
				+ "member_clearance_id=?, " + "member_zipcode=?, member_address1=?, member_address2=? "
				+ "where member_id=?";
		Object[] data = { memberDto.getMemberNameKor(), memberDto.getMemberNameEng(), memberDto.getMemberEmail(),
				memberDto.getMemberContact1(), memberDto.getMemberContact2(), memberDto.getMemberBirth(),
				memberDto.getMemberClearanceId(), memberDto.getMemberZipcode(), memberDto.getMemberAddress1(),
				memberDto.getMemberAddress2(), memberDto.getMemberId() };
		return jdbcTemplate.update(sql, data) > 0;
	}

	// 회원 비밀번호 수정
	public boolean updateMemberPw(MemberDto memberDto)
	{
		String sql = "update member set member_pw=? where member_id=?";
		Object[] data = { memberDto.getMemberPw(), memberDto.getMemberId() };

		return jdbcTemplate.update(sql, data) > 0;
	}
	
	// 회원 돈 수정
	public void updateCredit(MemberDto memberDto) {
		String sql = "update member set member_credit=? where member_id=?";
		Object[] data = { memberDto.getMemberCredit(), memberDto.getMemberId()};
		jdbcTemplate.update(sql, data);
	}

	// 회원탈퇴(상태 변경)
	public boolean deleteMember(String memberId)
	{
		String sql = "UPDATE MEMBER SET MEMBER_BLOCK='Y' WHERE MEMBER_ID=?";
		Object[] data = { memberId };

		return jdbcTemplate.update(sql, data) > 0;
	}
	//회원탈퇴(BLOCK테이블에 추가)
	public boolean addDeleteMember(String memberId) {
		String sql = "INSERT INTO MEMBER_BLOCK(BLOCK_NO, BLOCK_MEMBER_ID, BLOCK_STATUS, BLOCK_REASON) VALUES("
				+ "MEMBER_BLOCK_SEQ.NEXTVAL, ?, '탈퇴회원', '탈퇴회원')";
		return jdbcTemplate.update(sql, memberId) > 0;
	}
	// 돈 충전
	public boolean chargeCredit(String memberId, int credit)
	{
		String sql = "update member set member_credit = member_credit + ? " + "where member_id=?";
		Object[] data = { credit, memberId };

		return jdbcTemplate.update(sql, data) > 0;
	}

	// 돈 사용(차감)
	public boolean payCredit(String memberId, int credit)
	{
		String sql = "update member set member_credit = member_credit - ? " + "where member_id=?";
		Object[] data = { credit, memberId };

		return jdbcTemplate.update(sql, data) > 0;
	}

	// 포인트 충전
	public boolean chargePoint(String memberId, int point)
	{
		String sql = "update member set member_point = member_point + ? " + "where member_id=?";
		Object[] data = { memberId, point };

		return jdbcTemplate.update(sql, data) > 0;
	}

	// 포인트 차감
	public boolean minusPoint(String memberId, int point)
	{
		String sql = "update member set member_point = member_point - ? " + "where member_id=?";
		Object[] data = { memberId, point };

		return jdbcTemplate.update(sql, data) > 0;
	}

	// 이미지 번호 찾기
	public int findImgNo(String memberId)
	{
		String sql = "select img_no from member_img where member_id=?";
		Object[] data = { memberId };

		return jdbcTemplate.queryForObject(sql, int.class, data);
	}

	// 프로필 이미지 연결
	public void connect(String memberId, int imgNo)
	{
		String sql = "insert into member_img(member_id, img_no) values(?, ?)";
		Object[] data = { memberId, imgNo };
		jdbcTemplate.update(sql, data);
	}
	
	//회원이 우리 서비스를 이용한적(배송완료) 있는지
	public int hasServiceHistory(String memberId) {
		String sql = "SELECT COUNT(*) "
				+ "FROM ("
				+ "SELECT SHIPSVC.SHIPSVC_CUSTOMER_ID "
				+ "FROM SHIPSVC "
				+ "WHERE SHIPSVC.SHIPSVC_STATUS = '배송완료' AND SHIPSVC.SHIPSVC_CUSTOMER_ID = ? "
				+ "UNION ALL "
				+ "SELECT PO.PO_CUSTOMER_ID "
				+ "FROM PO "
				+ "WHERE PO.PO_STATUS = '배송완료' AND PO.PO_CUSTOMER_ID = ?"
				+ ")";
		Object[] datas = {memberId, memberId};
		return jdbcTemplate.queryForObject(sql, int.class, datas);
	}
	
	//block 회원 삭제 구문
	public void realRealDeleteMember() {
		String sql = "DELETE FROM MEMBER "
				+ "WHERE MEMBER_ID IN ("
				+ "SELECT BLOCK_MEMBER_ID "
				+ "FROM MEMBER_BLOCK "
				+ "WHERE BLOCK_TIME <= SYSDATE - INTERVAL '5' YEAR)";
		jdbcTemplate.update(sql);
	}
}
