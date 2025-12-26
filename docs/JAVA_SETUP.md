# Java Development Setup

Complete guide for setting up Java projects in this Neovim configuration.

## Prerequisites

Ensure you have these installed on your system:

```bash
# Java Development Kit (required for jdtls)
java -version  # Should be 11+

# Maven (for Maven projects)
mvn -version

# Gradle (for Gradle projects)
gradle --version

# Spotless (for code formatting via Maven/Gradle)
# Installed as a plugin in pom.xml or build.gradle
# See configuration examples below

# Checkstyle (for linting)
# Install via Maven or download jar from checkstyle.org
```

## First Time Setup

### 1. Install jdtls Language Server

```vim
:Mason                    " Open Mason
:MasonInstall jdtls       " Install Java language server
```

Or install via command line:
```bash
nvim +MasonInstall\ jdtls +qall
```

### 2. Verify Java Support

Open any `.java` file:
```vim
nvim src/Main.java
:LspInfo              " Should show jdtls as attached
```

### 3. Set Up Spotless Formatter

Spotless is configured via Maven or Gradle plugins. Choose one:

#### Maven Setup

Add to `pom.xml`:
```xml
<plugin>
  <groupId>com.diffplug.spotless</groupId>
  <artifactId>spotless-maven-plugin</artifactId>
  <version>2.43.0</version>
  <configuration>
    <java>
      <googleJavaFormat>
        <version>1.21.0</version>
      </googleJavaFormat>
    </java>
  </configuration>
</plugin>
```

#### Gradle Setup

Add to `build.gradle`:
```gradle
plugins {
  id "com.diffplug.spotless" version "6.25.0"
}

spotless {
  java {
    googleJavaFormat("1.21.0")
  }
}
```

### 4. Install Checkstyle (Optional but Recommended)

```bash
# macOS
brew install checkstyle

# Linux
sudo apt install checkstyle

# Or download from: https://checkstyle.org/download.html
```

## Creating a New Java Project

### Maven Project with Spotless

```bash
# Create new Maven project
mvn archetype:generate \
  -DgroupId=com.example \
  -DartifactId=my-app \
  -DarchetypeArtifactId=maven-archetype-quickstart

cd my-app

# Add Spotless to pom.xml (see section 3 above)

# Create Maven wrapper (optional but recommended)
mvn wrapper:wrapper

nvim
```

### Gradle Project with Spotless

```bash
# Create new Gradle project
mkdir my-app && cd my-app
gradle init --type java-application --dsl groovy

# Add Spotless to build.gradle (see section 3 above)

# Create Gradle wrapper (optional but recommended)
gradle wrapper

nvim
```

## IDE Features

### Java LSP Features

Once jdtls is running, you get:

| Shortcut | Action |
|----------|--------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gI` | Go to implementation |
| `gr` | Show all references |
| `K` | Show hover documentation |
| `<C-k>` | Show signature help |
| `<leader>la` | Code actions (organize imports, etc.) |
| `<leader>lr` | Rename symbol across project |
| `<leader>ld` | Show line diagnostics |

### Code Formatting

```vim
<leader>lf     " Format current file with google-java-format
```

Automatically formats on save if enabled.

### Linting

```vim
<leader>ll     " Run checkstyle linter
```

Shows style issues inline with error markers.

### Java-Specific Shortcuts

| Shortcut | Action |
|----------|--------|
| `<leader>tm` | Run Maven tests |
| `<leader>tg` | Run Gradle tests |
| `<leader>bm` | Build with Maven (clean install) |
| `<leader>bg` | Build with Gradle (clean build) |

### Code Snippets

Type these shortcuts and press Tab:

| Snippet | Generates |
|---------|-----------|
| `cl` | Public class skeleton |
| `m` | Public method |
| `psvm` | public static void main |
| `sout` | System.out.println |
| `serr` | System.err.println |
| `for` | Enhanced for loop |
| `if` | if statement |
| `try` | try-catch block |

## Working with Maven Projects

### Common Commands

```bash
# Run tests
mvn test

# Run specific test class
mvn test -Dtest=MyTestClassName

# Clean build
mvn clean install

# Skip tests during build
mvn clean install -DskipTests

# Run application
mvn exec:java -Dexec.mainClass="com.example.Main"
```

### Maven in Neovim

```vim
:!mvn test           " Run all tests
:!mvn clean install  " Clean build
:!mvn compile        " Just compile
```

## Working with Gradle Projects

### Common Commands

```bash
# Run tests
gradle test

# Run specific test
gradle test --tests com.example.MyTest

# Clean build
gradle clean build

# Skip tests
gradle clean build -x test

# Run application (if configured)
gradle run
```

### Gradle in Neovim

```vim
:!gradle test        " Run all tests
:!gradle clean build " Clean build
:!gradle build       " Just build
```

## Project Structure

Typical Maven project structure:
```
my-app/
├── pom.xml
├── src/
│   ├── main/
│   │   └── java/com/example/
│   │       └── Main.java
│   └── test/
│       └── java/com/example/
│           └── MainTest.java
└── target/
```

Typical Gradle project structure:
```
my-app/
├── build.gradle
├── src/
│   ├── main/
│   │   ├── java/com/example/
│   │   │   └── Main.java
│   │   └── resources/
│   └── test/
│       └── java/com/example/
│           └── MainTest.java
└── build/
```

## Debugging Tips

### jdtls Not Attaching?

1. Ensure Java 11+ is installed:
   ```bash
   java -version
   ```

2. Verify jdtls is installed:
   ```vim
   :Mason           " Check if jdtls shows as installed
   ```

3. Check LSP logs:
   ```vim
   :LspInfo
   :LspLog
   ```

4. Manually install jdtls:
   ```bash
   nvim +MasonInstall\ jdtls +qall
   ```

### Project Not Recognized?

jdtls looks for project markers in this order:
- `pom.xml` (Maven)
- `build.gradle` or `build.gradle.kts` (Gradle)
- `.git` (Git repository)

Make sure your project has at least one of these at the root.

### Formatting Not Working?

1. Verify google-java-format is installed:
   ```bash
   google-java-format --version
   ```

2. Check Neovim can find it:
   ```vim
   :ConformInfo
   ```

3. Or manually format:
   ```bash
   google-java-format -i src/Main.java
   ```

### Linting Not Working?

1. Verify checkstyle is installed:
   ```bash
   checkstyle -version
   ```

2. Check for checkstyle config file:
   ```bash
   ls -la checkstyle.xml
   ```

3. Default configuration uses Google's checks. Customize by placing checkstyle.xml in project root.

## Configuration Files

### pom.xml (Maven Example)

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0">
  <modelVersion>4.0.0</modelVersion>
  <groupId>com.example</groupId>
  <artifactId>my-app</artifactId>
  <version>1.0-SNAPSHOT</version>

  <properties>
    <maven.compiler.source>11</maven.compiler.source>
    <maven.compiler.target>11</maven.compiler.target>
  </properties>

  <dependencies>
    <dependency>
      <groupId>junit</groupId>
      <artifactId>junit</artifactId>
      <version>4.13.2</version>
      <scope>test</scope>
    </dependency>
  </dependencies>
</project>
```

### build.gradle (Gradle Example)

```gradle
plugins {
    id 'java'
    id 'application'
}

group = 'com.example'
version = '1.0-SNAPSHOT'

repositories {
    mavenCentral()
}

dependencies {
    testImplementation 'junit:junit:4.13.2'
}

application {
    mainClass = 'com.example.Main'
}
```

## Troubleshooting Test Integration

The `:Test` command auto-detects Maven and Gradle projects:

```vim
:Test                " Auto-runs mvn test or gradle test
:Test mvn test -Dtest=ClassName
```

For clickable file links in test output, ensure jdtls and proper Java formatting.

## IntelliJ IDEA Integration

If switching between IntelliJ and Neovim:

1. Both use jdtls/LSP underneath
2. Keep project structure consistent
3. Maven and Gradle configs are compatible
4. Code formatting settings might differ (IntelliJ vs google-java-format)

## Additional Resources

- **jdtls**: https://github.com/eclipse/eclipse.jdt.ls
- **Google Java Format**: https://github.com/google/google-java-format
- **Checkstyle**: https://checkstyle.org
- **Maven**: https://maven.apache.org
- **Gradle**: https://gradle.org
