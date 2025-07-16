package com.community.mbti.service;

import com.community.mbti.mapper.ChatroomMapper;
import com.community.mbti.vo.ChatroomVO;
import jakarta.annotation.PostConstruct;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ChatroomService {

    private final ChatroomMapper chatroomMapper;
    private Map<String, List<String>> relationMap;

    @PostConstruct
    public void init() {
        relationMap = chatroomMapper.getAllMbtiRelations().stream()
                .collect(Collectors.groupingBy(
                        map -> map.get("MBTI_FROM") + "_" + map.get("RELATION_TYPE"),
                        Collectors.mapping(map -> (String) map.get("MBTI_TO"), Collectors.toList())
                ));
    }

    @Transactional
    public void saveMessage(ChatroomVO chat) {
        chatroomMapper.insertMessage(chat);
    }

    public boolean canReceive(String senderMbti, String recipientMbti, int cat) {
        List<String> visibleListForRecipient = getVisibleMbtiList(recipientMbti, cat);
        return visibleListForRecipient.contains(senderMbti);
    }

    private List<String> getVisibleMbtiList(String userMbti, int cat) {
        List<String> mbtiList = new ArrayList<>();
        mbtiList.add(userMbti);

        if (cat > 0) {
            String relationType = getRelationType(cat);
            List<String> relatedMbtis = relationMap.getOrDefault(userMbti + "_" + relationType, new ArrayList<>());
            mbtiList.addAll(relatedMbtis);
        }
        return mbtiList;
    }

    public List<ChatroomVO> getInitialMessages(int cat, String userMbti) {
        List<String> mbtiList = getVisibleMbtiList(userMbti, cat);
        return chatroomMapper.selectInitialMessages(cat, mbtiList);
    }

    public String getChatroomTitle(int cat) {
        switch (cat) {
            case 1: return "RG 채팅방";
            case 2: return "RB 채팅방";
            case 3: return "LG 채팅방";
            case 4: return "LB 채팅방";
            default: return "MBTI 채팅방";
        }
    }

    private String getRelationType(int cat) {
        switch (cat) {
            case 1: return "relation_good";
            case 2: return "relation_bad";
            case 3: return "love_good";
            case 4: return "love_bad";
            default: return "";
        }
    }
}