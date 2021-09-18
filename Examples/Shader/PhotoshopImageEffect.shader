Shader "Hidden/PhotoshopImageEffect"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        // No culling or depth
        Cull Off ZWrite Off ZTest Always

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"
            #include "Assets/Packages/ShaderLib/Shader/Lib/PhotoshopMath.hlsl"

            #pragma multi_compile HslShift CurveDesaturate CurveGammaCorrection LC InputRangeLC InputLC OutputRangeLC \
                BlendColorContrastSaturationBrightnes BlendColorLighten BlendColorDarken \
                BlendColorLinearBurn BlendColorLinearDodge BlendColorLinearLight \
                BlendColorScreen BlendColorOverLay BlendColorSoftLight BlendColorHardLight \
                BlendColorColorDodge BlendColorColorBurn BlendColorVividLight \
                BlendColorPinLight BlendColorHardLerp BlendColorReflect BlendColorNegation \
                BlendColorExclusion BlendColorPhoenix BlendColorHue BlendColorSaturation \
                BlendColorColor BlendColorLuminosity

            int _BlendType;

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            sampler2D _MainTex;

            Texture2D<float4> Tex1;
            Texture2D<float4> Tex2;
            SamplerState samplerTex1;
            SamplerState samplerTex2;

            float _Param1, _Param2, _Param3;
            float4 _Color1;

            float4 frag (v2f i) : SV_Target
            {
                float4 col = 1;
                float4 mainTex = tex2D(_MainTex, i.uv);
                float4 tex1 = Tex1.SampleLevel(samplerTex1, i.uv, 0);
                float4 tex2 = Tex2.SampleLevel(samplerTex2, i.uv, 0);
                //col = tex1;

            #ifdef HslShift
                return tex1;
            #elif defined(CurveDesaturate)
                return tex2;
            #elif defined(CurveGammaCorrection)
                return Desaturate(tex1, _Param1);
            #elif defined(InputRangeLC)
                col.rgb = LevelsControlInputRange(tex1.rgb, _Param1, _Param2);
                return col;
            #elif defined(OutputRangeLC)
                col.rgb = LevelsControlOutputRange(tex1, _Param1, _Param2);
                return col;
            #elif defined(InputLC)
                col.rgb = LevelsControlInput(tex1, _Param1, _Param2, _Param3);
                return col;
            #elif defined(LC)
                //col.rgb = LevelsControlInputRange(tex1, _Param1, _Param2);
                //return col;
            #endif
            /*
            CurveDesaturate CurveGammaCorrection \
            LevelsControl LevelsControlInputRange LevelsControlInput LevelsControlOutputRange \
            BlendColorContrastSaturationBrightnes BlendColorLighten BlendColorDarken \
            BlendColorLinearBurn BlendColorLinearDodge BlendColorLinearLight \
            BlendColorScreen BlendColorOverLay BlendColorSoftLight BlendColorHardLight \
            BlendColorColorDodge BlendColorColorBurn BlendColorVividLight \
            BlendColorPinLight BlendColorHardLerp BlendColorReflect BlendColorNegation \
            BlendColorExclusion BlendColorPhoenix BlendColorHue BlendColorSaturation \
            BlendColorColor BlendColorLuminosity
            */


                //return Desaturate(tex1, _Param1);

                //return col;
                //col *= tex1;

                return col;
            }
            ENDCG
        }
    }
}
