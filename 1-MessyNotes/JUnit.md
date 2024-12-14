[[Testes et Qualimetrie]]
# JUnit 5 Overview

## Introduction
JUnit is a framework for unit testing in Java, designed to facilitate the testing of individual components of software.

- **Evolution of Versions**:
  - JUnit 3: Obsolete.
  - JUnit 4: Widely used in industrial projects.
  - JUnit 5: Latest version, backward-compatible with JUnit 4 tests.

## Architecture
JUnit 5 is modular and consists of:
- **JUnit Platform**: Core system for running tests.
- **JUnit Jupiter**: Library for writing and executing JUnit 5 tests.
- **JUnit Vintage**: Allows execution of JUnit 3 and 4 tests.

Supported by IDEs like Eclipse, IntelliJ IDEA, and build tools like Maven and Gradle.

## Assertions
JUnit provides static methods to write assertions for test validation:
- **Equality**: `assertEquals`, `assertNotEquals`
- **Truth**: `assertTrue`, `assertFalse`
- **Object Matching**: `assertSame`, `assertNotSame`
- **Exceptions**: `assertThrows`
- Supports custom failure messages.

## Test Annotations
JUnit 5 introduces annotations to streamline test execution:
- **Setup/Teardown**:
  - `@BeforeAll`, `@AfterAll`: Run once before/after all tests.
  - `@BeforeEach`, `@AfterEach`: Run before/after each test.
- **Test Configuration**:
  - `@DisplayName`: Customize test names.
  - `@Tag`: Categorize tests.
  - `@Disabled`: Disable a test.
- **Repetition and Parameterization**:
  - `@RepeatedTest`: Repeat tests multiple times.
  - `@ParameterizedTest`: Run tests with varying inputs.

## Advanced Testing Features
- **Error Handling**:
  - Method `assertAll` for multiple assertions without interruption.
- **Examples**:
  - Repeated tests using `@RepeatedTest`.
  - Parameterized tests using `@ParameterizedTest` with data sources like `@ValueSource`.