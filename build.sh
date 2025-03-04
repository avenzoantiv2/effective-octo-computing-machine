#!/bin/bash

# Define variables
PROJECT_DIR="my_project"
BUILD_DIR="$PROJECT_DIR/build"
SRC_DIR="$PROJECT_DIR/src"
LAYOUT_DIR="$PROJECT_DIR/res/layout"
OUT_FILE="$BUILD_DIR/output"
TEST_DIR="$PROJECT_DIR/test"
DEP_DIR="$PROJECT_DIR/deps"
GRADLE_FILE="$PROJECT_DIR/build.gradle"

# Function to create a build.gradle file
create_gradle_file() {
    echo "Creating build.gradle file..."
    cat <<EOL > "$GRADLE_FILE"
plugins {
    id 'com.android.application'
    id 'kotlin-android'
}

android {
    compileSdkVersion 31

    defaultConfig {
        applicationId "com.example.myapp"
        minSdkVersion 21
        targetSdkVersion 31
        versionCode 1
        versionName "1.0"
    }

    buildTypes {
        release {
            minifyEnabled false
            proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro'
        }
    }
}

dependencies {
    implementation 'androidx.appcompat:appcompat:1.3.1'
    implementation 'androidx.core:core-ktx:1.6.0'
    implementation 'com.google.android.material:material:1.4.0'
    implementation 'androidx.constraintlayout:constraintlayout:2.1.0'
    implementation 'org.jetbrains.kotlin:kotlin-stdlib:1.5.31'
    // Add more dependencies here
}
EOL
    echo "build.gradle file created successfully."
}

# Function to create a basic Android application structure
create_app_structure() {
    echo "Creating application structure..."
    mkdir -p "$SRC_DIR"
    mkdir -p "$LAYOUT_DIR"

    read -p "Choose the programming language (java/kotlin): " lang
    read -p "Enter the name for your main XML layout file (e.g., activity_main): " layout_name

    # Create the layout XML file
    cat <<EOL > "$LAYOUT_DIR/$layout_name.xml"
<RelativeLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent">

    <TextView
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:text="Hello World!" />
</RelativeLayout>
EOL
    echo "Layout file $layout_name.xml created successfully."

    # Create the main activity file
    if [[ "$lang" == "java" ]]; then
        cat <<EOL > "$SRC_DIR/MainActivity.java"
package com.example.myapp;

import androidx.appcompat.app.AppCompatActivity;
import android.os.Bundle;

public class MainActivity extends AppCompatActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.$layout_name);
    }
}
EOL
        echo "MainActivity.java created successfully."
    elif [[ "$lang" == "kotlin" ]]; then
        cat <<EOL > "$SRC_DIR/MainActivity.kt"
package com.example.myapp

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.$layout_name)
    }
}
EOL
        echo "MainActivity.kt created successfully."
    else
        echo "Invalid language choice. Please choose 'java' or 'kotlin'."
    fi
}

# Function to compile the project
compile() {
    echo "Compiling the project..."
    mkdir -p "$BUILD_DIR"
    # Placeholder for compilation command
    echo "Compilation completed."
}

# Function to clean the build directory
clean() {
    echo "Cleaning the build directory..."
    rm -rf "$BUILD_DIR"
    echo "Cleaning completed."
}

# Function to run the project
run() {
    echo "Running the project..."
    # Placeholder for run command
    echo "Project is running."
}

# Function to run tests
test() {
    echo "Running tests..."
    mkdir -p "$BUILD_DIR/tests"
    # Placeholder for test command
    echo "Tests completed."
}

# Function to install dependencies
install_dependencies() {
    echo "Installing dependencies..."
    mkdir -p "$DEP_DIR"
    
    # Asking for dependencies
    read -p "Add Kotlin Standard Library? (y/n): " add_kotlin
    if [[ "$add_kotlin" == "y" ]]; then
        echo "implementation 'org.jetbrains.kotlin:kotlin-stdlib:1.5.31'" >> "$GRADLE_FILE"
    fi

    read -p "Add I/O Library? (y/n): " add_io
    if [[ "$add_io" == "y" ]]; then
        echo "implementation 'com.squareup.okhttp3:okhttp:4.9.1'" >> "$GRADLE_FILE" # Example for OkHttp
    fi

    echo "Dependencies installed."
}

# Function to package the project
package() {
    echo "Packaging the project..."
    tar -czf "$PROJECT_DIR/project_package.tar.gz" -C "$BUILD_DIR" .
    echo "Project packaged successfully."
}

# Function for help
help() {
    echo "Usage: ./build.sh [command]"
    echo "Available commands:"
    echo "  create-gradle    - Creates build.gradle file"
    echo "  create-app       - Creates the application structure"
    echo "  compile          - Compiles the project"
    echo "  clean            - Cleans the build files"
    echo "  run              - Runs the project"
    echo "  test             - Runs the project tests"
    echo "  install-deps     - Installs project dependencies"
    echo "  package          - Packages the project into a tarball"
    echo "  help             - Displays this help message"
}

# Check the command passed
case $1 in
    create-gradle)
        create_gradle_file
        ;;
    create-app)
        create_app_structure
        ;;
    compile)
        compile
        ;;
    clean)
        clean
        ;;
    run)
        run
        ;;
    test)
        test
        ;;
    install-deps)
        install_dependencies
        ;;
    package)
        package
        ;;
    help)
        help
        ;;
    *)
        echo "Invalid command. Use 'help' to see the available commands."
        ;;
esac
