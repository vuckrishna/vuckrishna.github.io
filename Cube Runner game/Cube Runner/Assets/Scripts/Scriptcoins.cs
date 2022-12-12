using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;


public class Scriptcoins : MonoBehaviour
{
   
    // when player hits coins it will count and destroy the object upon hitting.
    public void OnTriggerEnter(Collider Player)
    {
        ScoreTextScript.coinAmount += 1;
        Destroy(gameObject);
    }

 
}
