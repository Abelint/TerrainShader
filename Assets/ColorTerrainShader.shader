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

            float3 color1; float3 color2; float3 colorResult; float t; float H1; float H2;

           
           
            if (height <= _WaterLevel) // синий
            {
                color1 = _WaterColor;
                color2 = _WaterColor;
                H1 =0; H2 = _WaterLevel;
              
            }
            else if (height <= _SandLevel) // желтый
            {
                 color1 =_WaterColor; // blue
                color2 = _SandColor; // yellow
                H1 = _WaterLevel; H2 = _SandLevel;
            }
            else if (height <= _GrassLevel) // зеленый
            {
                 color1 = _SandColor;
                color2 = _GrassColor; // green                
                H1 = _SandLevel; H2 = _GrassLevel;
            }
            else if (height <= _RockLevel) // коричневый
            {
               color1 = _GrassColor; // green
               color2 = _RockColor; // brown
               H1 = _GrassLevel; H2 = _RockLevel;
            }
            else if(height <= 1)
            {
                color1 = _RockColor;
                color2 = _SnowColor; // white
               H1 = _RockLevel; H2 =1;
            }
            // color1 = float3(0.0, 0.0, 0.0);
            float deltaH = H2 - H1;
            float step = deltaH/_Gradient;
            colorResult = color2-color1;
             t= _Gradient* (height-H1)/step;
            float3 stepColor =t* colorResult/_Gradient;
            colorResult = color1 + stepColor;
             

            o.Albedo = colorResult;
        }

       
        ENDCG
    }

    FallBack "Diffuse"
}
