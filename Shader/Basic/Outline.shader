//
// KinoContour - Contour line effect
//
// Copyright (C) 2015 Keijiro Takahashi
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of
// this software and associated documentation files (the "Software"), to deal in
// the Software without restriction, including without limitation the rights to
// use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
// the Software, and to permit persons to whom the Software is furnished to do so,
// subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
// FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
// COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
// IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
// CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//
Shader "ImageEffect/Outline"
{
    Properties
    {
        [HideInInspector] _MainTex("", 2D) = "" {}
        
        [KeywordEnum(COLOR, DEPTH, NORMAL)] _CONTOUR ("CONTOUR", Float) = 0

        _Color("Color", Color) = (1,1,1,1)
        _Background("Background", Color) = (1,1,1,1)
        _LowerThreshold("Lower threshold", Range(0, 1)) = 0.05
        //_InvRange("InvRange", Range(0, 1)) = 0.05
        _UpperThreshold("Upper threshold", Range(0, 1)) = 0.5

        _DepthSensitivity("Depth sensitivity", Range(0, 50)) = 0.5
        _NormalSensitivity("Normal sensitivity", Range(0, 5)) = 0
        _ColorSensitivity("Color sensitivity", Range(0, 5)) = 0
        _OutlineThickness("Outline thickness", Range(0, 5)) = 1
        //_InvFallOff("InvFallOff", Range(0, 1)) = 0.05
        _FallOffDepth("FallOff depth", Float) = 40
    }

    SubShader
    {
        Pass
        {
            //ZTest Always Cull Off ZWrite Off
            CGPROGRAM
            #define BUILTIN
            #pragma target 5.0
            #pragma vertex vert_img
            #pragma fragment frag
            #pragma multi_compile _ _CONTOUR_COLOR
            #pragma multi_compile _ _CONTOUR_DEPTH
            #pragma multi_compile _ _CONTOUR_NORMAL
            
            #include "UnityCG.cginc"
            //#include "Assets/Packages/ShaderLib/Shader/Basic/Contour.hlsl"
            #include "Assets/Packages/ShaderLib/Shader/Basic/Outline.hlsl"
            
            float _OutlineThickness;
            float _DepthSensitivity;
            float _NormalSensitivity;
            float _ColorSensitivity;

            float4 _Color;

            half4 frag(v2f_img IN) : SV_Target
            {
                float4 color;
                Outline_float(
                    IN.uv, _OutlineThickness,
                    _DepthSensitivity, _NormalSensitivity, _ColorSensitivity, _Color,
                    color
                );
                return color;
            }
            
            ENDCG
        }
    }
}