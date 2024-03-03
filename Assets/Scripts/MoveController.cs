using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MoveController : MonoBehaviour
{
    [SerializeField] MoveCharacter moveCharacter;

    // Update is called once per frame
    void Update()
    {
        moveCharacter.Move(new Vector3(Input.GetAxis("Horizontal"), 0, Input.GetAxis("Vertical")));
        moveCharacter.Rotate(new Vector3(Input.GetAxis("Horizontal"), 0, Input.GetAxis("Vertical")));
    }
}
