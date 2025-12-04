# Clover Task Mobile

A modern, responsive mobile task management application built with Flutter, featuring user authentication, task creation, editing, and organization capabilities.

## Features

- **User Authentication**: Secure login and registration using Supabase
- **Dashboard**: Overview of tasks with priority-based filtering
- **Task Management**: Create, read, update, and delete tasks with priority levels
- **Profile Management**: View and manage user profile information
- **Task History**: Track completed and edited tasks
- **Responsive Design**: Optimized for mobile devices
- **Real-time Updates**: Seamless task synchronization with backend API

## Tech Stack

### Frameworks & Libraries
- **Flutter**: Cross-platform UI toolkit for building natively compiled applications
- **Dart**: Programming language optimized for building mobile, desktop, server, and web applications
- **Provider**: State management library for Flutter

### Backend & Authentication
- **Supabase**: Backend-as-a-Service for authentication and real-time database
- **HTTP**: Dart package for making HTTP requests
- **Shared Preferences**: Flutter plugin for reading and writing simple key-value pairs
- **NestJS Backend**: Custom API server for task operations

### Development Tools
- **Flutter SDK**: Development kit for building Flutter applications
- **Android Studio / VS Code**: IDEs for Flutter development

## Prerequisites

Before running this project, ensure you have the following installed:

- **Flutter SDK** (version 3.10.1 or higher)
- **Dart SDK** (included with Flutter)
- **Android Studio** or **VS Code** with Flutter extensions
- **Android/iOS Emulator** or physical device for testing
- **Git** for version control

## Installation and Setup

1. **Clone the repository**:
   ```bash
   git clone <repository-url>
   cd clover-task-mobile
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Environment Configuration**:
   The Supabase URL and anonymous key are hardcoded in `lib/main.dart`. For production, consider moving them to environment variables or a secure config file.

   > **Note**: Replace the placeholder values with your actual Supabase project credentials if needed.

4. **Backend Setup**:
   Ensure the NestJS backend is running and accessible. The default API URL is configured in `lib/constants.dart` as `https://ea6f1dd87427.ngrok-free.app/api`. Update this if your backend is hosted elsewhere.

5. **Run the application**:
   ```bash
   flutter run
   ```

6. **Build for production**:
   - For Android: `flutter build apk`
   - For iOS: `flutter build ios` (requires macOS and Xcode)

## Usage

### Getting Started
1. **Register**: Create a new account or log in with existing credentials
2. **Dashboard**: View all tasks with priority filtering options
3. **Create Tasks**: Use the "Add Task" button to add tasks
4. **Manage Tasks**: Edit, delete, or mark tasks as complete
5. **Profile**: Access user information and account details

### Key Workflows
- **Task Creation**: Navigate to the Add Task page to create new tasks with title, description, and priority
- **Task Editing**: Tap on any task card to view details and edit
- **Priority Filtering**: Use the home page tabs to filter tasks by priority level
- **History Tracking**: View completed and recently edited tasks in the profile or dedicated sections

## Decisions and Tradeoffs

### Architecture Choices
- **Flutter Framework**: Chosen for cross-platform development, enabling single codebase for iOS and Android, though it may have performance tradeoffs compared to native development.
- **Supabase Authentication**: Selected for its simplicity and integration with real-time features, though it introduces vendor lock-in compared to custom JWT solutions.

### UI/UX Decisions
- **Material Design**: Adopted Flutter's Material Design for consistent UI across platforms, prioritizing familiarity over custom design systems.
- **Provider for State Management**: Chosen for its simplicity and integration with Flutter, trading off advanced features of other state management solutions like Bloc.

### Technical Tradeoffs
- **HTTP for API Calls**: Used for direct API communication, prioritizing simplicity over advanced features like caching or interceptors.
- **Shared Preferences**: Selected for local storage of simple data, though it lacks encryption for sensitive information.
- **Hardcoded Credentials**: Supabase keys are hardcoded for simplicity, but this should be addressed for production security.

### Performance Considerations
- **Cross-Platform Compilation**: Flutter compiles to native code, but initial app size may be larger compared to native apps.
- **State Management**: Provider is lightweight but may not scale as well as more complex solutions for larger apps.

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

- This project is developed by Patrice Oyende(abellepatrice) and is to be used by Clover team to assess my ability to build a scalable and reliable Nest JS backend for both web and mobile.
If anyone intends to use this project for personal and commercial use, they will be allowed to upon my(Patrice) approval.
Feel free to reach out regarding this project through my email: abellepatrice@gmail.com
