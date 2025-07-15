package com.community.mbti.service;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Slf4j
@Service
public class FileService {

    // application.properties에 설정한 파일 저장 경로를 가져옵니다.
    @Value("${file.upload-dir}")
    private String uploadDir;

    public List<String> storeFiles(List<MultipartFile> multipartFiles) throws IOException {
        List<String> storeResult = new ArrayList<>();
        if (multipartFiles != null && !multipartFiles.isEmpty()) {
            for (MultipartFile multipartFile : multipartFiles) {
                if (!multipartFile.isEmpty()) {
                    storeResult.add(storeFile(multipartFile));
                }
            }
        }
        return storeResult;
    }

    // 파일을 저장하고, 저장된 파일의 경로를 반환하는 메서드
    private String storeFile(MultipartFile multipartFile) throws IOException {
        String originalFilename = multipartFile.getOriginalFilename();
        // 원본 파일명에서 확장자 추출 (예: .png)
        String extension = originalFilename.substring(originalFilename.lastIndexOf("."));
        // 다른 파일과 이름이 겹치지 않도록 UUID를 사용하여 새로운 파일명 생성
        String storedFileName = UUID.randomUUID().toString() + extension;

        // 지정된 경로에 파일 저장
        File storedFile = new File(uploadDir + storedFileName);
        multipartFile.transferTo(storedFile);
        log.info("파일 저장 성공: {}", storedFile.getPath());

        // DB에 저장할 상대 경로 반환 (예: /uploads/파일이름.jpg)
        // 웹에서 접근할 수 있도록 URL 매핑이 필요합니다.
        return "/uploads/" + storedFileName;
    }
}