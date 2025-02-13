# 📦 Project Structure Generator - Documentation

**Note** : Only use it when creating your project. It is only used to generate a base of files and resources so that you do not have to create it yourself, especially since it is tedious to copy and paste or redo the same things from one project to another. If the generated files and architectures do not suit you, you can modify them after generation without worries. You can also modify the package and submit it to help other people.

## 📌 Installation

Add the `project_structure_builder` package to your project's `dev_dependencies`:

```yaml
flutter pub add --dev project_structure_builder
```

Or modify your `pubspec.yaml` file directly:

```yaml
dev_dependencies:
  project_structure_builder: latest_version
```

Alternatively:

```yaml
dependencies:
  flutter:
    sdk: flutter

dev_dependencies:
  project_structure_builder:
    git:
      url: https://github.com/BaHithBENON/flutter_project_structure_builder.git
      ref: main
      path: project_structure_builder
```

Then run:

```bash
flutter pub get
```

## 🛠️ Project Configuration

📌 Dependencies to Add in `pubspec.yaml`

Add the following dependencies to your `pubspec.yaml` file 
```yaml
dependencies:
  flutter_dotenv: latest_version
  get: latest_version
  get_it: latest_version
  fpdart: latest_version
  equatable: latest_version
```
Replace `latest_version` with the most recent version available on `pub.dev`.


📌 Create a `project_structure_builder.yml` file at the root of your Flutter project and configure it according to your needs:

### Example Configuration File:

```yaml
# This is an example. Modify values as needed.

# Project name
project_name: my_flutter_application

# Available architecture options:
#   - clean_architecture (default)
#   - mvc_architecture
#   - mvvm_architecture
architecture: mvc_architecture

# Available feature management strategies:
#   - inLib (default): all features are placed in the `lib` folder
#   - independantModules: each feature has its own Flutter modules for domain and data layers. The presentation layer remains in the main `lib` folder.
#
# Note: The "independantModules" option is only available for `clean_architecture`.
features_strategy: independantModules

# List of features:
features:
  - authentication: # Feature name (snake_case format)
      
      name: authentication # Override feature name
      
      # Feature description
      description: User authentication feature
      
      # List of entity attributes (optional)
      # If you don’t have attributes, you can skip this section.
      entity_attributes:
        email: String # Format: { attribute_name: type }
        otp: String
        password: String
        token: String
        id: int
      
      # List of use cases
      usecases:
        - getUserOtp: # Use case name
            use_case_type: Future # Return type (Future or Stream)
            description: Retrieve OTP for user authentication
            params: # List of parameters
              email: String # Format: { parameter_name: type }
        - verifyUserOtp:
            use_case_type: Future
            description: Verify OTP code
            params:
              email: String
              otp: String
        - verifyUserExistence:
            use_case_type: Future
            description: Check if the user exists

# State management
# Default is GetX
# Currently available options: none, getx
# Note: Only "none" and "getx" are available at the moment.
state_management: none

# List of environments:
envs:
  - development
  - staging
  - production

# List of environment variables
# Do not include sensitive data (only variable names)
env_variables:
  - ENV1
  - ENV2
```

## 🔍 Parameter Explanation

### **📌 Project Name**
```yaml
project_name: my_flutter_application
```
Defines the Flutter project name.

### **🛠️ Architecture**
```yaml
architecture: mvc_architecture
```
Sets the project architecture.
Available options:
- `clean_architecture` (default)
- `mvc_architecture`
- `mvvm_architecture`

### **📂 Feature Management Strategy**
```yaml
features_strategy: independantModules
```
Defines how features are organized in the project.
- `inLib`: All features are placed in `lib/`.
- `independantModules`: Each feature has its own modules.

> **Note**: `independantModules` is only available for `clean_architecture`.

### **🚀 Feature List**

```yaml
features:
  - authentication:
      name: authentication
      description: User authentication feature
      entity_attributes:
        email: String
        otp: String
        password: String
        token: String
        id: int
      usecases:
        - getUserOtp:
            use_case_type: Future
            description: Retrieve OTP for user authentication
            params:
              email: String
        - verifyUserOtp:
            use_case_type: Future
            description: Verify OTP code
            params:
              email: String
              otp: String
        - verifyUserExistence:
            use_case_type: Future
            description: Check if the user exists
```
- Supported attribute and parameter types: `String, int, double, num, bool, List, Set, Map, DateTime, Duration, Object, dynamic, void`. If a type is not recognized, it will default to `dynamic` during generation.
- Function return types (`Future` or `Stream`).

### **📊 State Management**
```yaml
state_management: none
```
Available options:
- `none`
- `getx` (default)

### **🔧 Environments**
Define the available environments. It is recommended to have at least one development environment.
```yaml
envs:
  - development
  - staging
  - production
```

### **🏢 Environment Variables**
```yaml
env_variables:
  - ENV1
  - ENV2
```
Do not include sensitive data here!

---

## 🚀 Generate Project Structure

Run the following command to generate the project structure:

```bash
dart run project_structure_builder update
```

This will parse the configuration file and automatically structure the project based on the defined parameters.

---

## 🎯 Conclusion

With this setup, your Flutter project will be well-structured and organized following best practices. 🚀

If you have any questions, feel free to check the official documentation or open an issue on the GitHub repository! 🎯

