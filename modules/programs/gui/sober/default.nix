{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.programs.gui.sober;
in {
  options.modules.programs.gui.sober = {
    enable = lib.mkEnableOption "sober";
  };
  config = mkIf cfg.enable {
    services.flatpak = {
      enable = true;
      packages = [
        ":${./sober.flatpakref}"
      ];
    };
    /*
    hj.files = {
      ".var/app/org.vinegarhq.Sober/data/sober/exe/ClientSettings/hm_ClientAppSettings.json".text = ''
               {
          "DFFlagDebugPauseVoxelizer": true,
          "DFFlagDebugRenderForceTechnologyVoxel": true,
          "DFFlagDisableDPIScale": false,
          "DFFlagTextureQualityOverrideEnabled": true,
          "DFIntCSGLevelOfDetailSwitchingDistance": 0,
          "DFIntCSGLevelOfDetailSwitchingDistanceL12": 0,
          "DFIntCSGLevelOfDetailSwitchingDistanceL23": 0,
          "DFIntCSGLevelOfDetailSwitchingDistanceL34": 0,
          "DFIntDebugFRMQualityLevelOverride": 1,
          "DFIntDebugRestrictGCDistance": "1",
          "DFIntMaxFrameBufferSize": "4",
          "DFIntTaskSchedulerTargetFps": 9999,
          "DFIntTextureCompositorActiveJobs": 0,
          "DFIntTextureQualityOverride": 0,
          "DFFlagDebugRenderForceTechnologyVoxel": true,
          "FFlagAdServiceEnabled": false,
          "FFlagCloudsReflectOnWater": false,
          "FFlagDebugCheckRenderThreading": "True",
          "FFlagDebugDisableTelemetryEphemeralCounter": true,
          "FFlagDebugDisableTelemetryEphemeralStat": true,
          "FFlagDebugDisableTelemetryEventIngest": true,
          "FFlagDebugDisableTelemetryPoint": true,
          "FFlagDebugDisableTelemetryV2Counter": true,
          "FFlagDebugDisableTelemetryV2Event": true,
          "FFlagDebugDisableTelemetryV2Stat": true,
          "FFlagDebugGraphicsDisableDirect3D11": "True",
          "FFlagDebugGraphicsPreferVulkan": "True",
          "FFlagDebugSkyGray": true,
          "FFlagDisablePostFx": true,
          "FFlagEnableAndroidVsync": false,
          "FFlagFastGPULightCulling3": true,
          "FFlagFutureIsBrightPhase3Vulkan": true,
          "FFlagGameBasicSettingsFramerateCap5": true,
          "FFlagGlobalWindActivated": "False",
          "FFlagGlobalWindRendering": "False",
          "FFlagRealMobileOutline": false,
          "FFlagRenderCheckThreading": true,
          "FFlagRenderDebugCheckThreading2": "True",
          "FFlagUserHandleChatHotKeyWithContextActionService": true,
          "FIntDebugForceMSAASamples": 0,
          "FIntFRMMaxGrassDistance": 0,
          "FIntFRMMinGrassDistance": 0,
          "FIntRenderGrassDetailStrands": 0,
          "FIntRenderGrassHeightScaler": 0,
          "FIntRenderLocalLightFadeInMs": "0",
          "FIntRenderLocalLightUpdatesMax": 1,
          "FIntRenderLocalLightUpdatesMin": 1,
          "FIntRenderShadowIntensity": 0,
          "FIntTerrainArraySliceSize": "4",
          "FFlagCoreGuiTypeSelfViewPresent": false,
          "FFlagEnableInGameMenuChromeABTest2": "False",
          "FFlagEnableReportAbuseMenuRoactABTest2": "False",
          "FFlagEnableInGameMenuChromeABTest3": "False",
          "FIntFullscreenTitleBarTriggerDelayMillis": "3600000",
          "FFlagUserShowGuiHideToggles": "True",
          "FIntDebugTextureManagerSkipMips": "8",
          "FIntRenderShadowmapBias": "-1",
          "DFIntAnimationLodFacsDistanceMin": "0",
          "DFIntAnimationLodFacsDistanceMax": "0",
          "DFIntAnimationLodFacsVisibilityDenominator": "0",
          "FFlagFixGraphicsQuality": "True",
          "DFIntCullFactorPixelThresholdShadowMapHighQuality": "2147483647",
          "DFIntCullFactorPixelThresholdShadowMapLowQuality": "2147483647",
          "FFlagDebugRenderingSetDeterministic": "True",
          "FFlagTaskSchedulerLimitTargetFpsTo2402": "False",
          "DFIntDefaultTimeoutTimeMs": "10000",
          "FFlagRenderFixFog": "True",
          "FIntRobloxGuiBlurIntensity": "0"
        }
      '';
    };
    */
  };
}
