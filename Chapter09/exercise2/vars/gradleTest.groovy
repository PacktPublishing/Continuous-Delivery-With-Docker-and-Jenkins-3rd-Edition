/**
 * Run unit tests in Gradle project.
 */
def call() {
  sh './gradlew test'
}
