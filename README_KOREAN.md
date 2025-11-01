# Mermaid Architecture Diagram Generator

Ruby on Rails와 Perplexity API를 사용한 Mermaid Architecture 다이어그램 생성기입니다.

## 기능

- 자연어로 시스템 아키텍처 설명 입력
- Perplexity AI API를 통해 Mermaid Architecture 다이어그램 코드 생성
- Mermaid.js를 사용한 실시간 아키텍처 다이어그램 렌더링
- Cloud, Server, Database 등의 아이콘을 사용한 전문적인 다이어그램
- 깔끔하고 직관적인 UI

## 설치 방법

### 1. 의존성 설치

```bash
bundle install
```

### 2. 환경 변수 설정

`.env.example` 파일을 복사하여 `.env` 파일을 생성합니다:

```bash
cp .env.example .env
```

`.env` 파일을 열고 Perplexity API 키를 입력합니다:

```
PERPLEXITY_API_KEY=your_actual_api_key_here
```

#### Perplexity API 키 발급 방법

1. [Perplexity AI](https://www.perplexity.ai/) 웹사이트에 접속
2. 계정 생성 또는 로그인
3. API 섹션에서 API 키 발급
4. 발급받은 키를 `.env` 파일에 입력

### 3. 서버 실행

```bash
# Windows에서
set PERPLEXITY_API_KEY=your_api_key_here && rails server

# 또는 .env 파일을 사용하는 경우 (dotenv-rails gem 설치 필요)
rails server
```

서버가 실행되면 브라우저에서 `http://localhost:3000`을 열어 애플리케이션을 사용할 수 있습니다.

## 사용 방법

1. 웹 브라우저에서 `http://localhost:3000` 접속
2. 텍스트 입력창에 원하는 아키텍처나 플로우차트 설명 입력
   - 예시: "전자상거래 웹사이트의 시스템 아키텍처를 그려줘. React, Node.js, PostgreSQL을 사용해."
3. "차트 생성하기" 버튼 클릭
4. 생성된 Mermaid 차트 확인

## 예시 프롬프트

- **전자상거래 아키텍처**: "전자상거래 웹사이트의 아키텍처를 그려줘. 클라우드에 웹 서버, API 서버, 데이터베이스, 캐시 서버를 배치해."
- **마이크로서비스**: "마이크로서비스 아키텍처를 그려줘. 인터넷, API 게이트웨이, 인증 서비스, 사용자 서비스, 제품 서비스, 데이터베이스를 포함해."
- **3티어 웹 앱**: "3티어 웹 애플리케이션 아키텍처를 그려줘. 웹 서버, 애플리케이션 서버, 데이터베이스 서버로 구성해."
- **CI/CD 파이프라인**: "CI/CD 파이프라인 아키텍처를 그려줘. 코드 저장소, 빌드 서버, 테스트 서버, 프로덕션 서버를 포함해."

## 기술 스택

- **Backend**: Ruby on Rails 8.1
- **HTTP Client**: HTTParty
- **AI API**: Perplexity AI API
- **Frontend**: Vanilla JavaScript
- **Diagram Rendering**: Mermaid.js Architecture Diagrams
- **Environment Variables**: dotenv-rails

## Mermaid Architecture 다이어그램이란?

Mermaid Architecture 다이어그램은 클라우드 및 CI/CD 배포를 시각화하는 전문적인 다이어그램입니다.

**주요 구성 요소:**
- **Groups**: 서비스를 조직하는 컨테이너
- **Services**: 개별 리소스를 나타내는 노드
- **Edges**: 서비스 간 연결
- **Icons**: cloud, database, disk, internet, server 등

자세한 정보: https://docs.mermaidchart.com/mermaid-oss/syntax/architecture.html

## 프로젝트 구조

```
mermaid_chart_generator/
├── app/
│   ├── controllers/
│   │   └── charts_controller.rb    # 차트 생성 컨트롤러
│   └── views/
│       └── charts/
│           └── index.html.erb       # 메인 UI
├── config/
│   └── routes.rb                    # 라우팅 설정
├── Gemfile                          # Ruby 의존성
└── .env.example                     # 환경 변수 예시
```

## 주의사항

- Perplexity API 키는 절대 공개 저장소에 업로드하지 마세요
- `.env` 파일은 `.gitignore`에 추가되어 있어야 합니다
- API 사용량에 따라 비용이 발생할 수 있습니다

## 문제 해결

### SQLite3 오류가 발생하는 경우

이 애플리케이션은 데이터베이스를 사용하지 않으므로, SQLite3 오류가 발생해도 웹 애플리케이션은 정상적으로 동작합니다.

### API 키 관련 오류

- `.env` 파일이 프로젝트 루트에 있는지 확인
- API 키가 올바르게 입력되었는지 확인
- 서버를 재시작해보세요

## 라이선스

MIT License
