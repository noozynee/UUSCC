
Shader "uuscc/01-color"
{
    Properties
    { 
        [MainColor] _BaseColor("Base Color", Color) = (1, 1, 1, 1)
    }
    
    SubShader
    {        
        Tags { "RenderType" = "Opaque" "RenderPipeline" = "UniversalPipeline" }

        Pass
        {
            HLSLPROGRAM

            #pragma vertex VSMain
            #pragma fragment PSMain

            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

            struct VSInput
            {                
                float4 pos : POSITION;
            };

            struct PSInput
            {                
                float4 posCS  : SV_POSITION;
            };

            CBUFFER_START(UnityPerMaterial)
                half4 _BaseColor;
            CBUFFER_END
            
            PSInput VSMain ( VSInput input )
            {
                PSInput output = (PSInput)0;
                output.posCS = TransformObjectToHClip( input.pos.xyz );                
                return output;
            }
            
            half4 PSMain() : SV_Target
            {               
                return _BaseColor;
            }

            ENDHLSL
        }
    }
}
