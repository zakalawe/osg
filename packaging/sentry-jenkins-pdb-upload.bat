
SET SENTRY_ORG=flightgear
SET SENTRY_PROJECT=flightgear
REM ensure SENTRY_AUTH_TOKEN is set in the environment

sentry-cli upload-dif %WORKSPACE%\install\msvc140-64\OpenSceneGraph\bin

sentry-cli upload-dif %WORKSPACE%\install\msvc140\OpenSceneGraph\bin


