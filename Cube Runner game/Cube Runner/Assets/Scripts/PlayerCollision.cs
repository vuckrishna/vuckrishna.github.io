using UnityEngine;

public class PlayerCollision : MonoBehaviour
{
    public PlayerMovement movement;

    //player collision code if player collide with obstacle the game ends.
    void OnCollisionEnter (Collision collisionInfo)
    {
        //collision with obstacle.
        if (collisionInfo.collider.tag == "Obstacle")  
        {
            movement.enabled = false;
            FindObjectOfType<GameManager>().EndGame(); // recalling the function End game from GameManager Script.
        }
    }
  
}
