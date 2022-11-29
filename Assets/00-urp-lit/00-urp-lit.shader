
Shader "uuscc/03-lighting"
{
    Properties
    {
        // [MainTexture] _BaseMap("Base Map", 2D) = "white"
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
                float4 posOS    : POSITION;
                float3 normalOS : NORMAL;
            };

            struct PSInput
            {                
                float4 posCS   : SV_POSITION;
                // float2 uv       : TEXCOORD0;
            };

            // TEXTURE2D( _BaseMap );
            // SAMPLER( sampler_BaseMap );

            CBUFFER_START( UnityPerMaterial )
                // float4 _BaseMap_ST;
            CBUFFER_END
            
            PSInput VSMain ( VSInput input )
            {
                PSInput output = (PSInput)0;

                output.posCS = TransformObjectToHClip( input.pos.xyz );
                // output.uv = TRANSFORM_TEX( input.uv, _BaseMap );
                output.normalWS = TransformObjectToWorldNormal( input.normalOS );

                return output;
            }
            
            half4 PSMain( PSInput input ) : SV_Target
            {
                half4 color = SAMPLE_TEXTURE2D( _BaseMap, sampler_BaseMap, input.uv );
                return color;
            }

            ENDHLSL
        }
    }
}


