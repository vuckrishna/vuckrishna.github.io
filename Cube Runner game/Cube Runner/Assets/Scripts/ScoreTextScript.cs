using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.SceneManagement;

public class ScoreTextScript : MonoBehaviour
{
    Text text;
    public static int coinAmount;


    // calls the Text to display score.
    void Start()
    {
        text = GetComponent<Text>();
    }

    // convert int to string.
    void Update()
    {
        text.text = coinAmount.ToString();
    }
}
