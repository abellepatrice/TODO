# Clover Task Web

A modern, responsive web-based task management application built with Next.js, featuring user authentication, task creation, editing, and organization capabilities.

## Features

- **User Authentication**: Secure login and registration using Supabase
- **Dashboard**: Overview of tasks with priority-based filtering
- **Task Management**: Create, read, update, and delete tasks with priority levels
- **Profile Management**: View and manage user profile information
- **Task History**: Track completed and edited tasks
- **Responsive Design**: Optimized for desktop and mobile devices
- **Real-time Updates**: Seamless task synchronization with backend API

## Tech Stack

### Frameworks & Libraries
- **Next.js 16**: React framework for server-side rendering and routing
- **React 19**: UI library for building interactive components
- **TypeScript**: Type-safe JavaScript for better development experience

### Styling & UI
- **Tailwind CSS v4**: Utility-first CSS framework for rapid styling
- **FontAwesome**: Icon library for consistent UI elements
- **Heroicons**: Additional icon set for modern interfaces

### Backend & Authentication
- **Supabase**: Backend-as-a-Service for authentication and real-time database
- **Axios**: HTTP client for API communication
- **NestJS Backend**: Custom API server for task operations

### Development Tools
- **ESLint**: Code linting for consistent code quality
- **React Hot Toast**: Notification system for user feedback

## Prerequisites

Before running this project, ensure you have the following installed:

- **Node.js** (version 18 or higher)
- **npm** or **yarn** package manager
- **Git** for version control

## Installation and Setup

1. **Clone the repository**:
   ```bash
   git clone <repository-url>
   cd clover-task-web
   ```

2. **Install dependencies**:
   ```bash
   npm install
   ```

3. **Environment Configuration**:
   Create a `.env.local` file in the root directory with the following variables:
   ```env
   NEXT_PUBLIC_SUPABASE_URL=your_supabase_project_url
   NEXT_PUBLIC_SUPABASE_ANON_KEY=your_supabase_anon_key
   ```

   > **Note**: Replace the placeholder values with your actual Supabase project credentials.

4. **Backend Setup**:
   Ensure the NestJS backend is running and accessible. The default API URL is configured as `https://ea6f1dd87427.ngrok-free.app/api`. Update this in `src/app/lib/api.ts` if your backend is hosted elsewhere.

5. **Run the development server**:
   ```bash
   npm run dev
   ```

6. **Access the application**:
   Open [http://localhost:3001](http://localhost:3001) in your browser.
   * NOTE the port 3000 is already being used by Nest JS

## Usage

### Getting Started
1. **Register**: Create a new account or log in with existing credentials
2. **Dashboard**: View all tasks with priority filtering options
3. **Create Tasks**: Use the "Create New Task" button to add tasks
4. **Manage Tasks**: Edit, delete, or mark tasks as complete
5. **Profile**: Access user information and account details

### Key Workflows
- **Task Creation**: Navigate to `/tasks/create` to add new tasks with title, description, and priority
- **Task Editing**: Click on any task card to view details and edit
- **Priority Filtering**: Use dashboard tabs to filter tasks by priority level
- **History Tracking**: Visit `/history` to view completed and recently edited tasks

## Screenshots

### Login Page
![Login Page](assets/LoginPage.bmp)
Secure authentication interface with email/password login and registration link.

### Register Page
![Register Page](assets/RegisterPage.bmp)
User registration form with validation and account creation.

### Dashboard
![Dashboard](assets/Dashboard.bmp)
Main dashboard displaying task cards with priority filtering tabs and quick action links.

### Profile Page
![Profile](assets/Profile.bmp)
User profile view showing account information, login history, and account creation date.

### Task Detail
![Task Detail](assets/TaskDetail.bmp)
Detailed view of individual tasks with full description and management options.

### Create Task
![Create Task](assets/CreateTaskImage.bmp)
Task creation form with title, description, and priority selection.

### Edit Task Page
![Edit Task](assets/EditTaskPage.bmp)
Task editing interface for updating existing task information.

## Decisions and Tradeoffs

### Architecture Choices
- **Next.js App Router**: Chosen for its improved routing and layout capabilities over Pages Router, enabling better code organization and performance.
- **Supabase Authentication**: Selected for its simplicity and integration with real-time features, though it introduces vendor lock-in compared to custom JWT solutions.

### UI/UX Decisions
- **Tailwind CSS v4**: Adopted for rapid development and consistent design system, prioritizing developer experience over potential bundle size concerns.
- **Mobile-First Design**: Responsive layout ensures usability across devices, with collapsible sidebar for mobile navigation.

### Technical Tradeoffs
- **Client-Side Rendering**: Most components use "use client" directive for interactivity, trading off initial page load performance for better user experience.
- **Axios for API Calls**: Chosen over fetch for its interceptor capabilities and better error handling, despite native fetch availability.
- **Environment Variables**: Sensitive configuration stored in environment files, requiring careful deployment management.

### Performance Considerations
- **Image Optimization**: Screenshots stored as BMP files for quality, but could be optimized to WebP for better web performance.
- **Bundle Splitting**: Next.js handles automatic code splitting, but manual optimization could further reduce initial bundle size.

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
