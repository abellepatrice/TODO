# Clover TODO Backend

A scalable backend API for a TODO application built with NestJS, providing task management and user authentication features.

## Features

- User authentication via Supabase
- Task CRUD operations
- Modular architecture with NestJS
- Type-safe development with TypeScript
- Code quality enforcement with ESLint and Prettier

## Tech Stack
- Nest JS + Supabase Auth 

### Frameworks and Libraries
- **NestJS**:  Node.js 
- **TypeScript**: Typed superset of JavaScript for enhanced developer experience and code reliability
- **Supabase**: Open-source Firebase alternative for authentication and database management
- **Express**: Fast, unopinionated, minimalist web framework for Node.js
- **RxJS**: Reactive programming library for composing asynchronous and event-based programs

### Development Tools
- **Jest**: JavaScript testing framework with a focus on simplicity
- **ESLint**: Tool for identifying and reporting on patterns in ECMAScript/JavaScript code
- **Prettier**: Opinionated code formatter
- **TS-Node**: TypeScript execution and REPL for Node.js
- **TS-Loader**: TypeScript loader for webpack
- **TSConfig Paths**: Support for TypeScript path mapping
- **Source Map Support**: Provides source map support for stack traces in Node.js
- **TypeScript ESLint**: ESLint parser that allows for linting TypeScript code
- **Globals**: Global variables for ESLint configuration
- **TS-Jest**: Jest transformer with source map support for TypeScript
- **NestJS CLI**: Command-line interface for NestJS applications
- **NestJS Schematics**: Code generation schematics for NestJS
- **NestJS Testing**: Testing utilities for NestJS applications
- **NestJS Config**: Configuration module for NestJS
- **NestJS Common**: Common utilities for NestJS
- **NestJS Core**: Core NestJS framework functionality
- **NestJS Platform Express**: Express platform for NestJS
- **Reflect Metadata**: Polyfill for Metadata Reflection API
- **Supertest**: HTTP assertions library for testing Node.js HTTP servers

## Prerequisites

- Node.js (version v22.16.0)
- npm 
- Supabase account and project

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/abellepatrice/TODO.git
   cd clover-task-backend
   ```

2. Install dependencies:
   ```bash
   npm install
   ```

## Configuration

1. Create a `.env` file in the root directory and add your Supabase configuration:
   ```
   SUPABASE_URL=your-supabase-url
   SUPABASE_ANON_KEY=your-supabase-anon-key
   SUPABASE_KEY=your-supabase-service-role-key
   PORT=3000
   ```

2. Ensure your Supabase project has the necessary tables and authentication setup for tasks and users.
## Below are the queries
- profile
    create table if not exists profiles (
        id uuid primary key references auth.users(id),
        email text unique not null,
        username text unique not null,
        created_at timestamp default now()
    );
- tasks
    create table if not exists tasks (
        id uuid primary key default uuid_generate_v4(),
        user_id uuid not null references auth.users(id),
        title text not null,
        description text,
        priority text check (priority in ('low', 'medium', 'high')) default 'low',
        is_completed boolean default false,
        created_at timestamp default now()
     );
- Row level security poilicy

    alter table tasks enable row level security;

    -- Users can insert their own tasks
    create policy "Insert own tasks"
    on tasks for insert
    with check (auth.uid() = user_id);

    -- Users can select only their own tasks
    create policy "Select own tasks"
    on tasks for select
    using (auth.uid() = user_id);

    -- Users can update only their own tasks
    create policy "Update own tasks"
    on tasks for update
    using (auth.uid() = user_id);

    -- Users can delete only their own tasks
    create policy "Delete own tasks"
    on tasks for delete
    using (auth.uid() = user_id);


## Running the Application

```bash
npm run start:dev
```

### Production
```bash
npm run build
npm run start:prod
```

The application will start on port 3000

### Unit Tests
```bash
npm run test
```

### E2E Tests
```bash
npm run test:e2e
```

### Test Coverage
```bash
npm run test:cov
```

## API Endpoints

### Authentication
- `POST /api/auth/login` - User login
- `POST /api/auth/register` - User registration
- `POST /api/auth/logout` - User logout

### Tasks
- `GET /api/tasks` - Get all tasks for authenticated user
- `POST /api/tasks` - Create a new task
- `GET /api/tasks/:id` - Get a specific task
- `PUT /api/tasks/:id` - Update a task
- `DELETE /api/tasks/:id` - Delete a task


### Linting
```bash
npm run lint
```

### Formatting
```bash
npm run format
```

## Project Structure

```
src/
├── app.controller.ts
├── app.module.ts
├── app.service.ts
├── auth/
│   ├── auth.controller.ts
│   ├── auth.module.ts
│   ├── auth.service.ts
│   └── supabase/
│       └── supabase.guard.ts
├── supabase/
│   └── supabase.service.ts
└── tasks/
    ├── tasks.controller.ts
    ├── tasks.module.ts
    └── tasks.service.ts
```

### Framework Choice: NestJS
- **Decision**: Chose NestJS over Express.js for its modular architecture, built-in dependency injection, and excellent TypeScript support.
- **Tradeoff**: Slightly steeper learning curve compared to vanilla Express, but provides better scalability and maintainability for larger applications.

### Authentication: Supabase
- **Decision**: Used Supabase for authentication to leverage its built-in user management, security features, and real-time capabilities.
- **Tradeoff**: Vendor lock-in to Supabase ecosystem, but significantly reduces development time and provides robust security out of the box.

### Database: Supabase (PostgreSQL)
- **Decision**: Opted for Supabase's PostgreSQL database for its integration with authentication and real-time features.
- **Tradeoff**: Less flexibility in database choice compared to using a separate database service, but simplifies data management and reduces infrastructure complexity.

### Testing: Jest
- **Decision**: Selected Jest for its zero-configuration setup, built-in mocking capabilities, and excellent TypeScript support.
- **Tradeoff**: Jest can be slower for large test suites compared to some alternatives, but its developer experience and feature set outweigh this drawback.

### Code Quality: ESLint + Prettier
- **Decision**: Implemented both ESLint and Prettier to enforce consistent code style and catch potential issues.
- **Tradeoff**: Initial setup time and potential conflicts between rules, but long-term benefits in code maintainability and team collaboration far outweigh the costs.

### Reactive Programming: RxJS
- **Decision**: Incorporated RxJS for handling asynchronous operations and complex data flows.
- **Tradeoff**: Added complexity for developers unfamiliar with reactive programming, but provides powerful tools for managing asynchronous code and improves code composability.

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is developed by Patrice Oyende(abellepatrice) and is to be used by Clover team to assess my ability to build a scalable and reliable Nest JS backend for both web and mobile.
If anyone intends to use this project for personal and commercial use, they will be allowed to upon my(Patrice) approval.
Feel free to reach out regarding this project through my email: abellepatrice@gmail.com
