using UnityEngine;

public class EndTrigger : MonoBehaviour
{
    public GameManager gameManager;

    //upon entering the end object the level completes and loads next level.
    void OnTriggerEnter()
    {
        gameManager.CompleteLevel();
    }
}
