Shader "Custom/ColorTerrainShader"
{
   Properties
    {
        _MainTex ("Texture", 2D) = "gray" {}
        _Gradient("Gradient", float) = 5
        _WaterLevel("Water Level", float) = 0.2
        _SandLevel("Sand Level", float) = 0.4
        _GrassLevel("Grass Level", float) = 0.6
        _RockLevel("Rock Level", float) = 0.8
        _WaterColor("Water Color", COLOR) = (1,1,1)
        _SandColor("Sand Color", COLOR)= (1,1,1)
        _GrassColor("Grass Color", COLOR)= (1,1,1)
        _RockColor("Rock Color", COLOR)= (1,1,1)
        _SnowColor("Snow Color",COLOR) = (1,1,1)
    }

    SubShader
    {
        Tags { "RenderType"="Opaque" "TerrainCompatible"="True" }

        CGPROGRAM
        #pragma surface surf Lambert

        sampler2D _MainTex;
        float _Gradient;

        
        float _WaterLevel;
        float _SandLevel;
        float _GrassLevel;
        float _RockLevel;
        float3 _WaterColor;
        float3 _SandColor;
        float3 _GrassColor;
        float3 _RockColor;
        float3 _SnowColor;
        struct Input
        {
            float2 uv_MainTex;
        };
         
        void surf(Input IN, inout SurfaceOutput o)
        {
            float4 terrainColor = tex2D(_MainTex, IN.uv_MainTex);
            float height = (tex2D(_MainTex, IN.uv_MainTex).r + tex2D(_MainTex, IN.uv_MainTex).g +
            tex2D(_MainTex, IN.uv_MainTex).b)/3;

            float3 color1; float3 color2; float3 colorResult; float t;

            color1 = float3(0.0, 0.0, 0.0);
            t=1;
            if (height <= _WaterLevel) // синий
            {
                // color2 = float3(0.0, 0.0, 1.0); // blue
                color2 = _WaterColor;
               
               //t=height;
            }
            else if (height <= _SandLevel) // желтый
            {
                 color1 =_WaterColor; // blue
                color2 = _SandColor; // yellow
               //  t = height/(_SandLevel -_WaterLevel);
                

            }
            else if (height <= _GrassLevel) // зеленый
            {
                // color1 = _SandColor;
                color2 = _GrassColor; // green
                 t = height/(_GrassLevel -_SandLevel);
            }
            else if (height <= _RockLevel) // коричневый
            {
               // color1 = _GrassColor; // green
               color2 = _RockColor; // brown
               t = height/(_RockLevel-_GrassLevel);
            }
            else // белый
            {
                // color1 = _RockColor;
                color2 = _SnowColor; // white
                t =1- height;
            }
             //t=height;
            float stepR = (color2.x - color1.x) / t;
            
            float stepG = (color2.y - color1.y) / t;
            float stepB = (color2.z - color1.z) / t;

            // if(stepR <0) stepR =0;
            // if(stepR <0) stepG =0;
            // if(stepR <0) stepB =0;

            colorResult = float3(stepR,stepG,stepB);
            
            o.Albedo = colorResult;
        }

       
        ENDCG
    }

    FallBack "Diffuse"
}
