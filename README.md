# Demo Flutter App

## 📁 프로젝트 구조
```
demo/
├── lib/                          
│   ├── main.dart                 
│   │
│   ├── models/                   # 데이터 모델 (Freezed 사용)
│   │   ├── todo.dart            # Todo 모델 정의
│   │   ├── todo.freezed.dart    # Freezed 생성 파일
│   │   └── todo.g.dart          # JSON 직렬화 생성 파일
│   │
│   ├── pages/                    # 화면 구조 (MVVM 패턴)
│   │   ├── base/                # 기본 클래스들
│   │   │   ├── page.dart        # BasePage - 페이지 기본 클래스
│   │   │   ├── view.dart        # BaseView - 뷰 기본 클래스
│   │   │   └── viewModel.dart  # BaseViewModel - 뷰모델 기본 클래스
│   │   │
│   │   └── main/                # 메인 페이지
│   │       ├── page.dart        # MainPage - 메인 페이지 진입점
│   │       ├── view.dart        # MainView - 메인 화면 UI
│   │       └── viewModel.dart  # MainViewModel - 메인 화면 로직
│   │
│   ├── core/                     
│   │   └── api/                 # API 관련
│   │       ├── client.dart      # ApiClient - HTTP 클라이언트 (Dio)
│   │       └── common/
│   │           └── interceptor.dart  # BaseInterceptor - HTTP 인터셉터
│   │
│   ├── mixin/                    # Mixin 클래스
│   │   └── modal.dart           # ModalMixin - 토스트 및 모달 
│   │
│   └── repository/               # 데이터 리포지토리 (Riverpod 사용)
│       ├── data_source.dart     # DataSource - 제네릭 데이터 소스 클래스
│       └── mock/
│           ├── mock.dart        # MockRepository - Mock 데이터 리포지토리
│           └── mock.g.dart      # Riverpod Generator 생성 파일
│
└── README.md                     # 프로젝트 문서
```

## 🏗️ 아키텍처

### MVVM 패턴
- **Model**: `lib/models/` - 데이터 모델 (Freezed로 불변 객체 생성)
- **View**: `lib/pages/*/view.dart` - UI 구성
- **ViewModel**: `lib/pages/*/viewModel.dart` - 비즈니스 로직 및 상태 관리
- **Page**: `lib/pages/*/page.dart` - View와 ViewModel을 연결하는 진입점

#### BaseView
모든 화면의 기본 클래스, 공통 UI 구조를 제공

#### BaseViewModel
모든 뷰모델의 기본 클래스, 공통 기능을 제공.
- 키보드 숨기기
- 뒤로가기 처리 (앱 종료 확인)
- 리빌드 트리거
- `ModalMixin`을 mixin하여 토스트 및 로딩 기능 사용 가능
### 데이터 모델링
- **Freezed** (^3.0.6) - 불변 클래스 생성
- **json_serializable** (^6.9.5) - JSON 직렬화/역직렬화

### 네트워킹
- **Retrofit** (^4.4.2) - 타입 안전한 HTTP 클라이언트
- **Dio** - HTTP 클라이언트 (Retrofit 의존성)
- **pretty_dio_logger** (^1.4.0) - HTTP 요청/응답 로깅

### 기타
- **shared_preferences** (^2.5.3) - 로컬 저장소
- **fluttertoast** (^8.2.14) - 토스트 메시지 표시
- **loader_overlay** (^2.0.0) - 로딩 오버레이 표시

## 빌드
### 필수 요구사항
- Flutter SDK ^3.7.2
- Dart SDK ^3.7.2

### 설치 및 실행

1. **의존성 설치**
   ```bash
   flutter pub get
   ```

2. **코드 생성 (Freezed, JSON Serialization)**
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

3. **앱 실행**
   ```bash
   flutter run
   ```

## 📂 디렉토리 설명

### `lib/models/`
**예시:**
- `todo.dart` - Todo 모델 정의
- `todo.freezed.dart` - Freezed가 생성한 클래스
- `todo.g.dart` - JSON 직렬화 코드

**구조:**
```
pages/
  └── [screen_name]/
      ├── page.dart      # 페이지 진입점 (View + ViewModel 연결)
      ├── view.dart       # UI 구성
      └── viewModel.dart  # 비즈니스 로직
```

### `lib/core/`
앱 전반에서 사용되는 핵심 기능을 담는 디렉토리

- `api/` - API 클라이언트 및 인터셉터
- 향후 확장: `utils/`, `constants/`, `extensions/` 등

### `lib/mixin/`
재사용 가능한 기능을 제공하는 Mixin 클래스들을 담는 디렉토리

**ModalMixin** (`lib/mixin/modal.dart`)
- `showToast()` - 토스트 메시지 표시
- `showLoading()` - 로딩 오버레이 표시
- `hideLoading()` - 로딩 오버레이 숨기기

**사용 예시:**
```dart
class MainViewModel extends BaseViewModel with ModalMixin {
  void someMethod() {
    showToast(message: "성공했습니다!");
    showLoading(context: context);
    // 작업 수행...
    hideLoading(context: context);
  }
}
```

### `lib/repository/`
데이터 레이어를 담당하는 디렉토리, Riverpod을 사용하여 상태 관리 및 데이터 접근을 관리

**DataSource** (`lib/repository/data_source.dart`)
- 제네릭 타입을 지원하는 데이터 소스 클래스
- `setValue()`, `getValue()`, `delete()`, `clear()` 메서드 제공 (이후 추가)

**MockRepository** (`lib/repository/mock/mock.dart`)
- `@Riverpod(keepAlive: true)` 어노테이션 사용
- Riverpod Generator로 자동 생성되는 Provider
- Mock 데이터 관리용 리포지토리 예시

**사용 예시:**
```dart
// ViewModel에서 사용
final mockRepo = ref.read(mockRepositoryProvider.notifier);
mockRepo.addMock(1);
mockRepo.deleteMock(1);

// View에서 상태 구독
final mockState = ref.watch(mockRepositoryProvider);
```

