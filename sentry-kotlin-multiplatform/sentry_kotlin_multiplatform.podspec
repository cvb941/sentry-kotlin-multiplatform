Pod::Spec.new do |spec|
    spec.name                     = 'sentry_kotlin_multiplatform'
    spec.version                  = '0.0.5'
    spec.homepage                 = 'https://github.com/getsentry/sentry-kotlin-multiplatform'
    spec.source                   = { :http=> ''}
    spec.authors                  = ''
    spec.license                  = ''
    spec.summary                  = 'Official Sentry SDK Kotlin Multiplatform'
    spec.vendored_frameworks      = 'build/cocoapods/framework/sentry_kotlin_multiplatform.framework'
    spec.libraries                = 'c++'
    spec.ios.deployment_target = '11.0'
    spec.osx.deployment_target = '10.13'
    spec.tvos.deployment_target = '11.0'
    spec.watchos.deployment_target = '4.0'
    spec.dependency 'Sentry', '~> 8.1.0'
                
    spec.pod_target_xcconfig = {
        'KOTLIN_PROJECT_PATH' => ':sentry-kotlin-multiplatform',
        'PRODUCT_MODULE_NAME' => 'sentry_kotlin_multiplatform',
    }
                
    spec.script_phases = [
        {
            :name => 'Build sentry_kotlin_multiplatform',
            :execution_position => :before_compile,
            :shell_path => '/bin/sh',
            :script => <<-SCRIPT
                if [ "YES" = "$OVERRIDE_KOTLIN_BUILD_IDE_SUPPORTED" ]; then
                  echo "Skipping Gradle build task invocation due to OVERRIDE_KOTLIN_BUILD_IDE_SUPPORTED environment variable set to \"YES\""
                  exit 0
                fi
                set -ev
                REPO_ROOT="$PODS_TARGET_SRCROOT"
                "$REPO_ROOT/../gradlew" -p "$REPO_ROOT" $KOTLIN_PROJECT_PATH:syncFramework \
                    -Pkotlin.native.cocoapods.platform=$PLATFORM_NAME \
                    -Pkotlin.native.cocoapods.archs="$ARCHS" \
                    -Pkotlin.native.cocoapods.configuration="$CONFIGURATION"
            SCRIPT
        }
    ]
                
end