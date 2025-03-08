# "Qaysar Rates"
is a Flutter-based application designed to allow users to rate employees and provide feedback. The app is divided into two parts:
User Section: Users can search for the employee they want to rate and submit their feedback.
Admin Section: Admins have the ability to add, edit, or delete employee profiles for rating purposes. Additionally, the app sends notifications to the admin if a negative review is submitted for any employee.

# Features
User Section:

Users can search for an employee by name and submit ratings and reviews.
The system allows users to give feedback based on their experience with specific employees.

Admin Section:

Admins can manage employee profiles by adding, editing, or deleting them.
Admins receive notifications via OneSignal if any negative review is submitted for an employee.
Push Notifications: The app uses OneSignal to send notifications to the admin when a negative review is submitted.
Search Functionality: The app allows users to search for employees by name to rate them quickly.

# Technologies Used:

Flutter: The primary framework used for building the app.

Supabase: For data storage and backend services.

OneSignal: For push notifications to alert the admin about negative reviews.

Cubit: For state management, following a reactive and clean architecture.

Clean Architecture: A well-structured architecture that separates different layers of the app for maintainability and scalability.

Dart: The programming language used for app development.
