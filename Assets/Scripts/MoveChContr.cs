using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[RequireComponent(typeof(CharacterController))]
public class MoveChContr : MonoBehaviour
{
    [SerializeField] float speedMove =1f;
    [SerializeField] float roteteMove = 1f;

    [SerializeField] float currentAttractionCharacter = 0f;
    [SerializeField] float gravityForce = 20;
    CharacterController characterController;
    void Start()
    {
        characterController = GetComponent<CharacterController>();
    }

    // Update is called once per frame
    void Update()
    {
        
    }


    void GravityHandling()
    {
        if(!characterController.isGrounded)
        {
            currentAttractionCharacter -= gravityForce * Time.deltaTime;
        }
        else
        {
            currentAttractionCharacter = 0;
        }
    }

    public void MoveCharacter(Vector3 moveDir)
    {
        moveDir = moveDir * speedMove;
        moveDir.y = currentAttractionCharacter;
        characterController.Move(moveDir*Time.deltaTime);
    }
    public void RotateCharacter(Vector3 moveDir)
    {
        if (characterController.isGrounded)
        {
            if (Vector3.Angle(transform.forward,moveDir)>0)
            {
                Vector3 newDir = Vector3.RotateTowards(transform.forward, moveDir, roteteMove, 0);
                transform.rotation = Quaternion.LookRotation(newDir);
            }
        }
    }
}
