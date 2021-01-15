package kr.or.ddit.alarm.dao;

import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import kr.or.ddit.alarm.vo.AlarmVO;
import kr.or.ddit.emp.vo.EmpVO;

@Mapper("alarmMapperDao")
public interface AlarmMapperDao {

	List<String> selectEmpIdList(String chatRoomId) throws Exception;

	int insertAlarm(AlarmVO alarm) throws Exception;

	List<AlarmVO> selectAlarmInfoList(String empId) throws Exception;

	int updateMyAlarmStatus(EmpVO empVO) throws Exception;

	int updateReadMyAlarm(AlarmVO alarm) throws Exception;

	int selectMyAlarmYCnt(String empId) throws Exception;

	List<AlarmVO> selectChatAlarmInfoList(String empId) throws Exception;

}
