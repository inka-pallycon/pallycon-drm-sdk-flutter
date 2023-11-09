# PallyCon DRM SDK for flutter

[PallyCon](https://pallycon.com) DRM SDK for flutter follows a federated architecture, which includes the following packages.
> In the trial account, you can freely test SDK products within the trial limit on the number of licenses issued. However, in order to apply the SDK to commercial services, you must apply for a plan that includes SDK usage rights when subscribing to PallyCon commercial plans.

1. [`pallycon_drm_sdk`][1]: the package that faces the app. It's what users rely on to use the plugin in their projects. For usage details, refer to its [README.md][2] file.
2. [`pallycon_drm_sdk_android`][3]: this package holds the official Android implementation of the pallycon_drm_sdk_interface and adds Android support to the [pallycon_drm_sdk][1] package. More information can be found in its [README.md][4] file.
3. [`pallycon_drm_sdk_ios`][5]: this package holds the official iOS implementation of the pallycon_drm_sdk_interface and adds iOS support to the [pallycon_drm_sdk][1] package. More information can be found in its [README.md][6] file.
4. [`pallycon_drm_sdk_interface`][7]: this package defines the interface that all platform packages must implement to support the app-facing package. Instructions on how to implement a platform package can be found in the [README.md][8] of the [pallycon_drm_sdk_interface][7] package.

[1]: ./pallycon_drm_sdk
[2]: ./pallycon_drm_sdk/README.md
[3]: ./pallycon_drm_sdk_android
[4]: ./pallycon_drm_sdk_android/README.md
[5]: ./pallycon_drm_sdk_ios
[6]: ./pallycon_drm_sdk_ios/README.md
[7]: ./pallycon_drm_sdk_interface
[8]: ./pallycon_drm_sdk_interface/README.md
