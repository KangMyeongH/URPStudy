 // Shader 시작. 셰이더의 폴더와 이름을 여기서 결정합니다.
 
Shader "Basic_01"
{
    Properties
    {
        _TintColor("Color", color) = (1,1,1,1)
        _Intensity("Range Sample", Range(0,1)) = 0.5
    }

	SubShader
	{
	    Tags
        {
            //Render type과 Render Queue를 여기서 결정합니다.
	        "RenderPipeline"="UniversalPipeline"
            "RenderType"="Opaque"          
            "Queue"="Geometry"
        }

        Pass
        {
     	    Name "Universal Forward"
            Tags { "LightMode" = "UniversalForward" }

       	    HLSLPROGRAM

            #pragma prefer_hlslcc gles
            #pragma exclude_renderers d3d11_9x
            #pragma vertex vert
            #pragma fragment frag

            //cg shader는 .cginc를 hlsl shader는 .hlsl을 include하게 됩니다.
       	    #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"        	

            //vertex buffer에서 읽어올 정보를 선언합니다. 	
            struct VertexInput
            {
                float4 vertex : POSITION;
            };

            //보간기를 통해 버텍스 셰이더에서 픽셀 셰이더로 전달할 정보를 선언합니다.
            struct VertexOutput
            {
           	    float4 vertex : SV_POSITION;
      	    };

            float _Intensity;
            float4 _TintColor;

            //버텍스 셰이더
      	    VertexOutput vert(VertexInput v)
            {
        	    VertexOutput o;      
          	    o.vertex = TransformObjectToHClip(v.vertex.xyz);
                
         	    return o;
            }

            //픽셀 셰이더
            half4 frag(VertexOutput i) : SV_Target
            {   	
                float4 color = _TintColor * _Intensity;
                return color;
            }
        	ENDHLSL  
    	}
    }
}