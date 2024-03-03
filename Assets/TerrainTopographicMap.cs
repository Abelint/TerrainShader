using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TerrainTopographicMap : MonoBehaviour
{
    public Texture2D topographicMapTexture;
    public Terrain terrain;

    void Start()
    {
        Debug.Log(terrain.terrainData.heightmapResolution);
        if (topographicMapTexture != null && terrain != null)
        {
            ApplyTopographicMap();
        }
    }

    void ApplyTopographicMap()
    {
        float[,] heights = new float[terrain.terrainData.heightmapResolution, terrain.terrainData.heightmapResolution];

        for (int x = 0; x < terrain.terrainData.heightmapResolution; x++)
        {
            for (int y = 0; y < terrain.terrainData.heightmapResolution; y++)
            {
                Color pixelColor = topographicMapTexture.GetPixel(
                     y,
                    x);
                float height = pixelColor.r * 0.3f + pixelColor.g * 0.59f + pixelColor.b * 0.11f;
                heights[x, y] = height;
            }
        }

        terrain.terrainData.SetHeights(0, 0, heights);
    }
}
