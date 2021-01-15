package kr.or.ddit.chat.dao;

import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import kr.or.ddit.alarm.vo.AlarmVO;
import kr.or.ddit.chat.vo.ChatInfoVO;
import kr.or.ddit.chat.vo.ChatRoomVO;
import kr.or.ddit.emp.vo.EmpVO;

@Mapper("chatMapperDao")
public interface ChatMapperDao {
	
	List<ChatRoomVO> selectChatRoomList(ChatRoomVO chatRoomVO) throws Exception;
	
	List<ChatInfoVO> selectChatInfoList(ChatInfoVO chatInfoVO) throws Exception;
	
	int insertChatInfo(ChatInfoVO chatInfoVO) throws Exception;

	List<EmpVO> selectEmpList() throws Exception;
	
	String selectChatRoomId() throws Exception;

	int insertChatRoom(ChatRoomVO chatRoomVO) throws Exception;

	List<EmpVO> selectAddChatRoomEmpList(String chatRoomId) throws Exception;

	int updateChatInfoEmp(ChatInfoVO chatInfo) throws Exception;

	ChatRoomVO selectChatRMInfo(ChatRoomVO chatRoomVO) throws Exception;

	int updateChatRMInfo(ChatRoomVO tempChatRoomVO) throws Exception;

	int updateChatAlarmInfo(AlarmVO tempAlarm) throws Exception;
}
