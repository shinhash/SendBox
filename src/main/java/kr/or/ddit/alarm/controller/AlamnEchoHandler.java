package kr.or.ddit.alarm.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.StringUtils;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import kr.or.ddit.emp.vo.EmpVO;

public class AlamnEchoHandler extends TextWebSocketHandler{
	
	
	private static final Logger logger = LoggerFactory.getLogger(AlamnEchoHandler.class);

	
	// 로그인한 전 사원의 정보 Map List
	private List<Map<String, Object>> empAlamnMapSessionList = SocketAlamnServer.empAlamnMapSessionList;
	
	
	// 현재 로그인한 사원의 정보 Map
	private Map<String, Object> empAlamnMap;
	
	
	

	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		
		// 현재 로그인한 사원의 정보를 담는 Map 객체
		empAlamnMap = new HashMap<String, Object>();
		
		
		// 현재 로그인한 사원의 모든 정보를 담고있는 session 객체
		Map<String, Object> sessionInfoMap = session.getAttributes();
		EmpVO empVO = (EmpVO) sessionInfoMap.get("EMP");
		
		
		// 현재 로그인한 사원의 정보를 map에 저장
		empAlamnMap.put("empId", empVO.getEmpId());
		empAlamnMap.put("empSocketId", session.getId());
		empAlamnMap.put("empSocketSession", session);
		
		// map 데이터를 List에 저장
		empAlamnMapSessionList.add(empAlamnMap);
		
		// logger
		logger.debug("empId : {}", empVO.getEmpId());
		logger.debug("empSocketId : {}", session.getId());
		logger.debug("empSocketSession : {}", session);
	}
	
	
	
	
	
	
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		// 등록버튼 클릭 시 저장되는 메시지 Text
		String msg = message.getPayload();
		if(StringUtils.isEmpty(msg)) {	// 메시지 Text문자열이 비어있을 경우 
		}else {						  	// 메시지 Text문자열이 비어있지 않을 경우
			String[] msgStr = msg.split(",");
			if(msgStr != null && msgStr.length == 5) {
				String cmd = msgStr[0];				// 메시지의 형식
				String caller = msgStr[1];			// 보내는 사원
				String receiverEmpId = msgStr[2];	// 받는 사원
				String linkInfoText = msgStr[3];	// 링크 텍스트
				String cmdStText = msgStr[4];		// 메시지 내용
				
				// 로그인한 전 사원중 map에 저장된 사원id와 알림을 보내려는 사원id가 일치하는 
				// 사원의 session에 알림 메시지 전달
				for(int i=0; i<empAlamnMapSessionList.size(); i++) {
					// 메시지의 받는 사원id와 List<Map>에 저장된 사원id가 일치하는것이 있을 경우 해당 socketSession정보 저장
					if((empAlamnMapSessionList.get(i).get("empId")).equals(receiverEmpId)) {
						WebSocketSession alarmSession = (WebSocketSession) empAlamnMapSessionList.get(i).get("empSocketSession");
						// 해당 사원의 session정보가 null이지 않을 경우 메시지 전송처리 실행
						if(alarmSession != null) {
							// 전송할 Text정보를 저장할 TextMessage객체 생성
							TextMessage tmpMsg = new TextMessage(cmd + ":" + caller + ":" + linkInfoText + ":" + cmdStText);
							// 해당 사원 socketSession에 TextMessage객체 전송
							alarmSession.sendMessage(tmpMsg);
						}
						break;
					}
				}
			}
		}
	}
	
	
	
	
	
	
	
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		
		Map<String, Object> sessionInfoMap = session.getAttributes();
		EmpVO empVO = (EmpVO) sessionInfoMap.get("EMP");
		
		
		// 로그아웃 또는 세션이 종료된 사원의 정보를 Map에서 삭제하는 과정
		for(int i=0; i<empAlamnMapSessionList.size(); i++) {
			if(((String)(empAlamnMapSessionList.get(i).get("empId"))).equals(empVO.getEmpId())) {
				
				empAlamnMapSessionList.remove(i);
				break;
			}
		}
	}
	
	
	
	
}
