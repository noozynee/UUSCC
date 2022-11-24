
Shader "uuscc/color"
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

            #pragma vertex VertexMain
            #pragma fragment PixelMain

            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

            struct VertexInput
            {                
                float4 pos : POSITION;
            };

            struct VertexOut
            {                
                float4 positionHCS  : SV_POSITION;
            };

            CBUFFER_START(UnityPerMaterial)
                half4 _BaseColor;
            CBUFFER_END
            
            VertexOut VertexMain ( VertexInput input )
            {
                VertexOut output;
                output.positionHCS = TransformObjectToHClip( input.pos.xyz );                
                return output;
            }
            
            half4 PixelMain() : SV_Target
            {               
                return _BaseColor;
            }

            ENDHLSL
        }
    }
}
