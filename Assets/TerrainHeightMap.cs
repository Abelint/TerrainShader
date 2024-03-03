using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TerrainHeightMap : MonoBehaviour
{
    public Texture2D heightMap;
    private Terrain terrain;

    void Start()
    {
        terrain = GetComponent<Terrain>();

        if (heightMap != null)
        {
            ApplyHeightMap();
        }
    }

    void ApplyHeightMap()
    {
        float[,] heights = new float[terrain.terrainData.heightmapResolution, terrain.terrainData.heightmapResolution];

        for (int x = 0; x < terrain.terrainData.heightmapResolution; x++)
        {
            for (int y = 0; y < terrain.terrainData.heightmapResolution; y++)
            {
                float pixelValue = heightMap.GetPixel(x, y).grayscale;
                heights[x, y] = pixelValue;
            }
        }

        terrain.terrainData.SetHeights(0, 0, heights);
    }
}
