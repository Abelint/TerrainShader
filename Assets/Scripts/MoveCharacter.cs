using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[RequireComponent(typeof(Rigidbody))]
public class MoveCharacter : MonoBehaviour
{
    [Header("Character movement")]
    [SerializeField] float _moveSpeed = 1f;
    [SerializeField] float _rotateSpeed = 1f;

    [Header("Component")]
    Rigidbody _rb;

    // Start is called before the first frame update
    void Start()
    {
        _rb = GetComponent<Rigidbody>();
    }

    public void Move(Vector3 direction)
    {
        Vector3 offset = direction * _moveSpeed * Time.deltaTime;
        _rb.MovePosition(_rb.position+offset);
    }

    public void Rotate(Vector3 direction)
    {
        if (Vector3.Angle(transform.forward, direction) > 0)
        {
            Vector3 newDir = Vector3.RotateTowards(transform.forward, direction, _rotateSpeed, 0);
            transform.rotation = Quaternion.LookRotation(newDir);
        }
    }
}
