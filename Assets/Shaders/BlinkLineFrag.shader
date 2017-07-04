Shader "Custom/BlinkLineFrag"
{
	Properties
	{
		[PerRendererData] _MainTex ("Sprite Texture", 2D) = "white" {}
        _Color ("Main Color", Color) = (1,1,1,1)
        _BlinkTex ("Detail (RGB)", 2D) = "white" {}
	}
	SubShader
	{
		Tags {
        		    "Queue"="Transparent"
        		    "PreviewType" = "Plane"
        		}
		LOD 100

		Pass
		{
		    Blend SrcAlpha OneMinusSrcAlpha
		
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
                float2 texcoord : TEXCOORD0;
                float2 texcoord2 : TEXCOORD1;
			};

			struct v2f
			{
			    float4 vertex : SV_POSITION;
				float2 texcoord : TEXCOORD0;
                float2 texcoord2 : TEXCOORD1;
			};

			sampler2D _MainTex;
           		sampler2D _BlinkTex;
            		fixed4 _Color;
            		float4 _MainTex_ST;
            		float4 _BlinkTex_ST;
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.texcoord = TRANSFORM_TEX(v.texcoord, _MainTex);
                		o.texcoord2 = TRANSFORM_TEX(v.texcoord2, _BlinkTex);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
			  	fixed4 color = tex2D(_MainTex, i.texcoord);
				fixed4 blink = tex2D(_BlinkTex, i.texcoord2);
                		fixed4 result = lerp(color, blink, blink.a);
				result.a = color.a;
				return result * _Color;
			}
			ENDCG
		}
	}
}