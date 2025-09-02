# MBTI 커뮤니티 프로젝트

## 1. 📖 프로젝트 소개

MBTI 유형에 따라 사용자들이 소통하는 웹 커뮤니티입니다. 자신의 MBTI는 물론, 다른 MBTI와의 관계(좋은 관계, 나쁜 관계 등)에 따라 필터링된 게시판과 채팅방에서 다양한 사람들과 교류할 수 있는 독특한 컨셉의 서비스를 제공합니다.

**테스트 URL**: [http://www.mbticommunity.cloud:8080/](http://www.mbticommunity.cloud:8080/)  
**서버 환경**:  
* Spring Boot 애플리케이션: 네이버 클라우드
* DB 서버: 개인 NAS

---

## 2. ✨ 주요 기능

* **회원 관리**:
    * 회원가입 및 수동 세션 기반 로그인/로그아웃
    * `BCryptPasswordEncoder`를 이용한 안전한 비밀번호 암호화
    * 테스트용 계정: MBTI 유형 뒤에 `_user`를 붙인 계정, 공통 비밀번호 `1234`  
      (예: `infp_user`, `entp_user`, `intj_user` 등)

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
| **Database** | Oracle DB |
| **Persistence** | MyBatis |
| **Build Tool** | Gradle |

---

## 4. ⚙️ 실행 방법

1.  **Repository 클론**
    ```bash
    git clone https://github.com/blh8577/mbti.git
    ```

2.  **데이터베이스 설정**
    * Oracle 데이터베이스에 접속하여, 제공된 `테이블 생성 DDL` 스크립트를 실행하여 모든 테이블과 시퀀스를 생성합니다.
    * 원활한 테스트를 위해 `테스트 데이터 삽입 SQL` 스크립트를 실행하여 초기 데이터를 추가합니다.

3.  **`application.properties` 설정**
    * `src/main/resources/application.properties` 파일을 열어 본인의 데이터베이스 접속 정보(URL, username, password)를 수정합니다.
    * 파일이 업로드될 실제 서버 경로를 설정합니다. (경로 마지막에 `/`를 꼭 포함해야 합니다)
        ```properties
        # 예시: 윈도우
        file.upload-dir=C:/mbti_uploads/
        # 예시: 리눅스/맥
        # file.upload-dir=/Users/username/mbti_uploads/
        ```

4.  **애플리케이션 실행**
    * `MbtiApplication.java` 파일을 실행하여 스프링 부트 애플리케이션을 시작합니다.
    * 웹 브라우저에서 `http://localhost:8080` 또는 테스트 URL에서 접속합니다.

---

## 5. 📝 테이블 구조 (ERD)

![ERD](src/main/webapp/static/images/ERD.png)

* **MEMBER**: 회원 정보
* **BOARD**: 게시물 정보
* **COMMENTS**: 댓글 정보
* **NOTE**: 쪽지 정보
* **PICTURE**: 업로드된 사진 정보
* **MBTI_RELATIONS**: MBTI 간의 관계를 정의하는 핵심 테이블
* **RECOMMENDATION / OPPOSITION**: 추천/반대 기록
* **CHATROOM**: 채팅 메시지 기록
