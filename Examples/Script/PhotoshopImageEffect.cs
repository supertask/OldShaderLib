using System;
using UnityEngine;

namespace ShaderLib.Examples {
    public enum BlendType {
        HslShift,
        CurveDesaturate,
        CurveGammaCorrection,
        InputRangeLC,
        OutputRangeLC,
        InputLC,
        LC,
        BlendColorContrastSaturationBrightness,
        BlendColorLighten,
        BlendColorDarken,
        BlendColorLinearBurn,
        BlendColorLinearDodge,
        BlendColorLinearLight,
        BlendColorScreen,
        BlendColorOverLay,
        BlendColorSoftLight,
        BlendColorHardLight,
        BlendColorColorDodge,
        BlendColorColorBurn,
        BlendColorVividLight,
        BlendColorPinLight,
        BlendColorHardLerp,
        BlendColorReflect,
        BlendColorNegation,
        BlendColorExclusion,
        BlendColorPhoenix,
        BlendColorHue,
        BlendColorSaturation,
        BlendColorColor,
        BlendColorLuminosity

    }

    public class PhotoshopImageEffect : ImageEffectBase
    {
        public BlendType blendType = BlendType.HslShift;
        public float param1;
        public float param2;
        public float param3;
        public Color baseColor;
        public Texture2D tex1;
        public Texture2D tex2;
        private string photoshopShader =  "Hidden/PhotoshopImageEffect";
        private BlendType cachedBlendType = BlendType.HslShift;

        void Start() {
            base.material = null;
            this.EnableKeyword();
        }

        void Update() {
        }

        protected virtual void OnRenderImage(RenderTexture source, RenderTexture destination)
        {
            if (material == null) {
                this.material = new Material(Shader.Find(photoshopShader));
            }

            this.material.SetFloat("_Param1", this.param1 );
            this.material.SetFloat("_Param2", this.param2 );
            this.material.SetFloat("_Param3", this.param3 );
            this.material.SetColor("_Color1", this.baseColor );

            this.material.SetTexture("Tex1", this.tex1 );
            this.material.SetTexture("Tex2", this.tex2 );

            if (IsSupportAndEnable()) {
                Graphics.Blit(source, destination, this.material);
            } else {
                Graphics.Blit(source, destination);
            }
        }

        public void EnableKeyword() {
            if (material == null) {
                this.material = new Material(Shader.Find(photoshopShader));
            }
            this.material.DisableKeyword(this.cachedBlendType.ToString());
            this.material.EnableKeyword(this.blendType.ToString());
            Debug.LogFormat("cachedBlendType: {0}, blendType: {1}", this.cachedBlendType.ToString(), this.blendType.ToString());
            this.cachedBlendType = this.blendType;
        }
    }
}
