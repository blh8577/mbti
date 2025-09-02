# MBTI 커뮤니티 프로젝트

## 1. 📖 프로젝트 소개

MBTI 유형에 따라 사용자들이 소통하는 웹 커뮤니티입니다.  
자신의 MBTI는 물론, 다른 MBTI와의 관계(좋은 관계, 나쁜 관계 등)에 따라 필터링된 게시판과 채팅방에서 다양한 사람들과 교류할 수 있는 독특한 컨셉의 서비스를 제공합니다.  

💡 **테스트용 URL**: [http://www.mbticommunity.cloud:8080/](http://www.mbticommunity.cloud:8080/)  
- 클라우드 서버: 네이버 클라우드
- 데이터베이스: 개인용 NAS 사용

---

## 2. ✨ 주요 기능

* **회원 관리**:
    * 회원가입 및 세션 기반 로그인/로그아웃
    * `BCryptPasswordEncoder`를 이용한 안전한 비밀번호 암호화
    * **테스트용 계정**: MBTI 이름 + `_user` (예: `infp_user`, `entp_user`)  
      공통 비밀번호: `1234`

* **MBTI 기반 개인화**:
    * 회원가입 시 선택한 MBTI에 따라 4가지 테마 색상(pink, green, blue, yellow) 자동 적용
    * 모든 콘텐츠(게시판, 채팅, 검색)는 로그인한 사용자의 MBTI 및 관계에 따라 동적으로 필터링

* **게시판**:
    * **카테고리 분류**: MBTI, 좋은 관계(RG), 나쁜 관계(RB), 좋은 연애(LG), 나쁜 연애(LB)
    * **목록 조회**: 인기글 및 최신글 목록 제공, 10개 단위 페이징 기능 구현
    * **게시물 CRUD**: 게시물 작성(사진 다중 업로드), 상세 보기(조회수 증가), 본인 게시물 삭제(논리적 삭제)
    * **상호작용**: 게시물 및 댓글 추천 기능

* **실시간 채팅**:
    * Spring WebSocket을 이용한 실시간 양방향 채팅
    * 게시판과 동일한 MBTI 관계 조건에 따라 분리된 채팅방 제공

* **쪽지 시스템**:
    * 사용자 간 1:1 쪽지 전송 및 답장 기능
    * 받은 쪽지함 제공 (페이징, 읽음/안읽음 상태 표시)
    * 홈 화면에서 읽지 않은 쪽지 목록 확인 기능

* **검색**:
    * **전체 검색**: 홈 화면에서 사용자와 관련된 모든 게시판의 게시물 검색
    * **게시판 내 검색**: 특정 카테고리 내에서 게시물 제목으로 검색

* **UI/UX**:
    * 모바일과 데스크탑을 모두 지원하는 반응형 웹 디자인
    * 모바일 환경을 위한 햄버거 메뉴 제공

---

## 3. 🛠️ 기술 스택

| 구분 | 기술 |
| :--- | :--- |
| **Backend** | Spring Boot, Java 17, Spring WebSocket |
| **Frontend** | JSP, JSTL, CSS3, JavaScript, jQuery |
| **Database** | Oracle DB (NAS 사용) |
| **Persistence** | MyBatis |
| **Build Tool** | Gradle |

---

## 4. ⚙️ 실행 방법

1.  **Repository 클론**
    ```bash
    git clone https://github.com/blh8577/mbti.git
    ```

2.  **데이터베이스 설정**
    * Oracle 데이터베이스 접속
    * 제공된 `테이블 생성 DDL` 스크립트 실행 → 모든 테이블과 시퀀스 생성
    * `테스트 데이터 삽입 SQL` 실행 → 초기 데이터 추가
    * **테스트용 계정 예시**
        ```sql
        INSERT INTO MEMBER (username, password, mbti)
        VALUES ('infp_user', '1234', 'INFP'),
               ('entp_user', '1234', 'ENTP'),
               ...;
        ```

3.  **`application.properties` 설정**
    * `src/main/resources/application.properties` 파일에서 본인의 DB 접속 정보 수정
        ```properties
        spring.datasource.url=jdbc:oracle:thin:@<NAS_IP>:1521:xe
        spring.datasource.username=YOUR_DB_USERNAME
        spring.datasource.password=YOUR_DB_PASSWORD
        spring.datasource.driver-class-name=oracle.jdbc.OracleDriver
        ```
    * 파일 업로드 경로 설정
        ```properties
        # 예시: 윈도우
        file.upload-dir=C:/mbti_uploads/
        # 예시: 리눅스/맥
        # file.upload-dir=/Users/username/mbti_uploads/
        ```

4.  **애플리케이션 실행**
    * `MbtiApplication.java` 실행 → Spring Boot 서버 시작
    * 웹 브라우저에서 [http://localhost:8080](http://localhost:8080) 접속

---

## 5. 📝 테스트용 계정

| MBTI | 테스트용 아이디 | 비밀번호 |
| :--- | :--- | :--- |
| 모든 MBTI | `MBTI_user` (예: `infp_user`, `entp_user`) | 1234 |

> 테스트 계정은 모든 MBTI 이름 뒤에 `_user`를 붙이면 생성됩니다.  
> 공통 비밀번호: `1234`

---

## 6. 📝 테이블 구조 (ERD)

(이곳에 ERD 이미지를 추가하면 좋습니다.)

* **MEMBER**: 회원 정보
* **BOARD**: 게시물 정보
* **COMMENTS**: 댓글 정보
* **NOTE**: 쪽지 정보
* **PICTURE**: 업로드된 사진 정보
* **MBTI_RELATIONS**: MBTI 간의 관계 정의
* **RECOMMENDATION / OPPOSITION**: 추천/반대 기록
* **CHATROOM**: 채팅 메시지 기록
