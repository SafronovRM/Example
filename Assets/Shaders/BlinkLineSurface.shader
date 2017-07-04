Shader "Custom/BlinkLineSuraface"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        [PerRendererData]  _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _BlinkTex ("Blink image (RGB)", 2D) = "white" {}
    }
    SubShader
    {
        Tags {"Queue" = "Transparent" "RenderType"="Transparent" }
        LOD 200
   
        CGPROGRAM
 
        #pragma surface surf Standard alpha:fade nofog
        #pragma target 3.0
 
        sampler2D _MainTex;
        sampler2D _BlinkTex;
 
        struct Input {
            float2 uv_MainTex;
            float2 uv2_BlinkTex;
        };
 
        fixed4 _Color;
 
        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
            fixed4 c2 = tex2D(_BlinkTex, IN.uv2_BlinkTex) * _Color;
            o.Albedo = lerp(c.rgb, c2.rgb, c2.a);
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Standard"
}